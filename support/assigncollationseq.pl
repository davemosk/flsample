#!/usr/bin/perl -w
#
# update collation sequence in bulk
#
##

use FindBin;

BEGIN {
  use lib '/home/www-bin/freelex/lib';
  use lib "$FindBin::Bin/../lib";
  
  use FreelexDB::Headword;

}

my $it = FreelexDB::Headword->retrieve_all;

$i = 0;
while (my $hw = $it->next) {
   $i++;
   $hw->pre_update_collateseq;
   $hw->update; 
   if ($i % 100 == 0) {
      print $i, "\n";
      $hw->dbi_commit;
   }
}
FreelexDB::Headword->dbi_commit;





