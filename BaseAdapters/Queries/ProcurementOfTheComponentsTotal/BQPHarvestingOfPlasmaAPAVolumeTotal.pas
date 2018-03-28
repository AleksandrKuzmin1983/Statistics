unit BQPHarvestingOfPlasmaAPAVolumeTotal;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  GetAdoConnect,
  USCheckNull;

type
  IBQPHarvestingOfPlasmaAPAVolumeTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfPlasmaAPAVolumeTotal = class(TInterfacedObject,
    IBQPHarvestingOfPlasmaAPAVolumeTotal)
  private
    PlasmaAPAVolumeTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfPlasmaAPAVolumeTotal.create(DateStart,
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
  TempQuery.SQL.Add('SELECT Sum(PlasmaComponents.КПЛП) ' +
    'FROM (Plasma INNER JOIN PlazmaDoza ON Plasma.ДатаП = PlazmaDoza.ДатаП) ' +
    'INNER JOIN PlasmaComponents ON PlazmaDoza.КодПл = PlasmaComponents.КодДП '
    + 'WHERE (Plasma.ДатаП) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  PlasmaAPAVolumeTotal :=
    VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function TBQPHarvestingOfPlasmaAPAVolumeTotal.GetValue: string;
begin
  result := PlasmaAPAVolumeTotal;
end;

end.
