unit MQPHarvestingOfErSuspensionsValumeTotal;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  UCheckNull,
  GetAdoQuery;

type
  IHarvestingOfErSuspensionsValumeTotal = interface
    function GetValue: string;
  end;

  THarvestingOfErSuspensionsValumeTotal = class(TInterfacedObject,
    IHarvestingOfErSuspensionsValumeTotal)
  private
    ErSuspVolumeTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor THarvestingOfErSuspensionsValumeTotal.create(DateStart, DateEnd: TDate);
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
  TempQuery.SQL.Add('SELECT Sum(BloodErSusp.���) ' +
    'FROM (Blood INNER JOIN BloodDoza ON Blood.����� = BloodDoza.�����) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.���� = BloodErSusp.��� ' +
    'WHERE (Blood.�����) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#;');
  TempQuery.Open;
  ErSuspVolumeTotal := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function THarvestingOfErSuspensionsValumeTotal.GetValue: string;
begin
  result := ErSuspVolumeTotal;
end;

end.
