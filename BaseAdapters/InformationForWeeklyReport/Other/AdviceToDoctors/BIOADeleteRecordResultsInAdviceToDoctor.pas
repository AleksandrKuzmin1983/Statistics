unit BIOADeleteRecordResultsInAdviceToDoctor;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOADeleteRecordResultsInAdviceToDoctor = interface
    procedure DeleteRecord(NumRecord: String);
  end;

  TBIOADeleteRecordResultsInAdviceToDoctor = class(TInterfacedObject,
    IBIOADeleteRecordResultsInAdviceToDoctor)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure DeleteRecord(NumRecord: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOADeleteRecordResultsInAdviceToDoctor.DeleteRecord
  (NumRecord: String);
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
      SQL.Add('DELETE FROM Consultations WHERE Consultations.Код=' + NumRecord);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

end.
