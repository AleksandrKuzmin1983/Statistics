unit BMDeleteRecordMonthlyPlan;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IMMDeleteRecordMonthlyPlan = interface
    procedure DeleteRecord(CurRecord: String);
  end;

  TMMDeleteRecordMonthlyPlan = class(TInterfacedObject,
    IMMDeleteRecordMonthlyPlan)
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

procedure TMMDeleteRecordMonthlyPlan.DeleteRecord(CurRecord: String);
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
      SQL.Add('DELETE FROM Plans WHERE Plans.[ДатаПлан]=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(StrToDate(CurRecord))) + '#');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
