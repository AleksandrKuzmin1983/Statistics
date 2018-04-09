unit BHADeleteRecordAutomaticApheresis;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBHADeleteRecordAutomaticApheresis = interface
    procedure DeleteRecord(CurRecord: String);
  end;

  TBHADeleteRecordAutomaticApheresis = class(TInterfacedObject,
    IBHADeleteRecordAutomaticApheresis)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure DeleteRecord(CurRecord: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBHADeleteRecordAutomaticApheresis.DeleteRecord(CurRecord: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    StrToDateTime(CurRecord);
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM Plasma WHERE Plasma.[ДатаП]=#' +
        FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(StrToDate(CurRecord))) + '#');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHADeleteRecordAutomaticApheresis.DeleteRecord выполнена');
end;

end.
