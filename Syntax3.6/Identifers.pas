unit Identifers;

interface


Type
  TId = record
    Name, Type_: string;
end;


type
  TIdentifer = class

  private

    Ids: array of TId;
    function GetIdentifers(Index: integer): TId;
    procedure SetIdentifers(Index: integer; const Value: TId);

  public
    Count: integer;
//    Find: boolean;

    constructor Create;
    destructor Destroy; override;

    procedure Add(Name, Type_: string);
    function GetType(Name: string): string;
    property Identifers[Index: integer]: TId  read GetIdentifers write SetIdentifers;
    procedure SetType(Index: integer; Type_: string);

end;

implementation



procedure TIdentifer.Add(Name, Type_: string);
begin

  inc(Count);
  SetLength(Ids, Count);
  Ids[Count-1].Name:=Name;
  Ids[Count-1].Type_:=Type_;

end;



constructor TIdentifer.Create;
begin
  Count:=0;
end;


destructor TIdentifer.Destroy;
begin
  Ids:=nil;

  inherited Destroy;
end;


function TIdentifer.GetIdentifers(Index: integer): TId;
begin
  result.Name:=Ids[Index].Name;
  result.Type_:=Ids[Index].Type_;
end;

function TIdentifer.GetType(Name: string): string;
var i: integer;
begin

  result:='unknown';
  for i:=0 to Count-1 do
    if Ids[i].Name=Name then
      result:=Ids[i].Type_;

end;

procedure TIdentifer.SetIdentifers(Index: integer; const Value: TId);
begin
  Ids[Index].Name:=Value.Name;
  Ids[Index].Type_:=Value.Type_;
end;


procedure TIdentifer.SetType(Index: integer; Type_: string);
begin
  Ids[Index].Type_:=Type_;
end;

end.
