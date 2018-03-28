unit BHSDeleteRecordSitoferez;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMHSDeleteRecordSitoferez = interface
    procedure DeleteRecord(CurRecord: String);
  end;

  TMHSDeleteRecordSitoferez = class(TInterfacedObject,
    IMHSDeleteRecordSitoferez)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure DeleteRecord(CurRecord: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMHSDeleteRecordSitoferez.DeleteRecord(CurRecord: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
  StrToDateTime(CurRecord);
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM Tromb WHERE Tromb.[ДатаТ]=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(StrToDate(CurRecord))) + '#');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
