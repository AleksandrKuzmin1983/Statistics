unit MRWWeeklyReportProduction;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;
type
  IMRWWeeklyReportProduction = interface
    function GetValueLitr(i: integer): string;
    function GetValuePlan(i: integer): string;
    function GetValuePercent(i: integer): string;
    function GetValueTromboPacketsDoses(i: integer): string;
  end;

  TMRWWeeklyReportProduction = class(TInterfacedObject, IMRWWeeklyReportProduction)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
    TempArray: array of real;
    TempValue: Real;
    TempSQL: String;
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

constructor TMRWWeeklyReportProduction.create;
var
  i: integer;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  CSQL:=
    'SELECT [(������) � ������������� ������ ����].��� AS [������� ����� (����)], ' +
    '[(������) � ������������� ������ ����].��� AS [���� ����� (����)], ' +
    '[(������) � ������������� ������ ����].�� AS [����� ������ ����� (����)], ' +
    '[(������) � ������������� ������ ����].���� AS [����� ��� (����)], ' +
    '[(������) � ������������� ������ ����].��� AS [����� �� ���� (����)], ' +
    '([(������) ������� ���� � ����� �� ���������� �������]![����� ������� �����]+  ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������� ����� ���]+ ' +
    '[(������) ����� ����� � �����-� �� ���������� �������]![����� ������� ����� � ����������]) AS [����� ������� �����], ' +
    '([(������) ������� ���� � ����� �� ���������� �������]![����� ���������������� �����]+  ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������� ����� ���]+ ' +
    '[(������) ����� ����� � �����-� �� ���������� �������]![����� ���������������� ����� � ����������]) AS [����� ���� �����], ' +
    '([(������) ������� ���� � ����� �� ���������� �������]![����� ������]+ ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������ ���]) AS [����� ������ �����], ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������ ���] AS [����� ���], ' +
    '[(������) ������� ���� � ����� �� ���������� �������]![����� �� ������] AS [����� �� ����], ' +
    '([(������) ������� ���� � ����� �� ���������� �������]![����� ������� �����]+ ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������� ����� ���]+ ' +
    '[(������) ����� ����� � �����-� �� ���������� �������]![����� ������� ����� � ����������])/ ' +
    '[(������) � ������������� ������ ����].��� AS [�� ������� �����], ' +
    '([(������) ������� ���� � ����� �� ���������� �������]![����� ���������������� �����]+ ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������� ����� ���]+ ' +
    '[(������) ����� ����� � �����-� �� ���������� �������]![����� ���������������� ����� � ����������])/ ' +
    '[(������) � ������������� ������ ����].��� AS [�� ���� �����], ' +
    '([(������) ������� ���� � ����� �� ���������� �������]![����� ������]+ ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������ ���])/ ' +
    '[(������) � ������������� ������ ����].�� AS [�� ������ �����], ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������]![����� ������ ���]/ ' +
    '[(������) � ������������� ������ ����].���� AS [�� ������ ���], ' +
    '[(������) ������� ���� � ����� �� ���������� �������]![����� �� ������]/ ' +
    '[(������) � ������������� ������ ����].��� AS [�� �� �����], ' +
    '[(������) ����� ����� � �����-� �� ���������� �������]![����� �����������] AS [����� �����������], ' +
    '[(������) ����� ����� � �����-� �� ���������� �������].[Sum-Sum-����] AS [������ ����], ' +
    '[(������) ����� ����� � �����-� �� ���������� �������].[Sum-Sum-����] AS [������ ������] ' +
    'FROM [(������) ������� ���� � ����� �� ���������� �������], ' +
    '[(������) ����� ����� � ������ ��� �� ���������� �������], [(������) ����� ����� � �����-� �� ���������� �������], ' +
    '[(������) � ����������� ������ ����], [� ���������� ����� ������], ' +
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
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  SetLength(TempArray, TempQuery.Fields.Count);
  for i := 0 to TempQuery.Fields.Count-1 do
  begin
    TempArray[i]:=CheckNull.CheckedValue(TempQuery.Fields[i].value);
  end;
  TempQuery.Close;
end;

function TMRWWeeklyReportProduction.GetValueLitr(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0.000',TempArray[i]/1000));
end;

function TMRWWeeklyReportProduction.GetValuePlan(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0.000',TempArray[i]));
end;

function TMRWWeeklyReportProduction.GetValuePercent(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0',TempArray[i]/10)) + '%';
end;

function TMRWWeeklyReportProduction.GetValueTromboPacketsDoses(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0',TempArray[i]));
end;

end.
