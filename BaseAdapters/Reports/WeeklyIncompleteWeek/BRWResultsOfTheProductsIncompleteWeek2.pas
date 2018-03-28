unit BRWResultsOfTheProductsIncompleteWeek2;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWResultsOfTheProductsIncompleteWeek2 = interface
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
    function GetValuePercent(i: integer): string;
  end;

  TBRWResultsOfTheProductsIncompleteWeek2 = class(TInterfacedObject,
    IBRWResultsOfTheProductsIncompleteWeek2)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempArray: array of real;
    CSQL: String;
  public
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
    function GetValuePercent(i: integer): string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRWResultsOfTheProductsIncompleteWeek2.create;
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
  CSQL := 'SELECT ' +
    '[��������� 1 (����)].[Sum-���] AS ���1, [��������� 2 (����)].[Sum-���] AS ���2, '
    + '[��������� 3 (����)].[Sum-���] AS ���3, [��������� 4 (����)].[Sum-���] AS ���4, '
    + '[��������� 5 (����)].[Sum-���] AS ���5, [��������� 6 (����)].[Sum-���] AS ���6, '
    + '[��������� 7 (����)].[Sum-���] AS ���7, [��������� 8 (����)].[Sum-���] AS ���8, '
    +

    '[�������� 1 (����)].[Sum-���] AS ���1, [�������� 2 (����)].[Sum-���] AS ���2, '
    + '[�������� 3 (����)].[Sum-���] AS ���3, [�������� 4 (����)].[Sum-���] AS ���4, '
    + '[�������� 5 (����)].[Sum-���] AS ���5, [�������� 6 (����)].[Sum-���] AS ���6, '
    + '[�������� 7 (����)].[Sum-���] AS ���7, [�������� 8 (����)].[Sum-���] AS ���8, '
    +

    '[��������� 1 (����)].[Sum-���] AS [���1 �], [��������� 2 (����)].[Sum-���] AS [���2 �], '
    + '[��������� 3 (����)].[Sum-���] AS [���3 �], [��������� 4 (����)].[Sum-���] AS [���4 �], '
    + '[��������� 5 (����)].[Sum-���] AS [���5 �], [��������� 6 (����)].[Sum-���] AS [���6 �], '
    + '[��������� 7 (����)].[Sum-���] AS [���7 �], [��������� 8 (����)].[Sum-���] AS [���8 �], '
    +

    '[�������� 1 (����)].[Sum-���] AS [���1 �], [�������� 2 (����)].[Sum-���] AS [���2 �], '
    + '[�������� 3 (����)].[Sum-���] AS [���3 �], [�������� 4 (����)].[Sum-���] AS [���4 �], '
    + '[�������� 5 (����)].[Sum-���] AS [���5 �], [�������� 6 (����)].[Sum-���] AS [���6 �], '
    + '[�������� 7 (����)].[Sum-���] AS [���7 �], [�������� 8 (����)].[Sum-���] AS [���8 �], '
    +

    '[��������� 1 (����)].[Sum-����] AS [���1 ��], [��������� 2 (����)].[Sum-����] AS [���2 ��], '
    + '[��������� 3 (����)].[Sum-����] AS [���3 ��], [��������� 4 (����)].[Sum-����] AS [���4 ��], '
    + '[��������� 5 (����)].[Sum-����] AS [���5 ��], [��������� 6 (����)].[Sum-����] AS [���6 ��], '
    + '[��������� 7 (����)].[Sum-����] AS [���7 ��], [��������� 8 (����)].[Sum-����] AS [���8 ��], '
    +

    '[�������� 1 (����)].[Sum-����] AS [���1 ��], [�������� 2 (����)].[Sum-����] AS [���2 ��], '
    + '[�������� 3 (����)].[Sum-����] AS [���3 ��], [�������� 4 (����)].[Sum-����] AS [���4 ��], '
    + '[�������� 5 (����)].[Sum-����] AS [���5 ��], [�������� 6 (����)].[Sum-����] AS [���6 ��], '
    + '[�������� 7 (����)].[Sum-����] AS [���7 ��], [�������� 8 (����)].[Sum-����] AS [���8 ��] '
    +

    'FROM [��������� 1 (����)], [��������� 2 (����)], [��������� 3 (����)], [��������� 4 (����)], '
    + '[��������� 5 (����)], [��������� 6 (����)], [��������� 7 (����)], [�������� 1 (����)], '
    + '[�������� 2 (����)], [�������� 3 (����)], [�������� 4 (����)], [�������� 5 (����)], '
    + '[�������� 6 (����)], [�������� 7 (����)], [�������� 8 (����)], [��������� 8 (����)];';
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
end;

function TBRWResultsOfTheProductsIncompleteWeek2.GetValueLitr
  (i: integer): string;

begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempArray[i] / 1000));
end;

function TBRWResultsOfTheProductsIncompleteWeek2.GetValueDoses
  (i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i]));
end;

function TBRWResultsOfTheProductsIncompleteWeek2.GetValuePercent
  (i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i])) + '%';
end;

end.
