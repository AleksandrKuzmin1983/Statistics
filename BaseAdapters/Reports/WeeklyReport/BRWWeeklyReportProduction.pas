unit BRWWeeklyReportProduction;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWWeeklyReportProduction = interface
    function GetValueLitr(i: integer): string;
    function GetValuePlan(i: integer): string;
    function GetValuePercent(i: integer): string;
    function GetValueTromboPacketsDoses(i: integer): string;
  end;

  TBRWWeeklyReportProduction = class(TInterfacedObject,
    IBRWWeeklyReportProduction)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempArray: array of real;

    CSQL: String;
  public
    function GetValueLitr(i: integer): string;
    function GetValuePlan(i: integer): string;
    function GetValuePercent(i: integer): string;
    function GetValueTromboPacketsDoses(i: integer): string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRWWeeklyReportProduction.create;
var
  i: integer;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  CSQL := 'SELECT [(������) � ������������� ������ ����].��� AS [������� ����� (����)], '
    + '[(������) � ������������� ������ ����].��� AS [���� ����� (����)], ' +
    '[(������) � ������������� ������ ����].�� AS [����� ������ ����� (����)], '
    + '[(������) � ������������� ������ ����].���� AS [����� ��� (����)], ' +
    '[(������) � ������������� ������ ����].��� AS [����� �� ���� (����)], ' +
    '([(������) ������� ���� � ����� �� ���������� �������]![����� ������� �����]+  '
    + '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������� ����� ���]+ '
    + '[(������) ����� ����� � �����-� �� ���������� �������]![����� ������� ����� � ����������]) AS [����� ������� �����], '
    + '([(������) ������� ���� � ����� �� ���������� �������]![����� ���������������� �����]+  '
    + '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������� ����� ���]+ '
    + '[(������) ����� ����� � �����-� �� ���������� �������]![����� ���������������� ����� � ����������]) AS [����� ���� �����], '
    + '([(������) ������� ���� � ����� �� ���������� �������]![����� ������]+ '
    + '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������ ���]) AS [����� ������ �����], '
    + '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������ ���] AS [����� ���], '
    + '[(������) ������� ���� � ����� �� ���������� �������]![����� �� ������] AS [����� �� ����], '
    + '([(������) ������� ���� � ����� �� ���������� �������]![����� ������� �����]+ '
    + '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������� ����� ���]+ '
    + '[(������) ����� ����� � �����-� �� ���������� �������]![����� ������� ����� � ����������])/ '
    + '[(������) � ������������� ������ ����].��� AS [�� ������� �����], ' +
    '([(������) ������� ���� � ����� �� ���������� �������]![����� ���������������� �����]+ '
    + '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������� ����� ���]+ '
    + '[(������) ����� ����� � �����-� �� ���������� �������]![����� ���������������� ����� � ����������])/ '
    + '[(������) � ������������� ������ ����].��� AS [�� ���� �����], ' +
    '([(������) ������� ���� � ����� �� ���������� �������]![����� ������]+ ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������ ���])/ '
    + '[(������) � ������������� ������ ����].�� AS [�� ������ �����], ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������ ���]/ '
    + '[(������) � ������������� ������ ����].���� AS [�� ������ ���], ' +
    '[(������) ������� ���� � ����� �� ���������� �������]![����� �� ������]/ '
    + '[(������) � ������������� ������ ����].��� AS [�� �� �����], ' +
    '[(������) ����� ����� � �����-� �� ���������� �������]![����� �����������] AS [����� �����������], '
    + '[(������) ����� ����� � �����-� �� ���������� �������].[Sum-Sum-����] AS [������ ����], '
    + '[(������) ����� ����� � �����-� �� ���������� �������].[Sum-Sum-����] AS [������ ������] '
    + 'FROM [(������) ������� ���� � ����� �� ���������� �������], ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������], [(������) ����� ����� � �����-� �� ���������� �������], '
    + '[(������) � ����������� ������ ����], [� ���������� ����� ������], ' +
    '[(�����) � ���������� ����], [(������) � ������������� ������ ����];';
  Try
    With TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add(CSQL);
      Open;
    end;
  Except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  SetLength(TempArray, TempQuery.Fields.Count);
  for i := 0 to TempQuery.Fields.Count - 1 do
  begin
    TempArray[i] := CheckNull.CheckedValue(TempQuery.Fields[i].value);
  end;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWWeeklyReportProduction.create ���������');
end;

function TBRWWeeklyReportProduction.GetValueLitr(i: integer): string;

begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempArray[i] / 1000));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWWeeklyReportProduction.GetValueLitr ���������', result);
end;

function TBRWWeeklyReportProduction.GetValuePlan(i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempArray[i]));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWWeeklyReportProduction.GetValuePlan ���������', result);
end;

function TBRWWeeklyReportProduction.GetValuePercent(i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i] / 10)) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWWeeklyReportProduction.GetValuePercent ���������', result);
end;

function TBRWWeeklyReportProduction.GetValueTromboPacketsDoses
  (i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i]));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWWeeklyReportProduction.GetValueTromboPacketsDoses ���������', result);
end;
end.
