unit MQPHarvestingOfPlasmaBloodDosesTotal;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  GetAdoQuery,
  UCheckNull;

type
  IHarvestingOfPlasmaBloodDosesTotal = interface
    function GetValue: string;
  end;

  THarvestingOfPlasmaBloodDosesTotal = class(TInterfacedObject,
    IHarvestingOfPlasmaBloodDosesTotal)
  private
    PlasmaBloodDosesTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor THarvestingOfPlasmaBloodDosesTotal.create(DateStart, DateEnd: TDate);
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
  TempQuery.SQL.Add('SELECT Sum(BloodPlasma.���) ' +
    'FROM ((Blood INNER JOIN BloodDoza ON Blood.����� = BloodDoza.�����) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.���� = BloodErSusp.���) ' +
    'INNER JOIN BloodPlasma ON BloodErSusp.��� = BloodPlasma.���� ' +
    'WHERE (Blood.�����) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#;');
  TempQuery.Open;
  PlasmaBloodDosesTotal := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function THarvestingOfPlasmaBloodDosesTotal.GetValue: string;
begin
  result := PlasmaBloodDosesTotal;
end;

end.
