unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TForm4 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox2: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Button1: TButton;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
   mmm:boolean;
implementation

uses Unit1;

{$R *.dfm}
Procedure norm;
begin
Form4.Visible := false;
If Life > 0 Then
  begin
Form1.Timer1.Enabled:=true;
Form1.Timer3.Enabled:=true;
Form1.Timer5.Enabled:=true;
Form1.DXTimer1.Enabled:=true;
end;

end;
procedure TForm4.RadioButton1Click(Sender: TObject);
begin
Form1.DXWaveList1.DXSound.Initialize;

end;

procedure TForm4.RadioButton2Click(Sender: TObject);
begin
Form1.DXWaveList1.DXSound.Finalize;

end;

procedure TForm4.RadioButton3Click(Sender: TObject);
begin
Form1.MediaPlayer1.Play;
end;

procedure TForm4.RadioButton4Click(Sender: TObject);
begin
Form1.MediaPlayer1.Stop;
mmm := true;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
mmm := false;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
norm;

end;

end.
