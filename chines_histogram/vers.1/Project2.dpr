program Project2;

uses
  Forms,
  Unit1 in 'dalee\Unit1.pas' {Form1},
  Unit2 in 'dalee\Unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
