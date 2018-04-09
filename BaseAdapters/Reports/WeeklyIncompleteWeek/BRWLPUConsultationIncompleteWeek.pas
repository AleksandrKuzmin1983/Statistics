unit BRWLPUConsultationIncompleteWeek;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWLPUConsultationIncompleteWeek = interface
    function GetTransfusiolog: string;
    function GetLaboratory: string;
    function GetCheckLPU: string;
  end;

  TBRWLPUConsultationIncompleteWeek = class(TInterfacedObject,
    IBRWLPUConsultationIncompleteWeek)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempValue: Real;
    TempSQL: String;
    procedure GetSQL(CSQL: String);
  public
    function GetTransfusiolog: string;
    function GetLaboratory: string;
    function GetCheckLPU: string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRWLPUConsultationIncompleteWeek.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultationIncompleteWeek.create выполнена');
end;

procedure TBRWLPUConsultationIncompleteWeek.GetSQL(CSQL: String);

begin
  Try
    With TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add(CSQL);
      Open;
      TempValue := CheckNull.CheckedValue(TempQuery.Fields[0].value);
      Close;
    end;
  Except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultationIncompleteWeek.GetSQL выполнена');
end;

function TBRWLPUConsultationIncompleteWeek.GetTransfusiolog: string;
begin
  TempSQL := 'SELECT Consultations.ВТ ' + 'FROM Consultations ' +
    'WHERE (((Consultations.ДатаКон)<=Date()-Weekday(Date())+1 ' +
    'And (Consultations.ДатаКон)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultationIncompleteWeek.GetTransfusiolog выполнена', result);
end;

function TBRWLPUConsultationIncompleteWeek.GetLaboratory: string;
begin
  TempSQL := 'SELECT Consultations.ВЛ ' + 'FROM Consultations ' +
    'WHERE (((Consultations.ДатаКон)<=Date()-Weekday(Date())+1 ' +
    'And (Consultations.ДатаКон)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultationIncompleteWeek.GetLaboratory выполнена', result);
end;

function TBRWLPUConsultationIncompleteWeek.GetCheckLPU: string;
begin
  TempSQL := 'SELECT Consultations.ПЛПУ ' + 'FROM Consultations ' +
    'WHERE (((Consultations.ДатаКон)<=Date()-Weekday(Date())+1 ' +
    'And (Consultations.ДатаКон)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultationIncompleteWeek.GetCheckLPU выполнена', result);
end;

end.
