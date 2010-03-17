package FreelexDB::Globals;

use strict;
use base qw(FreelexDB::Globals::Defaults);
use FindBin;
use utf8;

my $localdir = $FindBin::Bin . '/..';

sub db_name { "flsample" }
sub db_user { "flsample" }
sub db_password { "flsample" }

sub headword_fields_dir { $localdir . '/lib/FreelexDB/Headword/Fields', '/home/www-bin/freelex/lib/FreelexDB/Headword/Fields' }
sub template_dir { $localdir . '/root' }
sub system_name { "Freelex Sample Dictionary" };
sub mlmessage_file_location { $localdir . '/messages.txt' };
sub reports_dir { $localdir . '/reports/' };
sub support_contact_name { '' }
sub support_contact_email { '<a href="http://www.thinktank.co.nz/contact">Dave Moskovitz</a>' }
sub support_contact_phone {'+64 27 220 2202'}

sub fckeditor_path { '../static/FCKeditor' }
sub fckeditor_height { 200 };

sub textarearows { 2 }
sub textareacols { 50 }

sub search_select_tag { 1 };

sub qa_levels { 2 };

sub collate { [ ['-'],[' ','.','~'],["‘"],['a'],['b'],['c'],['d'],['e'],['f'],['g'],['h'],['i'],['j'],['k'],['l'],['m'],['n'],['o'],['p'],['q'],['r'],['s'],['t'],['u'],['v'],['w'],['x'],['y'],['ƴ'],['z'] ] };

sub enable_categories { 0 }
sub enable_tags { 0 } 
sub enable_print_xref { 0 }

1;