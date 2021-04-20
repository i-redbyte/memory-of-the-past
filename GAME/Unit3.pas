unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Button1: TButton;
    Image2: TImage;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Timer19: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer19Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
     xx:integer;
implementation

uses Unit1;

Procedure norm;
begin
Form3.Visible := false;
If Life > 0 Then
  begin
Form1.Timer1.Enabled:=true;
Form1.Timer3.Enabled:=true;
Form1.Timer5.Enabled:=true;
Form1.DXTimer1.Enabled:=true;
end;
end;
{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
Timer19.Enabled := False;
  norm;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Timer19.Enabled := False;
norm;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
xx := Label22.Left;
Timer19.Enabled := False;
end;

procedure TForm3.Timer19Timer(Sender: TObject);
begin
Label22.Left := Label22.Left - 10;
IF label22.Left <-270 Then Label22.Left := xx;
end;

end.
