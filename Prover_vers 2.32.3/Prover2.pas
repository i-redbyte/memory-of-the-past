unit Prover2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ToolWin, ActnMan, ActnCtrls, ActnMenus, ActnList,
  ImgList, XPStyleActnCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Memo2: TMemo;
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    ImageList1: TImageList;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    procedure Action4Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  perem,skobki:Array[1..4000]of String;
  Sc_per:integer;
implementation

{$R *.dfm}

{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
         {Начало. Раздел приведения текста к нормальным параметрам}
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}

{функция удаляет все пробелы больше одного между словами, пробелы
между командой и ";" и все пробелы слева и справа}

Function preddelstrim(s1:string): string;
var
i1:integer;
Begin
s1:=trim(s1);{удаление пробелов с права и слева от строки}
{цикл удаление пробелов "внутри" строки}
For i1 := 1 to length(s1) do
        If (s1[i1]=' ') and (s1[i1+1]=' ') then
                while (s1[i1]=' ') and (s1[i1+1]=' ') do
                       delete(s1,i1+1,1);
For i1:=1 to length(s1) do
If (s1[i1]=' ') and (s1[i1+1]=';') then
delete(s1,i1,1);
For i1 := 1 to length(s1) do
preddelstrim:=s1;{передача значения входящей строки функции}
End;

{процедура копирует не "пустые" строки из "поля набора"(Memo1) в
"поле проверки"(Memo2)}
procedure copystr;
var i1:integer;
Begin
    Form1.Memo2.Lines.Clear;{очищает "поле проверки" при каждом обращении к прц}
       For i1 := 0 to form1.Memo1.Lines.Count-1 do
           If Length(Form1.Memo1.Lines[i1])>0 then
              Form1.Memo2.Lines.Add(preddelstrim(LowerCase(form1.memo1.lines[i1]))){добавляет в поле проверки не "пустую" строку}
End;

{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}

{Процедура поднимает ; и . к строке}
procedure SimvolUp(insymbol:char);
var i1: integer;
s1:string;
Begin
For i1:=0 to form1.Memo2.Lines.Count-1 do Begin
s1:=Form1.Memo2.lines[i1+1];
If (length(form1.Memo2.Lines[i1+1])=1) and (s1[1]=insymbol) then
Begin
form1.Memo2.Lines.Delete(i1+1);
form1.Memo2.Lines[i1]:=form1.Memo2.Lines[i1]+insymbol;
End
Else
  IF (Length(form1.Memo2.Lines[i1+1])>1) and (s1[1]=insymbol)Then
  Begin
s1:=Form1.Memo2.Lines[i1+1];
     Delete(s1,1,1);
     Form1.Memo2.Lines[i1+1] := s1;
     form1.Memo2.Lines[i1]:=form1.Memo2.Lines[i1]+insymbol;
    End;
End;
end;
{-------------------------------------------}
{------Процедура поднимает одно слово к другому ------}
{-------------------------------------------}
procedure WinUp(win:String);
var i1: integer;
s1:string;
Begin
For i1:=0 to form1.Memo2.Lines.Count-1 do Begin
s1:=Form1.Memo2.lines[i1+1];
If (length(form1.Memo2.Lines[i1+1])=length(win)) and (s1=win) then
Begin
form1.Memo2.Lines.Delete(i1+1);
form1.Memo2.Lines[i1]:=form1.Memo2.Lines[i1]+' '+win;
End
Else
  IF (Length(form1.Memo2.Lines[i1+length(win)])>length(win)) and (s1=win)Then
  Begin
s1:=Form1.Memo2.Lines[i1+1];
     Delete(s1,1,1);
     Form1.Memo2.Lines[i1+1] := s1;
     form1.Memo2.Lines[i1]:=form1.Memo2.Lines[i1]+win;
  End;
End;
end;
{------------------------------------------------------------}
{----------Процедура поднимает заданный  Тип к вару----------}
{------------------------------------------------------------}
procedure TipUp(Tip:String);
var i1: integer;
s1:string;
Begin
For i1:=1 to form1.Memo2.Lines.Count-1 do Begin
s1:=Form1.Memo2.lines[i1+1];
If (length(form1.Memo2.Lines[i1+1])=length(Tip)) and (s1=Tip) then
Begin
form1.Memo2.Lines.Delete(i1+1);
form1.Memo2.Lines[i1]:=form1.Memo2.Lines[i1]+Tip;
End
Else
  IF (Length(form1.Memo2.Lines[i1+7])>length(Tip)) and (s1=Tip)Then
  Begin
s1:=Form1.Memo2.Lines[i1+1];
     Delete(s1,1,1);
     Form1.Memo2.Lines[i1+1] := s1;
     form1.Memo2.Lines[i1]:=form1.Memo2.Lines[i1]+Tip;
    End;
End;
end;
//Поднимает переменные к var
Procedure per;
var
  s,s1:String;
  i:integer;
begin
s := Form1.Memo2.Lines[1];
i := pos('var',s);
IF i<>0 Then
begin
   s1 := Copy(s,5,1);
   IF (s1 = '')or(s1 = ' ') Then
   begin
      Form1.Memo2.Lines[1] := s + ' ' + Form1.Memo2.Lines[2];
      Form1.Memo2.Lines.Delete(2);
   end;
end;
end;
//Процедура создает массив переменных
Procedure MasPer;
var
  s,s1,s2,s3:String;
  i,x,y,p,j:integer;
Begin
  s := Form1.Memo2.Lines[1];
  Sc_per := 1;
   x := pos(':',s);
    s1 := Copy(s,5,x-5);
      y := pos(',',s1);
       s2 := Copy(s1,1,y-1);
         p := pos(' ',s1);
   For i := 2 to Length(s1) do
     begin
       y := pos(',',s1);
       s2 := Copy(s1,1,y-1);
       IF s2<>'' Then
         begin
           Perem[i] := s2;
           delete(s1,1,y);
           Sc_per := Sc_per + 1;
         end;
      s3 := Copy(s1,p,x-5);
      Perem[1] := s3;
            end;
end;
Procedure p;
var j:integer;
Begin
for j := 1 to form1.Memo1.Lines.Count - 1 do
IF (form1.Memo1.Lines[j] = ' ')or(form1.Memo1.Lines[j] = '  ')or(form1.Memo1.Lines[j] = '   ')or(form1.Memo1.Lines[j] = '    ')or(form1.Memo1.Lines[j] = '     ')or(form1.Memo1.Lines[j] = '      ')or(form1.Memo1.Lines[j] = '        ')or(form1.Memo1.Lines[j] = '        ') Then form1.Memo1.Lines.Delete(j);
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Функция для проверки множества мат. функций.
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
{procedure Function31;
var
   s1,s,s2:string;
   i1,j:integer;
   symbol:array[1..4]of char;
begin
  While pos(':=',Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
  s1 := Form1.Memo2.Lines[i1];
  symbol[1]:='+';
  symbol[2]:='-';
  symbol[3]:='*';
  symbol[4]:='/';
  s:='';
For j := 1 to 4 do
begin
  IF Pos(symbol[j],s1)<>0 then s := symbol[j];
  IF s<>'' Then Delete(s1,pos(s,s1),pos(s,s1));
//  Form1.Memo2.Lines[i1] := s1;
end;
end; }

{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
{завершающая процедура удаления всего лишнего}
procedure Delstrim;
Begin
p;
copystr;
//Function31;
SimvolUp(';');
WinUp('wincrt;');
WinUp('wincrt');
Per;
MasPer;
SimvolUp('.');
//SimvolUp(',');
//SimvolUp(':');
SimvolUp('(');
SimvolUp(')');
{Тип без ;}
TipUp('integer');
TipUp('real');
TipUp('char');
TipUp('string');
TipUp('boolean');
{Тип с ; }
TipUp('integer;');
TipUp('real;');
TipUp('char;');
TipUp('string;');
TipUp('boolean;');
End;
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
           {Конец. Раздела приведения текста к нормальным параметрам}
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
{Начало. Раздела функций основ т. е.  функций на которых будет онована вся
                                     програма}
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}

{функция выполняет проверку колличества втречи строки(слова) в теле программы
если строка встречается больше чем raz1 раз, то функция принимает значение false
иначе True}
function Function0(raz1:integer; stroka1:string): string;
var
i1,kol1:integer;
Begin
kol1:=0;
For i1:=0 to form1.memo2.lines.count-1 Do
If pos(stroka1,form1.Memo2.Lines[i1])>0 then kol1:=kol1+1;
If kol1>raz1 Then Function0:='слово '+stroka1+' встречается больше '+inttostr(raz1)+' раза'
else Function0:=''
End;

{функция ищет слово в массиве}
function Function1(in1: string):string;
var i1:integer;
pr: string;
Begin
i1:=-1;
While (i1<form1.memo2.lines.count-1) and (pos(in1,pr)=0) do
Begin
i1:=i1+1;
pr:=form1.Memo2.Lines[i1];
If pos(in1,pr)>0 then
Function1:=''
Else Function1:='Ошибка в правописании '+in1;
End;
End;

{проверяет есть ли лишние символы перед словом}
Function Function2(instr:string; symbol:string):string;
var i1,x1:integer;
s,s1:string;
Begin
While pos(instr,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
s1:=Form1.Memo2.Lines[i1];
x1:=pos(instr,s1);
s :=  Copy(s1,2,1);
IF s =' ' Then Delete(s,1,1);
IF (s1[x1-1]=' ') or (s1[x1-1]=symbol) or (x1=1) Then Function2:=''
else function2:='Лишние символы перед '+instr;
End;

{проверяет есть ли лишние символы после слова}
Function Function3(instr:string): string;
var i1,x1,ln:integer;
s1:string;
Begin
While pos(instr,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
s1:=Form1.Memo2.Lines[i1];
x1 := pos(instr,s1);
IF (instr='write')Then
IF (s1[x1+length(instr)]=' ') or (s1[x1+length(instr)]=';') or (s1[x1+length(instr)]=''){}or
 (s1[x1+length(instr)]='(')or((s1[x1+length(instr)]=' ')and
 ((s1[x1+length(instr)+1]='(')or(s1[x1+length(instr)+1]=';')))OR
 ((s1[x1+length(instr)]='l')and(s1[x1+length(instr)+1]='n')and
((s1[x1+length(instr)+2]='(')or(s1[x1+length(instr)+2]=' ')or(s1[x1+length(instr)+2]=';'))Or(s1[x1+length(instr)+2]=' ')and((s1[x1+length(instr)+3]=';')or(s1[x1+length(instr)+3]='(')))
then
 Function3:=''
 else function3:='Лишние символы в строке '+s1

 Else IF (instr='end')Then
   IF (s1[x1+length(instr)]=' ') or (s1[x1+length(instr)]=';') or (s1[x1+length(instr)]='.')or (s1[x1+length(instr)]='')Then Function3:=''
      else function3:='Лишние символы после '+instr
      
 Else IF (instr='gotoxy')Then
   IF (s1[x1+length(instr)]=' ') or (s1[x1+length(instr)]='(')Then Function3:=''
      else function3:='Лишние символы в строке '+s1

Else IF {(instr<>'writeln')and}(instr<>'write')and(instr<>'end')Then
If (s1[x1+length(instr)]=' ') or (s1[x1+length(instr)]=';') or (s1[x1+length(instr)]='') Then Function3:=''
else function3:='Лишние символы после '+instr;
End;

{inword слово после которго должен стоять стоит symbol, symbol-сам символ}
Function Function4(inword:string; symbol:char):string;
var i1,x1:integer;
s1,s2:string;
Begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
  s1 := Form1.Memo2.Lines[i1];
   x1 := pos(inword,s1);
IF (s1[x1+length(inword)]=symbol)or(s1[x1+length(inword)+1]=symbol) Or((s1[x1+length(inword)]='l')and(s1[x1+length(inword)+1]='n')) Then Function4:=''
 else function4:='После '+inword+' нет '+ symbol;
End;

Function Function5(inword:string):string;
var i1,x1:integer;
s1,s2:string;
Begin
While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
s1:=Form1.Memo2.Lines[i1];
x1:=pos(inword,s1);
s2 := Copy(s1,5,6);
If s1[x1+length(inword)]=' '  Then Function5:=''
else if s2='wincrt' then function5:='После '+inword+' нет пробела';
End;


Function Function6(inword:string; symbol:char):string;
var i1,x1:integer;
s1:string;
Begin
While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
s1:=Form1.Memo2.Lines[i1];
x1:=pos(inword,s1);
If ((s1[x1+length(inword)]=symbol)and (s1[x1+length(inword)+1]<>symbol))or
((s1[x1+length(inword)]<>symbol)and (s1[x1+length(inword)+1]=symbol))
Then Function6:=''
else function6:='Более одной ' + symbol+ ' подряд после '+inword;
End;
{}
{ищет uses или  wincrt}
Function Function7(inword:string):String;
Var
   pr:String;
x1,x2,x3,x4,x5,x6,y,z:Integer;
Begin
   pr := Form1.Memo2.Lines[0];
   x1 := pos(inword[1],pr);
   x2 := pos(inword[2],pr);
   x3 := pos(inword[3],pr);
   x4 := pos(inword[4],pr);
   x5 := pos(inword[5],pr);
   x6 := pos(inword[6],pr);
y := pos('uses',pr);
z := pos('wincrt',pr);
IF (y<>0)or(z<>0)Then
begin
   IF ((x1<>0)and(x2<>0)and(x3<>0)and(x4<>0))or
      ((x1<>0)and(x2<>0)and(x3<>0)and(x4<>0)and
      (x5<>0)and(x6<>0)) Then Function7:=''
   Else
     IF ((x1=0)and(x2=0)and(x3=0)and(x4=0))or
        ((x1=0)and(x2=0)and(x3=0)and(x4=0)and
        (x5=0)and(x6=0))Then Function7:='Ненайден '+Inword;
end
Else
IF ((x1=0)and(x2=0)and(x3=0)and(x4=0))and
((x1=0)and(x2=0)and(x3=0)and(x4=0)
and(x5=0)and(x6=0)) Then Function7:='Отсутствует строка uses wincrt;';
end;

//Хоть они и похожи, но всежи они разные...:-)
Function Function8(inword:string):String;
Var
   pr,ss:String;
x1,x2,x3,x4,x5,i,j:Integer;
Begin
For i := 1 to Form1.Memo2.Lines.Count-1 do begin
   pr := Form1.Memo2.Lines[i];
   x1 := pos(inword[1],pr);
   x2 := pos(inword[2],pr);
   x3 := pos(inword[3],pr);
   x4 := pos(inword[4],pr);
   x5 := pos(inword[5],pr);

if   ss='ok' then  Function8:=''
else
begin
For j := 1 to 5 do

   IF (pr[j]=inword[j])
//      (x1<>0)and(x2<>0)and(x3<>0)and(x4<>0)and(x5<>0)
      Then
      begin
      Function8:='';
      ss:='ok';
      end
   Else
   IF(pr[j]<>inword[j])
   //((x1=0)and(x2=0)and(x3=0)and(x4=0)and(x5=0))
   Then  Function8:='Ненайден '+Inword;
   EnD;
end;
End;


//Лишние символы после строки
Function Function12(nom_symbol:integer; inword:string):String;
var
i1,j:integer;
s2,s1:string;
Begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1 := i1+1;
  s1 := Form1.Memo2.Lines[i1];
  s2 := copy(s1,nom_symbol,1800);
For j := 1 to Length(s2) do
IF (s2='')or(s2=' ')or (s2[j]=';')or (s2='.')or(s2[2]='.') Then Function12:=''
 else Function12:='Лишние символы после строки '+inword
   end;

{Проверка лишних символах при ситуации-
uses<Любая строка> wincrt}
Function Function11(inword:string):String;
var i1,x1,x2:integer;
s3,s1:string;
Begin
   While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
s1:=Form1.Memo2.Lines[i1];
x1:=pos(inword,s1);
x2 := pos('wincrt',s1);
s3 := Copy(s1,5,7);
If s3=' wincrt' Then Function11:=''
else    function11:='Между uses и wincrt есть лишнии символы';
end;

Function Function20(nom_symbol:integer;inword:string):string;
var
s1,s2,s3:string;
x,i,j:integer;
begin
  While pos(inword,Form1.Memo2.Lines[i])=0 do i := i+1;
  s1 := Form1.Memo2.Lines[i];
  s2 := copy(s1,nom_symbol,1800);
  x := Pos(')',s2);
  s3 := Copy(s2,x+1,1);
     IF s3=';'  Then Function20 := ''
      else  Function20 := 'После ' +inword+ ' нет ;'
end;


//ошибки в переменных !
Function Function19(inword:String):String;
var
  i1,x1,x2,i,prob,k:integer;
  s1,s2,s3:string;
  a1:array[1..200] of string;
begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1 := i1 + 1;
     s1 := Form1.Memo2.Lines[i1];
     x2 := 0;
     x1 := Pos('(',s1);
    prob := Pos(' ',s1);
//     IF prob<>0 Then delete(s1,prob,1);
     s2 := Copy(s1,x1+1,Pos(#39,s1)-(x1+1));

   For i := 1 to Sc_per do   begin
    IF(s2=perem[i])or(s2=perem[i]+' ')or(s2=' '+perem[i]) or(s2=' '+perem[i]+' ')or
(s2=perem[i]+',')or(s2=' '+perem[i]+',')or(s2=' '+perem[i]+' '+',')or(s2=perem[i]+' '+',')or(s2=perem[i]+','+' ')or(s2=' '+perem[i]+','+' ')or (s2=' '+perem[i]+' '+',')or(s2=' '+perem[i]+' '+','+' ')or(s2=perem[i]+' '+','+' ')or
//Скобки
 (s2='(')or (s2='((')or (s2='(((')or (s2='((((')or(s2='(((((')or(s2='((((((')or(s2='(((((((')or(s2='((((((((')or(s2='((((((((((')or
    (s2='('+perem[i])or(s2='(('+perem[i])or(s2='((('+perem[i])or(s2='(((('+perem[i])or
    (s2='((((('+perem[i])or(s2='(((((('+perem[i])or(s2='((((((('+perem[i])or(s2='(((((((('+perem[i]) or
    (s2='((((((((('+perem[i])or(s2='(((((((((('+perem[i])or(s2='((((((((((('+perem[i])or(s2='((((((((((('+perem[i])OR

    (s2='('+perem[i]+',')or(s2='(('+perem[i]+',')or(s2='((('+perem[i]+',')or(s2='(((('+perem[i]+',')or
    (s2='((((('+perem[i]+',')or(s2='(((((('+perem[i]+',')or(s2='((((((('+perem[i]+',')or(s2='(((((((('+perem[i]+',') or
    (s2='((((((((('+perem[i]+',')or(s2='(((((((((('+perem[i]+',')or(s2='((((((((((('+perem[i]+',')or(s2='((((((((((('+perem[i]+',')
    then x2 := x2 + 1;
s3 := Copy(s1,x1,x1+4-Pos(',',s1));
IF (s3<>'(,'+#39) Then
    IF (x2 <> 0)or(s2='')or(s2=' ')Then Function19 := ''
     Else  Function19 := 'После '+inword+ ' стоит неизвестная переменная!'
     Else  Function19 := 'Перед , нет переменой!'
END;

end;
//Запятая после переменной
Function Function23(inword:string):String;
var
  i1,x1,x2,k:integer;
  s1,s2,s3:string;
begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1 := i1 + 1;
     s1 := Form1.Memo2.Lines[i1];
     x2 := 0;
     x1 := Pos('(',s1);
     s2 := Copy(s1,x1+1,Pos(#39,s1)-(x1+1));
     s3 := Copy(s1,length(s2)+length(inword),4);
 IF (Pos(',',s3)<>0)or(s2='')or(s2=' ')or(s2='(')or(s2='((')or
 (s2='(((')or(s2='((((')or(s2='(((((')or(s2='((((((')or(s2='(((((((') Then Function23 := ''
   else Function23 := 'После переменной '+ s2+' нет ,';
end;

Function Function24(inword:String):String;
var
  i1,x1,x2,i:integer;
  s1,s2,s3,ss1:string;
begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1 := i1 + 1;
     s1 := Form1.Memo2.Lines[i1];
     x2 := 0;
     x1 := Pos(')',s1);
//     s2 := Copy(s1,x1+1,Pos(#39,s1)-(x1+1));
     s3 := Copy(s1, Pos(#39,s1)+1 ,x1);
   For i := 1 to Sc_per do begin
//   Pos(',',s3) or
IF Pos(',',s3)<>0 Then s2 := Copy(s3,Pos(',',s3)+1,length(perem[i])+1)
Else s2 := Copy(s3, Pos(#39,s3)+1,length(perem[i])+1);

    IF(s2=perem[i])or(s2=perem[i]+' ')or(s2=' '+perem[i]) or(s2=' '+perem[i]+' ')or
(s2=','+perem[i])or(s2=','+perem[i]+' ')or(s2=','+' '+perem[i]+' ')or
(s2=' '+','+perem[i])or(s2=' '+','+perem[i]+' ')or (s2=perem[i]+');')or
(s2=' '+perem[i]+');')or (s2=perem[i]+' );')or(s2=' '+perem[i]+' );')or
{Скобки}
 (s2=')')or (s2='))')or (s2=')))')or (s2='))))')or(s2=')))))')or(s2='))))))')or(s2=')))))))')or(s2='))))))))')or(s2=')))))))))')or
    (s2=perem[i]+')')or(s2=perem[i]+'))')or(s2=perem[i]+')))')or(s2=perem[i]+'))))')or
    (s2=perem[i]+')))))')or(s2=perem[i]+'))))))')or(s2=perem[i]+')))))))')or(s2=perem[i]+'))))))))') or
    (s2=perem[i]+'))))))))')or(s2=perem[i]+')))))))))')or(s2=perem[i]+')))))))))))')or(s2=perem[i]+'))))))))))))')OR
//(s2=');') or (s2=','+perem[i])or
    (s2=','+perem[i]+')')or(s2=','+perem[i]+'))')or(s2=','+perem[i]+')))')or(s2=','+perem[i]+'))))')or
    (s2=','+perem[i]+')))))')or(s2=','+perem[i]+'))))))')or(s2=','+perem[i]+')))))))')or(s2=','+perem[i]+'))))))))') or
    (s2=','+perem[i]+'))))))))')or(s2=','+perem[i]+')))))))))')or(s2=','+perem[i]+')))))))))))')or(s2=','+perem[i]+'))))))))))))')
    then x2 := x2 + 1;
ss1 := Copy(s3,Pos(');',s3)-2,Length(s2)+2);
IF (ss1<>#39+',);')And(ss1<>' ,);')AND(ss1<>', );')and(ss1<>',,);') Then
    IF (x2 <> 0)or(s2=');')or(s2=' '+')')Then Function24 := ''
     Else
     Function24 := 'После '+inword+ ' стоит неизвестная переменная!'
Else Function24 := 'После , нет переменой!'
END;;;
end;

//Перед переменной нет ,
Function Function25(inword:string):String;
var
  i1,x2,x3,i,k:integer;
  s1,s2,s3:string;
begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1 := i1 + 1;
     s1 := Form1.Memo2.Lines[i1];
     x3 := Pos(')',s1);
     s3 := Copy(s1,Pos(#39,s1)+1,x3);
     s2 := Copy(s3,Pos(#39,s3)+1,x3);
For k := 0 to Sc_per*2 do
begin
  For i := 0 to Sc_per*2 do  begin
  x2 := Pos(Perem[i+k],s2);
  IF x2<>0 Then
  IF (Pos(','+Perem[i+k],s2)<>0)or(Pos(','+' '+Perem[i+k],s2)<>0)or(Pos(' '+','+' '+Perem[i+k],s2)<>0)or(Pos(' '+','+Perem[i+k],s2)<>0) Then Function25 := ''
   else Function25 := 'Перед переменной '+ Perem[i+k]+' нет ,'
End
End
end;

Function Function27(inword:string):string;
var
  i1,x2,x3,x1:integer;
  s1,s2,s3,s4:string;
begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1 := i1 + 1;
     s1 := Form1.Memo2.Lines[i1];
     x2 := Pos('(',s1);
     x3 := Pos(')',s1);
     s2 := Copy(s1,x2+1,x3);
     x1 := Pos(',',s1);
     s3 := Copy(s1,x2+1,x1-(x2+1));
     s4 := Copy(s1,x1+1,x3-(x1+1));
IF x1 <> 0 Then
     try
      IF  ((StrToInt(s3)>=1)or(StrToInt(s3)<=9))and
      ((StrToInt(s4)>=1)or(StrToInt(s4)<=9))
      Then Function27:='';
     except on EConvertError do
      Function27 := 'Ошибка в вводимом числе  после '+inword;
end
Else
   Function27 := 'После ' +inword+ ' нет ,';
end;

Function Function28(inword:string):String;
var
  i1,x1,x2:integer;
  s1 :String;
begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1 := i1 + 1;
     s1 := Form1.Memo2.Lines[i1];
     x1 := Pos('(',s1);
     x2 := Pos(')',s1);
IF (x1 <> 0)and(x2 <> 0) Then Function28 := ''
Else IF (x1 = 0)and(x2 <> 0) Then Function28 := 'Отсутствует начальная скобка после '+Inword
Else IF (x1 <> 0)and(x2 = 0) Then Function28 := 'Отсутствует конечная скобка после '+Inword
Else IF (x1 = 0)and(x2 = 0) Then Function28 := 'Отсутствуют скобки после '+Inword
end;

Function Function29:boolean;
begin
End;

Function Function26_Write:Boolean;
Var
  i,x,z,x1:Integer;
  s:String;
Begin
  Function26_Write := False;
  For i := 3 To Form1.Memo2.Lines.Count-1 Do
    Begin
      s := Form1.Memo2.Lines[i];
      x := Pos('ln',s);
      x1 := Pos('l n',s);
IF (x <> 0)or(x1<>0) Then
begin
z := 1;
 IF (Function1('writeln')='')Then function26_Write := True
  Else Form1.Label1.Caption := Function1('writeln')
end
Else IF (Function1('writeln')<>'')and (Function1('write')='')
Then function26_Write := True

Else IF  (Function1('write')<>'')and(z<>1)
Then Form1.Label1.Caption := Function1('write')
    End;
end;

Function Function25_write:boolean;
begin
Function25_write := False;
IF Function25('write')='' then Function25_write := True
Else Form1.Label1.Caption:=Function25('write');
end;

Function Function24_write:boolean;
begin
Function24_write := False;
IF Function24('write')='' then Function24_write := True
Else Form1.Label1.Caption:=Function24('write');
end;


//кол-во скобок
Function Function21(inword:string):string;
var
  s1,s2:string;
  i1,x1,y,i,k,n:integer;
begin
  While pos(inword,Form1.Memo2.Lines[i1]) = 0 do i1 := i1 + 1;
    s1 := Form1.Memo2.Lines[i1];
    k := 0;
    n := 0;
    For i := 1 to Length(s1) do
      begin
        s2 := s1;
        x1 := Pos('(',s2);
        y := Pos(')',s2);
        IF y<>0 Then
          begin
             k := k + 1;
             Delete(s1,y,1);
          END;
    IF x1<>0 Then
      begin
        n := n + 1;
        Delete(s1,x1,1);
      END;
end;
    IF n>k Then Function21 := 'Конечная скобка не закрыта после '+inword
     Else
       IF n<k Then Function21 := 'Начальная скобка не открыта после '+inword
        Else
          IF k=n Then Function21 := '';
end;

//кол-во опострофов
Function Function22(inword:string):string;
var
  s1,s2:string;
  i1,x1,y,i,n:integer;
begin
  While pos(inword,Form1.Memo2.Lines[i1]) = 0 do i1 := i1 + 1;
    s1 := Form1.Memo2.Lines[i1];
    n := 0;
    x1 := Pos(#39,s1);
    y := Pos(')',s1);
    s2 :=Copy(s1,x1,y-3);
For i := 1 to Length(s1) do
begin
    x1 := Pos(#39,s1);
    y := Pos(')',s1);
    s2 := Copy(s1,x1,y-3);
  IF x1<>0 Then
   begin
     n := n + 1;
     Delete(s1,x1,1);
   END;
//s2 :=Copy(s1,x1,y-3);
end;
IF (n<>1)Then
IF (n mod 2 = 0){and(pos(#39,s2)=0)} Then Function22 := ''
 Else
   IF n mod 2 <> 0 Then Function22 := 'В строке '+inword+' есть лишнии опостроф(ы)'
    Else Function22 := ''
    Else IF n=1 Then Function22 := 'Отсутствует начальный опостров после '+inword;
end;
{*********************Раздел Описания ":="*********************}
//*****************************************************************************************
{Если переменной присваивается значение другой переменной или значение с мат. функциями(ей)}
//*****************************************************************************************
{============================================================}
{============================ДО ЗНАКА========================}
{============================================================}
Function Function30_2(inword:string):String;
Var
  g,i1,i:Integer;
  s1,c2 :String;
  ok:boolean;
Begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
  s1 := Form1.Memo2.Lines[i1];
   c2 := copy(s1,1,pos(':=',s1)-1);
  g := 0;
  Ok := False;
  For i := 1 to sc_per do
    IF c2 = perem[i] Then Ok := true;
       IF ok = false Then Function30_2 := 'Ошибка в имени переменной которой присваивается значение.'
       Else Function30_2 := '';
end;

Function Function30_1(inword:string):String;
Var
  g,j,n1,i1,z,j1,x:Integer;
  nn,m,m2,i:byte;
  s1,c1,c2,c3 :String;
  okk1,ok:Boolean;
  symbol:array[1..4] OF Char;
Begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
  s1 := Form1.Memo2.Lines[i1];
  symbol[1]:='+';
  symbol[2]:='-';
  symbol[3]:='*';
  symbol[4]:='/';
  x := 0;
{     Delete(s1,pos(':=',s1)+1,pos(c3,s1));
   Form1.Memo2.Lines[i1]:=s1;
 }

 For j := 1 to 4 do IF pos(symbol[j],s1)<> 0 Then
    begin
      c3 := symbol[j];
      x := x + 1;
    end;
    // Delete(s1,pos(':=',s1)+1,pos(c3,s1));
 IF (x > 1) Then
  c1 := Copy(s1,pos(inword,s1)+2,pos(c3,s1)-pos(inword,s1)-2)
  Else
  c1 := Copy(s1,pos(inword,s1)+2,pos(c3,s1)-pos(inword,s1)-2);

  z := 0;
  okk1 := false;


  For nn := 1 to sc_Per do
     IF (c1 = perem[nn]) then okk1 := true;
      IF okk1 Then z := z + 1
       Else
         IF not okk1 Then
          begin
            Function30_1 := 'Ошибка в присваевом значении до знака операции';
            For m2 := 0 to length(c1) do
              Begin
                For n1 := 1 to length(c1) do
                  begin
                    m := m + 1;
                    IF ((m<>Length(c1))and(c1[n1]>=#48)and(c1[n1]<=#57)) Then okk1 := False
                     Else
                       okk1 := True;
                    IF okk1 Then z := z + 1;
          END;
              End;
                  end;
//Else
   IF (z=1)or(z=0) Then Function30_1 := ''
    Else Function30_1 := 'Ошибка в присваевом значении  до знака операции';

end;
{============================================================}
{=========================ПОСЛЕ ЗНАКА========================}
{============================================================}
Function Function30(inword:string):String;
Var
  i1,j,z,n1:Integer;
  nn,m,m2,w,x:byte;
  s1,c1,c2,c3,ss :String;
  okk1:Boolean;
  symbol :Array[1..4]Of char;
Begin
  x := 0;
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
  s1 := Form1.Memo2.Lines[i1];
  symbol[1]:='+';
  symbol[2]:='-';
  symbol[3]:='*';
  symbol[4]:='/';
  c3:='';
For j := 1 to 4 do IF pos(symbol[j],s1)<> 0 Then
begin
c3 := symbol[j];
x := x + 1;
end;
IF x = 1 Then c2 := Copy(s1,pos(c3,s1)+1,length(s1)-(pos(c3,s1)+1));
//Else IF x > 1 Then c2 := Copy(s1,pos(c3,s1)+1,length(s1)-(pos(c3,s1)+1));
  z := 0;
  okk1 := false;
       For nn := 1 to sc_Per do
         IF (c2 = perem[nn]) then okk1 := true;
           IF okk1 Then z := z + 1
             Else
               IF not okk1 Then
                 begin
                   Function30 := 'Ошибка в присваевом значении  после знака операции';
                   For m2 := 0 to length(c2) do
                     Begin
                       For n1 := 1 to length(c2) do
                         begin
                           m := m + 1;
                           IF ((m<>Length(c2))and(c2[n1]>=#48)and(c2[n1]<=#57)) Then okk1 := False
                            Else
                              okk1 := True;
                              IF okk1 Then z := z + 1;
                         END;
                     End;
                 end;
         IF (z=1)or(z=0)or(c3='') Then Function30 := ''
         Else
           Function30 := 'Ошибка в присваевом значении после знака операции';
end;
//Функция ищет ощибки если переменной присваевается простое значение
Function Function30_3(inword:string):String;
Var
  z,i1,i,nn,m2,m,n1,x:Integer;
  j:byte;
  s1,c2,s :String;
  ok:boolean;
  symbol: array[1..4] Of char;
Begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
  s1 := Form1.Memo2.Lines[i1];
  symbol[1]:='+';
  symbol[2]:='-';
  symbol[3]:='*';
  symbol[4]:='/';
  s:='';
For j := 1 to 4 do IF Pos(symbol[j],s1)<>0 then s := symbol[j];
IF s='' Then
Begin
   c2 := copy(s1,pos(':=',s1)+2,pos(';',s1)-(pos(':=',s1)+2));
  Ok := False;
  z := 0;
    For nn := 1 to sc_Per do
     IF (c2 = perem[nn]) then ok := true;
      IF ok Then z := z + 1
       Else
         IF (not ok) Then
          begin
            Function30_3 := 'Ошибка в присваевом значении';
            For m2 := 0 to length(c2) do
              Begin
                For n1 := 1 to length(c2) do
                  begin
                    m := m + 1;
                    IF ((m<>Length(c2))and(c2[n1]>=#48)and(c2[n1]<=#57)) Then ok := False
                     Else
                       ok := True;
                    IF ok Then z := z + 1;
          END;
              End;
                  end;
     //  End;
     IF (z=1)or(z=0) Then Function30_3 := ''
    Else Function30_3 := 'Ошибка в присваемом значении';
END
Else
begin
  c2 := copy(s1,pos(':=',s1)+pos(';',s1)-3,pos(';',s1)-(pos(':=',s1)+2));
  IF (c2='+;')or(c2='-;')or(c2='*;')or(c2='/;') Then Function30_3 :='После присваемового значения не должно быть мат. функций.'
  Else
    Function30_3 :='';
end
end;

{***********************************************************}
{****************************скобки*************************}
{***********************************************************}
{-----------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
     {Конец. Раздела функций основ т. е.  функций на которых будет
                            строоится вся программа}
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}
  {!!!!!!начало раздела функций для описания строки uses wincrt!!!!!!!}
{---------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----------------}

function Function0_UsesWincrt: boolean;
Begin
Function0_UsesWincrt:=False;
If Function0(1,'uses')='' then
If Function0(1,'wincrt')='' Then Function0_UsesWincrt:=true
Else form1.Label1.Caption:=Function0(1,'wincrt')
Else form1.Label1.Caption:=Function0(1,'uses');
End;

Function function1_UsesWincrt:boolean;
Begin
function1_UsesWincrt:=false;
If Function1('uses')=''then
   If Function1('wincrt')='' then function1_UsesWincrt:=True
      else Form1.Label1.Caption:=Function1('wincrt')
   Else Form1.Label1.Caption:=Function1('uses');
End;
Function function2_Uses:boolean;
Begin
Function2_Uses:=False;
If function2('uses','')='' then Function2_Uses:=true
Else Form1.Label1.Caption:=Function2('uses','');
End;

Function function2_Wincrt:boolean;
Begin
Function2_Wincrt:=False;
If function2('wincrt','')='' then Function2_Wincrt:=true
      else Form1.Label1.Caption:=Function2('wincrt','');
End;

Function function3_Uses:boolean;
Begin
Function3_Uses:=False;
If function3('uses')='' then Function3_Uses:=true
Else Form1.Label1.Caption:=Function3('uses');
End;
Function function3_Wincrt:boolean;
Begin
 Function3_Wincrt:=False;
 If function3('wincrt')='' then Function3_Wincrt:=true
    else Form1.Label1.Caption:=Function3('wincrt');
End;

Function function4_Wincrt:boolean;
Begin
Function4_Wincrt:=False;
 If function4('wincrt',';')='' then Function4_Wincrt:=true
      else Form1.Label1.Caption:=function4('wincrt',';')
End;

Function function5_Uses:boolean;
Begin
Function5_Uses:=False;
 If function5('uses')='' then Function5_Uses:=true
      else Form1.Label1.Caption:=function5('uses');
End;

Function function6_Wincrt:boolean;
Begin
Function6_Wincrt:=False;
 If function6('wincrt',';')='' then Function6_Wincrt:=true
      else Form1.Label1.Caption:=function6('wincrt',';');
End;
Function Function11_UsesWincrt:boolean;
Begin
Function11_UsesWincrt:=False;
 If function11('uses')='' then Function11_UsesWincrt:=true
      else Form1.Label1.Caption:=function11('uses');
end;

Function Function7_UsesWincrt:boolean;
Begin
function7_UsesWincrt := false;
If Function7('uses')=''then
   If Function7('wincrt')='' then function7_UsesWincrt:=True
      else Form1.Label1.Caption:=Function7('wincrt')
   Else Form1.Label1.Caption:=Function7('uses  ');
End;

Function Function12_UsesWincrt:boolean;
begin
Function12_UsesWincrt:=false;
IF Function12(13,'uses wincrt')='' Then Function12_UsesWincrt:= True
else   Form1.Label1.Caption:=Function12(13,'uses wincrt');
end;


{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++А тут уже ВАР:-)++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

{Функция проверяет наличие переменных между var  и типом}
Function Function13(Vari,Tip: String):String;
Var s1,s2:string;
Begin
s1 := Form1.Memo2.Lines[1];
s2 := Copy(s1,5,8);
If (s2<>':'+tip)  Then Function13:=''
else function13:='Необъявлены переменные между var и ' + Tip;
end;

//если между переменными нет запятой
Function Function9_v1:Boolean;
Var
  s,s1,s2,per:string;
  x,i,z,k :Integer;
Begin

  s := Form1.Memo2.Lines[1];
  s1 := Copy(s,5,100);
  x := Pos(' ',s1);
  s2 := Copy(s1,x-1,x+2);
  per := s2;
  z := Length(s1);
  For i := 1 to z do
  begin
  if (s2[1]=' ')and(s2[3]=' ')then
   Function9_v1 := false
  else
    IF s2[1]=':' then
          Function9_v1 := True
else
  If (s2[1]=' ')and(s2[3]=' ')and(s2[4]<>',') Then//!!!!!!!!!!!!!!!!!!!!!!!!
   Function9_v1 := false
  else

  IF ((s2[1]<>' ') and (s2[3]<>' ')) Then
  Begin
    IF ((s2[3]<>':')and (s2[3]<>',')) and (s2[1]<>',') Then
    Begin
     IF (s2[2]<>' ')  Then
       Begin
          Function9_v1 := True;
          Delete(s2,x-i,x+2);
          s2 := Copy(s1,x-i,x+2);
          Form1.Label1.Caption := '';
        end
          Else IF (s2[2]=' ') Then
            begin
              Function9_v1:=False;
              Form1.Label1.Caption := 'Между переменными нет запятой';
            end
            else IF s2[1]=' ' Then Function9_v1:=True;
    end
      else Function9_v1:=True;
 end;
  end;

end;
// Между запятыми нет переменной
Function Function16_v2:boolean;
var
  s,s1:string;
  x :Integer;
Begin
  s := Form1.Memo2.Lines[1];
  s1 := Copy(s,5,100);
  x := Pos(', ,',s1);
 Function16_v2 := False;
  IF x = 0 Then
begin
  Function16_v2:=True;
  Form1.Label1.Caption := '';
end
else
   Form1.Label1.Caption := 'Между запятыми нет переменной';
end;

// функция проверяет лишние символы перед переменными.
Function Function17_v3:boolean;
Var
  s,s1,s2:String;
  z,x,i:Integer;
Begin
   s := Form1.Memo2.Lines[1];
   s1 := Copy(s,5,100);
   x := Pos(',',s1);
   s2 := Copy(s1,1,1);
   z := Length(s1);
   Function17_v3 := False;
   For i := 1 to z do
   Begin
     IF(s2 <> '0' ) and (s2 <> '1') and(s2 <> '2' ) and (s2 <> '3') and(s2<> '4' ) and (s2<> '5')and(s2 <> '6' ) and (s2<> '7') and(s2 <> '8' ) and (s2 <> '9')
     Then
       begin
          Function17_v3 := True;
          Delete(s2,1,x+1);
          s2 :=Copy(s1,1,x+1);
          Form1.Label1.Caption := '';
       end
        else Form1.Label1.Caption := 'Перед переменными не должны стоять символы отличные от латинского алфавита или _';
   end;
end;
//{цифры} (s2 <> '0' ) and (s2 <> '1') and(s2 <> '2' ) and (s2 <> '3') and(s2 <> '4' ) and (s2 <> '5') and           (s2 <> '6' ) and (s2 <> '7') and(s2 <> '8' ) and (s2 <> '9') and


{функция проверяет количество или отсутствие :}
Function Function10(inword:string; symbol:char):string;
var i1,x1:integer;
s1,ss:string;
Begin
  While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
  s1:=Form1.Memo2.Lines[i1];
  ss:=copy(inword,1,1);
  x1 := pos(symbol,s1);

IF (x1<>0)and((s1[x1+1]<>ss)and(s1[x1+1]<>':')and(s1[x1-1]<>' ')and(s1[x1+1]<>' ')) then
begin
Function10:='Лишнии символы перед '+inword;
end
else

IF x1<>0 then
begin
  if s1[x1+1]=' ' then delete(s1,x1+1,1);
     If s1[x1+1]=':'  Then Function10:='больше 1-го идущих подряд :'
        else
          If s1[x1+1]=ss  Then Function10:=''
            else function10:='Перед '+inword+' нет '+ symbol;
end
else function10:='Отсутствует '+symbol;
End;



{Функция проверки кол-вa запятых}
Function Function14: Boolean;
Var s1,s2,s3:string;
x,z:Integer;
Begin
   s1 := Form1.Memo2.Lines[1];
   s2 := Copy(s1,5,100);
   x := Pos(',,',s2);
   s3 := Copy(s2,x,2);
   z := length(s2);
       IF x = 0  Then
           Begin
             Function14 := True;
           end
           Else
             begin
               Form1.Label1.Caption:='Больше одной подряд идущей запятой - в объявленых переменных';
               Function14:=False;
            end;
end;

{Функция проверки правельности имен переменных}
Function Function15_per: Boolean;
Var
  s,s1,s2:string;
  i,z : integer;
  op:char;
Begin
   s := Form1.Memo2.Lines[1];
   s1 := Copy(s,5,100);
   s2:= Copy(s1,1,1);
   z := length(s1);
   op:=#39;
   For i := 1 to z do
     begin
        IF{Другие символы}(s2 <> '!' ) and (s2 <> '@') and(s2 <> '#' )and (s2 <> '$')and(s2 <> '^' ) and (s2 <> '%') and(s2 <> op ) and (s2 <> '*') and(s2 <> '(' ) and (s2 <> ')') and(s2 <> '[' ) and (s2 <> ']') and(s2 <> '-' ) and (s2 <> '+') and (s2 <> '|' ) and (s2 <> '\') and (s2 <> '/' ) and (s2 <> '=') and (s2 <> '?' ) and (s2 <> ';') and (s2 <> '~') and (s2 <> '`') and(s2<>'"') and (s2<>'.')and (s2<>'<')and (s2<>'>')and (s2<>'&')and (s2<>'')
{Russian алфавит} and (s2 <> 'й' ) and (s2 <> 'ц') and(s2 <> 'к' ) and (s2 <> 'у') and (s2 <> 'е' ) and (s2 <> 'н') and (s2 <> 'г' ) and (s2 <> 'ш') and (s2 <> 'щ' ) and (s2 <> 'з') and (s2 <> 'х' ) and (s2 <> 'ъ') and (s2 <> 'ф' ) and (s2 <> 'ы') and (s2 <> 'в' ) and (s2 <> 'а') and (s2 <> 'п' ) and (s2 <> 'р') and (s2 <> 'о' ) and (s2 <> 'л') and (s2 <> 'д' ) and (s2 <> 'ж') and (s2 <> 'э' ) and (s2 <> 'я') and (s2 <> 'ч' ) and (s2 <> 'с') and (s2 <> 'м' ) and (s2 <> 'и') and (s2 <> 'т' ) and (s2 <> 'ь') and(s2 <> 'б' ) and (s2 <> 'ю') and (s2 <> 'ё') Then
           begin
              Function15_per := True;
              Delete(s2,i,1);
              s2 := Copy(s1,i,1);
              Form1.Label1.Caption := '';
           end
         Else
           begin
             Function15_per:=False;
             Form1.Label1.Caption := 'Ошибка в правописании объявленной переменной. Там не должно быть символа-> '+s2;
         end;
     end;
end;
{------------------------------------------------------------}
function Function1_Var:Boolean;
Begin
Function1_Var := False;
If (Function1('var ') = '') then
function1_var := True
  else
   Form1.Label1.Caption:=Function1('var ');
end;

function Function1_Tip:Boolean;
Begin
Function1_Tip := False;
If Function1('integer')=''{) or(Function9('real')='')} then
    begin
       function1_Tip := True;
     end
     Else Form1.Label1.Caption:=Function1('integer');
end;

Function function2_var:boolean; //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Begin
Function2_var := False;
If function2('var',' ')='' then Function2_var := true
Else Form1.Label1.Caption:=Function2('var',' ');
End;

Function function2_Tip:boolean; //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Begin
Function2_tip := False;
If (function2('integer',' ')='') or(function2('integer',':')='') then Function2_tip := true
Else Form1.Label1.Caption:=Function2('integer',' ');
End;

Function Function4_Int:Boolean;
Begin
Function4_Int:=False;
 If (function4('integer',';')='') {or (function4('real',';')='')} then Function4_Int := true
      else Form1.Label1.Caption:=function4('integer',';')
end;
  Function function6_tip:boolean;
Begin
Function6_tip:=False;
 If function6('integer',';')='' then Function6_tip:=true
      else Form1.Label1.Caption:=function6('integer',';');
End;

  Function Function10_Tip:Boolean;
Begin
Function10_Tip:=False;
 If function10('integer',':')='' then Function10_Tip:=true
      else Form1.Label1.Caption:=function10('integer',':')
end;

Function Function13_per:Boolean;
Begin
Function13_per:=False;
IF function13('var ','integer')='' Then Function13_per:=True
Else Form1.Label1.Caption:=function13('var','integer');
end;

{------------------------------------------------------------------------}
{------------------Раздел Описания Begin'a-------------------------------}
{вынесен сюда потому-что основываеться полностью на уже созданых функциях}
{------------------------------------------------------------------------}
{------------------------------------------------------------------------}
//ошибка в проваписании Begin
 function Function1_Beg:Boolean;
Begin
Function1_beg := False;
If (Function1('begin') = '') then
function1_beg := True
  else
   Form1.Label1.Caption:=Function1('begin');
end;
//Лишние символы перед begin
Function function2_beg:boolean;
Begin
Function2_beg := False;
If function2('begin',' ')='' then Function2_beg := true
Else Form1.Label1.Caption:=Function2('begin',' ');
End;

//Лишние символы после begin'a
Function function3_beg:boolean;
Begin
Function3_beg:=False;
 If (function3('begin')='') then Function3_beg:=true
    else Form1.Label1.Caption:=Function3('begin');
End;

//Ненайден Begin
Function Function8_beg:boolean;
Begin
  function8_beg := false;
  If Function8('begin')=''then  function8_beg:=True
    Else Form1.Label1.Caption:=Function8('begin');
End;

// Лишнии Символы после Begin;
Function Function12_beg:boolean;
begin
  Function12_beg := false;
  IF (Function12(6,'begin')='')Then Function12_beg := True
   else Form1.Label1.Caption:=Function12(6,'begin');
end;

function Function0_beg: boolean;
Begin
Function0_beg:=False;
If Function0(1,'begin')='' Then Function0_beg:=true
Else form1.Label1.Caption:=Function0(1,'begin');
End;

{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{------------------------------------------------------------}
{*******************Раздел описания Write********************}
{------------------------------------------------------------}
{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
// Функция проверяет наличие опостровов и скобок после write/writeln
Function Function18_Wri(inword:string{; k1:byte}):String;
var
  i1,x1,x2,x3,x4,x5,x6,z,x7,x8,x9,i,k:integer;
  s1,s2,s3,s4:string;
  p:array[1..400]of string;
Begin
  z := 0;
    While pos(inword,Form1.Memo2.Lines[i1])=0 do i1:=i1+1;
  s1 := Form1.Memo2.Lines[i1];
   x1 := pos(inword,s1);
    s2 := Copy(s1,x1+Length(inword),2000);
      x2 := Pos('(',s2);
        x3 := Pos(')',s2);
For i := 1 to Sc_per do
begin
  s3 := Copy(s2,x2,x3);
//  s4 := Copy(s2,x3-(Length(perem[i])*10),x3);
//s4 := Copy(s2,x3-(Pos(#39,s2)),16);
k := Length(perem[i]);
 s4 := Copy(s2,(x2+2),x3);
end;
//  s4 := Copy(s2,x3-2,2);
          x4 := Pos(#39,s3);
            x5 := Pos(#39,s4);
             x6 := Pos('('+#39+')',s2);
              x7 := Pos('( '+#39+')',s2);
               x8 := Pos('('+#39+' )',s2);
                x9 := Pos('( '+#39+' )',s2);
              //   ss := Copy(s2,x3-1,2);

IF (s2='') Then Function18_wri := 'Отсутствует ; после '+ inword
Else
  IF (s2[1]=';')or(s2[2]=';') Then Function18_wri:=''
        else
          begin
            IF (x5 <> 0){and (k1 = 0)} Then z := z + 1
                    else IF (x5 = 0){and (k1 = 0)}Then Function18_wri := 'Отсутствует конечный опостроф после ' +inword;
            IF (x4 <> 0){and (k1 = 0)} Then z := z + 1
                    else IF (x4 = 0){and (k1 = 0)} Then Function18_wri := 'Отсутствует начальный опостроф после ' +inword;

            IF (x6  = 0){and (k1 = 0) }Then z := z + 1
                    else IF (x6 <> 0){and (k1 = 0)} Then Function18_wri := 'После '+ Inword + ' неможет быть одного опострофа';
            IF (x7  = 0){and (k1 = 0)} then z := z + 1
                    else IF (x7 <> 0){and (k1 = 0)} Then Function18_wri := 'После '+ Inword + ' неможет быть одного опострофа';
            IF (x8  = 0){and (k1 = 0)} then z := z + 1
                    else IF (x8 <> 0){and (k1 = 0)} Then Function18_wri := 'После '+ Inword + ' неможет быть одного опострофа';
            IF (x9  = 0) then z := z + 1
                    else IF (x9 <> 0){and (k1 = 0)} Then Function18_wri := 'После '+ Inword + ' неможет быть одного опострофа';
            IF (x2 = 0)and(x3 = 0) Then  Function18_wri := 'Нет скобок после ' +inword
                    else z := z + 1;
            IF (x4<>0)and(x5<>0){and (k1 = 0)} Then  z := z + 1
                    else IF(x4=0) and(x5=0){and (k1 = 0)} Then Function18_wri := 'После ' +inword+ ' нет опостровоф.'  ;

            IF (z = 8){and (k1 = 0) }Then Function18_wri:=''
        //    Else IF (z = 1)and (k1 = 1) Then Function18_wri:='';
          end;

end;

Function function2_write:boolean;
Begin
Function2_write := False;
IF function2('write',' ')='' then Function2_write := true
Else Form1.Label1.Caption:=Function2('write',' ');
End;

Function function4_Write:boolean;
Begin
Function4_write:=False;
 If (function4('write',';')='') Or(function4('write','(')='')  then Function4_Write:=true
  Else Form1.Label1.Caption:=function4('write',';')
End;
///
Function Function12_Write:boolean;
var i:integer;
begin
Function12_write := False;
 for i := 1 to 200 do begin
 If (function4('write',';')<>'') then
     IF (Function12(i,'write')='')Then Function12_write:= True
       else  Form1.Label1.Caption:= Function12(i,'write')
     else Function12_write:=True;
  end;
end;

Function Function20_write:boolean;
var i:integer;
begin
Function20_write := False;
 for i := 1 to 200 do begin
 If (function12(i,'write')<>'') then
   IF Function20(i,'write')='' Then Function20_write := True
  else form1.Label1.Caption := Function20(i,'write')
  else Function20_write := True;
end;
end;

// Функция проверяет наличие опостровов и скобок после write
Function Function18_write:Boolean;
Begin
Function18_write := False;
IF Function18_Wri('write')='' Then Function18_write := True
Else Form1.Label1.Caption:=Function18_Wri('write');
end;

Function function3_write:boolean;
Begin
Function3_write:=False;
IF function18_wri('write')='' Then
 If function3('write')='' then Function3_write:=true
    else Form1.Label1.Caption:=Function3('write')
    else Function3_write:=true
End;

Function function3_writeln:boolean;
Begin
Function3_writeln:=False;
IF function18_wri('writeln')='' Then
 If function3('writeln')='' then Function3_writeln:=true
    else Form1.Label1.Caption:=Function3('writeln')
    else Function3_writeln:=true
End;

Function Function8_write:boolean;
Begin
  function8_write := false;
  If Function8('write')=''then  function8_write:=True
    Else Form1.Label1.Caption:=Function8('write');
End;

Function Function19_write:boolean;
begin
Function19_write := False;
IF Function19('write')='' then Function19_write := True
Else Form1.Label1.Caption:=Function19('write');
end;

Function Function21_write:boolean;
begin
Function21_write := False;
IF Function21('write')='' then Function21_write := True
Else Form1.Label1.Caption:=Function21('write');
end;

Function Function23_write:boolean;
begin
Function23_write := False;
IF Function23('write')='' then Function23_write := True
Else  Form1.Label1.Caption:=Function23('write')
{Else
IF Function23('writeln')='' then Function23_write := True
Else  Form1.Label1.Caption:=Function23('write')}
//Else Form1.Label1.Caption:=Function23('writeln');
end;

Function Function23_writeln:boolean;
begin
Function23_writeln := False;

IF Function23('writeln')='' then Function23_writeln := True
Else Form1.Label1.Caption:=Function23('writeln');
end;

Function Function22_write:boolean;
begin
Function22_write := False;
//IF Function18_Wri('write')=''Then
IF Function22('write')='' then Function22_write := True
Else Form1.Label1.Caption:=Function22('write')
{else Function22_write := false;  }
end;

Function Function28_Write:boolean;
begin
  Function28_Write := False;
  IF Function28('write')='' then Function28_write := True
   Else Form1.Label1.Caption:=Function28('write');
end;

function Function1_WRITELN:Boolean;
Begin
Function1_writeln := False;
If (Function1('writeln') = '') then
function1_writeln := True
  else
   Form1.Label1.Caption:=Function1('writeln');
end;

{============================================================}
{============================End=============================}
{============================================================}
Function Function1_end:Boolean;
begin
  function1_end:=false;
  If Function1('end')=''then function1_end:= True
  Else Form1.Label1.Caption:=Function1('end');
end;


Function function2_end:boolean;
Begin
Function2_end := False;
If function2('end',' ')='' then Function2_end := true
Else Form1.Label1.Caption:=Function2('end',' ');
End;

Function function3_end:boolean;
Begin
Function3_end:=False;
 If function3('end')='' then Function3_end:=true
    else Form1.Label1.Caption:=Function3('end')
End;

Function function4_end:boolean;
Begin
Function4_end:=False;
 If (function4('end','.')='') then Function4_end:=true
  Else Form1.Label1.Caption:=function4('end','.')
End;

Function Function12_end:boolean;
begin
  Function12_end := false;
  IF (Function12(4,'end')='')Then Function12_end := True
   else Form1.Label1.Caption:=Function12(4,'end');
end;

  Function function6_end:boolean;
Begin
Function6_end:=False;
 If function6('end','.')='' then Function6_end:=true
      else Form1.Label1.Caption:=function6('end','.');
End;

Function Function8_end:boolean;
Begin
  function8_end := false;
  If Function8('end. ')=''then  function8_end:=True
    Else Form1.Label1.Caption:=Function8('end. ');
End;

{------------------------------------------------------------------------}
{------------------Раздел Описания Gotxy-------------------------------}
{вынесен сюда потому-что основываеться полностью на уже созданых функциях}
{------------------------------------------------------------------------}
{------------------------------------------------------------------------}
//ошибка в проваписании Gotoxy
 function Function1_GotoXY:Boolean;
Begin
Function1_GotoXY := False;
If (Function1('gotoxy') = '') then function1_GotoXY := True
  else
   Form1.Label1.Caption:=Function1('gotoxy');
end;

Function function3_gotoxy:boolean;
Begin
Function3_gotoxy:=False;
 If (function3('gotoxy')='') then Function3_gotoxy:=true
    else Form1.Label1.Caption:=Function3('gotoxy');
End;

Function Function8_gotoxy:boolean;
Begin
  function8_gotoxy := false;
  If Function8('gotoxy')=''then  function8_gotoxy:=True
    Else Form1.Label1.Caption:=Function8('gotoxy');
End;

Function function2_gotoxy:boolean;
Begin
  Function2_gotoxy := False;
  IF function2('gotoxy',' ')='' Then Function2_gotoxy := True
   Else Form1.Label1.Caption:=Function2('gotoxy',' ');
End;

Function Function27_gotoxy:boolean;
begin
  Function27_gotoxy := False;
  IF Function27('gotoxy')='' then Function27_gotoxy := True
   Else Form1.Label1.Caption:=Function27('gotoxy');
end;

Function Function20_gotoxy:boolean;
var i:integer;
begin
Function20_gotoxy := False;
 for i := 1 to 200 do begin
 If (function12(i,'gotoxy')<>'') then
   IF Function20(i,'gotoxy')='' Then Function20_gotoxy := True
  else form1.Label1.Caption := Function20(i,'gotoxy')
  else Function20_gotoxy := True;
end;
end;

Function Function12_gotoxy:boolean;
var i:integer;
begin
Function12_gotoxy := False;
 for i := 1 to 200 do begin
 If (function4('gotoxy',';')<>'') then
     IF (Function12(i,'gotoxy')='')Then Function12_gotoxy:= True
       else  Form1.Label1.Caption:= Function12(i,'gotoxy')
     else Function12_gotoxy:=True;
  end;
end;

Function Function28_gotoxy:boolean;
begin
  Function28_gotoxy := False;
  IF Function28('gotoxy')='' then Function28_gotoxy := True
   Else Form1.Label1.Caption:=Function28('gotoxy');
end;
{===========================================================}
{===========================================================}
{*******************Раздел описания := *********************}
{===========================================================}
{===========================================================}

function Function1_Prisvay:Boolean;
Begin
Function1_Prisvay := False;
If (Function1(':=') = '') then function1_Prisvay:= True
  else
   Form1.Label1.Caption:=Function1(':=');
end;

Function Function8_Prisvay:boolean;
var s,s1,s2:string;
i:integer;
Begin
  function8_Prisvay := false;
{  s:=perem[1];
  For  i := 2 to Sc_per do IF Length(perem[i]) > length(s) Then s := perem[i];
  form1.Caption:=s;}

  IF Function8(':=')=''then  function8_Prisvay:=True
    Else Form1.Label1.Caption:=Function8(':=');
End;

Function Function30_Prisvay:boolean;
Begin
  function30_Prisvay := false;
  If Function30(':=')=''then  function30_Prisvay:=True
    Else Form1.Label1.Caption:=Function30(':=');
End;

Function Function30_1_Prisvay:boolean;
Begin
  function30_1_Prisvay := false;
  If Function30_1(':=')=''then  function30_1_Prisvay:=True
    Else Form1.Label1.Caption:=Function30_1(':=');
End;

Function Function30_2_Prisvay:boolean;
Begin
  function30_2_Prisvay := false;
  If Function30_2(':=')=''then  function30_2_Prisvay:=True
    Else Form1.Label1.Caption:=Function30_2(':=');
End;

Function Function30_3_Prisvay:boolean;
Begin
  function30_3_Prisvay := false;
  If Function30_3(':=')=''then  function30_3_Prisvay:=True
    Else Form1.Label1.Caption:=Function30_3(':=');
End;

//***********************************************************
Function function4_Prisvay:boolean;
Begin
Function4_Prisvay:=False;
 If (function4(':=',';')='') {Or(function4(':=','(')='')}  then Function4_Prisvay:=true
  Else Form1.Label1.Caption:=function4(':=',';')
End;

Function Function12_Prisvay:boolean;
var i:integer;
begin
Function12_Prisvay := False;
 for i := 1 to 200 do begin
 If (function4(':=',';')<>'') then
     IF (Function12(i,':=')='')Then Function12_Prisvay:= True
       else  Form1.Label1.Caption:= Function12(i,':=')
     else Function12_Prisvay:=True;
  end;
end;

Function Function20_Prisvay:boolean;
var i:integer;
begin
Function20_Prisvay := False;
 for i := 1 to 200 do begin
 If (function12(i,':=')<>'') then
   IF Function20(i,':=')='' Then Function20_Prisvay := True
  else form1.Label1.Caption := Function20(i,':=')
  else Function20_Prisvay := True;
end;
end;

{Function Function31_Prisvay:boolean;
Begin
  function31_Prisvay := false;
  If Function31(':=')=''then  function31_Prisvay:=True
    Else Form1.Label1.Caption:=Function31(':=');
End;}



//**************************************************
{ClOSE;}
{конечная функция для строки uses wincrt}
Function AllUsesWincrt:boolean;
Begin
AllUsesWincrt:=false;
If Function0_UsesWincrt Then
If Function7_UsesWincrt Then
If Function1_UsesWincrt then
If Function5_Uses Then
If Function3_Uses Then
If Function3_Wincrt Then
If Function4_Wincrt Then
If Function6_Wincrt Then
If Function2_Uses Then
If Function2_Wincrt Then
IF Function11_UsesWincrt Then
IF Function12_UsesWincrt Then AllUsesWincrt:=true
End;

{конечная функция для строки Var .....: Нужный тип}
Function AllVar:boolean;
var
  i:byte;
Begin
AllVar := false;
{Если строки var...Тип нет, то True, иначе проверяем на наличее ошибок}
IF (Function1_Var = False) and (Function1_TIP = false){(Function13_per=False)} Then //
begin
For i := 1 to Sc_Per do
perem[i]:='';
AllVar := True;
end
Else
IF Function1_Var Then
IF Function1_Tip Then
IF Function2_var Then
IF Function4_int Then
IF function6_tip Then
IF Function10_Tip Then
IF Function13_per Then
IF Function14 Then
IF Function15_per Then
IF Function9_v1 Then
IF Function16_v2 Then
IF Function17_v3 Then
AllVar := True;
end;

{конечная функция для строки Begin}
Function AllBegin:boolean;
begin
AllBegin := false;
IF Function0_beg Then
IF function8_beg Then
IF Function1_beg Then
IF Function2_beg then
IF function3_beg then
IF Function12_beg Then
AllBegin := True;
end;

Function AllWrite:boolean;
begin
  AllWrite := False;
  IF (Function8_write=False)and(Function26_write=False)Then AllWrite:=True
    else
//    IF (function1_writeln)and(function1_write = False) Then
      IF function26_Write Then
      IF function2_write Then
   //  IF function27_write Then
      IF function3_write Then
      IF Function28_write Then
      IF Function18_write Then
      IF Function4_Write Then
      IF Function20_write Then
      IF Function21_write Then
      IF Function22_write Then
      IF Function24_write Then
      IF Function19_write Then
      IF Function23_write Then
      IF Function25_write Then
      IF Function12_write Then
    //  IF Function23_writeLN Then
  AllWrite := True
end;
Function AllGotoXy:Boolean;
begin
  IF (Function8_gotoxy=False)and(Function1_gotoxy=False) Then AllGotoXy:=True
   else
     IF Function1_GotoXY Then
     IF Function2_GotoXY Then
     IF Function28_gotoxy Then
     IF Function3_GotoXY Then
     IF Function20_gotoxy Then
     IF Function12_gotoxy Then
     IF Function27_gotoxy Then
       AllGotoXy := True;
end;

Function AllPrisvay:Boolean;
begin
AllPrisvay := False;
IF (Function8_Prisvay=False)and(Function1_Prisvay=False) Then AllPrisvay:=True
 Else
   IF Function1_Prisvay Then
   IF Function20_Prisvay Then
   IF Function12_Prisvay Then
   IF Function30_Prisvay Then
   IF Function30_1_Prisvay Then
   IF Function30_2_Prisvay Then
   IF Function30_3_Prisvay Then
   AllPrisvay := True;
end;

Function AllEnd:Boolean;
Begin
  AllEnd := False;
//  IF function8_end Then
  IF function1_end Then
  IF function2_end Then
  IF function3_end Then
  IF function4_end Then
  IF function6_end Then
  IF function12_end Then
  AllEnd := True;
End;

Procedure Mnogo_Comand;
var
i1,kol1,tree:integer;
Begin
  For kol1 := 1 to form1.memo2.lines.count-1 Do
    begin
      For i1 := 1 to form1.memo2.lines.count-1 Do
      begin
        For tree := 3 to form1.memo2.lines.count-1 Do
        begin
          If (pos('write',form1.Memo2.Lines[i1])>0)AND(AllWrite = True) then form1.memo2.lines.Delete(i1);
          If (pos('gotoxy',form1.Memo2.Lines[i1])>0)AND(AllGotoxy = True) then form1.memo2.lines.Delete(i1);
          If (pos(':=',form1.Memo2.Lines[i1])>0)AND(AllPrisvay = True) then form1.memo2.lines.Delete(i1);
        end;
        end
    end;
End;

{конец раздела описания строки Uses wincrt}
{Начало. итоговый раздел промежутка начало Uses конец строка End.}
Function PostOsn:boolean;
Begin
  delstrim;
  Mnogo_Comand;
  PostOsn := false;
  IF AllUsesWincrt Then
  IF AllVar Then
  IF AllBegin Then
  IF AllPrisvay Then  
  IF AllWrite Then
  IF AllGotoXy Then
  IF AllEnd Then
  PostOsn := true
End;

{Конец}
Function ALLosnova: boolean;
Begin
  Allosnova:=false;
  IF PostOsn then Allosnova:=true
End;

procedure TForm1.Action4Execute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Action3Execute(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  f: textfile ;
  s:string;
begin
  AssignFile(f,'config.txt');
    Reset(f);
    Readln(f,s);
  Closefile(f);
  Memo1.Lines.LoadFromFile(s);
  Form1.Label1.Font.Color:=ClRed;
  If ALLosnova then
    begin
      Form1.Label1.Font.Color:=ClBlack;
      Form1.Label1.Caption:='Программа успешно выполнена на стадии проверки';
    end;
end;

procedure TForm1.Action1Execute(Sender: TObject);
var
  x:byte;
begin
  Form1.OpenDialog1.Execute;
  IF Form1.OpenDialog1.FileName='' Then x := 9
   Else
     Memo1.Lines.LoadFromFile(Form1.OpenDialog1.FileName);
end;

procedure TForm1.Action7Execute(Sender: TObject);
begin
  Form1.Label1.Font.Color:=ClRed;
  If ALLosnova then
   begin
     Form1.Label1.Font.Color:=ClBlack;
     Form1.Label1.Caption:='Программа успешно выполнена на стадии проверки';
   end;
end;

procedure TForm1.Action2Execute(Sender: TObject);
var
  x:byte;
begin
  Form1.SaveDialog1.Execute;
  IF Form1.SaveDialog1.FileName='' Then x := 9
   Else
     Memo1.Lines.SaveToFile(Form1.SaveDialog1.FileName);
end;

end.





