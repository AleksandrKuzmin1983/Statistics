unit MQHPlasmaAPA;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs,
  UCheckNull,
  GetDataSoursUnit1;

type
  IPlasmaAPA = interface
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumber(i: integer): string;
    function GetRowCount: integer;
  end;

  TResultRecord=Record
    Name: String;
    Volume: String;
    Number: String;
  end;

  TPlasmaAPA = class(TInterfacedObject,
    IPlasmaAPA)
  private
    TempConnect: IDataBaseTables;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumber(i: integer): string;
    function GetRowCount: integer;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TPlasmaAPA.create(DateStart, DateEnd: TDate);
var i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TDataBaseTables.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add
    ('SELECT PlasmaComponents.¬Ë‰œÀœ, Sum(PlasmaComponents. œÀœ), Sum(PlasmaComponents.ƒœÀœ) ' +
     'FROM PlazmaDoza INNER JOIN PlasmaComponents ON PlazmaDoza. Ó‰œÎ = PlasmaComponents. Ó‰ƒœ ' +
     'WHERE (((PlazmaDoza.ƒ‡Ú‡œ) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#)) GROUP BY PlasmaComponents.¬Ë‰œÀœ;');
  TempQuery.Open;
  SetLength(ResultMass, TempQuery.RecordCount);
  if (TempQuery.Recordset.EOF<>true) and (TempQuery.Recordset.BOF<>true) then
  begin
  TempQuery.Recordset.MoveFirst;
  for i:=0 to TempQuery.RecordCount-1 do
  begin
    ResultMass[i].Name:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
    ResultMass[i].Volume:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
    ResultMass[i].Number:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
    TempQuery.Next;
  end;
  end;
  TempQuery.Close;
end;

function TPlasmaAPA.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TPlasmaAPA.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TPlasmaAPA.GetName(i: integer): string ;
begin
  result := ResultMass[i].Name;
end;

function TPlasmaAPA.GetNumber(i: integer): string;
begin
  result := ResultMass[i].Number;
end;

end.
