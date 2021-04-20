{     program
      uses       }
unit Unit_Syntax1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Map2, Identifers;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  function Main: boolean;
  function _Begin(Kind, Atype, Value: String): boolean;
  function _Program(Kind, Atype, Value: String): boolean;


  function ReadWord: TKey;
  procedure ReadString;
  procedure SetError(Error: string);
  function GetPoint(P: integer): TPoint;


const
  semicolon = 1;
  spot = 2;
  comma = 3;
  colon = 4;

var
  Form1: TForm1;
  S: string;
  ERROR: string;
  Pos: integer;
  Start, End_: integer;
  Cur_Name: string;
  Table: TMap;
  Ident: TIdentifer;

  Prog_, Prog_Name: TMap;
  Uses_, Uses_Name: TMap;
  Begin_, Begin_End: TMap;

  Write_: TMap;

  String_: TMap;


implementation

{$R *.dfm}

{ TForm1 }



//-------------    MAIN    -----------------------------------------------------
{
    ! Duplicate identifer
    ! Var
    ! Символы после 'end.'
}
function Main: boolean;
begin

  Table:=TMap.Create;
  Prog_Name:=TMap.Create;
  Prog_:=TMap.Create;
  Uses_Name:=TMap.Create;
  Uses_:=TMap.Create;
  Begin_:=TMap.Create;
  Begin_End:=TMap.Create;

  String_:=TMap.Create;

  Write_:=TMap.Create;


//-------------    Program    --------------------------------------------------
  Prog_.Add('variable', 'unknown', '', Prog_Name);
  Prog_.Add('resword', '', '', 'Зарезервированное слово не может быть именем программы');
  Prog_.Add('', '', '', 'Требуется имя программы');

  Prog_Name.Add('symbol', '', ';', '');
  Prog_Name.Add('', '', '', 'Требуется '';''');

//-------------    Uses    -----------------------------------------------------
  Uses_.Add('module', '', '', Uses_Name);
  Uses_.Add('', '', '', 'Требуется имя модуля');

  Uses_Name.Add('symbol', '', ',', Uses_);
  Uses_Name.Add('symbol', '', ';', '');
  Uses_Name.Add('', '', '', 'Требуется '';''');

//-------------    Write    ----------------------------------------------------
  Write_.Add('symbol', '', '''', String_);
  Write_.Add('', '', '', 'Error');

//-------------    String    ----------------------------------------------------
  String_.Add('symbol', '', '''', '');
  String_.Add('eof', '', '', 'Unterminated string');
  String_.Add('', '', '', String_);


  Ident:=TIdentifer.Create;
  Ident.Add('integer', 'type');
  Ident.Add('real', 'type');
  Ident.Add('char', 'type');
  Ident.Add('byte', 'type');
  Ident.Add('boolean', 'type');

  Table.Add('resword', '', 'program' ,_Program);
  Table.Add('resword', '', 'uses' ,Uses_);
  Table.Add('resword', '', 'begin' ,_Begin);
  Table.Add('eof', '', '' , 'Проверка завершена');
  Table.Add('', '', '' , 'Begin expected');

  repeat
    result:=Table.Exec(ReadWord);
  until not result;

  Table.Free;
  Ident.Free;
  Prog_.Free;
  Prog_Name.Free;
  Uses_Name.Free;
  Uses_.Free;

end;

function _Program(Kind, Atype, Value: String): boolean;
var
  Prog_, Prog_Name: TMap;
begin

  Prog_Name:=TMap.Create;
  Prog_:=TMap.Create;

  Prog_.Add('variable', 'unknown', '', Prog_Name);
  Prog_.Add('resword', '', '', 'Зарезервированное слово не может быть именем программы');
  Prog_.Add('', '', '', 'Требуется имя программы');

  Prog_Name.Add('symbol', '', ';', '');
  Prog_Name.Add('', '', '', 'Требуется '';''');

  result:=Prog_.Exec(ReadWord);

  Table.Delete(Key('resword', '', 'program'));

end;


//-------------    Begin    ----------------------------------------------------
{

}
function _Begin(Kind, Atype, Value: String): boolean;
var
  Key: TKey;
  Operator: TMap;
begin

  Operator:=TMap.Create;
  Operator.Add('resword', '', 'begin', _Begin);
  Operator.Add('', '', '', 'Unknown operator');

  result:=true;
  while result do
  begin
    Key:=ReadWord;
    if Key.Value = 'end' then
      result:=false
    else
    if Key.Value <> ';' then
      begin
        result:=Operator.Exec(Key);
        if result then
        begin
          Key:=ReadWord;
          if Key.Value <> ';' then
          begin
            SetError('Требуется '';''');
            result:=false;
            Key.Value:='';
          end;
        end;
      end;
  end;

  if Key.Value = 'end' then
    result:=true;
//  else
//    if Key.Value <> ';' then
//      SetError('Требуется ''end''');
{

  Key:=ReadWord;
  if Key.Value=';' then
    result:=true
  else
    result:=Operator.Exec(Key);
  while not ((not result) or (Key.Value='end')) do
  begin
    Key:=ReadWord;
    if result then
       if Key.Value<>';' then
        SetError('Требуется '';''');
    if Key.Value=';' then
      result:=true
    else
      result:=Operator.Exec(Key);
  end;

  if (not result) and not (Key.Value='end') then
    SetError('Требуется ''end''')
  else
    result:=true;
}
  Table.DeleteAll;
  Table.Add('symbol', '', '.', 'Проверка завершена');
  Table.Add('', '', '', 'Требуется ''.''');

  Operator.Free;

end;















//==============================================================================
procedure TForm1.Button2Click(Sender: TObject);
begin
  Pos:=1;
  Start:=1;
  ReadString;
  Main;
end;


//-------------    ReadWord    -------------------------------------------------
{
}
function ReadWord: TKey;
const
  RW: array[1..51] of string = (
'and',
'asm',
'array',
'begin',
'case',
'const',
'constructor',
'destructor',
'div',
'do',
'downto',
'else',
'end',
'exports',
'file',
'for',
'function',
'goto',
'if',
'implementation',
'in',
'inline',
'interface',
'label',
'library',
'mod',
'nil',
'not',
'object',
'of',
'or',
'packed',
'pointer',
'procedure',
'program',
'record',
'repeat',
'set',
'shl',
'shr',
'string',
'then',
'to',
'type',
'unit',
'until',
'uses',
'var',
'while',
'with',
'xor'   );

  Modules: array[1..7] of string = (
    'strings',
	  'system',
  	'wincrt',
	  'windos',
  	'winprocs',
	  'wintypes',
  	'wobjects'  );

var
  i: integer;
begin

  result.AType:='';
  result.Value:='';

  while   (  (s[Pos]=' ')             //  Space,
          or (s[Pos]=#13)             //  Enter
          or (s[Pos]=#10)
          or (s[Pos]=#9)  )           //  TAB
          and (Pos<=Length(s)  ) do
    inc(Pos);
  Start:=Pos;

  if s[pos]=#0 then
  begin
    result.Kind:='eof';
    result.AType:='';
    result.Value:='';
  end
//-----------------------------------------------
  else
  if     ((s[Pos]+s[Pos+1]) = '<=')
      or ((s[Pos]+s[Pos+1]) = '>=')
      or ((s[Pos]+s[Pos+1]) = ':=')
      or ((s[Pos]+s[Pos+1]) = '..')
      or ((s[Pos]+s[Pos+1]) = '(*')
      or ((s[Pos]+s[Pos+1]) = '*)')
      or ((s[Pos]+s[Pos+1]) = '(.')
      or ((s[Pos]+s[Pos+1]) = '.)') then
    begin
      result.Kind:='symbol';
      result.AType:='';
      result.Value:=AnsiLowerCase(s[Pos]+s[Pos+1]);
      inc(Pos);
      inc(Pos);
    end
//-----------------------------------------------

  else
    if  s[Pos] in ['+', '-', '*', '/', '=', '<', '>',
                  '[',	']', ',',	'(', ')',	':', ';',
                   '^',	'.', '@',	'{', '}',	'$', '#', ''''] then
      begin
        result.Kind:='symbol';
        result.AType:='';
        result.Value:=AnsiLowerCase(s[Pos]);
        inc(Pos);
      end
//-----------------------------------------------

      else
        if (s[Pos] in ['A'..'Z']) or (s[Pos] in ['a'..'z']) or (s[Pos]='_') then
        begin
          while ( (s[Pos] in ['A'..'Z']) or (s[Pos] in ['a'..'z'])
                  or (s[Pos]='_') or (s[Pos] in ['0'..'9']) )  do
            inc(Pos);

          for i:=1 to Length(RW) do
            if AnsiLowerCase(copy(s, Start, Pos-Start)) = RW[i] then
            begin
              result.Kind:='resword';
              result.AType:='';
              result.Value:=AnsiLowerCase(copy(s, Start, Pos-Start));
            end;

          for i:=1 to Length(Modules) do
            if AnsiLowerCase(copy(s, Start, Pos-Start)) = Modules[i] then
            begin
              result.Kind:='module';
              result.AType:='';
              result.Value:=AnsiLowerCase(copy(s, Start, Pos-Start));
              Ident.Add(result.Value, 'uses');
            end;

            if result.Value='' then
              begin
                result.Kind:='variable';
                result.AType:=Ident.GetType(copy(s, Start, Pos-Start));
                result.Value:=AnsiLowerCase(copy(s, Start, Pos-Start));
              end;
        end
//-----------------------------------------------

        else
          if (s[Pos] in ['0'..'9']) then
          begin
            while ( (s[Pos] in ['0'..'9']) or (s[Pos]='.') )  do
              inc(Pos);
            result.Kind:='digit';
            result.AType:='';
            result.Value:=AnsiLowerCase(copy(s, Start, Pos-Start));
          end;
//-----------------------------------------------

  Cur_Name:=AnsiLowerCase(result.Value);                             //    ????????????????????????????????

end;



procedure SetError(Error: string);
begin
  Form1.Memo2.Lines.Add(IntToStr(GetPoint(Start).X)+':'+
                        IntToStr(GetPoint(Start).Y)+' '+Error);
end;


procedure ReadString;
begin
  s:=Form1.Memo1.Text;
end;


function GetPoint(P: integer): TPoint;
var i, Lines, Col: integer;
begin
  Lines:=1;
  Col:=1;

  for i:=1 to P do
    if s[i]=#13 then
    begin
      inc(Lines);
      Col:=0;
    end
    else
      inc(Col);

  result.X:=Lines;
  result.Y:=Col-1;

end;



end.
