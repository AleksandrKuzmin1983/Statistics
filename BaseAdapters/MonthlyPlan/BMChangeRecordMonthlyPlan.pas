unit BMChangeRecordMonthlyPlan;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  GetAdoConnect;

type
  IBMChangeRecordMonthlyPlan = interface
    procedure AddRecordDays(MonthOfPlan: Extended; Days: Extended);
  end;

  TBMChangeRecordMonthlyPlan = class(TInterfacedObject,
    IBMChangeRecordMonthlyPlan)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    procedure AddRecordDays(MonthOfPlan: Extended; Days: Extended);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBMChangeRecordMonthlyPlan.AddRecordDays(MonthOfPlan: Extended;
  Days: Extended);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO FactoryCal([ДатаПлан], [День]) VALUES ' + '(#' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(MonthOfPlan)) + '#, ' + '#'
        + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Days)) + '#) ');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

end.
