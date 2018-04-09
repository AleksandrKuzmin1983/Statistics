unit BHSDeleteRecordSitoferez;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, CodeSiteLogging, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBHSDeleteRecordSitoferez = interface
    procedure DeleteRecord(CurRecord: String);
  end;

  TBHSDeleteRecordSitoferez = class(TInterfacedObject,
    IBHSDeleteRecordSitoferez)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure DeleteRecord(CurRecord: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBHSDeleteRecordSitoferez.DeleteRecord(CurRecord: String);
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
      SQL.Add('DELETE FROM Tromb WHERE Tromb.[ДатаТ]=#' +
        FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(StrToDate(CurRecord))) + '#');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSDeleteRecordSitoferez.DeleteRecord выполнена');
end;

end.
