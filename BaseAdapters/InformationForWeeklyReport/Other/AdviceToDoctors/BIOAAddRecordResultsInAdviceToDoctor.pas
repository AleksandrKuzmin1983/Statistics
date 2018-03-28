unit BIOAAddRecordResultsInAdviceToDoctor;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOAAddRecordResultsInAdviceToDoctor = interface
    procedure AddRecord(Date: Extended; DoctorTrans: String;
      MedicalLab: String);
  end;

  TBIOAAddRecordResultsInAdviceToDoctor = class(TInterfacedObject,
    IBIOAAddRecordResultsInAdviceToDoctor)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure AddRecord(Date: Extended; DoctorTrans: String;
      MedicalLab: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOAAddRecordResultsInAdviceToDoctor.AddRecord(Date: Extended;
  DoctorTrans: String; MedicalLab: String);
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
      SQL.Add('INSERT INTO Consultations (ƒ‡Ú‡ ÓÌ, ¬“, ¬À) VALUES ' + '(#' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' + DoctorTrans
        + ', ' + MedicalLab + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

end.
