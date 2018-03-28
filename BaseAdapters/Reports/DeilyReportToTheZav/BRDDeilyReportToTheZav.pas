unit BRDDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IMRDDeilyReportToTheZav = interface
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

  TMRDDeilyReportToTheZav = class(TInterfacedObject, IMRDDeilyReportToTheZav)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
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

constructor TMRDDeilyReportToTheZav.create;
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

procedure TMRDDeilyReportToTheZav.GetSQL(CSQL: String);
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

function TMRDDeilyReportToTheZav.GetPercentWholeBlood: string;
begin
  TempSQL:=
    'SELECT (([(������) ������� ����������� � ����� �� ������� �����]![����� ������� �����]+' +
    '[(������) ����� ����� � ������ ���]![����� ������� ����� ���]+' +
    '[(������) ����� ����� � �����-�]![����� ������� ����� � ����������])/1000)/[Plans]![���] AS [�� �������] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) ����� ����� � ������ ���], ' +
    '[(������) � ����������� ������ ����], [(������) � ����������� ������ (���������)], ' +
    '[(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue*100)) + '%';
end;

function TMRDDeilyReportToTheZav.GetVolumeWholeBlood: string;
begin
  TempSQL:=
      'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� ������� �����]+' +
      '[(������) ����� ����� � ������ ���]![����� ������� ����� ���]+' +
      '[(������) ����� ����� � �����-�]![����� ������� ����� � ����������])/1000 AS [����� ������� �����] ' +
      'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) ����� ����� � ������ ���], ' +
      '[(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDDeilyReportToTheZav.GetPercentConsBlood: string;
begin
  TempSQL:=
    'SELECT (([(������) ������� ����������� � ����� �� ������� �����]![����� ���������������� �����]+' +
    '[(������) ����� ����� � ������ ���]![����� ������� ����� ���]+' +
    '[(������) ����� ����� � �����-�]![����� ���������������� ����� � ����������])/1000)/[Plans]![���] AS [�� ����������������] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����], ' +
    '[(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����], ' +
    '[(������) � ����������� ������ (���������)], [(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue*100)) + '%';
end;

function TMRDDeilyReportToTheZav.GetVolumeConsBlood: string;
begin
  TempSQL:=
      'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� ���������������� �����]+' +
      '[(������) ����� ����� � ������ ���]![����� ������� ����� ���]+' +
      '[(������) ����� ����� � �����-�]![����� ���������������� ����� � ����������])/1000 AS [����� ���������������� �����] ' +
      'FROM [(������) ������� ����������� � ����� �� ������� �����], ' +
      '[(������) ����� ����� � ������ ���], [(������) ����� ����� � �����-�];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDDeilyReportToTheZav.GetPercentPlasmaTotal: string;
begin
  TempSQL:=
    'SELECT (([(������) ������� ����������� � ����� �� ������� �����]![����� ������]+' +
    '[(������) ����� ����� � ������ ���]![����� ������ ���])/1000)/[Plans]![��] AS [�� ������] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����], ' +
    '[(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue*100)) + '%';
end;

function TMRDDeilyReportToTheZav.GetVolumePlasmaTotal: string;
begin
  TempSQL:=
    'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� ������]+' +
    '[(������) ����� ����� � ������ ���]![����� ������ ���])/1000 AS [����� ������] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) ����� ����� � ������ ���] ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDDeilyReportToTheZav.GetPercentPlasmaAPA: string;
begin
  TempSQL:=
    'SELECT ([(������) ����� ����� � ������ ���]![����� ������ ���]/1000)/[Plans]![����] AS [�� ������] ' +
    'FROM [(������) ����� ����� � ������ ���], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue*100)) + '%';
end;

function TMRDDeilyReportToTheZav.GetVolumePlasmaAPA: string;
begin
  TempSQL:=
    'SELECT [(������) ����� ����� � ������ ���]![����� ������ ���]/1000 AS [����� ������] ' +
    'FROM [(������) ����� ����� � ������ ���] ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDDeilyReportToTheZav.GetPercentErSusp: string;
begin
  TempSQL:=
    'SELECT ([(������) ������� ����������� � ����� �� ������� �����]![����� �� ������]/1000)/[(������) � ����������� ������ ����]![���] AS [�� �� ������] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����], [(������) � ����������� ������ ����];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue*100)) + '%';
end;

function TMRDDeilyReportToTheZav.GetVolumeErSusp: string;
begin
  TempSQL:=
    'SELECT [(������) ������� ����������� � ����� �� ������� �����]![����� �� ������]/1000 AS [����� �� ������] ' +
    'FROM [(������) ������� ����������� � ����� �� ������� �����] ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDDeilyReportToTheZav.GetVolumeTrombo: string;
begin
  TempSQL:=
    'SELECT [(������) ����� ����� � �����-�]![����� �����������]/1000 AS [����� �����������] ' +
    'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDDeilyReportToTheZav.GetNumberDosesTromb: string;
begin
  TempSQL:=
    'SELECT [(������) ����� ����� � �����-�].[���-�� ��� ������] ' +
    'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + ' �.';
end;

function TMRDDeilyReportToTheZav.GetNumberPacketsTromb: string;
begin
  TempSQL:=
    'SELECT [(������) ����� ����� � �����-�].[���-�� �������] ' +
    'FROM [(������) ����� ����� � �����-�]; ';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + ' ���.';
end;
end.
