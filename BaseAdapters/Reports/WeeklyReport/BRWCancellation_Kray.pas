unit BRWCancellation_Kray;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;
type
  IMRWCancellation_Kray = interface
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
  end;

  TMRWCancellation_Kray = class(TInterfacedObject, IMRWCancellation_Kray)
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
    function GetValueDoses(i: integer): string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TMRWCancellation_Kray.create;
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
    'SELECT [���� 1]![Sum-���] AS [�� ������ � ������ �-���, �������������], ' +
    '[���� 2]![Sum-���] AS [�� ������ � ������ �-���], [���� 3]![Sum-���] AS [�� ������ � ����� �-���], ' +
    '[���� 4]![Sum-���] AS [��� ���], [���� 5]![Sum-���] AS [��� ������������-�], ' +
    '[���� 6]![Sum-���] AS [�������������� ���], [���� 7]![Sum-���] AS [���������� �����������], ' +
    '[���� 8]![Sum-���] AS ���������, [���� 1].[Sum-���] AS [�� ������ � ������ �-���, �������������, �], ' +
    '[���� 2].[Sum-���] AS [�� ������ � ������ �-���, �], [���� 3].[Sum-���] AS [�� ������ � ����� �-���, �],  ' +
    '[���� 4].[Sum-���] AS [��� ���, �], [���� 5].[Sum-���] AS [��� ������������-�, �], ' +
    '[���� 6].[Sum-���] AS [�������������� ���, �], [���� 7].[Sum-���] AS [���������� �����������, �], ' +
    '[���� 8].[Sum-���] AS [���������, �], [���� �� 1]![Sum-���] AS [�� �� ������ � ������ �-���, �������������], ' +
    '[���� �� 2]![Sum-���] AS [�� �� ������ � ������ �-���], [���� �� 3]![Sum-���] AS [�� �� ������ � ����� �-���],  ' +
    '[���� �� 4]![Sum-���] AS [�� ��� ���], [���� �� 5]![Sum-���] AS [�� ��� ������������-�], ' +
    '[���� �� 6]![Sum-���] AS [�� �������������� ���], [���� �� 7]![Sum-���] AS [�� ���������� �����������], ' +
    '[���� �� 8]![Sum-���] AS [�� ���������], [���� �� 1].[Sum-���] AS [�� �� ������ � ������ �-���, �������������, �], ' +
    '[���� �� 2].[Sum-���] AS [�� �� ������ � ������ �-���, �], [���� �� 3].[Sum-���] AS [�� �� ������ � ����� �-���, �],  ' +
    '[���� �� 4].[Sum-���] AS [�� ��� ���, �], [���� �� 5].[Sum-���] AS [�� ��� ������������-�, �], ' +
    '[���� �� 6].[Sum-���] AS [�� �������������� ���, �], [���� �� 7].[Sum-���] AS [�� ���������� �����������, �], ' +
    '[���� �� 8].[Sum-���] AS [�� ���������, �] ' +
    'FROM [���� 1], [���� 2], [���� 3], [���� 4], [���� 5], [���� 6], [���� 7], ' +
    '[���� �� 1], [���� �� 2], [���� �� 3], [���� �� 4], [���� �� 5], [���� �� 6], [���� �� 7], [���� 8], [���� �� 8]; ';
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

function TMRWCancellation_Kray.GetValueLitr(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0.000',TempArray[i]/1000));
end;

function TMRWCancellation_Kray.GetValueDoses(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0',TempArray[i]));
end;
end.
