unit BIOAChangeRecordResultsInAdviceToDoctor;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOAChangeRecordResultsInAdviceToDoctor = interface
    procedure ChangeRecord(Date: Extended; DoctorTrans: String;
      MedicalLab: String; Id: String);
  end;

  TBIOAChangeRecordResultsInAdviceToDoctor = class(TInterfacedObject,
    IBIOAChangeRecordResultsInAdviceToDoctor)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure ChangeRecord(Date: Extended; DoctorTrans: String;
      MedicalLab: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOAChangeRecordResultsInAdviceToDoctor.ChangeRecord(Date: Extended;
  DoctorTrans: String; MedicalLab: String; Id: String);
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
      SQL.Add('UPDATE Consultations SET Consultations.ДатаКон = #' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'Consultations.ВТ =''' + DoctorTrans + ''', ' + 'Consultations.ВЛ=' +
        MedicalLab + ' ' + 'WHERE Consultations.Код=' + Id);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

end.
