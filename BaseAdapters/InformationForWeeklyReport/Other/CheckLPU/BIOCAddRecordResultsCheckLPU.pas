unit BIOCAddRecordResultsCheckLPU;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, CodeSiteLogging, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOCAddRecordResultsCheckLPU = interface
    procedure AddRecord(Date: Extended; CheckLPU: String);
  end;

  TBIOCAddRecordResultsCheckLPU = class(TInterfacedObject,
    IBIOCAddRecordResultsCheckLPU)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure AddRecord(Date: Extended; CheckLPU: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOCAddRecordResultsCheckLPU.AddRecord(Date: Extended;
  CheckLPU: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO Consultations (ДатаКон, ПЛПУ) VALUES ' + '(#' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        CheckLPU + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOCAddRecordResultsCheckLPU.AddRecord выполнена');
end;

end.
