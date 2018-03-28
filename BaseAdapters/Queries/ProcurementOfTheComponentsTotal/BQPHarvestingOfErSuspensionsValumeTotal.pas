unit BQPHarvestingOfErSuspensionsValumeTotal;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  USCheckNull,
  GetAdoConnect;

type
  IBQPHarvestingOfErSuspensionsValumeTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfErSuspensionsValumeTotal = class(TInterfacedObject,
    IBQPHarvestingOfErSuspensionsValumeTotal)
  private
    ErSuspVolumeTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfErSuspensionsValumeTotal.create(DateStart,
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
  TempQuery.SQL.Add('SELECT Sum(BloodErSusp.КЭВ) ' +
    'FROM (Blood INNER JOIN BloodDoza ON Blood.ДатаК = BloodDoza.ДатаК) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.КодД = BloodErSusp.Код ' +
    'WHERE (Blood.ДатаК) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  ErSuspVolumeTotal :=
    VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function TBQPHarvestingOfErSuspensionsValumeTotal.GetValue: string;
begin
  result := ErSuspVolumeTotal;
end;

end.
