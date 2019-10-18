{This file contains common constants and variables}
unit file00;
{$R+}
interface
type t_f=file of byte;
var _width,_height:integer; const _fontname='Times New Roman';
var current_width, current_height:integer;
const memo5height=5;
var initial:boolean; //true while the initial inialization of the screen is being performed and false otherwise.
var chosen_task, filename:string;
var chosen_chapter:integer;
En_rus:boolean;    {language}
text_size:boolean;{if the size of the component with the text of the program is normal/increased  }
task_size:boolean;{if the size of the component with the text of the task is normal/increased  }

//test_size:boolean; now it is ignored {if the size of the component with the tests is normal/increased  }
//Only one component can be increased
pr_an:boolean;     {if the preliminary analysis was made}
compi:boolean;     {if the compilation was made}
current_dir:string; {the directory where the Delphi program is located }
const alphadigit=['a'..'z','A'..'Z','0'..'9','_'];
var fpc_dir:string; {the directory where fpc-compilator is stored}
Number_of_intervals:integer; //for timer
Number_of_tests:integer;//Number of tests for the current task
const Max_test_number=70;//Maximal Number of tests

var Linetest:array[1..2*max_test_number+1]of integer;//Linetest [i] contains the number of line where information about the test I begins.

const css=50; type tss=array[1..css]of string; tns=array[1..css]of integer;
//words to be checked, the numbers of their occurences in a pascal program
var ss:tss; ns:tns;
const max_results_number=1001;
var Number_of_results:array[1..2]of integer;//Number of results for odd and even tests for the current task, respectively
var result_type:array[1..2, 1..max_results_number]of char;//types of the results the main program (row number =1) and for the subprogram (row number=2)

var consts:array[1..4,1..2]of integer; //Eight constants are needed. Four values of the first (second) constant are stored
//in the first (second) column of the array consts, respectively; If a task has only one consts, the second column of the
//array consts contains zero values. If no constants are needed, all the elements of the array consts are zeros.
const nres=50;type t_an_res=array[1..nres]of integer; //for preliminary analysis3 - different types of errors.
type Ts_n=set of byte;
var i_c:longint; //the current record in the encoded file
var i_n:integer; s_n:Ts_n;//how much to subtract and the numbers of the ballast records
var i_c_2:longint; //the same for the claim-files
var i_n_2:integer; s_n_2:Ts_n;//the same for the claim-files
var task_names:array[1..200]of string;
task_amount:integer;//Names of the tasks and their currrect amount (for the chosen chapter)
var chapter_names:array[1..150,1..2]of string;
var directory_names:array[1..150]of string;
//Claims that are common for all tasks of the chosen chapter
type Tclaims=array[1..20]of record s1,s2,s3:string; b:boolean;b1:boolean end;
var chapter_claims:Tclaims;chapter_claims_amount:integer;
//Claims for the chosen task
var task_claims:Tclaims; task_claims_amount:integer;
//Warning messages
var warnings:array[1..25]of string;warnings_amount:integer;
//true if infinite loop was discovered
was_loop:boolean;
//0 if the output data must not be sorted; 1 (2) if they must be sorted and are real/integer; a positive value of the variable sort means that the order of the numbers in the output data does not matter.
var sorts:integer;
//It is true, if the answer 'Error' is correct for an incorrect input data , it is false, otherwise
var errorr:boolean;
//It is equal to a positive integer k>1 if an input data is k arrays; it is 0 ,otherwise; the 's' at the end means the same for the subprogram.
var arrayin,arrayins:integer;
//The same for output data
var arrayout, arrayouts:integer;
//The same for matrices
var matrixin,matrixins,matrixout,matrixouts:integer;
//The same for binary files - fileinc means that a it is a file of char; filei means that it is a file of integer
var filein,fileout:integer;
//The same for text files
var textsin,textsout:integer;


//0, if a complete program in Pascal must be presented; 1 (2) if a function (procedure) must be presented
var func_proc0,func_proc:integer;
//functions and procedures and amounts of their calls in the program; maxpf - maximal number of procudures and functions
//We are leaving it now
//type tcalls=record name:string; amount: integer end;
//const maxpf=20;
//var acalls:array[1..maxpf]of tcalls;
//These are variables that store the program text before a function or a procedure and after it, respectively.
var text_before, text_after:string;
var text_before0,text_after0:string;
//These are types of actual paramaters that can be passed by reference only
var varparam:array[1..20] of string;
//True if both a program and its main subroutine must be checked
var program_sub:boolean;
//Number of tests for the subroutine
var number_of_subtests:integer;
//It is true if the claims to all programs of the chosen chapter must be ignored.
var noclaims:boolean;
//true (false) if run time errors are (not) allowed in the program
var run_time_err:boolean;
//True if a string '=true' or '=false' without ':' before is found in the program.
var incorrect_boolean:boolean;
//True if amount of New or Dispose procedures is checked;
var check_new, check_dispose:boolean; 
implementation

end.
