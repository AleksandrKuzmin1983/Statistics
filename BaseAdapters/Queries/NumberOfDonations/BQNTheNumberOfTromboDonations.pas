unit BQNTheNumberOfTromboDonations;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB,
  USCheckNull,
  GetAdoConnect;

type
  IBQNTheNumberOfTromboDonations = interface
    function GetValue: string;
  end;

  TBQNTheNumberOfTromboDonations = class(TInterfacedObject,
    IBQNTheNumberOfTromboDonations)
  private
    NumberOfTD: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQNTheNumberOfTromboDonations.create(DateStart, DateEnd: TDate);
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
  TempQuery.SQL.Add
    ('SELECT SUM(Tromb.КДТ) FROM Tromb WHERE (Tromb.ДатаТ) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
  TempQuery.Open;
  NumberOfTD := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQNTheNumberOfTromboDonations.create выполнена');
end;

function TBQNTheNumberOfTromboDonations.GetValue: string;
begin
  result := NumberOfTD;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQNTheNumberOfTromboDonations.GetValue выполнена');
end;

end.
