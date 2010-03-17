#!/usr/bin/perl -w
#
# workflow dispatcher
#
# recalculate the workqueueposition of each entry
#

use strict;
use FindBin;


BEGIN {
  use lib '/home/www-bin/freelex/lib';
  use lib "$FindBin::Bin/../lib";
  
  use FreelexDB::Globals;
  use FreelexDB::Matapunauser;
  use FreelexDB::Headword;
}

my %seenhwids = ();

my $ituser = FreelexDB::Matapunauser->retrieve_all;

while (my $u = $ituser->next) {
   next unless (my $wsid = $u->workflowschemeid);
   my $ws = $wsid->workflowscheme;
   my $muid = $u->matapunauserid;
   $ws =~ s/\#\#user\#\#/$muid/g;
   $ws =~ s/limit 1\s*\;//ig;
   
   my $uqmethod = 'user_queue_' . $muid;
   my $search_uqmethod = 'search_' . $uqmethod;   
   
   FreelexDB::Headword->set_sql( $uqmethod => $ws );
   
   my $ithw = FreelexDB::Headword->$search_uqmethod;
   
   my $position = 100;
   while (my $hw = $ithw->next) {
      next if $seenhwids{$hw->headwordid};
      $seenhwids{$hw->headwordid} = 1;
#      my $hw = FreelexDB::Headword->retrieve($hid);
      # skip if it was explicitly sent
      next if (defined $hw->workqueueposition && $hw->workqueueposition < 100);
      $hw->set("workqueueposition",$position);
      $hw->set("allocateduserid",$u->matapunauserid);
      $hw->update; 
      $hw->dbi_commit    if $position % 100 == 0;
      $position++;
   }
}
      
      
