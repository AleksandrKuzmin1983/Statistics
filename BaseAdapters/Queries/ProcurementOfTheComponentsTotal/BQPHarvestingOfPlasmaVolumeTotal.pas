unit BQPHarvestingOfPlasmaVolumeTotal;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB,
  GetAdoConnect,
  USCheckNull;

type
  IBQPHarvestingOfPlasmaVolumeTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfPlasmaVolumeTotal = class(TInterfacedObject,
    IBQPHarvestingOfPlasmaVolumeTotal)
  private
    TempValue: Integer;
    PlasmaVolumeTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfPlasmaVolumeTotal.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add('SELECT Sum(BloodPlasma.КПЛ) ' +
    'FROM ((Blood INNER JOIN BloodDoza ON Blood.ДатаК = BloodDoza.ДатаК) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.КодД = BloodErSusp.Код) ' +
    'INNER JOIN BloodPlasma ON BloodErSusp.Код = BloodPlasma.КодЭ ' +
    'WHERE (Blood.ДатаК) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  TempValue := StrToInt
    (VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value)));
  TempQuery.Close;

  TempQuery.SQL.Clear;
  TempQuery.SQL.Add('SELECT Sum(PlasmaComponents.КПЛП) ' +
    'FROM (Plasma INNER JOIN PlazmaDoza ON Plasma.ДатаП = PlazmaDoza.ДатаП) ' +
    'INNER JOIN PlasmaComponents ON PlazmaDoza.КодПл = PlasmaComponents.КодДП '
    + 'WHERE (Plasma.ДатаП) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  PlasmaVolumeTotal :=
    IntToStr(TempValue +
    StrToInt(VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value))));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfPlasmaVolumeTotal.create выполнена');
end;

function TBQPHarvestingOfPlasmaVolumeTotal.GetValue: string;
begin
  result := PlasmaVolumeTotal;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfPlasmaVolumeTotal.GetValue выполнена');
end;

end.
