unit BRWSecondTableIncompleteWeek;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWSecondTableIncompleteWeek = interface
    function GetProductWholeBlood: string;
    function GetVolumeReinfusion: string;
    function GetPreparedFitProductionErSuspFiltr: string;
    function GetPreparedFitProductionErSusp: string;
    function GetPreparedFitProductionSZP: string;
    function GetOutingProductWholeBlood: string;
    function GetOutingPreparedFitProductionErSuspFiltr: string;
    function GetOutingPreparedFitProductionErSusp: string;
    function GetOutingPreparedFitProductionSZP: string;
  end;

  TBRWSecondTableIncompleteWeek = class(TInterfacedObject,
    IBRWSecondTableIncompleteWeek)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempValue: Real;
    TempSQL: String;
    procedure GetSQL(CSQL: String);
  public
    function GetProductWholeBlood: string;
    function GetVolumeReinfusion: string;
    function GetPreparedFitProductionErSuspFiltr: string;
    function GetPreparedFitProductionErSusp: string;
    function GetPreparedFitProductionSZP: string;
    function GetOutingProductWholeBlood: string;
    function GetOutingPreparedFitProductionErSuspFiltr: string;
    function GetOutingPreparedFitProductionErSusp: string;
    function GetOutingPreparedFitProductionSZP: string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRWSecondTableIncompleteWeek.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.create ���������');
end;

procedure TBRWSecondTableIncompleteWeek.GetSQL(CSQL: String);

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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetSQL ���������');
end;

function TBRWSecondTableIncompleteWeek.GetProductWholeBlood: string;
begin
  TempSQL :=
    'SELECT ([(������) ������� ���� � ����� �� ���� ������]![����� ������� �����]+ '
    + '[(������) ����� ����� � ������ ��� �� ���� ������]![����� ������� ����� ���]+ '
    + '[(������) ����� ����� � �����-� �� ���� ������]![����� ������� ����� � ����������])/1000 '
    + 'AS [��������� ��� ����� �� ������] ' +
    'FROM [(������) ������� ���� � ����� �� ���� ������], ' +
    '[(������) ����� ����� � ������ ��� �� ���� ������], ' +
    '[(������) ����� ����� � �����-� �� ���� ������];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetProductWholeBlood ���������', result);
end;

function TBRWSecondTableIncompleteWeek.GetVolumeReinfusion: string;
begin
  TempSQL :=
    'SELECT ([(������) ����� ����� � ������ ��� �� ���� ������]![����� ������� ����� ���]+'
    + '[(������) ����� ����� � �����-� �� ���� ������]![����� ���������������� ����� � ����������])/1000-'
    + '([(������) ����� ����� � ������ ��� �� ���� ������]![����� ������ ���]+'
    + '[(������) ����� ����� � �����-� �� ���� ������]![����� �����������])/1000 AS [��������� �� ������] '
    + 'FROM [(������) ����� ����� � ������ ��� �� ���� ������], ' +
    '[(������) ����� ����� � �����-� �� ���� ������];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetVolumeReinfusion ���������', result);
end;

function TBRWSecondTableIncompleteWeek.
  GetPreparedFitProductionErSuspFiltr: string;
begin
  TempSQL :=
    'SELECT [����������� ������ �� �� 1]![Sum-����]/1000 AS [�� �� (010)] ' +
    'FROM [����������� ������ �� �� 1];';
  GetSQL(TempSQL);
  result := '�� �� ��� - ' + VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetPreparedFitProductionErSuspFiltr ���������', result);
end;

function TBRWSecondTableIncompleteWeek.GetPreparedFitProductionErSusp: string;
begin
  TempSQL :=
    'SELECT [����������� ������ �� �� 2]![Sum-����]/1000 AS [�� �� (008)] ' +
    'FROM [����������� ������ �� �� 2];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
  if result = '0,000' then
    result := ''
  else
    result := '�� �� - ' + result;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetPreparedFitProductionErSusp ���������', result);
end;

function TBRWSecondTableIncompleteWeek.GetPreparedFitProductionSZP: string;
begin
  TempSQL :=
    'SELECT ([(������) ������� ���� � ����� �� ���� ������]![����� ������]+' +
    '[(������) ����� ����� � ������ ��� �� ���� ������]![����� ������ ���]-' +
    '[� ���������� ����� ������]![Sum-���])/1000 AS [����������� ������ ������] '
    + 'FROM [(������) ������� ���� � ����� �� ���� ������], ' +
    '[(������) ����� ����� � ������ ��� �� ���� ������], [� ���������� ����� ������];';
  GetSQL(TempSQL);
  result := '��� - ' + VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetPreparedFitProductionSZP ���������', result);
end;

function TBRWSecondTableIncompleteWeek.GetOutingProductWholeBlood: string;
begin
  TempSQL := 'SELECT Sum(Blood.����)/1000 AS [Sum-����] ' +
    'FROM Blood INNER JOIN FactoryCal ON Blood.����� = FactoryCal.���� ' +
    'WHERE (((Blood.�����)=True) ' +
    'AND ((Year([blood].[�����]))=Year(Now())) ' +
    'AND ((FactoryCal.����)<=Date()-Weekday(Date())+1 ' +
    'And (FactoryCal.����)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  if TempValue = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetOutingProductWholeBlood ���������', result);
end;

function TBRWSecondTableIncompleteWeek.
  GetOutingPreparedFitProductionErSuspFiltr: string;
begin
  TempSQL := 'SELECT Sum(Exped.����)/1000 AS [Sum-����] ' + 'FROM Exped ' +
    'WHERE (((Exped.��)=(select ShortName from NameProducts where NameProducts.id=5) '
    + 'Or (Exped.��)="None") AND ((Exped.������)<=Date()-Weekday(Date())+1 ' +
    'And (Exped.������)>=Date()-Weekday(Date())-5) AND ((Exped.�����)=True)) ' +
    'OR (((Exped.������)=#1/1/2015#));';
  GetSQL(TempSQL);
  if TempValue = 0 then
    result := ' '
  else
    result := '�� �� ��� - ' + VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetOutingPreparedFitProductionErSuspFiltr ���������', result);
end;

function TBRWSecondTableIncompleteWeek.
  GetOutingPreparedFitProductionErSusp: string;
begin
  TempSQL := 'SELECT Sum(Exped.����)/1000 AS [Sum-����] ' + 'FROM Exped ' +
    'WHERE (((Exped.��)=(select ShortName from NameProducts where NameProducts.id=4) '
    + 'Or (Exped.��)="None") AND ((Exped.������)<=Date()-Weekday(Date())+1 ' +
    'And (Exped.������)>=Date()-Weekday(Date())-5) AND ((Exped.�����)=True)) ' +
    'OR (((Exped.������)=#1/1/2015#));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
  if TempValue = 0 then
    result := ' '
  else
    result := '�� �� - ' + result;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetOutingPreparedFitProductionErSusp ���������', result);
end;

function TBRWSecondTableIncompleteWeek.
  GetOutingPreparedFitProductionSZP: string;
begin
  TempSQL := 'SELECT Sum(BloodPlasma.���)/1000 AS [Sum-���] ' +
    'FROM (((Blood INNER JOIN BloodDoza ON Blood.����� = BloodDoza.�����) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.���� = BloodErSusp.���) ' +
    'INNER JOIN BloodPlasma ON BloodErSusp.��� = BloodPlasma.����) ' +
    'INNER JOIN FactoryCal ON Blood.����� = FactoryCal.���� ' +
    'WHERE (((Blood.�����)=True) AND ((Year([blood].[�����]))=Year(Now())) ' +
    'AND ((FactoryCal.����)<=Date()-Weekday(Date())+1 ' +
    'And (FactoryCal.����)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  if TempValue = 0 then
    result := ' '
  else
    result := '��� - ' + VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTableIncompleteWeek.GetOutingPreparedFitProductionSZP ���������', result);
end;

end.
