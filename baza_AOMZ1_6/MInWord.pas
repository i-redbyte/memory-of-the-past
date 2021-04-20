{***********************************************************************}
{ Невизуальный компонент для перевода денежной единицы в сумму прописью }
{ Автор: Александр Шабля, e-mail: shablya@yandex.ru                     }
{***********************************************************************}
unit MInWord;

interface

uses
  SysUtils,
  Classes,
  stdctrls;

type
  TDigLevel = (lvlNone, lvlThousand, lvlMillion, lvlBillion);

type
  TInWord = class(TComponent)
  private
    {Private Declaration}
    FInWordList: TStringList;
    FText: String;
    FValue: Double;
    FMale: Boolean;
    FComma: ShortString;
    FLabel: TLabel;
    FFileName: TFileName;
    FSeparator: Char;
    procedure SetValue(NewValue: Double);
    procedure SetMale(AMale: Boolean);
    procedure SetComma(AComma: ShortString);
    procedure SetLabel(ALabel: TLabel);
    procedure SetSeparator(const Value: Char);
    procedure SetFileName(const Value: TFileName);
    function GetCurName: String;
  protected
    {Protected Declaration}
    function GetValue(Name: String; Count: Integer): String;
    function NumToStr(ANum: Cardinal; ALevel: TDigLevel): String;
    procedure ResetText;
  public
    {Public Declaration}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetDefList;
    procedure LoadFromFile(const AFileName: TFileName); virtual;
    procedure SaveToFile(const AFileName: TFileName); virtual;
    function GetMonth(const D: TDateTime; Nominative: Boolean = True): String;
    function GetDate(const D: TDateTime): String;
    function GetDayOfWeek(const D: TDateTime): String;
    function GetInWord(const AValue: Double): String;

  published
    property FileName: TFileName read FFileName write SetFileName;

    property Comma: ShortString read FComma write SetComma; // разделитель целой и дес. частей
    property CurrencyName: String read GetCurName; // наименование валюты
    property Male: Boolean read FMale write SetMale; // "род" валюты
    property Text: String read FText;  // значение в виде текста
    property Separator: Char read FSeparator write SetSeparator; // разделитель слов в файле
    property Target: TLabel read FLabel write SetLabel; // лейбл на форме
    property Value: Double read FValue write SetValue;  // значение
  end;

implementation

{$ifdef ver150} // if Borland Delphi7 then...
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_CAST OFF}
{$endif}

const
  DefValues: array[0..13] of PChar = ( // unsafe type
    'One=один;два;три;чотири;п’ять;шiсть;сiм;вiсiм;дев’ять;одна;двi;ноль',
    'Ten=десять;одинадцять;дванадцять;тринадцять;чотирнадцять;п’ятнадцять;' +
    'шiстнадцять;сiмнадцять;вiсiмнадцять;дев’ятнадцять',
    'Twen=двадцять;тридцять;сорок;п’ятдесят;шiстдесят;сiмдесят;вiсiмдесят;дев’яносто',
    'Hndr=сто;двiстi;триста;чотириста;п’ятсот;шiстсот;сiмсот;вiсiмсот;дев’ятсот',
    'Thou=тисяча;тисячi;тисяч',
    'Mill=мiльйон;мiльйони;мiльйонiв',
    'Bill=мiльярд;мiльярди;мiльярдiв',
    'Currency=гривня;гривнi;гривень',
    'CurrencyMale=0',
    'Cop=копiйка;копiйки;копiйок',
    'Comma=,',
    'Month1=січень;лютий;березень;квітень;травень;червень;липень;серпень;вересень;' +
    'жовтень;листопад;грудень',
    'Month2=січня;лютого;березня;квітня;травня;червня;липня;серпня;вересня;' +
    'жовтня;листопада;грудня',
    'DayOfWeek=недiля;понедiлок;вiвторок;середа;четвер;п’ятниця;субота'
  );

// некоторые функции
function Iif(Condition: Boolean; const Res1, Res2: String): String;
begin
  if Condition then Result := Res1 else Result := Res2;
end;

function TrimBlanks(const S: String): String;
const
  PointSign = [',', ';', '.', '!', '?'];
var
  i: Integer;
  T: String;
  B: Boolean;
begin
  T := Trim(S); Result := EmptyStr; // Теперь поубираем символы внутри строки
  B := False;
  for i := 1 to Length(T) do begin // первый символ точно не пробел
    if (T[i] > #32) then begin
      // добавим пробел, если он был, но не перед знаком припинания
      if ((not (T[i] in PointSign)) and B) then Result := Result + #32;
      Result := Result + T[i];
    end;
    B := (T[i] <= #32);
  end;
end;

{ TInWord }

constructor TInWord.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetDefList;
  FText := EmptyStr;
  FValue := 0;
  FMale := False;
  FComma := ',';
  FLabel := nil;
  FFileName := EmptyStr;
  FSeparator := ';';
end;

destructor TInWord.Destroy;
begin
  FInWordList.Free;
  inherited;
end;

// Поиск нужного значения в ключе Name по счету Count
function TInWord.GetValue(Name: String; Count: Integer): String;
var
  S: String;
  i, p1, p2: Integer;
begin
  S := FInWordList.Values[Name];
  if Length(S) > 0 then begin
    i := 1;
    p1 := Pos(Separator, S);
    while (i < Count) and (p1 > 0) do begin
      S := Copy(S, p1 + 1, 255);
      p1 := Pos(Separator, S);
      Inc(i);
    end;
    if i = Count then begin // то что надо!
      p2 := Pos(Separator, S);
      if p2 > 0 then S := Copy(S, 1, p2 - 1); // else S := Copy(S, 1, 255);
      S := Concat(Trim(S), ' ');
    end else S := EmptyStr;
  end;
  Result := S;
end;

procedure TInWord.ResetText;
var
  S: String;
  L: Int64; // Только Int64 работает правильно для миллиардов!
begin
  if FValue > 999.99999999999E+9 then begin
    FText := '******************';
    if Assigned(FLabel) then FLabel.Caption := FText;
    Exit;
  end;
  // Начнем сначала
  L := Trunc(FValue);
  if L = 0 then S := GetValue('One', 12)
  else begin
    S := NumToStr(Trunc(L / 1E+9), lvlBillion);
    L := L mod Trunc(1E+9);
    S := S + NumToStr(Trunc(L / 1E+6), lvlMillion);
    L := L mod Trunc(1E+6); //1E+6;
    S := S + NumToStr(Trunc(L / 1E+3), lvlThousand);
    L := L mod 1000; //1E+3;
  end;
  S := S + NumToStr(L, lvlNone); // валюту дописали
  { Если вообще существует обозначение копеек, то допишем копейки }
  if Length(Trim(GetValue('Cop', 1))) > 0  then begin
    L := Round((FValue - Trunc(FValue)) * 100);
    S := Trim(S) + FComma + ' ' + FormatFloat('00 ', L);
    if L > 20 then L := L mod 10;
    case L of
      1: S := S + GetValue('Cop', 1);
      2..4: S := S + GetValue('Cop', 2);
      else S := S + GetValue('Cop', 3);
    end;
  end;
  FText := Trim(Concat(AnsiUpperCase(Copy(S, 1, 1)), Copy(S, 2, 255)));
  if Assigned(FLabel) then FLabel.Caption := FText;
end;

procedure TInWord.SetValue(NewValue: Double);
begin
  if FValue <> Abs(NewValue) then begin
    FValue := Abs(NewValue);
    ResetText;
  end;
end;

function TInWord.NumToStr(ANum: Cardinal; ALevel: TDigLevel): String;
const
  DigLevelNames: array[TDigLevel] of PChar = ('', 'Thou', 'Mill', 'Bill');
var
  Male: Boolean;
begin
  case ALevel of
    lvlThousand: Male := False;
    lvlMillion, lvlBillion: Male := True;
    else Male := FMale;
  end;
  if (ANum = 0) and (ALevel <> lvlNone) then begin
    Result := EmptyStr;
    Exit;
  end;
  Result := GetValue('Hndr', ANum div 100);
  ANum := ANum mod 100;
  if ANum >= 20 then begin
    Result := Result + GetValue('Twen', ANum div 10 - 1);
    ANum := ANum mod 10;
  end;
  if ANum >= 10 then Result := Result + GetValue('Ten', ANum - 10 + 1)
  else begin
    if (ANum in [1, 2]) and not Male then Result := Result + GetValue('One', ANum + 10 - 1)
      else Result := Result + GetValue('One', ANum);
  end;
  if ALevel = lvlNone then // добавляем валюту
    case ANum of
      1: Result := Result + GetValue('Currency', 1);
      2..4: Result := Result + GetValue('Currency', 2);
      else Result := Result + GetValue('Currency', 3);
    end
  else // или уровень
    case ANum of
      1: Result := Result + GetValue(DigLevelNames[ALevel], 1);
      2..4: Result := Result + GetValue(DigLevelNames[ALevel], 2);
      else Result := Result + GetValue(DigLevelNames[ALevel], 3);
    end;
end;

procedure TInWord.SetMale(AMale: Boolean);
const
  CMale: array[Boolean] of String[1] = ('1', '0');
begin
  if FMale <> AMale then begin
    FMale := AMale;
    FInWordList.Values['CurrencyMale'] := CMale[FMale];
    ResetText;
  end;
end;

procedure TInWord.SetComma(AComma: ShortString);
begin
  AComma := Trim(AComma);
  if AComma <> FComma then begin
    FComma := AComma;
    ResetText;
  end;
end;

procedure TInWord.SetLabel(ALabel: TLabel);
begin
  FLabel := ALabel;
  ResetText;
end;

procedure TInWord.LoadFromFile(const AFileName: TFileName);
const
  CMale = 'YES,Y,T,TRUE,ДА,Д,М,M,1';
begin
  try // Нужно ли здесь делать Clear ???
    FInWordList.Clear;
    FInWordList.LoadFromFile(AFileName);
    if Length(GetValue('One', 9)) = 0 then raise Exception.Create('Это не файл поддержки языка!');
    FMale := Pos(AnsiUpperCase(Trim(GetValue('CurrencyMale', 1))), CMale) > 0;
    SetComma(GetValue('Comma', 1));
    ResetText;
  except
    on E:Exception do begin
      SetDefList;
      raise Exception.CreateFmt('%s'#10'%s', [E.Message, Self.ClassName]);
    end;
  end;
end;

procedure TInWord.SaveToFile(const AFileName: TFileName);
begin
  try
    FInWordList.SaveToFile(AFileName);
  except
    raise Exception.CreateFmt('%s'#10'Ошибка записи файла %s', [Self.ClassName, AFileName]);
  end;
end;

procedure TInWord.SetFileName(const Value: TFileName);
begin
  if AnsiUpperCase(FFileName) <> AnsiUpperCase(Value) then begin
    FFileName := Value;
    if FileExists(FFileName) then LoadFromFile(FFileName)
    else raise Exception.CreateFmt('Файл %s не найден!', [FFileName]);
  end;
end;

function TInWord.GetMonth(const D: TDateTime; Nominative: Boolean): String;
begin
  Result := Trim(GetValue(Iif(Nominative, 'Month1', 'Month2'), StrToInt(FormatDateTime('mm', D))));
end;

function TInWord.GetDate(const D: TDateTime): String;
begin
  Result := TrimBlanks(Format('%s %s %s', [FormatDateTime('d', D),
    AnsiLowerCase(GetMonth(D, False)), FormatDateTime('yyyy', D)]));
end;

procedure TInWord.SetDefList;
var
  i: Integer;
begin
  if not Assigned(FInWordList) then FInWordList := TStringList.Create;
  FInWordList.Clear;
  with FInWordList do for i := Low(DefValues) to High(DefValues) do Add(String(DefValues[i]));
end;

procedure TInWord.SetSeparator(const Value: Char);
begin
  if FSeparator <> Value then begin
    FSeparator := Value;
    ResetText;
  end;
end;

function TInWord.GetDayOfWeek(const D: TDateTime): String;
begin
  Result := GetValue('DayOfWeek', Abs(Trunc(D) - 1) mod 7 + 1);
end;

{ Вызов методов
   TInWord.Value := MyNumber;
   Label1.Caption := TInWord.Text;
 земеняется на
   Label1.Caption := TInWord.GetInWord(MyNumber);
}
function TInWord.GetInWord(const AValue: Double): String;
begin
  if AValue <> Value then begin
    Value := AValue; // Вызывается вместо SetValue
  end;
  Result := Text;
end;

function TInWord.GetCurName: String;
begin
  Result := GetValue('Currency', 1);
end;

end.
