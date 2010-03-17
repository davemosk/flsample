#!/usr/bin/perl;

package FreelexDB::Headword;
  
  use FreelexDB::Globals;
  use base 'FreelexDB::Headword::Base';
  use FreelexDB::Usage;
  use strict;
 
  
  __PACKAGE__->set_up_table( "headword" );
  __PACKAGE__->has_a( owneruserid => "FreelexDB::Matapunauser" );
  __PACKAGE__->has_a( wordclassid => "FreelexDB::Wordclass" );
  __PACKAGE__->has_a( categoryid => "FreelexDB::Category" );
  __PACKAGE__->has_a( allocateduserid => "FreelexDB::Matapunauser");
  __PACKAGE__->has_a( sentbyuserid => "FreelexDB::Matapunauser");
  __PACKAGE__->has_a( updateuserid => "FreelexDB::Matapunauser");
  __PACKAGE__->has_a( createuserid => "FreelexDB::Matapunauser");  
  __PACKAGE__->has_a( qastatus1 => "FreelexDB::Qastatus");
  __PACKAGE__->has_many( editorialcomment => "FreelexDB::Editorialcomment", {order_by => "editorialcommentdate DESC"}); 
 
  __PACKAGE__->columns(TEMP => qw/neweditorialcomment/);
  
  __PACKAGE__->set_sql( count_all => "SELECT COUNT(*) FROM __TABLE__");
  __PACKAGE__->set_sql( count_distinct => "SELECT COUNT(DISTINCT %s) from __TABLE__" );
  __PACKAGE__->set_sql( count_updated_today => "SELECT COUNT(headword) AS hw FROM headword WHERE createdate > 'today' OR updatedate > 'today'" );
  __PACKAGE__->set_sql( next_wf => "SELECT headwordid FROM headword WHERE allocateduserid=%s ORDER BY workqueueposition, collateseq, headword, variantno, majsense, minsense LIMIT 1");
                
  __PACKAGE__->set_sql( get_print_rows => "SELECT __ESSENTIAL__, CASE WHEN (variantno ISNULL) THEN 0 ELSE variantno END AS variantno2, CASE WHEN (majsense ISNULL OR majsense='') THEN '0' ELSE majsense END AS majsense2, CASE WHEN (minsense ISNULL OR minsense='') THEN '0' ELSE minsense END AS minsense2 FROM __TABLE__ %s ORDER BY collateseq, headword, variantno2, majsense2, minsense2"); 
  
  __PACKAGE__->use_headword_fields();

  
sub display_order_form {
   return ['headword','headwordid','SENSE','wordclassid','definition','example','cf','synonyms','essay','neweditorialcomment','allocateduserid','qastatus1','owneruserid','CREATEUSERANDDATE','UPDATEUSERANDDATE'];
}

sub display_order_print {
   return ['headword','headwordid','variantno','majsense','minsense','wordclassid','definition','example','cf','essay'];
}

sub search_result_cols { return ['headword','headwordid','wordclassid','definition'] }

sub search_include_other_cols { return 
['headword','definition','essay','see','synonyms']
}

  

  1;
