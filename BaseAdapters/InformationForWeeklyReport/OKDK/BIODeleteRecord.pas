unit BIODeleteRecord;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIODeleteRecord = interface
    procedure DeleteRecord(NumRecord: String);
    procedure destroy;
  end;

  TBIODeleteRecord = class(TInterfacedObject, IBIODeleteRecord)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    procedure DeleteRecord(NumRecord: String);
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIODeleteRecord.DeleteRecord(NumRecord: String);
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
      SQL.Add('DELETE FROM NewOKDK WHERE NewOKDK.Код=' + NumRecord);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIODeleteRecord.DeleteRecord выполнена');
end;

procedure TBIODeleteRecord.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIODeleteRecord.destroy выполнена');
end;
end.
