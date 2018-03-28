unit BQPHarvestingOfErSuspensionsDosesTotal;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  USCheckNull,
  GetAdoConnect;

type
  IHarvestingOfErSuspensionsDosesTotal = interface
    function GetValue: string;
  end;

  THarvestingOfErSuspensionsDosesTotal = class(TInterfacedObject,
    IHarvestingOfErSuspensionsDosesTotal)
  private
    ErSuspDosesTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor THarvestingOfErSuspensionsDosesTotal.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add('SELECT Sum(BloodErSusp.ДЭВ) ' +
    'FROM (Blood INNER JOIN BloodDoza ON Blood.ДатаК = BloodDoza.ДатаК) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.КодД = BloodErSusp.Код ' +
    'WHERE (Blood.ДатаК) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#;');
  TempQuery.Open;
  ErSuspDosesTotal := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function THarvestingOfErSuspensionsDosesTotal.GetValue: string;
begin
  result := ErSuspDosesTotal;
end;

end.
