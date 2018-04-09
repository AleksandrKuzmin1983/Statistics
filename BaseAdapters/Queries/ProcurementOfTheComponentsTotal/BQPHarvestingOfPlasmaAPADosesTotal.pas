unit BQPHarvestingOfPlasmaAPADosesTotal;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB,
  GetAdoConnect,
  USCheckNull;

type
  IBQPHarvestingOfPlasmaAPADosesTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfPlasmaAPADosesTotal = class(TInterfacedObject,
    IBQPHarvestingOfPlasmaAPADosesTotal)
  private
    PlasmaAPADosesTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfPlasmaAPADosesTotal.create(DateStart,
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
  TempQuery.SQL.Add('SELECT Sum(PlasmaComponents.ДПЛП) ' +
    'FROM (Plasma INNER JOIN PlazmaDoza ON Plasma.ДатаП = PlazmaDoza.ДатаП) ' +
    'INNER JOIN PlasmaComponents ON PlazmaDoza.КодПл = PlasmaComponents.КодДП '
    + 'WHERE (Plasma.ДатаП) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  PlasmaAPADosesTotal :=
    VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfPlasmaAPADosesTotal.create выполнена');
end;

function TBQPHarvestingOfPlasmaAPADosesTotal.GetValue: string;
begin
  result := PlasmaAPADosesTotal;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfPlasmaAPADosesTotal.GetValue выполнена');
end;

end.
