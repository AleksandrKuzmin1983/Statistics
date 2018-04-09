unit BIEDeleteRecordResultsInLPU;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIEDeleteRecordResultsInLPU = interface
    procedure DeleteRecord(NumRecord: String);
  end;

  TBIEDeleteRecordResultsInLPU = class(TInterfacedObject,
    IBIEDeleteRecordResultsInLPU)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure DeleteRecord(NumRecord: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIEDeleteRecordResultsInLPU.DeleteRecord(NumRecord: String);
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
      SQL.Add('DELETE FROM Exped WHERE Exped.Код=' + NumRecord);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIEDeleteRecordResultsInLPU.DeleteRecord выполнена');
end;

end.
