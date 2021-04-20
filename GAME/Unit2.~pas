unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, ComCtrls, ExtCtrls,shellapi;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const n = 850;
var
  Form2: TForm2;
 b:array[1..n] of string;
 a:array[1..n] of integer;
implementation

uses Unit1;
{$R *.dfm}

Procedure sort;
var t,f:TextFile;
      i,k,j,w,x,cycle:integer;
      s,g:string;
begin
i := 0;
x := 0;
AssignFile(t,'result.asm');
Reset(t);
  While not eof(t) do
   begin
      x := x + 1;
      i := i + 1;
      ReadLn(t,s);
      a[i] := StrToInt(Copy(s,Pos('>| ',s)+3,(Length(s)-pos('>| ',s))));
      b[i] := Copy(s,1,pos('>| ',s)-1);
   end;
CloseFile(t);

For j := 1 to n do
  begin
    For i := 1 to n - 1 do
      IF a[i] < a [i + 1] then
        begin
          g := b[i];
          b[i] := b[i + 1];
          b[i + 1] := g;
          w := a[i];
          a[i] := a[i + 1];
          a[i + 1] := w;
        end;
  end;
      // ÎÒÑÎÐÒÈÐÎÂÀÍÍÛÉ ÔÀÉË!
AssignFile(f,'ResultSort.asm');
RewRite(f);
If x > 10 then cycle := 10
else cycle := x;
For k := 1 to cycle do WriteLn(F,b[k] + '>| ' + IntToStr(a[k]));


CloseFile(f);

end;

procedure TForm2.Button1Click(Sender: TObject);
var
  s,s1,s2:string;
  i,x,cycle,k:integer;
  f,t:textfile;
  lab,lab1 : Tlabel;
begin
  x := 0;
  s := edit1.Text;
  edit1.Visible:=false;
  button1.Visible:=false;
  Form2.Caption:='Òàáëèöà ðåçóëüòàòîâ';
image1.Top := 1;
image1.Left := 1;
image1.Picture.LoadFromFile('lake.bmp');
Form2.Height := image1.Height-40;
Form2.Width := image1.Width-40;
    s := edit1.Text;
  i := 20;
  IF s='' Then s:='Player';
AssignFile(F,'result.asm');
      Append(f);
      s := s +'>| '+inttostr(pop);
      writeln(f,s);
CloseFile(f);
 SORT;
 //Ìåñòî
Lab := Tlabel.Create(self);
Lab.Parent := self;
lab.Font.Size := 10;
lab.Font.Color := ClBlack;
lab.Caption := 'Ìåñòî:';
lab.Top := 0;
lab.Transparent := true;
lab.Show;
//Èãðîê
Lab := Tlabel.Create(Self);
Lab.Parent := self;
lab.Font.Size := 10;
lab.Font.Color := ClBlack;
lab.Caption := 'Èãðîê:';
lab.Top := 1;
lab.Left := 55;
lab.Transparent := true;
lab.Show;
//Î÷êè
Lab := Tlabel.Create(Self);
Lab.Parent := self;
lab.Font.Size := 10;
lab.Font.Color := ClBlack;
lab.Caption := 'Î÷êè:';
lab.Top := 1;
lab.Left := 170;
lab.Transparent := true;
lab.Show;

AssignFile(f,'ResultSort.asm');
Reset(f);

While not eof(f) do
  begin
       inc(x);
        readln(f,s);
        s1 := Copy(s,1,pos('>|',s)-1);
        s2 := Copy(s,pos('>| ',s)+1,length(s)-pos('>| ',s));
        if pos('|',s2) <> 0 then delete(s2,pos('|',s2),1);
        Lab := Tlabel.Create(Self);
        Lab.Parent := self;
        lab.Font.Size := 11;
        If x<= 3 then
         lab.Font.Color := ClYellow
         else
           lab.Font.Color := ClWhite;

        lab.Caption := '   '+inttostr(x)+'         '+ s1;
        lab.Top := i;
        i := i + 16;
        lab.Transparent := true;
        lab.Show;
        // OCHKI
        Lab1 := Tlabel.Create(Self);
        Lab1.Parent := self;
        lab1.Font.Size := 11;
        If x<= 3 then lab1.Font.Color := ClGreen
         else
           lab1.Font.Color := ClWhite;
           lab1.Left := 178;
        lab1.Caption :=' '+s2;
        lab1.Top :=lab.Top ;
        lab1.Transparent := true;
        lab1.Show;
  end;
CloseFile(f);
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
IF key = #27 Then Form2.Close;
end;

procedure TForm2.Button1KeyPress(Sender: TObject; var Key: Char);
var f:textfile;
begin
IF key = #27 Then Form2.Close;
IF (key = 'c')or(key = 'C')or(key = 'ñ')or(key = 'Ñ') Then
 begin
   assignfile(f,'Result.txt');
   rewrite(f);
   closefile(f);
 end;
end;

procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
IF key = #27 Then Form2.Close;

end;

end.
