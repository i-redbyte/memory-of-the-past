unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;
{????????? ????????? ????????}
procedure tri(x,y,z:integer);
begin
  form2.Canvas.Pen.Width:=2;
  if z=1 then
    begin
      form2.Canvas.MoveTo(x,y);
      form2.Canvas.LineTo(x+20,y);
      form2.Canvas.MoveTo(x,y+20);
      form2.Canvas.LineTo(x+20,y+20);
      form2.Canvas.MoveTo(x,y+20);
      form2.Canvas.LineTo(x+20,y+20);
    end;
  if z=7 then
    begin
      form2.Canvas.MoveTo(x,y);
      form2.Canvas.LineTo(x+100,y);
      form2.Canvas.MoveTo(x,y+20);
      form2.Canvas.LineTo(x+40,y+20);
      form2.Canvas.MoveTo(x+60,y+20);
      form2.Canvas.LineTo(x+100,y+20);
      form2.Canvas.MoveTo(x,y+40);
      form2.Canvas.LineTo(x+100,y+40);
    end;
  if z=2 then
    begin
      form2.Canvas.MoveTo(x,y);
      form2.Canvas.LineTo(x+100,y);
      form2.Canvas.MoveTo(x,y+20);
      form2.Canvas.LineTo(x+100,y+20);
      form2.Canvas.MoveTo(x,y+40);
      form2.Canvas.LineTo(x+40,y+40);
      form2.Canvas.MoveTo(x+60,y+40);
      form2.Canvas.LineTo(x+100,y+40);
    end;
  if z=3 then
    begin
      form2.Canvas.MoveTo(x,y);
      form2.Canvas.LineTo(x+40,y);
      form2.Canvas.MoveTo(x+60,y);
      form2.Canvas.LineTo(x+100,y);
      form2.Canvas.MoveTo(x,y+20);
      form2.Canvas.LineTo(x+100,y+20);
      form2.Canvas.MoveTo(x,y+40);
      form2.Canvas.LineTo(x+40,y+40);
      form2.Canvas.MoveTo(x+60,y+40);
      form2.Canvas.LineTo(x+100,y+40);
    end;
  if z=4 then
    begin
      form2.Canvas.MoveTo(x,y);
      form2.Canvas.LineTo(x+100,y);
      form2.Canvas.MoveTo(x,y+20);
      form2.Canvas.LineTo(x+40,y+20);
      form2.Canvas.MoveTo(x+60,y+20);
      form2.Canvas.LineTo(x+100,y+20);
      form2.Canvas.MoveTo(x,y+40);
      form2.Canvas.LineTo(x+40,y+40);
      form2.Canvas.MoveTo(x+60,y+40);
      form2.Canvas.LineTo(x+100,y+40);
    end;
  if z=5 then
    begin
      form2.Canvas.MoveTo(x,y);
      form2.Canvas.LineTo(x+40,y);
      form2.Canvas.MoveTo(x+60,y);
      form2.Canvas.LineTo(x+100,y);
      form2.Canvas.MoveTo(x,y+20);
      form2.Canvas.LineTo(x+40,y+20);
      form2.Canvas.MoveTo(x+60,y+20);
      form2.Canvas.LineTo(x+100,y+20);
      form2.Canvas.MoveTo(x,y+40);
      form2.Canvas.LineTo(x+40,y+40);
      form2.Canvas.MoveTo(x+60,y+40);
      form2.Canvas.LineTo(x+100,y+40);
    end;
  if z=6 then
    begin
      form2.Canvas.MoveTo(x,y);
      form2.Canvas.LineTo(x+40,y);
      form2.Canvas.MoveTo(x+60,y);
      form2.Canvas.LineTo(x+100,y);
      form2.Canvas.MoveTo(x,y+20);
      form2.Canvas.LineTo(x+40,y+20);
      form2.Canvas.MoveTo(x+60,y+20);
      form2.Canvas.LineTo(x+100,y+20);
      form2.Canvas.MoveTo(x,y+40);
      form2.Canvas.LineTo(x+100,y+40);
    end;
  if z=8 then
    begin
      form2.Canvas.MoveTo(x,y);
      form2.Canvas.LineTo(x+40,y);
      form2.Canvas.MoveTo(x+60,y);
      form2.Canvas.LineTo(x+100,y);
      form2.Canvas.MoveTo(x,y+20);
      form2.Canvas.LineTo(x+100,y+20);
      form2.Canvas.MoveTo(x,y+40);
      form2.Canvas.LineTo(x+100,y+40);
    end;
end;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
   tri(10,10,1);
end;

end.
