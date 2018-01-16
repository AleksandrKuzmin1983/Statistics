unit MIOADeleteRecordResultsInAdviceToDoctor;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOADeleteRecordResultsInAdviceToDoctor = interface
    procedure DeleteRecord(NumRecord: String);
  end;

  TMIOADeleteRecordResultsInAdviceToDoctor = class(TInterfacedObject,
    IMIOADeleteRecordResultsInAdviceToDoctor)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure DeleteRecord(NumRecord: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOADeleteRecordResultsInAdviceToDoctor.DeleteRecord(NumRecord: String);
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
    with TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM Consultations WHERE Consultations.Код=' + NumRecord);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.
