unit BQPHarvestingOfPlasmaBloodDosesTotal;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB,
  GetAdoConnect,
  USCheckNull;

type
  IBQPHarvestingOfPlasmaBloodDosesTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfPlasmaBloodDosesTotal = class(TInterfacedObject,
    IBQPHarvestingOfPlasmaBloodDosesTotal)
  private
    PlasmaBloodDosesTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfPlasmaBloodDosesTotal.create(DateStart,
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
  TempQuery.SQL.Add('SELECT Sum(BloodPlasma.ДПЛ) ' +
    'FROM ((Blood INNER JOIN BloodDoza ON Blood.ДатаК = BloodDoza.ДатаК) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.КодД = BloodErSusp.Код) ' +
    'INNER JOIN BloodPlasma ON BloodErSusp.Код = BloodPlasma.КодЭ ' +
    'WHERE (Blood.ДатаК) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  PlasmaBloodDosesTotal :=
    VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfPlasmaBloodDosesTotal.create выполнена');
end;

function TBQPHarvestingOfPlasmaBloodDosesTotal.GetValue: string;
begin
  result := PlasmaBloodDosesTotal;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfPlasmaBloodDosesTotal.GetValue выполнена');
end;

end.
