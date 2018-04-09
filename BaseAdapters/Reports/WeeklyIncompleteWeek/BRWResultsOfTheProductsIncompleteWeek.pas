unit BRWResultsOfTheProductsIncompleteWeek;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWResultsOfTheProductsIncompleteWeek = interface
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
    function GetValuePercent(i: integer): string;
  end;

  TBRWResultsOfTheProductsIncompleteWeek = class(TInterfacedObject,
    IBRWResultsOfTheProductsIncompleteWeek)
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

constructor TBRWResultsOfTheProductsIncompleteWeek.create;
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
    '[��������� 1 (����0)].[Sum-���] AS ���1, [��������� 2 (����0)].[Sum-���] AS ���2, '
    + '[��������� 3 (����0)].[Sum-���] AS ���3, [��������� 4 (����0)].[Sum-���] AS ���4, '
    + '[��������� 5 (����0)].[Sum-���] AS ���5, [��������� 6 (����0)].[Sum-���] AS ���6, '
    + '[��������� 7 (����0)].[Sum-���] AS ���7, [��������� 8 (����0)].[Sum-���] AS ���8, '
    +

    '[�������� 1 (����0)].[Sum-���] AS ���1, [�������� 2 (����0)].[Sum-���] AS ���2, '
    + '[�������� 3 (����0)].[Sum-���] AS ���3, [�������� 4 (����0)].[Sum-���] AS ���4, '
    + '[�������� 5 (����0)].[Sum-���] AS ���5, [�������� 6 (����0)].[Sum-���] AS ���6, '
    + '[�������� 7 (����0)].[Sum-���] AS ���7, [�������� 8 (����0)].[Sum-���] AS ���8, '
    +

    '[��������� 1 (����0)].[Sum-���] AS [���1 �], [��������� 2 (����0)].[Sum-���] AS [���2 �], '
    + '[��������� 3 (����0)].[Sum-���] AS [���3 �], [��������� 4 (����0)].[Sum-���] AS [���4 �], '
    + '[��������� 5 (����0)].[Sum-���] AS [���5 �], [��������� 6 (����0)].[Sum-���] AS [���6 �], '
    + '[��������� 7 (����0)].[Sum-���] AS [���7 �], [��������� 8 (����0)].[Sum-���] AS [���8 �], '
    +

    '[�������� 1 (����0)].[Sum-���] AS [���1 �], [�������� 2 (����0)].[Sum-���] AS [���2 �], '
    + '[�������� 3 (����0)].[Sum-���] AS [���3 �], [�������� 4 (����0)].[Sum-���] AS [���4 �], '
    + '[�������� 5 (����0)].[Sum-���] AS [���5 �], [�������� 6 (����0)].[Sum-���] AS [���6 �], '
    + '[�������� 7 (����0)].[Sum-���] AS [���7 �], [�������� 8 (����0)].[Sum-���] AS [���8 �], '
    +

    '[��������� 1 (����0)].[Sum-����] AS [���1 ��], [��������� 2 (����0)].[Sum-����] AS [���2 ��], '
    + '[��������� 3 (����0)].[Sum-����] AS [���3 ��], [��������� 4 (����0)].[Sum-����] AS [���4 ��], '
    + '[��������� 5 (����0)].[Sum-����] AS [���5 ��], [��������� 6 (����0)].[Sum-����] AS [���6 ��], '
    + '[��������� 7 (����0)].[Sum-����] AS [���7 ��], [��������� 8 (����0)].[Sum-����] AS [���8 ��], '
    +

    '[�������� 1 (����0)].[Sum-����] AS [���1 ��], [�������� 2 (����0)].[Sum-����] AS [���2 ��], '
    + '[�������� 3 (����0)].[Sum-����] AS [���3 ��], [�������� 4 (����0)].[Sum-����] AS [���4 ��], '
    + '[�������� 5 (����0)].[Sum-����] AS [���5 ��], [�������� 6 (����0)].[Sum-����] AS [���6 ��], '
    + '[�������� 7 (����0)].[Sum-����] AS [���7 ��], [�������� 8 (����0)].[Sum-����] AS [���8 ��] '
    +

    'FROM [��������� 1 (����0)], [��������� 2 (����0)], [��������� 3 (����0)], [��������� 4 (����0)], '
    + '[��������� 5 (����0)], [��������� 6 (����0)], [��������� 7 (����0)], [�������� 1 (����0)], '
    + '[�������� 2 (����0)], [�������� 3 (����0)], [�������� 4 (����0)], [�������� 5 (����0)], '
    + '[�������� 6 (����0)], [�������� 7 (����0)], [�������� 8 (����0)], [��������� 8 (����0)];';
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProductsIncompleteWeek.create ���������');
end;

function TBRWResultsOfTheProductsIncompleteWeek.GetValueLitr
  (i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempArray[i] / 1000));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProductsIncompleteWeek.GetValueLitr ���������', result);
end;

function TBRWResultsOfTheProductsIncompleteWeek.GetValueDoses
  (i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i]));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProductsIncompleteWeek.GetValueDoses ���������', result);
end;

function TBRWResultsOfTheProductsIncompleteWeek.GetValuePercent
  (i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i])) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProductsIncompleteWeek.GetValuePercent ���������', result);
end;
end.
