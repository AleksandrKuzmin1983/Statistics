unit MIOAChangeRecordResultsInAdviceToDoctor;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOAChangeRecordResultsInAdviceToDoctor = interface
    procedure ChangeRecord(Date: Extended; DoctorTrans: String;
      MedicalLab: String; Id: String);
  end;

  TMIOAChangeRecordResultsInAdviceToDoctor = class(TInterfacedObject,
    IMIOAChangeRecordResultsInAdviceToDoctor)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure ChangeRecord(Date: Extended; DoctorTrans: String;
      MedicalLab: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOAChangeRecordResultsInAdviceToDoctor.ChangeRecord(Date: Extended; DoctorTrans: String;
  MedicalLab: String; Id: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('UPDATE Consultations SET Consultations.������� = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'Consultations.�� =''' + DoctorTrans + ''', ' +
        'Consultations.��=' + MedicalLab + ' ' +
        'WHERE Consultations.���=' + Id);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.
