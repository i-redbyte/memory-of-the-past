unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Kitay = Record
        nom :integer;
        a:array[1..6] of byte;
  end;
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  gis,gg:array[1..8,1..8] of Kitay;
  ele:byte;
  trig:string[3];
Const
    n = 8;
    nn = 6;
implementation

uses Unit2;
//??????? ????? ?? ???????? ??????? ? ??????????.
Function  des(bin:string):integer;
var
dec,v,i:integer;
r : string[1];
Begin
   dec := 0;
   v := 32;
   for i := 1 to 6 do
      begin
        r := bin[i];
        if r = '1' then dec := dec + v;
        v := round(v/2);
      end;
des := dec;      
end;

{??????? ???????? ?????????? ???? ? ????????}
Function Binary(n :integer):string; //n - ????? ??????? ??????????? ? ???????? ???????.
var r,i,j:integer;
    s:array[1..nn] of string;
    s1:string;
Begin
  i := 0;
  While n >= 2 do
  begin
    inc(i);
    r := n mod 2;
    n := n div 2;
    s[i] := inttostr(r);
  end;
    s[i+1] := inttostr(n);
    s1 := '';
  For j := nn downto 1 do s1 := s1 + s[j];
  IF length(s1) < nn Then
   begin
     While length(s1) < nn do
     s1 := '0' + s1;
   end;
Binary := s1;   
end;

{===+????????? ?????????? ??????? ??????????+===}
Procedure zap;
var
  l,i,j,k:byte;
  s:string[6];
  c:array[1..nn]of string;
Begin
  k := 0;
  For i := 1 to n do
    begin
      For j := 1 to n do
        begin
          gis[i,j].nom := k;  //????????? ??????? ?? 0 ?? 63 ?? ???????.
          s := binary(k);
{*********????????? ???? ??????? ??????????? ???????.********}
          For l := 1 to nn do c[l] := s[l];
          For l := 1 to nn do
          gis[i,j].a[l] := strtoint(c[l]);
          inc(k);
        end;
    end;
end;

//???????a?? ????? ?????????.
Function izm(k,m:integer):integer; //k - ????? ???????????, m - ????? ???????????? ?????.
Var
  i,j,x,y:integer;
  d:array[1..6] of String;
  s : string;
begin
//  y := 0;
  s :='';
  For i := 1 to 8 do
    begin
      For j := 1 to 8 do
        begin
          IF gis[i,j].nom = k Then
           begin
             IF gis[i,j].a[m] = 1 Then gis[i,j].a[m] := 0
              Else gis[i,j].a[m] := 1;
              For x := 1 to 6 do s := s + inttostr(gis[i,j].a[x]);
              y := des(s);
           end;
        end;
    end;
  For i := 1 to 8 do
    begin
      For j := 1 to 8 do
        begin
          IF gis[i,j].nom = y Then izm := y;
        end;
    end;
end;

{????????? ????????? ????????}
procedure tri(x,y,z:integer);
begin
  form1.Canvas.Pen.Width:=7;
  if z=1 then
    begin
      ele := 1;
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+100,y+40);
      trig := '000';
    end;
  if z=3 then           //3
    begin
      ele := 3;
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+40,y+20);
      form1.Canvas.MoveTo(x+60,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
  if z=5 then          //5
    begin
      ele := 5;
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+40,y+40);
      form1.Canvas.MoveTo(x+60,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
  if z=6 then        //6
    begin
      ele := 6;
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+40,y);
      form1.Canvas.MoveTo(x+60,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+40,y+40);
      form1.Canvas.MoveTo(x+60,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
  if z=7 then             //7
    begin
      ele := 7;
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+40,y+20);
      form1.Canvas.MoveTo(x+60,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+40,y+40);
      form1.Canvas.MoveTo(x+60,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
  if z=8 then        //8
    begin
      ele := 8;
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+40,y);
      form1.Canvas.MoveTo(x+60,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+40,y+20);
      form1.Canvas.MoveTo(x+60,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+40,y+40);
      form1.Canvas.MoveTo(x+60,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
  if z=4 then        //4
    begin
      ele := 4;
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+40,y);
      form1.Canvas.MoveTo(x+60,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+40,y+20);
      form1.Canvas.MoveTo(x+60,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
  if z=2 then             //2
    begin
      ele := 2;
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+40,y);
      form1.Canvas.MoveTo(x+60,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+100,y+40);
      trig := '100';      
    end;
end;
//????? ??????????? ?? ?????.
Procedure viv_gis(x1,y1,i,j:integer);
Begin
form1.Canvas.Font.Color := ClRed;
form1.Canvas.Font.Size := 14;
tri(-100,20000,i);
IF ele = 1 Then form1.Canvas.TextOut(x1+20,y1-30,'??????');
IF ele = 2 Then form1.Canvas.TextOut(x1+20,y1-30,'??????');
IF ele = 3 Then form1.Canvas.TextOut(x1+20,y1-30,'?????');
IF ele = 4 Then form1.Canvas.TextOut(x1+20,y1-30,'??????');
IF ele = 5 Then form1.Canvas.TextOut(x1+20,y1-30,'??????');
IF ele = 6 Then form1.Canvas.TextOut(x1+20,y1-30,'????');
IF ele = 7 Then form1.Canvas.TextOut(x1+20,y1-30,'?????');
IF ele = 8 Then form1.Canvas.TextOut(x1+20,y1-30,'?????');
  tri(x1,y1,i);
  tri(x1,y1+60,j);
IF ele = 1 Then form1.Canvas.TextOut(x1+20,y1+115,'??????');
IF ele = 2 Then form1.Canvas.TextOut(x1+20,y1+115,'??????');
IF ele = 3 Then form1.Canvas.TextOut(x1+20,y1+115,'?????');
IF ele = 4 Then form1.Canvas.TextOut(x1+20,y1+115,'??????');
IF ele = 5 Then form1.Canvas.TextOut(x1+20,y1+115,'??????');
IF ele = 6 Then form1.Canvas.TextOut(x1+20,y1+115,'????');
IF ele = 7 Then form1.Canvas.TextOut(x1+20,y1+115,'?????');
IF ele = 8 Then form1.Canvas.TextOut(x1+20,y1+115,'?????');
end;
//???????? ?????.
Procedure Line_splosh(x1,y1:integer);
begin
  form1.Canvas.Pen.Width:=7;
  form1.Canvas.MoveTo(x1,y1);
  form1.Canvas.LineTo(x1+100,y1);
end;
//??????????? ?????.
Procedure Line_preriv(x1,y1:integer);
begin
  form1.Canvas.Pen.Width:=7;
  form1.Canvas.MoveTo(x1,y1);
  form1.Canvas.LineTo(x1+40,y1);
  form1.Canvas.MoveTo(x1+60,y1);
  form1.Canvas.LineTo(x1+100,y1);
end;

//???????????? ????????????? ???????????
Procedure promej(x1,y1,nom:integer); //nom-????? ???????????.
var i,j,k,q:integer;
    d:array[1..6] of byte;
    s:string[6];
begin
  q := 0;
  For i := 1 To 8 Do
    begin
      For j := 1 To 8 Do
        Begin
          IF gis[i,j].nom =  nom Then
            begin
         {     For k := 1 To 6 do
              d[k]:= gis[i,j].a[k];}
              d[1] := gis[i,j].a[2];
              d[2] := gis[i,j].a[3];
              d[3] := gis[i,j].a[4];
              d[4] := gis[i,j].a[3];
              d[5] := gis[i,j].a[4];
              d[6] := gis[i,j].a[5];
           end;
        end;
     end;
s := '';
For k := 1 To 6 do s := s + inttostr(d[k]);
For k := 6 DownTo 1 Do
  Begin
    IF s[k] = '0'  Then Line_splosh(x1,y1+q)
     Else
    IF s[k] = '1'  Then Line_preriv(x1,y1+q);
     q := q + 20;
  End;
form1.Canvas.Font.Color := ClRed;
form1.Canvas.Font.Size := 14;
{?????}
IF (s[6]='0')and(s[5]='0')and(s[4]='0') Then form1.Canvas.TextOut(x1+20,y1-30,'??????');
IF (s[1]='0')and(s[2]='0')and(s[3]='0') Then form1.Canvas.TextOut(x1+20,y1+115,'??????');
IF (s[6]='1')and(s[5]='0')and(s[4]='0') Then form1.Canvas.TextOut(x1+20,y1-30,'??????');
IF (s[1]='0')and(s[2]='0')and(s[3]='1') Then form1.Canvas.TextOut(x1+20,y1+115,'??????');
{?????}
IF (s[6]='0')and(s[5]='1')and(s[4]='0') Then form1.Canvas.TextOut(x1+20,y1-30,'?????');
IF (s[1]='0')and(s[2]='1')and(s[3]='0') Then form1.Canvas.TextOut(x1+20,y1+115,'?????');
{??????}
IF (s[6]='1')and(s[5]='1')and(s[4]='0') Then form1.Canvas.TextOut(x1+20,y1-30,'??????');
IF (s[1]='0')and(s[2]='1')and(s[3]='1') Then form1.Canvas.TextOut(x1+20,y1+115,'??????');
IF (s[6]='0')and(s[5]='0')and(s[4]='1') Then form1.Canvas.TextOut(x1+20,y1-30,'??????');
IF (s[1]='1')and(s[2]='0')and(s[3]='0') Then form1.Canvas.TextOut(x1+20,y1+115,'??????');
{????}
IF (s[6]='1')and(s[5]='0')and(s[4]='1') Then form1.Canvas.TextOut(x1+20,y1-30,'????');
IF (s[1]='1')and(s[2]='0')and(s[3]='1') Then form1.Canvas.TextOut(x1+20,y1+115,'????');
{?????}
IF (s[6]='0')and(s[5]='1')and(s[4]='1') Then form1.Canvas.TextOut(x1+20,y1-30,'?????');
IF (s[1]='1')and(s[2]='1')and(s[3]='0') Then form1.Canvas.TextOut(x1+20,y1+115,'?????');
IF (s[6]='1')and(s[5]='1')and(s[4]='1') Then form1.Canvas.TextOut(x1+20,y1-30,'?????');
IF (s[1]='1')and(s[2]='1')and(s[3]='1') Then form1.Canvas.TextOut(x1+20,y1+115,'?????');
end;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  zap;
  ele := 0;
end;

procedure TForm1.Button2Click(Sender: TObject);
var x,y,i,j,z,q:integer;
begin
    zap;
    Form1.Refresh;
    z := StrToInt(Edit1.Text);
//*********************************************
//=======????? ????????????? ???????????=======
//*********************************************
    i := strtoint(edit2.Text);
    j := strtoint(edit3.Text);
    promej(300,120,gis[j,i].nom);
//*********************************************
//=========????? ??????????? ???????????=======
    viv_gis(50,120,strtoint(edit2.Text),strtoint(edit3.Text));//?????????? ?????
//*********************************************
//=========????? ?????????? ???????????========
//*********************************************
    q := izm(gis[j,i].nom,z);
  For i := 1 To 8 Do
    begin
      For j := 1 To 8 Do
        Begin
          IF gis[i,j].nom =  q Then
            begin
              x := i;
              y := j;
            end;
        end;
     end;
     viv_gis(535,120,y,x);//?????????? ?????
end;

Procedure cherta(q:byte);
begin
  if q = 1 Then
    begin
      Form1.Canvas.Pen.Color := ClLime;
      Form1.Canvas.Ellipse(20,115,30,120);
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
tri(100,300,2);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var x,y,i,j,z,q:integer;
begin
  zap;
  Form1.Refresh;
  z := StrToInt(Edit1.Text);
  //*********************************************
  //=======????? ????????????? ???????????=======
  //*********************************************

  i := strtoint(edit2.Text);
  j := strtoint(edit3.Text);
  promej(300,120,gis[j,i].nom);

  //*********************************************
  //=========????? ??????????? ???????????=======

  viv_gis(50,120,strtoint(edit2.Text),strtoint(edit3.Text));//?????????? ?????

  //*********************************************
  //=========????? ?????????? ???????????========
  //*********************************************
  
  q := izm(gis[j,i].nom,z);
  For i := 1 To 8 Do
    begin
      For j := 1 To 8 Do
        Begin
          IF gis[i,j].nom =  q Then
            begin
              x := i;
              y := j;
            end;
        end;
     end;
     viv_gis(535,120,y,x);//?????????? ?????

end;

end.
