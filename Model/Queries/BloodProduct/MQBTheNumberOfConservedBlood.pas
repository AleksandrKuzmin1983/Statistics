unit MQBTheNumberOfConservedBlood;

interface

uses
  SysUtils, Variants,
  Dialogs, Data.Win.ADODB,
  GetDataSoursUnit1,
  UCheckNull;

type
  ITheNumberOfConservedBlood = interface
    function GetValue: string;
  end;

  TTheNumberOfConservedBlood = class(TInterfacedObject, ITheNumberOfConservedBlood)
  private
    NumberOfCB: string;
    TempConnect: IDataBaseTables;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TTheNumberOfConservedBlood.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(TempConnect) then
    TempConnect := TDataBaseTables.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add
    ('SELECT Sum(Blood.����) AS [Sum-����], Sum(Plasma.����) AS [Sum-����], '
    + 'Sum(Tromb.����) AS [Sum-����] ' +
    'FROM ((FactoryCal LEFT JOIN Blood ON FactoryCal.���� = Blood.�����) ' +
    'LEFT JOIN Plasma ON FactoryCal.���� = Plasma.�����) ' +
    'LEFT JOIN Tromb ON FactoryCal.���� = Tromb.����� ' +
    'WHERE (Blood.�����) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#');
  TempQuery.Open;
  NumberOfCB := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value) +
    CheckNull.CheckedValue(TempQuery.Fields[1].value) + CheckNull.CheckedValue
    (TempQuery.Fields[0].value));
  TempQuery.Close;
end;

function TTheNumberOfConservedBlood.GetValue: string;
begin
  result := NumberOfCB;
end;

end.
