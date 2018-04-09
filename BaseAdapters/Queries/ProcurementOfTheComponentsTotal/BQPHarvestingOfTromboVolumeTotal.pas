unit BQPHarvestingOfTromboVolumeTotal;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB,
  GetAdoConnect,
  USCheckNull;

type
  IBQPHarvestingOfTromboVolumeTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfTromboVolumeTotal = class(TInterfacedObject,
    IBQPHarvestingOfTromboVolumeTotal)
  private
    TromboVolumeTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfTromboVolumeTotal.create(DateStart, DateEnd: TDate);
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
  TempQuery.SQL.Add('SELECT Sum(TrombComponents.КПЛТ) ' +
    'FROM Tromb INNER JOIN (TrombDoza INNER JOIN TrombComponents ' +
    'ON TrombDoza.КодТ = TrombComponents.КодДТ) ON Tromb.ДатаТ = TrombDoza.ДатаТ '
    + 'WHERE (Tromb.ДатаТ) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  TromboVolumeTotal :=
    VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfTromboVolumeTotal.create выполнена');
end;

function TBQPHarvestingOfTromboVolumeTotal.GetValue: string;
begin
  result := TromboVolumeTotal;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfTromboVolumeTotal.GetValue выполнена');
end;

end.
