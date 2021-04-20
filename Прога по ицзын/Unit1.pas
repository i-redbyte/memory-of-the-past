unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Kitay = Record
        nom :integer;
        a:array[1..6] of byte;
  end;
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  gis:array[1..8,1..8] of Kitay;
Const
    n = 8;
    nn = 6;
implementation

{������� �������� ���������� ���� � ��������}
Function Binary(n :integer):string; //n - ����� ������� ����������� � �������� �������.
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

{===+��������� ���������� ������� ����������+===}
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
          gis[i,j].nom := k;  //��������� ������� �� 1 �� 63 �� �������.
          s := binary(k);
{*********��������� ���� ������� ����������� �������.********}          
          For l := 1 to nn do c[l] := s[l];
          For l := 1 to nn do
          gis[i,j].a[l] := strtoint(c[l]);
          inc(k);
        end;
    end;
end;
Function izm(m:integer):integer;
begin

end;
{��������� ��������� ��������}
procedure tri(x,y,z:integer);
begin
  form1.Canvas.Pen.Width:=7;
  if z=1 then
    begin
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
  if z=7 then
    begin
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+40,y+20);
      form1.Canvas.MoveTo(x+60,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
  if z=2 then
    begin
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+40,y+40);
      form1.Canvas.MoveTo(x+60,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
  if z=3 then
    begin
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
  if z=4 then
    begin
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
  if z=5 then
    begin
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
  if z=6 then
    begin
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
  if z=8 then
    begin
      form1.Canvas.MoveTo(x,y);
      form1.Canvas.LineTo(x+40,y);
      form1.Canvas.MoveTo(x+60,y);
      form1.Canvas.LineTo(x+100,y);
      form1.Canvas.MoveTo(x,y+20);
      form1.Canvas.LineTo(x+100,y+20);
      form1.Canvas.MoveTo(x,y+40);
      form1.Canvas.LineTo(x+100,y+40);
    end;
end;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
s :string;
begin
zap;
s := '';
For i := 1 to 6 do s := s + inttostr(gis[8,1].a[i]);
Form1.Caption := s;

end;

end.
