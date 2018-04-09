unit BQPHarvestingOfFiltratVolumeTotal;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB,
  GetAdoConnect,
  USCheckNull;

type
  IBQPHarvestingOfFiltratVolumeTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfFiltratVolumeTotal = class(TInterfacedObject,
    IBQPHarvestingOfFiltratVolumeTotal)
  private
    FiltratVolumeTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfFiltratVolumeTotal.create(DateStart,
  DateEnd: TDate);
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
  TempQuery.SQL.Add('SELECT Sum(Filtrat.��) ' +
    'FROM (((Blood INNER JOIN BloodDoza ON Blood.����� = BloodDoza.�����) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.���� = BloodErSusp.���) ' +
    'INNER JOIN BloodPlasma ON BloodErSusp.��� = BloodPlasma.����) ' +
    'INNER JOIN Filtrat ON BloodPlasma.���� = Filtrat.���� ' +
    'WHERE (Blood.�����) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  FiltratVolumeTotal :=
    VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfFiltratVolumeTotal.create ���������');
end;

function TBQPHarvestingOfFiltratVolumeTotal.GetValue: string;
begin
  result := FiltratVolumeTotal;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfFiltratVolumeTotal.GetValue ���������');
end;

end.
