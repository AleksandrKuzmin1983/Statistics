unit MQPHarvestingOfFiltratDosesTotal;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  GetDataSoursUnit1,
  UCheckNull;

type
  IHarvestingOfFiltratDosesTotal = interface
    function GetValue: string;
  end;

  THarvestingOfFiltratDosesTotal = class(TInterfacedObject,
    IHarvestingOfFiltratDosesTotal)
  private
    FiltratDosesTotal: string;
    TempConnect: IDataBaseTables;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor THarvestingOfFiltratDosesTotal.create(DateStart, DateEnd: TDate);
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
  TempQuery.SQL.Add('SELECT Sum(Filtrat.��) ' +
    'FROM (((Blood INNER JOIN BloodDoza ON Blood.����� = BloodDoza.�����) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.���� = BloodErSusp.���) ' +
    'INNER JOIN BloodPlasma ON BloodErSusp.��� = BloodPlasma.����) ' +
    'INNER JOIN Filtrat ON BloodPlasma.���� = Filtrat.���� ' +
    'WHERE (Blood.�����) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#;');
  TempQuery.Open;
  FiltratDosesTotal :=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function THarvestingOfFiltratDosesTotal.GetValue: string;
begin
  result := FiltratDosesTotal;
end;


end.
