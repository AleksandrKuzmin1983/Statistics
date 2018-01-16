unit MHMDeleteRecordManualHarvesting;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMHMDeleteRecordManualHarvesting = interface
    procedure DeleteRecord(CurRecord: String);
  end;

  TMHMDeleteRecordManualHarvesting = class(TInterfacedObject,
    IMHMDeleteRecordManualHarvesting)
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

procedure TMHMDeleteRecordManualHarvesting.DeleteRecord(CurRecord: String);
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
  StrToDateTime(CurRecord);
    with TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM Blood WHERE Blood.[ДатаК]=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(StrToDate(CurRecord))) + '#');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
