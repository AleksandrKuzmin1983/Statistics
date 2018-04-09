unit BQPHarvestingOfErSuspensionsDosesTotal;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB,
  USCheckNull,
  GetAdoConnect;

type
  IBQPHarvestingOfErSuspensionsDosesTotal = interface
    function GetValue: string;
  end;

  TBQPHarvestingOfErSuspensionsDosesTotal = class(TInterfacedObject,
    IBQPHarvestingOfErSuspensionsDosesTotal)
  private
    ErSuspDosesTotal: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQPHarvestingOfErSuspensionsDosesTotal.create(DateStart,
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
  TempQuery.SQL.Add('SELECT Sum(BloodErSusp.���) ' +
    'FROM (Blood INNER JOIN BloodDoza ON Blood.����� = BloodDoza.�����) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.���� = BloodErSusp.��� ' +
    'WHERE (Blood.�����) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
    DateEnd) + '#;');
  TempQuery.Open;
  ErSuspDosesTotal :=
    VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfErSuspensionsDosesTotal.create ���������');
end;

function TBQPHarvestingOfErSuspensionsDosesTotal.GetValue: string;
begin
  result := ErSuspDosesTotal;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQPHarvestingOfErSuspensionsDosesTotal.GetValue ���������');
end;

end.
