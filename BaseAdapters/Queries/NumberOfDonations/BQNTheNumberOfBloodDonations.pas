unit BQNTheNumberOfBloodDonations;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBQNTheNumberOfBloodDonations = interface
    function GetValue: string;
    procedure free;
  end;

  TBQNTheNumberOfBloodDonations = class(TInterfacedObject,
    IBQNTheNumberOfBloodDonations)
  private
    NumberOfBD: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBQNTheNumberOfBloodDonations.create(DateStart, DateEnd: TDate);
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
  Try
    TempQuery.SQL.Add
      ('SELECT SUM(Blood.КДК) FROM Blood WHERE (Blood.ДатаК) Between #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
    TempQuery.Open;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  NumberOfBD := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQNTheNumberOfBloodDonations.create выполнена');
end;

function TBQNTheNumberOfBloodDonations.GetValue: string;
begin
  result := NumberOfBD;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQNTheNumberOfBloodDonations.GetValue выполнена');
end;

end.
