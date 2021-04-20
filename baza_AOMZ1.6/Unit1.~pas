unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, Grids, DBGrids, ComCtrls, Buttons,
  DBCtrls, Mask,ShellApi, QRCtrls, QuickRpt, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Table1: TTable;
    DateTimePicker1: TDateTimePicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBCheckBox1: TDBCheckBox;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    Table2: TTable;
    GroupBox1: TGroupBox;
    DBEdit6: TDBEdit;
    Label2: TLabel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    DBEdit2: TDBEdit;
    Button1: TButton;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit5: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    Button2: TButton;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    Label11: TLabel;
    Button4: TButton;
    Button5: TButton;
    QuickRep1: TQuickRep;
    ChildBand1: TQRChildBand;
    DetailBand1: TQRBand;
    QRShape1: TQRShape;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel4: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRDBText5: TQRDBText;
    QRLabel6: TQRLabel;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRDBText6: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape8: TQRShape;
    QRDBText10: TQRDBText;
    QRLabel9: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText11: TQRDBText;
    QRShape16: TQRShape;
    QRDBText12: TQRDBText;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    Button6: TButton;
    Button3: TButton;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DBEdit4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Table1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  str:string;
   t:tdatetime;
implementation

{$R *.dfm}

uses
   MInWord;
var
  IW: TInWord;
Function Udal_prob(s:string):String;
Var
  j,i:integer;
Begin
  For i := 1 To Length(s)-1 Do
    For j := i+1 To Length(s) Do
      IF s[i] = ' ' Then Delete(s,i,1);
  Udal_prob := s;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
   d:TDateTimePicker;
begin
d := TDateTimePicker.Create(self);
t := d.Date;
d.Free;
Form1.DateTimePicker1.Date := t;
Form1.Caption := DateToStr(t);
Table1.DatabaseName := ExtractFilePath(application.exename);
Table1.TableName := 'baza_ao.DB';
table1.Active:=true;
Table2.DatabaseName := ExtractFilePath(application.exename);
Table2.TableName := 'About.DB';
table2.Active:=true;

QuickRep1.Visible := False;
str := '0';
  IW := TInWord.Create(Self);
  IW.LoadFromFile('Ruble.lng');
  IW.Target := label1;
  Edit1Change(Sender);
//Edit1.Text := table1['Summa'];
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  try
    IW.Value := StrToFloat(Edit1.Text);
  except
    IW.Value := 0.00; // <--
  end;
end;

Function dat_norm(x:TdateTime):string;
var
   s,s1:string;
   y:integer;
Begin
  s := datetostr(x);
  y := Pos('.',s);
  s1 := Copy(s,y+1,2);
  delete(s,y,4);
  IF s1 = '01' Then s1 := ' янворя ';
  IF s1 = '02' Then s1 := ' февраля ';
  IF s1 = '03' Then s1 := ' марта ';
  IF s1 = '04' Then s1 := ' апреля ';
  IF s1 = '05' Then s1 := ' мая ';
  IF s1 = '06' Then s1 := ' июня ';
  IF s1 = '07' Then s1 := ' июля ';
  IF s1 = '08' Then s1 := ' августа ';
  IF s1 = '09' Then s1 := ' сентября ';
  IF s1 = '10' Then s1 := ' октября ';
  IF s1 = '11' Then s1 := ' ноября ';
  IF s1 = '12' Then s1 := ' декабря ';
  insert(s1,s,y);
  insert(' г',s,length(s)+1);
Dat_norm := s;
end;
{}
Function Sumprop(x:real):string;
var
   s,s1:string;
   y:integer;
Begin
  s := FloatToStr(x);
  y := Pos(',',s);
  IF y = 0 Then s := s + '-00'
   Else
     begin
       s1 := Copy(s,y+1,Length(s)-y);
       IF Length(s1) = 1 Then s := s + '0'
        Else
          IF Length(s1) > 2 Then delete(s,y+2,length(s1)-2);
       Delete(s,y,1);
       insert('-',s,y);
     end;
  Sumprop := s;
End;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  b:boolean;
begin
str := DBEdit4.Text;
Edit1.Text := str;
b := false;
IF (table1.FieldByName('Bank_pol').AsString <> '') Then b := true
  Else b := false;
IF (table1.FieldByName('Ist_vznos').AsString <> '')and(b = true) Then b := true
 Else b := false;
 IF (table1.FieldByName('Summa').AsString <> '')and(b = true) Then b := true
  Else b := false;

IF b Then
begin
//  IF table1['Ist_vznos'] <> '' Then
  table1.Edit;
  table1.FieldByName('Datstr').AsString := dat_norm(DateTimePicker1.date);
  table1.FieldByName('Sum_prop').AsString := Label1.Caption;
  table1.FieldByName('Date').AsDateTime := DateTimePicker1.date;
  table1.FieldByName('SumOt').AsString := Sumprop(Table1['Summa']);
  table1.Post;
End
 Else MessageBox(0,'Вы заполнили не все поля!','Внимание!',0);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
table1.Prior;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
table1.Next;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
table1.Delete;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
close;
end;

procedure TForm1.DBEdit4KeyPress(Sender: TObject; var Key: Char);
begin
//Edit1.Text := prop;
IF (key > '9')or(key ='.')or(key ='-')or(key ='=')or(key ='*')or(key ='/')or(key =' ')or(key ='\') Then key := #0;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
   s:Real;
   f:string;
begin
  s := 0;
  table1.First;
  table1.Edit;
  f := dateToStr(t);
  t := StrToDate(f);
While not table1.Eof do
  begin
    IF Table1['Date'] = t Then s := s + strtofloat(table1['Summa']);
    table1.Next;
  end;
  table1.First;
  Label12.Caption := FloatToSTr(s)+' руб.';
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
Table1.Append;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//Form1.Caption := Sumprop(Table1['Summa']);
Table1.First;
end;

procedure TForm1.DBEdit4Change(Sender: TObject);
begin
str := DBEdit4.Text;
IF str = '' Then
  begin
    str := '0,0';
    DBEdit4.Text := '0,0';
//    showmessage('Введите ссуму');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
        b:boolean;
begin
str := DBEdit4.Text;
Edit1.Text := str;
b := false;
IF (table1.FieldByName('Bank_pol').AsString <> '') Then b := true
  Else b := false;
IF (table1.FieldByName('Ist_vznos').AsString <> '')and(b = true) Then b := true
 Else b := false;
 IF (table1.FieldByName('Summa').AsString <> '')and(b = true) Then b := true
  Else b := false;
IF b Then
begin
  table1.Edit;
  table1.FieldByName('Datstr').AsString := dat_norm(DateTimePicker1.date);
  table1.FieldByName('Sum_prop').AsString := Label1.Caption;
  table1.FieldByName('Date').AsDateTime := DateTimePicker1.date;
  table1.FieldByName('SumOt').AsString := Sumprop(Table1['Summa']);
  table1.Post;
End;
// Else MessageBox(0,'Вы заполнили не все поля!','Внимание!',0);

Table1.Filtered := True;
Form1.QuickRep1.Preview;
Table1.Filtered := False;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
Table1.Last;
end;

procedure TForm1.Table1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := dataset['Print_doc'] = true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
table2.Edit;
table2.Post;
IF (table1.FieldByName('Bank_pol').AsString <> '') Then
begin
str := DBEdit4.Text;
Edit1.Text := str;
  table1.Edit;
  table1.FieldByName('Datstr').AsString := dat_norm(DateTimePicker1.date);
  table1.FieldByName('Sum_prop').AsString := Label1.Caption;
  table1.FieldByName('Date').AsDateTime := DateTimePicker1.date;
  table1.FieldByName('SumOt').AsString := Sumprop(Table1['Summa']);
  table1.Post;
End;
end;

end.
 