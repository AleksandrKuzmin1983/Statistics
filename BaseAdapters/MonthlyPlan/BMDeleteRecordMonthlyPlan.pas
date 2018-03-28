unit BMDeleteRecordMonthlyPlan;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBMDeleteRecordMonthlyPlan = interface
    procedure DeleteRecord(CurRecord: String);
  end;

  TBMDeleteRecordMonthlyPlan = class(TInterfacedObject,
    IBMDeleteRecordMonthlyPlan)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure DeleteRecord(CurRecord: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBMDeleteRecordMonthlyPlan.DeleteRecord(CurRecord: String);
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
      SQL.Add('DELETE FROM Plans WHERE Plans.[��������]=#' +
        FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(StrToDate(CurRecord))) + '#');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

end.
