unit MQNTheNumberOfTromboDonations;

interface

uses
  SysUtils, Variants,
  Data.Win.ADODB, GetDataSoursUnit1;

type
  ITheNumberOfTromboDonations = interface
    function GetValue: string;
  end;

  TTheNumberOfTromboDonations = class(TInterfacedObject,
    ITheNumberOfTromboDonations)
  private
    NumberOfTD: string;
    TempConnect: IDataBaseTables;
    TempQuery: TADOQuery;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TTheNumberOfTromboDonations.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(TempConnect) then
    TempConnect := TDataBaseTables.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  TempQuery.SQL.Add
    ('SELECT SUM(Tromb. ƒ“) FROM Tromb WHERE (Tromb.ƒ‡Ú‡“) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
  TempQuery.Open;
  NumberOfTD := VarToStr(TempQuery.Fields[0].Value);
  TempQuery.Close;
end;

function TTheNumberOfTromboDonations.GetValue: string;
begin
  result := NumberOfTD;
end;

end.
