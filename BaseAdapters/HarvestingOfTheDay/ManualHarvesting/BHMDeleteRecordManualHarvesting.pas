unit BHMDeleteRecordManualHarvesting;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, CodeSiteLogging, Data.DB, DateUtils,
  GetAdoConnect;

type
  IBHMDeleteRecordManualHarvesting = interface
    procedure DeleteRecord(CurRecord: String);
  end;

  TBHMDeleteRecordManualHarvesting = class(TInterfacedObject,
    IBHMDeleteRecordManualHarvesting)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    procedure DeleteRecord(CurRecord: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBHMDeleteRecordManualHarvesting.DeleteRecord(CurRecord: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    StrToDateTime(CurRecord);
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM Blood WHERE Blood.[ДатаК]=#' +
        FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(StrToDate(CurRecord))) + '#');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMDeleteRecordManualHarvesting.DeleteRecord выполнена');
end;
end.
