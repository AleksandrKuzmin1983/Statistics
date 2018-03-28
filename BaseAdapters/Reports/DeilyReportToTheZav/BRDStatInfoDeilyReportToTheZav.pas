unit BRDStatInfoDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IMRDStatInfoDeilyReportToTheZav = interface
    function GetBloodNumberProceduresDone: string;
    function GetBloodRestImplementationOfThePlan: string;
    function GetBloodPercentageOfPlanProcedures: string;
    function GetBloodTheNumberOfTreatmentsPerDay: string;
    function GetBloodTheNumberOfTreatmentsPerDayWholeBlood: string;
    function GetBloodNumberWholeBloodAtTheMomentToMatchThePlan: string;
    function GetPlasmaNumberProceduresDone: string;
    function GetPlasmaRestImplementationOfThePlan: string;
    function GetPlasmaPercentageOfPlanProcedures: string;
    function GetPlasmaTheNumberOfTreatmentsPerDay: string;
    function GetTromboNumberProceduresDone: string;
    function GetTromboRestImplementationOfThePlan: string;
    function GetTromboPercentageOfPlanProcedures: string;
    function GetTromboTheNumberOfTreatmentsPerDay: string;
    function GetBloodTheNumberOfTreatmentsPerDayErSusp: string;
  end;

  TMRDStatInfoDeilyReportToTheZav = class(TInterfacedObject, IMRDStatInfoDeilyReportToTheZav)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
    TempValue: Real;
    TempSQL: String;
    procedure GetSQL(CSQL: String);
  public
    function GetBloodNumberProceduresDone: string;
    function GetBloodRestImplementationOfThePlan: string;
    function GetBloodPercentageOfPlanProcedures: string;
    function GetBloodTheNumberOfTreatmentsPerDay: string;
    function GetBloodTheNumberOfTreatmentsPerDayWholeBlood: string;
    function GetBloodNumberWholeBloodAtTheMomentToMatchThePlan: string;
    function GetPlasmaNumberProceduresDone: string;
    function GetPlasmaRestImplementationOfThePlan: string;
    function GetPlasmaPercentageOfPlanProcedures: string;
    function GetPlasmaTheNumberOfTreatmentsPerDay: string;
    function GetTromboNumberProceduresDone: string;
    function GetTromboRestImplementationOfThePlan: string;
    function GetTromboPercentageOfPlanProcedures: string;
    function GetTromboTheNumberOfTreatmentsPerDay: string;
    function GetBloodTheNumberOfTreatmentsPerDayErSusp: string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TMRDStatInfoDeilyReportToTheZav.create;
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

procedure TMRDStatInfoDeilyReportToTheZav.GetSQL(CSQL: String);
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



function TMRDStatInfoDeilyReportToTheZav.GetBloodNumberProceduresDone: string;
begin
  TempSQL:=
    'SELECT [(������) ������� ����������� � ����� �� ������� �����].[���-�� �������� �����] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetBloodRestImplementationOfThePlan: string;
begin
  TempSQL:=
      'SELECT [Plans]![���]-[(������) ������� ����������� � ����� �� ������� �����]' +
      '![���-�� �������� �����] AS [������� �� ����� �� ���������� �����]' +
      'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetBloodPercentageOfPlanProcedures: string;
begin
  TempSQL:=
    'SELECT ([(������) ������� ����������� � ����� �� ������� �����]' +
    '![���-�� �������� �����])/([Plans]![���]) AS [% �������� �����] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue*100)) + '%';
end;

function TMRDStatInfoDeilyReportToTheZav.GetBloodTheNumberOfTreatmentsPerDay: string;
begin
  TempSQL:=
    'SELECT IIf(([Plans]![���]-[(������) � ����������� ������ (���������)]' +
    '![���-�� ������������ ���� � ������� ������])=0,([Plans]![���]-[(������) ������� ����������� � ����� �� ������� �����]' +
    '![���-�� �������� �����])/1,([Plans]![���]-[(������) ������� ����������� � ����� �� ������� �����]' +
    '![���-�� �������� �����])/([Plans]![���]-[(������) � ����������� ������ (���������)]' +
    '![���-�� ������������ ���� � ������� ������])) AS [���-�� ����������� �������� � ����] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����], ' +
    '[(������) � ����������� ������ ����], [(������) � ����������� ������ (���������)]; ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetBloodTheNumberOfTreatmentsPerDayWholeBlood: string;
begin
  TempSQL:=
    'SELECT IIf([(������) � ����������� ������ ����]![���]=[(������) � ����������� ������ (���������)]![���-�� ������������ ���� � ������� ������],' +
    '999,IIf(([(������) � ����������� ������ ����]![���]-' +           //999 - "���� �� ��������!"
    '[VolumeWholeBloodPerMomentMonth]![����� ������� �����]-1.4*' +
    '([PlasmaRestImplementationOfThePlan]![������� �� ���������� �� ����� ���]))<0,' +
    '0,([(������) � ����������� ������ ����]![���]-' +
    '[VolumeWholeBloodPerMomentMonth]![����� ������� �����]-1.4*' +
    '([PlasmaRestImplementationOfThePlan]![������� �� ���������� �� ����� ���]))/' +
    '(0.47*([(������) � ����������� ������ ����]![���]-' +
    '[(������) � ����������� ������ (���������)]![���-�� ������������ ���� � ������� ������])))) ' +
    'AS [���-�� ���� �� ����� �����] ' +
    'FROM [(������) � ����������� ������ ����], [(������) � ����������� ������ (���������)], ' +
    'VolumeWholeBloodPerMomentMonth, PlasmaRestImplementationOfThePlan;';
  GetSQL(TempSQL);
  if TempValue=999 then result:='���� �� ��������!'
    else result:=VarToStr(FormatFloat('0.0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetBloodNumberWholeBloodAtTheMomentToMatchThePlan: string;
begin
  TempSQL:=
    'SELECT ([Plans]![���]/[Plans]![���])*([(������) � ����������� ������ (���������)]' +
    '![���-�� ������������ ���� � ������� ������]) AS TargetValue ' +
    'FROM [(������) � ����������� ������ (���������)], Plans ' +
    'WHERE (((Month([Plans].[��������]))=Month(Now())) AND ((Year([Plans].[��������]))=Year(Now())));';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetPlasmaNumberProceduresDone: string;
begin
  TempSQL:=
    'SELECT [(������) ����� ����� � ������ ���].[���-�� �������� ������] ' +
    'FROM [(������) ����� ����� � ������ ���];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetPlasmaRestImplementationOfThePlan: string;
begin
  TempSQL:=
    'SELECT IIf(([Plans]![���]-[(������) ����� ����� � ������ ���]' +
    '![���-�� �������� ������]<0),0,[Plans]![���]-[(������) ����� ����� � ������ ���]' +
    '![���-�� �������� ������]) AS [������� �� ���������� �� ����� ���] ' +
    'FROM [(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����] ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetPlasmaPercentageOfPlanProcedures: string;
begin
  TempSQL:=
    'SELECT ([(������) ����� ����� � ������ ���]![���-�� �������� ������])/([Plans]![���]) AS [% �������� ������] ' +
    'FROM [(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue*100)) + '%';
end;

function TMRDStatInfoDeilyReportToTheZav.GetPlasmaTheNumberOfTreatmentsPerDay: string;
begin
  TempSQL:=
    'SELECT IIf([Plans]![���]-[(������) ����� ����� � ������ ���]' +
    '![���-�� �������� ������]<0,0,IIf(([Plans]![���]-[(������) � ����������� ������ (���������)]' +
    '![���-�� ������������ ���� � ������� ������])=0,([Plans]![���]-[(������) ����� ����� � ������ ���]' +
    '![���-�� �������� ������])/1,([Plans]![���]-[(������) ����� ����� � ������ ���]' +
    '![���-�� �������� ������])/([Plans]![���]-[(������) � ����������� ������ (���������)]' +
    '![���-�� ������������ ���� � ������� ������]))) AS [���-�� ����������� �������� ��� � ����] ' +
    'FROM [(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����], ' +
    '[(������) � ����������� ������ (���������)];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetTromboNumberProceduresDone: string;
begin
  TempSQL:=
    'SELECT [(������) ����� ����� � �����-�].[���-�� �������� ����������] ' +
    'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetTromboRestImplementationOfThePlan: string;
begin
  TempSQL:=
    'SELECT [Plans]![���]-[(������) ����� ����� � �����-�]![���-�� �������� ����������] AS [������� �� ���������� ������] ' +
    'FROM [(������) � ����������� ������ ����], [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetTromboPercentageOfPlanProcedures: string;
begin
  TempSQL:=
    'SELECT ([(������) ����� ����� � �����-�]![���-�� �������� ����������])/([Plans]![���]) AS [% �������� ������] ' +
    'FROM [(������) ����� ����� � �����-�], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue*100) + '%');
end;

function TMRDStatInfoDeilyReportToTheZav.GetTromboTheNumberOfTreatmentsPerDay: string;
begin
  TempSQL:=
    'SELECT IIf(([Plans]![���]-[(������) � ����������� ������ (���������)]' +
    '![���-�� ������������ ���� � ������� ������])=0,([Plans]![���]-[(������) ����� ����� � �����-�]' +
    '![���-�� �������� ����������])/1,([Plans]![���]-[(������) ����� ����� � �����-�]' +
    '![���-�� �������� ����������])/([Plans]![���]-[(������) � ����������� ������ (���������)]' +
    '![���-�� ������������ ���� � ������� ������])) AS [���-�� �����-� �������� ������] ' +
    'FROM [(������) � ����������� ������ ����], [(������) � ����������� ������ (���������)], ' +
    '[(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.0',TempValue));
end;

function TMRDStatInfoDeilyReportToTheZav.GetBloodTheNumberOfTreatmentsPerDayErSusp: string;
begin
  TempSQL:=
    'SELECT (([(������) � ����������� ������ ����]![���]*1000-' +
    '[(������) ������� ����������� � ����� �� ������� �����]![����� �� ������])/320)/' +
    'IIf([(������) � ����������� ������ ����]![���]-' +
    '[(������) � ����������� ������ (���������)]![���-�� ������������ ���� � ������� ������]=0,1,' +
    '[(������) � ����������� ������ ����]![���]-' +
    '[(������) � ����������� ������ (���������)]![���-�� ������������ ���� � ������� ������]) AS [������� ��������]' +
    'FROM [(������) � ����������� ������ ����], [(������) ������� ����������� � ����� �� ������� �����], ' +
    '[(������) � ����������� ������ (���������)];';
  GetSQL(TempSQL);
  if TempValue<0 then result:='���� ��������' else result:=VarToStr(FormatFloat('0.0',TempValue));
end;

end.
