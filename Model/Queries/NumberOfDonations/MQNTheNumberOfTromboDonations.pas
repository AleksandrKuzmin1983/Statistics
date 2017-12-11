unit MQNTheNumberOfTromboDonations;

interface

uses
  SysUtils, Variants, Data.Win.ADODB,
  UCheckNull,
  GetAdoQuery;

type
  ITheNumberOfTromboDonations = interface
    function GetValue: string;
  end;

  TTheNumberOfTromboDonations = class(TInterfacedObject,
    ITheNumberOfTromboDonations)
  private
    NumberOfTD: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TTheNumberOfTromboDonations.create(DateStart, DateEnd: TDate);
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
  TempQuery.SQL.Add
    ('SELECT SUM(Tromb.���) FROM Tromb WHERE (Tromb.�����) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
  TempQuery.Open;
  NumberOfTD := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

function TTheNumberOfTromboDonations.GetValue: string;
begin
  result := NumberOfTD;
end;

end.
