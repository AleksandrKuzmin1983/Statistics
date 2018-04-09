unit BRDDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRDDeilyReportToTheZav = interface
    function GetVolumeWholeBlood: string;
    function GetPercentWholeBlood: string;
    function GetVolumeConsBlood: string;
    function GetPercentConsBlood: string;
    function GetVolumePlasmaTotal: string;
    function GetPercentPlasmaTotal: string;
    function GetVolumePlasmaAPA: string;
    function GetPercentPlasmaAPA: string;
    function GetVolumeErSusp: string;
    function GetPercentErSusp: string;
    function GetVolumeTrombo: string;
    function GetNumberDosesTromb: string;
    function GetNumberPacketsTromb: string;
  end;

  TBRDDeilyReportToTheZav = class(TInterfacedObject, IBRDDeilyReportToTheZav)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempValue: Real;
    TempSQL: String;
    procedure GetSQL(CSQL: String);
  public
    function GetVolumeWholeBlood: string;
    function GetPercentWholeBlood: string;
    function GetVolumeConsBlood: string;
    function GetPercentConsBlood: string;
    function GetVolumePlasmaTotal: string;
    function GetPercentPlasmaTotal: string;
    function GetVolumePlasmaAPA: string;
    function GetPercentPlasmaAPA: string;
    function GetVolumeErSusp: string;
    function GetPercentErSusp: string;
    function GetVolumeTrombo: string;
    function GetNumberDosesTromb: string;
    function GetNumberPacketsTromb: string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRDDeilyReportToTheZav.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.create ���������');
end;

procedure TBRDDeilyReportToTheZav.GetSQL(CSQL: String);

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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetSQL ���������');
end;

function TBRDDeilyReportToTheZav.GetPercentWholeBlood: string;
begin
  TempSQL :=
    'SELECT (([(������) ������� ����������� � ����� �� ������� �����]![����� ������� �����]+'
    + '[(������) ����� ����� � ������ ���]![����� ������� ����� ���]+' +
    '[(������) ����� ����� � �����-�]![����� ������� ����� � ����������])/1000)/[Plans]![���] AS [�� �������] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) ����� ����� � ������ ���], '
    + '[(������) � ����������� ������ ����], [(������) � ����������� ������ (���������)], '
    + '[(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetPercentWholeBlood ���������', result);
end;

function TBRDDeilyReportToTheZav.GetVolumeWholeBlood: string;
begin
  TempSQL :=
    'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� ������� �����]+'
    + '[(������) ����� ����� � ������ ���]![����� ������� ����� ���]+' +
    '[(������) ����� ����� � �����-�]![����� ������� ����� � ����������])/1000 AS [����� ������� �����] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) ����� ����� � ������ ���], '
    + '[(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetVolumeWholeBlood ���������', result);
end;

function TBRDDeilyReportToTheZav.GetPercentConsBlood: string;
begin
  TempSQL :=
    'SELECT (([(������) ������� ����������� � ����� �� ������� �����]![����� ���������������� �����]+'
    + '[(������) ����� ����� � ������ ���]![����� ������� ����� ���]+' +
    '[(������) ����� ����� � �����-�]![����� ���������������� ����� � ����������])/1000)/[Plans]![���] AS [�� ����������������] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], ' +
    '[(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����], '
    + '[(������) � ����������� ������ (���������)], [(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetPercentConsBlood ���������', result);
end;

function TBRDDeilyReportToTheZav.GetVolumeConsBlood: string;
begin
  TempSQL :=
    'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� ���������������� �����]+'
    + '[(������) ����� ����� � ������ ���]![����� ������� ����� ���]+' +
    '[(������) ����� ����� � �����-�]![����� ���������������� ����� � ����������])/1000 AS [����� ���������������� �����] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], ' +
    '[(������) ����� ����� � ������ ���], [(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetVolumeConsBlood ���������', result);
end;

function TBRDDeilyReportToTheZav.GetPercentPlasmaTotal: string;
begin
  TempSQL :=
    'SELECT (([(������) ������� ����������� � ����� �� ������� �����]![����� ������]+'
    + '[(������) ����� ����� � ������ ���]![����� ������ ���])/1000)/[Plans]![��] AS [�� ������] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], ' +
    '[(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetPercentPlasmaTotal ���������', result);
end;

function TBRDDeilyReportToTheZav.GetVolumePlasmaTotal: string;
begin
  TempSQL :=
    'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� ������]+'
    + '[(������) ����� ����� � ������ ���]![����� ������ ���])/1000 AS [����� ������] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) ����� ����� � ������ ���] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetVolumePlasmaTotal ���������', result);
end;

function TBRDDeilyReportToTheZav.GetPercentPlasmaAPA: string;
begin
  TempSQL :=
    'SELECT ([(������) ����� ����� � ������ ���]![����� ������ ���]/1000)/[Plans]![����] AS [�� ������] '
    + 'FROM [(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetPercentPlasmaAPA ���������', result);
end;

function TBRDDeilyReportToTheZav.GetVolumePlasmaAPA: string;
begin
  TempSQL :=
    'SELECT [(������) ����� ����� � ������ ���]![����� ������ ���]/1000 AS [����� ������] '
    + 'FROM [(������) ����� ����� � ������ ���] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetVolumePlasmaAPA ���������', result);
end;

function TBRDDeilyReportToTheZav.GetPercentErSusp: string;
begin
  TempSQL :=
    'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� �� ������]/1000)/[(������) � ����������� ������ ����]![���] AS [�� �� ������] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetPercentErSusp ���������', result);
end;

function TBRDDeilyReportToTheZav.GetVolumeErSusp: string;
begin
  TempSQL :=
    'SELECT [(������) ������� ����������� � ����� �� ������� �����]![����� �� ������]/1000 AS [����� �� ������] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetVolumeErSusp ���������', result);
end;

function TBRDDeilyReportToTheZav.GetVolumeTrombo: string;
begin
  TempSQL :=
    'SELECT [(������) ����� ����� � �����-�]![����� �����������]/1000 AS [����� �����������] '
    + 'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetVolumeTrombo ���������', result);
end;

function TBRDDeilyReportToTheZav.GetNumberDosesTromb: string;
begin
  TempSQL := 'SELECT [(������) ����� ����� � �����-�].[���-�� ��� ������] ' +
    'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue)) + ' �.';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetNumberDosesTromb ���������', result);
end;

function TBRDDeilyReportToTheZav.GetNumberPacketsTromb: string;
begin
  TempSQL := 'SELECT [(������) ����� ����� � �����-�].[���-�� �������] ' +
    'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue)) + ' ���.';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDDeilyReportToTheZav.GetNumberPacketsTromb ���������', result);
end;
end.
