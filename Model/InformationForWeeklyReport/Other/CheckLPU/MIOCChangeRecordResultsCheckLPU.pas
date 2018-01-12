unit MIOCChangeRecordResultsCheckLPU;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOCChangeRecordResultsCheckLPU = interface
procedure ChangeRecord(Date: Extended; CheckLPU: String; Id: String);
  end;

  TMIOCChangeRecordResultsCheckLPU = class(TInterfacedObject,
    IMIOCChangeRecordResultsCheckLPU)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
procedure ChangeRecord(Date: Extended; CheckLPU: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOCChangeRecordResultsCheckLPU.ChangeRecord(Date: Extended; CheckLPU: String; Id: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    with TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE Consultations SET Consultations.ДатаКон = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'Consultations.ПЛПУ=' + CheckLPU + ' ' +
        'WHERE Consultations.Код=' + Id);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.
