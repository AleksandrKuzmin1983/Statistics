unit BRWCancellation_KrayIncomlpeteWeek;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWCancellation_KrayIncomlpeteWeek = interface
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
  end;

  TBRWCancellation_KrayIncomlpeteWeek = class(TInterfacedObject,
    IBRWCancellation_KrayIncomlpeteWeek)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempArray: array of real;
    CSQL: String;
  public
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRWCancellation_KrayIncomlpeteWeek.create;
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
  CSQL := 'SELECT [���� 1]![Sum-���] AS [�� ������ � ������ �-���, �������������], '
    + '[���� 2]![Sum-���] AS [�� ������ � ������ �-���], [���� 3]![Sum-���] AS [�� ������ � ����� �-���], '
    + '[���� 4]![Sum-���] AS [��� ���], [���� 5]![Sum-���] AS [��� ������������-�], '
    + '[���� 6]![Sum-���] AS [�������������� ���], [���� 7]![Sum-���] AS [���������� �����������], '
    + '[���� 8]![Sum-���] AS ���������, [���� 1].[Sum-���] AS [�� ������ � ������ �-���, �������������, �], '
    + '[���� 2].[Sum-���] AS [�� ������ � ������ �-���, �], [���� 3].[Sum-���] AS [�� ������ � ����� �-���, �],  '
    + '[���� 4].[Sum-���] AS [��� ���, �], [���� 5].[Sum-���] AS [��� ������������-�, �], '
    + '[���� 6].[Sum-���] AS [�������������� ���, �], [���� 7].[Sum-���] AS [���������� �����������, �], '
    + '[���� 8].[Sum-���] AS [���������, �], [���� �� 1]![Sum-���] AS [�� �� ������ � ������ �-���, �������������], '
    + '[���� �� 2]![Sum-���] AS [�� �� ������ � ������ �-���], [���� �� 3]![Sum-���] AS [�� �� ������ � ����� �-���],  '
    + '[���� �� 4]![Sum-���] AS [�� ��� ���], [���� �� 5]![Sum-���] AS [�� ��� ������������-�], '
    + '[���� �� 6]![Sum-���] AS [�� �������������� ���], [���� �� 7]![Sum-���] AS [�� ���������� �����������], '
    + '[���� �� 8]![Sum-���] AS [�� ���������], [���� �� 1].[Sum-���] AS [�� �� ������ � ������ �-���, �������������, �], '
    + '[���� �� 2].[Sum-���] AS [�� �� ������ � ������ �-���, �], [���� �� 3].[Sum-���] AS [�� �� ������ � ����� �-���, �],  '
    + '[���� �� 4].[Sum-���] AS [�� ��� ���, �], [���� �� 5].[Sum-���] AS [�� ��� ������������-�, �], '
    + '[���� �� 6].[Sum-���] AS [�� �������������� ���, �], [���� �� 7].[Sum-���] AS [�� ���������� �����������, �], '
    + '[���� �� 8].[Sum-���] AS [�� ���������, �] ' +
    'FROM [���� 1], [���� 2], [���� 3], [���� 4], [���� 5], [���� 6], [���� 7], '
    + '[���� �� 1], [���� �� 2], [���� �� 3], [���� �� 4], [���� �� 5], [���� �� 6], [���� �� 7], [���� 8], [���� �� 8]; ';
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWCancellation_KrayIncomlpeteWeek.create ���������');
end;

function TBRWCancellation_KrayIncomlpeteWeek.GetValueLitr(i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempArray[i] / 1000));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWCancellation_KrayIncomlpeteWeek.GetValueLitr ���������', result);
end;

function TBRWCancellation_KrayIncomlpeteWeek.GetValueDoses(i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i]));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWCancellation_KrayIncomlpeteWeek.GetValueDoses ���������', result);
end;

end.
