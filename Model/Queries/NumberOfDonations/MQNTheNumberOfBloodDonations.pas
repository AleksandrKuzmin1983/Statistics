unit MQNTheNumberOfBloodDonations;

interface

uses
  SysUtils, Variants,
  Dialogs, Data.Win.ADODB, GetDataSoursUnit1;

type
  TTheNumberOfBloodDonations = class
  private
    NumberOfBD: string;
    TempConnect: DataBaseTables;
    TempQuery: TADOQuery;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TTheNumberOfBloodDonations.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(TempConnect) then
    TempConnect := DataBaseTables.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add
    ('SELECT SUM(Blood. ƒ ) FROM Blood WHERE (Blood.ƒ‡Ú‡ ) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
  TempQuery.Open;
  NumberOfBD := VarToStr(TempQuery.Fields[0].Value);
  TempQuery.Close;
end;

function TTheNumberOfBloodDonations.GetValue: string;
begin
  result := NumberOfBD;
end;

end.
