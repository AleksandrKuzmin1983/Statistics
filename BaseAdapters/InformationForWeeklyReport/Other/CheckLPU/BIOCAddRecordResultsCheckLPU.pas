unit BIOCAddRecordResultsCheckLPU;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMIOCAddRecordResultsCheckLPU = interface
    procedure AddRecord(Date: Extended; CheckLPU: String);
  end;

  TMIOCAddRecordResultsCheckLPU = class(TInterfacedObject,
    IMIOCAddRecordResultsCheckLPU)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure AddRecord(Date: Extended; CheckLPU: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOCAddRecordResultsCheckLPU.AddRecord(Date: Extended; CheckLPU: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO Consultations (ƒ‡Ú‡ ÓÌ, œÀœ”) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        CheckLPU + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
