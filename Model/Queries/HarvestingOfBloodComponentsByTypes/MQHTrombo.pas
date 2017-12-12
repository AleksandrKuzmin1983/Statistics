unit MQHTrombo;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs,
  UCheckNull,
  GetAdoQuery;

type
  ITrombo = interface
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumber(i: integer): string;
    function GetPacet(i: integer): string;
    function GetRowCount: integer;
  end;

  TResultRecord=Record
  private
    Name: String;
    Volume: String;
    Number: String;
    Pacet: String;
  end;

  TTrombo = class(TInterfacedObject,
    ITrombo)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumber(i: integer): string;
    function GetPacet(i: integer): string;
    function GetRowCount: integer;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TTrombo.create(DateStart, DateEnd: TDate);
var i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add
    ('SELECT TrombComponents.����, Sum(TrombComponents.����), Sum(TrombComponents.����), Sum(TrombComponents.����) ' +
     'FROM TrombDoza INNER JOIN TrombComponents ON TrombDoza.���� = TrombComponents.����� ' +
     'WHERE (((TrombDoza.�����) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#)) GROUP BY TrombComponents.����;');
  TempQuery.Open;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Name:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Volume:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Number:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].Pacet:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

function TTrombo.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TTrombo.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TTrombo.GetName(i: integer): string ;
begin
  result := ResultMass[i].Name;
end;

function TTrombo.GetNumber(i: integer): string;
begin
  result := ResultMass[i].Number;
end;

function TTrombo.GetPacet(i: integer): string;
begin
  result := ResultMass[i].Pacet;
end;

end.
