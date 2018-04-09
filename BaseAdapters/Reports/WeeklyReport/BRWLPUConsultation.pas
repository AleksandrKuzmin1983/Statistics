unit BRWLPUConsultation;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWLPUConsultation = interface
    function GetTransfusiolog: string;
    function GetLaboratory: string;
    function GetCheckLPU: string;
  end;

  TBRWLPUConsultation = class(TInterfacedObject, IBRWLPUConsultation)
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

constructor TBRWLPUConsultation.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultation.create выполнена');
end;

procedure TBRWLPUConsultation.GetSQL(CSQL: String);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultation.GetSQL выполнена');
end;

function TBRWLPUConsultation.GetTransfusiolog: string;
begin
  TempSQL := 'SELECT Sum(Consultations.ВТ) as [SUM-ВТ] ' +
    'FROM Consultations ' +
    'WHERE (((Consultations.ДатаКон)<=Date()-Weekday(Date())+1 ' +
    'And (Consultations.ДатаКон)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultation.GetTransfusiolog выполнена', result);
end;

function TBRWLPUConsultation.GetLaboratory: string;
begin
  TempSQL := 'SELECT Sum(Consultations.ВЛ) as [SUM-ВЛ] ' +
    'FROM Consultations ' +
    'WHERE (((Consultations.ДатаКон)<=Date()-Weekday(Date())+1 ' +
    'And (Consultations.ДатаКон)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultation.GetLaboratory выполнена', result);
end;

function TBRWLPUConsultation.GetCheckLPU: string;
begin
  TempSQL := 'SELECT Sum(Consultations.ПЛПУ) as [SUM-ПЛПУ] ' +
    'FROM Consultations ' +
    'WHERE (((Consultations.ДатаКон)<=Date()-Weekday(Date())+1 ' +
    'And (Consultations.ДатаКон)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWLPUConsultation.GetCheckLPU выполнена', result);
end;

end.
