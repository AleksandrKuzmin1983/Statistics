unit BRWResultsOfTheProductsIncompleteWeek;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;
type
  IMRWResultsOfTheProductsIncompleteWeek = interface
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
    function GetValuePercent(i: integer): string;
  end;

  TMRWResultsOfTheProductsIncompleteWeek = class(TInterfacedObject, IMRWResultsOfTheProductsIncompleteWeek)
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
    function GetValuePercent(i: integer): string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TMRWResultsOfTheProductsIncompleteWeek.create;
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
    'SELECT ' +
    '[��������� 1 (����0)].[Sum-���] AS ���1, [��������� 2 (����0)].[Sum-���] AS ���2, ' +
    '[��������� 3 (����0)].[Sum-���] AS ���3, [��������� 4 (����0)].[Sum-���] AS ���4, ' +
    '[��������� 5 (����0)].[Sum-���] AS ���5, [��������� 6 (����0)].[Sum-���] AS ���6, ' +
    '[��������� 7 (����0)].[Sum-���] AS ���7, [��������� 8 (����0)].[Sum-���] AS ���8, ' +

    '[�������� 1 (����0)].[Sum-���] AS ���1, [�������� 2 (����0)].[Sum-���] AS ���2, ' +
    '[�������� 3 (����0)].[Sum-���] AS ���3, [�������� 4 (����0)].[Sum-���] AS ���4, ' +
    '[�������� 5 (����0)].[Sum-���] AS ���5, [�������� 6 (����0)].[Sum-���] AS ���6, ' +
    '[�������� 7 (����0)].[Sum-���] AS ���7, [�������� 8 (����0)].[Sum-���] AS ���8, ' +

    '[��������� 1 (����0)].[Sum-���] AS [���1 �], [��������� 2 (����0)].[Sum-���] AS [���2 �], ' +
    '[��������� 3 (����0)].[Sum-���] AS [���3 �], [��������� 4 (����0)].[Sum-���] AS [���4 �], ' +
    '[��������� 5 (����0)].[Sum-���] AS [���5 �], [��������� 6 (����0)].[Sum-���] AS [���6 �], ' +
    '[��������� 7 (����0)].[Sum-���] AS [���7 �], [��������� 8 (����0)].[Sum-���] AS [���8 �], ' +

    '[�������� 1 (����0)].[Sum-���] AS [���1 �], [�������� 2 (����0)].[Sum-���] AS [���2 �], ' +
    '[�������� 3 (����0)].[Sum-���] AS [���3 �], [�������� 4 (����0)].[Sum-���] AS [���4 �], ' +
    '[�������� 5 (����0)].[Sum-���] AS [���5 �], [�������� 6 (����0)].[Sum-���] AS [���6 �], ' +
    '[�������� 7 (����0)].[Sum-���] AS [���7 �], [�������� 8 (����0)].[Sum-���] AS [���8 �], ' +

    '[��������� 1 (����0)].[Sum-����] AS [���1 ��], [��������� 2 (����0)].[Sum-����] AS [���2 ��], ' +
    '[��������� 3 (����0)].[Sum-����] AS [���3 ��], [��������� 4 (����0)].[Sum-����] AS [���4 ��], ' +
    '[��������� 5 (����0)].[Sum-����] AS [���5 ��], [��������� 6 (����0)].[Sum-����] AS [���6 ��], ' +
    '[��������� 7 (����0)].[Sum-����] AS [���7 ��], [��������� 8 (����0)].[Sum-����] AS [���8 ��], ' +

    '[�������� 1 (����0)].[Sum-����] AS [���1 ��], [�������� 2 (����0)].[Sum-����] AS [���2 ��], ' +
    '[�������� 3 (����0)].[Sum-����] AS [���3 ��], [�������� 4 (����0)].[Sum-����] AS [���4 ��], ' +
    '[�������� 5 (����0)].[Sum-����] AS [���5 ��], [�������� 6 (����0)].[Sum-����] AS [���6 ��], ' +
    '[�������� 7 (����0)].[Sum-����] AS [���7 ��], [�������� 8 (����0)].[Sum-����] AS [���8 ��] ' +

    'FROM [��������� 1 (����0)], [��������� 2 (����0)], [��������� 3 (����0)], [��������� 4 (����0)], ' +
    '[��������� 5 (����0)], [��������� 6 (����0)], [��������� 7 (����0)], [�������� 1 (����0)], ' +
    '[�������� 2 (����0)], [�������� 3 (����0)], [�������� 4 (����0)], [�������� 5 (����0)], ' +
    '[�������� 6 (����0)], [�������� 7 (����0)], [�������� 8 (����0)], [��������� 8 (����0)];';
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

function TMRWResultsOfTheProductsIncompleteWeek.GetValueLitr(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0.000',TempArray[i]/1000));
end;

function TMRWResultsOfTheProductsIncompleteWeek.GetValueDoses(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0',TempArray[i]));
end;

function TMRWResultsOfTheProductsIncompleteWeek.GetValuePercent(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0',TempArray[i])) + '%';
end;
end.
