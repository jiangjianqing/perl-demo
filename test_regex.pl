#引入外部文件中的正则表达式定义
require "./perl_lib/regex_lib.pl";

$text="cz_jjq\@163.com";
$text =~ s/$EmailRegex/<a href="mailto:$1">$1<\/a>/igx;
print "修改后的邮箱地址为：$text \n";
exit;

