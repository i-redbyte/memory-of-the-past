unit Map2;

interface

Uses
  SysUtils;

type

  TKey = Record
    Kind: string;
    AType: string;
    Value: string;
  end;

  function Key(Kind, Atype, Value: String): TKey;

type
  F = function(Kind, Atype, Value: String): boolean;

type
  TMap = class
  private

    Keys: array of TKey;
    Maps: array of TMap;
    Strs: array of string;
    Funs: array of F;

  public
    Count: integer;
    Find: boolean;

    constructor Create;
    destructor Destroy; override;

    procedure Add(Kind, Atype, Value: String; AMap: TMap); overload;
    procedure Add(Kind, Atype, Value: String; AFun: F); overload;
    procedure Add(Kind, Atype, Value: String; Error: String); overload;

    procedure Delete(AKey: TKey);
    procedure DeleteAll;

    function Exec(AKey: TKey): boolean;


end;


implementation

uses
  Unit_Syntax1;

//-------------    Key    ------------------------------------------------------
{

}
function Key(Kind, Atype, Value: String): TKey;
begin
  result.Kind:=Kind;
  result.AType:=AType;
  result.Value:=Value;
end;


//-------------    CREATE / DESTROY    -----------------------------------------
{

}
constructor TMap.Create;
begin
  Count:=0;
  Find:=false;
end;

destructor TMap.Destroy;
begin
  Keys:=nil;
  Maps:=nil;
  Strs:=nil;
  Funs:=nil;

  inherited Destroy;
end;


//-------------    Add    ------------------------------------------------------
{

}
procedure TMap.Add(Kind, Atype, Value: String; AMap: TMap);
begin

  inc(Count);

  SetLength(Keys, Count);
  Keys[Count-1].Kind:=Kind;
  Keys[Count-1].AType:=AnsiLowerCase(AType);
  Keys[Count-1].Value:=AnsiLowerCase(Value);

  SetLength(Maps, Count);
  Maps[Count-1]:=AMap;

  SetLength(Strs, Count);
  Strs[Count-1]:='';

  SetLength(Funs, Count);
  Funs[Count-1]:=nil;

end;

procedure TMap.Add(Kind, Atype, Value: String; AFun: F);
begin

  inc(Count);

  SetLength(Keys, Count);
  Keys[Count-1].Kind:=Kind;
  Keys[Count-1].AType:=AnsiLowerCase(AType);
  Keys[Count-1].Value:=AnsiLowerCase(Value);

  SetLength(Maps, Count);
  Maps[Count-1]:=nil;

  SetLength(Strs, Count);
  Strs[Count-1]:='';

  SetLength(Funs, Count);
  Funs[Count-1]:=AFun;

end;

procedure TMap.Add(Kind, Atype, Value: String; Error: String);
begin

  inc(Count);

  SetLength(Keys, Count);
  Keys[Count-1].Kind:=Kind;
  Keys[Count-1].AType:=AnsiLowerCase(AType);
  Keys[Count-1].Value:=AnsiLowerCase(Value);

  SetLength(Maps, Count);
  Maps[Count-1]:=nil;

  SetLength(Strs, Count);
  Strs[Count-1]:=Error;

  SetLength(Funs, Count);
  Funs[Count-1]:=nil;

end;



procedure TMap.Delete(AKey: TKey);
var
  k, j, Minus: integer;
begin

  minus:=0;
  for k:=0 to Count-1 do
  begin
    if (Keys[k-Minus].Kind=AKey.Kind) and
       (Keys[k-Minus].AType=AKey.AType) and
       (Keys[k-Minus].Value=AKey.Value)  then
    begin                       //      _
      if k<Count-1 then         // |0|1|2|3|4|5| -> |0|1|3|4|5| | -> |0|1|3|4|5|
        for j:=k-Minus to Count-2 do
        begin
          Keys[j]:=Keys[j+1];
          Maps[j]:=Maps[j+1];
          Funs[j]:=Funs[j+1];
          Strs[j]:=Strs[j+1];
        end;
      dec(Count);
      inc(Minus);
      SetLength(Keys, Count);
      SetLength(Maps, Count);
      SetLength(Strs, Count);
      SetLength(Funs, Count);
    end;
  end;

end;


procedure TMap.DeleteAll;
begin
  Count:=0;
  SetLength(Keys, Count);
  SetLength(Maps, Count);
  SetLength(Funs, Count);
  SetLength(Strs, Count);
end;

//-------------    EXEC    -----------------------------------------------------
{
}
function TMap.Exec(AKey: TKey): boolean;
var i: integer;
begin

  Find:=false;
  result:=false;

  i:=0;
  while (i<Count) and (not find) do
  begin
    if (Keys[i].Kind=AKey.Kind) or (Keys[i].Kind='') then
      if (Keys[i].AType=AKey.AType) or (Keys[i].AType='') then
       if (Keys[i].Value=AKey.Value) or (Keys[i].Value='') then
        begin
          if Maps[i]<>nil then
            result:=Maps[i].Exec(ReadWord)
          else
            if Assigned(Funs[i]) then
              result:=Funs[i](AKey.Kind, AKey.AType, Akey.Value)
            else
              if Strs[i]<>'' then
              begin
                SetError(Strs[i]);
                result:=false;
              end
              else
                result:=true;
            Find:=true;
         end;
    inc(i);
  end;

end;




end.
