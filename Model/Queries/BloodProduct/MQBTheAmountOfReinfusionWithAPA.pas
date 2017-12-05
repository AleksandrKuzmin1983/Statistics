unit MQBTheAmountOfReinfusionWithAPA;

interface

uses
  SysUtils, Variants,
  Dialogs, Data.Win.ADODB,
  GetDataSoursUnit1,
  UCheckNull;

type
  ITheAmountOfReinfusionWithAPA = interface
    function GetValue: string;
  end;

  TTheAmountOfReinfusionWithAPA = class(TInterfacedObject, ITheAmountOfReinfusionWithAPA)
  private
    AmountOfRWAPA: string;
    TempConnect: IDataBaseTables;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TTheAmountOfReinfusionWithAPA.create(DateStart, DateEnd: TDate);
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
    ('SELECT Sum(Plasma.����), Sum(PlasmaComponents.����), Sum(PlazmaBrak.����) ' +
    'FROM (Plasma INNER JOIN PlazmaDoza ON Plasma.�����=PlazmaDoza.�����) ' +
    'INNER JOIN (PlasmaComponents INNER JOIN PlazmaBrak ' +
    'ON PlasmaComponents.����� = PlazmaBrak.�����) ON ' +
    'PlazmaDoza.����� = PlasmaComponents.����� ' +
    'WHERE (Plasma.�����) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#');
  TempQuery.Open;
  AmountOfRWAPA := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value) -
    CheckNull.CheckedValue(TempQuery.Fields[1].value) - CheckNull.CheckedValue
    (TempQuery.Fields[2].value));
  TempQuery.Close;
end;

function TTheAmountOfReinfusionWithAPA.GetValue: string;
begin
  result := AmountOfRWAPA;
end;

end.