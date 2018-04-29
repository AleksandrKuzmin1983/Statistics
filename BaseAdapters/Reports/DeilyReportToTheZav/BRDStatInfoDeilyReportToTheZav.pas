unit BRDStatInfoDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRDStatInfoDeilyReportToTheZav = interface
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

  TBRDStatInfoDeilyReportToTheZav = class(TInterfacedObject,
    IBRDStatInfoDeilyReportToTheZav)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
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

constructor TBRDStatInfoDeilyReportToTheZav.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.create ���������');
end;

procedure TBRDStatInfoDeilyReportToTheZav.GetSQL(CSQL: String);

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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetSQL ���������');
end;

function TBRDStatInfoDeilyReportToTheZav.GetBloodNumberProceduresDone: string;
begin
  TempSQL :=
    'SELECT [(������) ������� ����������� � ����� �� ������� �����].[���-�� �������� �����] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetBloodNumberProceduresDone ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodRestImplementationOfThePlan: string;
begin
  TempSQL :=
    'SELECT [Plans]![���]-[(������) ������� ����������� � ����� �� ������� �����]'
    + '![���-�� �������� �����] AS [������� �� ����� �� ���������� �����]' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetBloodRestImplementationOfThePlan ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodPercentageOfPlanProcedures: string;
begin
  TempSQL := 'SELECT ([(������) ������� ����������� � ����� �� ������� �����]' +
    '![���-�� �������� �����])/([Plans]![���]) AS [% �������� �����] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetBloodPercentageOfPlanProcedures ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodTheNumberOfTreatmentsPerDay: string;
begin
  TempSQL :=
    'SELECT IIf(([Plans]![���]-[(������) � ����������� ������ (���������)]' +
    '![���-�� ������������ ���� � ������� ������])=0,([Plans]![���]-[(������) ������� ����������� � ����� �� ������� �����]'
    + '![���-�� �������� �����])/1,([Plans]![���]-[(������) ������� ����������� � ����� �� ������� �����]'
    + '![���-�� �������� �����])/([Plans]![���]-[(������) � ����������� ������ (���������)]'
    + '![���-�� ������������ ���� � ������� ������])) AS [���-�� ����������� �������� � ����] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], ' +
    '[(������) � ����������� ������ ����], [(������) � ����������� ������ (���������)]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetBloodTheNumberOfTreatmentsPerDay ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodTheNumberOfTreatmentsPerDayWholeBlood: string;
begin
  TempSQL :=
    'SELECT IIf([(������) � ����������� ������ ����]![���]=[(������) � ����������� ������ (���������)]![���-�� ������������ ���� � ������� ������],'
    + '999,IIf(([(������) � ����������� ������ ����]![���]-' +
  // 999 - "���� �� ��������!"
    '[VolumeWholeBloodPerMomentMonth]![����� ������� �����]-1.4*' +
    '([PlasmaRestImplementationOfThePlan]![������� �� ���������� �� ����� ���]))<0,'
    + '0,([(������) � ����������� ������ ����]![���]-' +
    '[VolumeWholeBloodPerMomentMonth]![����� ������� �����]-1.4*' +
    '([PlasmaRestImplementationOfThePlan]![������� �� ���������� �� ����� ���]))/'
    + '(0.47*([(������) � ����������� ������ ����]![���]-' +
    '[(������) � ����������� ������ (���������)]![���-�� ������������ ���� � ������� ������])))) '
    + 'AS [���-�� ���� �� ����� �����] ' +
    'FROM [(������) � ����������� ������ ����], [(������) � ����������� ������ (���������)], '
    + 'VolumeWholeBloodPerMomentMonth, PlasmaRestImplementationOfThePlan;';
  GetSQL(TempSQL);
  if TempValue = 999 then
    result := '���� �� ��������!'
  else
    result := VarToStr(FormatFloat('0.0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetBloodTheNumberOfTreatmentsPerDayWholeBlood ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodNumberWholeBloodAtTheMomentToMatchThePlan: string;
begin
  TempSQL :=
    'SELECT ([Plans]![���]/[Plans]![���])*([(������) � ����������� ������ (���������)]'
    + '![���-�� ������������ ���� � ������� ������]) AS TargetValue ' +
    'FROM [(������) � ����������� ������ (���������)], Plans ' +
    'WHERE (((Month([Plans].[��������]))=Month(Now())) AND ((Year([Plans].[��������]))=Year(Now())));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetBloodNumberWholeBloodAtTheMomentToMatchThePlan ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.GetPlasmaNumberProceduresDone: string;
begin
  TempSQL :=
    'SELECT [(������) ����� ����� � ������ ���].[���-�� �������� ������] ' +
    'FROM [(������) ����� ����� � ������ ���];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetPlasmaNumberProceduresDone ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetPlasmaRestImplementationOfThePlan: string;
begin
  TempSQL := 'SELECT IIf(([Plans]![���]-[(������) ����� ����� � ������ ���]' +
    '![���-�� �������� ������]<0),0,[Plans]![���]-[(������) ����� ����� � ������ ���]'
    + '![���-�� �������� ������]) AS [������� �� ���������� �� ����� ���] ' +
    'FROM [(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetPlasmaRestImplementationOfThePlan ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetPlasmaPercentageOfPlanProcedures: string;
begin
  TempSQL :=
    'SELECT ([(������) ����� ����� � ������ ���]![���-�� �������� ������])/([Plans]![���]) AS [% �������� ������] '
    + 'FROM [(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetPlasmaPercentageOfPlanProcedures ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetPlasmaTheNumberOfTreatmentsPerDay: string;
begin
  TempSQL := 'SELECT IIf([Plans]![���]-[(������) ����� ����� � ������ ���]' +
    '![���-�� �������� ������]<0,0,IIf(([Plans]![���]-[(������) � ����������� ������ (���������)]'
    + '![���-�� ������������ ���� � ������� ������])=0,([Plans]![���]-[(������) ����� ����� � ������ ���]'
    + '![���-�� �������� ������])/1,([Plans]![���]-[(������) ����� ����� � ������ ���]'
    + '![���-�� �������� ������])/([Plans]![���]-[(������) � ����������� ������ (���������)]'
    + '![���-�� ������������ ���� � ������� ������]))) AS [���-�� ����������� �������� ��� � ����] '
    + 'FROM [(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����], '
    + '[(������) � ����������� ������ (���������)];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetPlasmaTheNumberOfTreatmentsPerDay ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.GetTromboNumberProceduresDone: string;
begin
  TempSQL :=
    'SELECT [(������) ����� ����� � �����-�].[���-�� �������� ����������] ' +
    'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetTromboNumberProceduresDone ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetTromboRestImplementationOfThePlan: string;
begin
  TempSQL :=
    'SELECT [Plans]![���]-[(������) ����� ����� � �����-�]![���-�� �������� ����������] AS [������� �� ���������� ������] '
    + 'FROM [(������) � ����������� ������ ����], [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetTromboRestImplementationOfThePlan ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetTromboPercentageOfPlanProcedures: string;
begin
  TempSQL :=
    'SELECT ([(������) ����� ����� � �����-�]![���-�� �������� ����������])/([Plans]![���]) AS [% �������� ������] '
    + 'FROM [(������) ����� ����� � �����-�], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100) + '%');

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetTromboPercentageOfPlanProcedures ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetTromboTheNumberOfTreatmentsPerDay: string;
begin
  TempSQL :=
    'SELECT IIf(([Plans]![���]-[(������) � ����������� ������ (���������)]' +
    '![���-�� ������������ ���� � ������� ������])=0,([Plans]![���]-[(������) ����� ����� � �����-�]'
    + '![���-�� �������� ����������])/1,([Plans]![���]-[(������) ����� ����� � �����-�]'
    + '![���-�� �������� ����������])/([Plans]![���]-[(������) � ����������� ������ (���������)]'
    + '![���-�� ������������ ���� � ������� ������])) AS [���-�� �����-� �������� ������] '
    + 'FROM [(������) � ����������� ������ ����], [(������) � ����������� ������ (���������)], '
    + '[(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetTromboTheNumberOfTreatmentsPerDay ���������', result);
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodTheNumberOfTreatmentsPerDayErSusp: string;
begin
  TempSQL := 'SELECT (([(������) � ����������� ������ ����]![���]*1000-' +
    '[(������) ������� ����������� � ����� �� ������� �����]![����� �� ������])/310)/'
    + 'IIf([(������) � ����������� ������ ����]![���]-' +
    '[(������) � ����������� ������ (���������)]![���-�� ������������ ���� � ������� ������]=0,1,'
    + '[(������) � ����������� ������ ����]![���]-' +
    '[(������) � ����������� ������ (���������)]![���-�� ������������ ���� � ������� ������]) AS [������� ��������]'
    + 'FROM [(������) � ����������� ������ ����], [(������) ������� ����������� � ����� �� ������� �����], '
    + '[(������) � ����������� ������ (���������)];';
  GetSQL(TempSQL);
  if TempValue < 0 then
    result := '���� ��������'
  else
    result := VarToStr(FormatFloat('0.0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDStatInfoDeilyReportToTheZav.GetBloodTheNumberOfTreatmentsPerDayErSusp ���������', result);
end;

end.
