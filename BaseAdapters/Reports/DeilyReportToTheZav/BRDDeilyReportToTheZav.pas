unit BRDDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
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
end;

function TBRDDeilyReportToTheZav.GetVolumePlasmaTotal: string;
begin
  TempSQL :=
    'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� ������]+'
    + '[(������) ����� ����� � ������ ���]![����� ������ ���])/1000 AS [����� ������] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) ����� ����� � ������ ���] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDeilyReportToTheZav.GetPercentPlasmaAPA: string;
begin
  TempSQL :=
    'SELECT ([(������) ����� ����� � ������ ���]![����� ������ ���]/1000)/[Plans]![����] AS [�� ������] '
    + 'FROM [(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDeilyReportToTheZav.GetVolumePlasmaAPA: string;
begin
  TempSQL :=
    'SELECT [(������) ����� ����� � ������ ���]![����� ������ ���]/1000 AS [����� ������] '
    + 'FROM [(������) ����� ����� � ������ ���] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDeilyReportToTheZav.GetPercentErSusp: string;
begin
  TempSQL :=
    'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� �� ������]/1000)/[(������) � ����������� ������ ����]![���] AS [�� �� ������] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDeilyReportToTheZav.GetVolumeErSusp: string;
begin
  TempSQL :=
    'SELECT [(������) ������� ����������� � ����� �� ������� �����]![����� �� ������]/1000 AS [����� �� ������] '
    + 'FROM [(������) ������� ����������� � ����� �� ������� �����] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDeilyReportToTheZav.GetVolumeTrombo: string;
begin
  TempSQL :=
    'SELECT [(������) ����� ����� � �����-�]![����� �����������]/1000 AS [����� �����������] '
    + 'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDeilyReportToTheZav.GetNumberDosesTromb: string;
begin
  TempSQL := 'SELECT [(������) ����� ����� � �����-�].[���-�� ��� ������] ' +
    'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue)) + ' �.';
end;

function TBRDDeilyReportToTheZav.GetNumberPacketsTromb: string;
begin
  TempSQL := 'SELECT [(������) ����� ����� � �����-�].[���-�� �������] ' +
    'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue)) + ' ���.';
end;

end.
