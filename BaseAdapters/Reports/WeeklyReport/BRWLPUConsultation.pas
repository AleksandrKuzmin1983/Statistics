unit BRWLPUConsultation;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IMRWLPUConsultation = interface
    function GetTransfusiolog: string;
    function GetLaboratory: string;
    function GetCheckLPU: string;
  end;

  TMRWLPUConsultation = class(TInterfacedObject, IMRWLPUConsultation)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
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

constructor TMRWLPUConsultation.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
end;

procedure TMRWLPUConsultation.GetSQL(CSQL: String);
begin
  Try
    With TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add(CSQL);
      Open;
      TempValue:=CheckNull.CheckedValue(TempQuery.Fields[0].value);
      Close;
    end;
  Except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

function TMRWLPUConsultation.GetTransfusiolog: string;
begin
  TempSQL:=
    'SELECT Consultations.ВТ ' +
    'FROM Consultations ' +
    'WHERE (((Consultations.ДатаКон)<=Date()-Weekday(Date())+1 ' +
    'And (Consultations.ДатаКон)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRWLPUConsultation.GetLaboratory: string;
begin
  TempSQL:=
    'SELECT Consultations.ВЛ ' +
    'FROM Consultations ' +
    'WHERE (((Consultations.ДатаКон)<=Date()-Weekday(Date())+1 ' +
    'And (Consultations.ДатаКон)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRWLPUConsultation.GetCheckLPU: string;
begin
  TempSQL:=
    'SELECT Consultations.ПЛПУ ' +
    'FROM Consultations ' +
    'WHERE (((Consultations.ДатаКон)<=Date()-Weekday(Date())+1 ' +
    'And (Consultations.ДатаКон)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

end.
