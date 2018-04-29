unit BRWResultsOfTheProducts;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWResultsOfTheProducts = interface
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
    function GetValuePercent(i: integer): string;
  end;

  TBRWResultsOfTheProducts = class(TInterfacedObject, IBRWResultsOfTheProducts)
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

constructor TBRWResultsOfTheProducts.create;
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
    '[��������� 1]![Sum-���] AS [��������� 1�], [��������� 1].[Sum-���] AS [��������� 1�], [�������� 1]![Sum-���] AS [�������� 1�], '
    + '[�������� 1].[Sum-���] AS [�������� 1�], [��������� 1].[Sum-����] AS [��������� 1��],  [�������� 1].[Sum-����] AS [�������� 1��], '
    +

    '[��������� 2]![Sum-���] AS [��������� 2�], [��������� 2].[Sum-���] AS [��������� 2�], [�������� 2]![Sum-���] AS [�������� 2�], '
    + '[�������� 2].[Sum-���] AS [�������� 2�], [��������� 2].[Sum-����] AS [��������� 2��], [�������� 2].[Sum-����] AS [�������� 2��], '
    +

    '[��������� 3]![Sum-���] AS [��������� 3�], [��������� 3].[Sum-���] AS [��������� 3�], [�������� 3]![Sum-���] AS [�������� 3�],  '
    + '[�������� 3].[Sum-���] AS [�������� 3�], [��������� 3].[Sum-����] AS [��������� 3��], [�������� 3].[Sum-����] AS [�������� 3��], '
    +

    '[��������� 4]![Sum-���] AS [��������� 4�], [��������� 4].[Sum-���] AS [��������� 4�], [�������� 4]![Sum-���] AS [�������� 4�], '
    + '[�������� 4].[Sum-���] AS [�������� 4�],[��������� 4].[Sum-����] AS [��������� 4��], [�������� 4].[Sum-����] AS [�������� 4��], '
    +

    '[��������� 5]![Sum-���] AS [��������� 5�], [��������� 5].[Sum-���] AS [��������� 5�], [�������� 5]![Sum-���] AS [�������� 5�],  '
    + '[�������� 5].[Sum-���] AS [�������� 5�],  [��������� 5].[Sum-����] AS [��������� 5��], [�������� 5].[Sum-����] AS [�������� 5��], '
    +

    '[��������� 6]![Sum-���] AS [��������� 6�], [��������� 6].[Sum-���] AS [��������� 6�], [�������� 6]![Sum-���] AS [�������� 6�], '
    + '[�������� 6].[Sum-���] AS [�������� 6�], [��������� 6].[Sum-����] AS [��������� 6��], [�������� 6].[Sum-����] AS [�������� 6��], '
    +

    '[��������� 7]![Sum-���] AS [��������� 7�], [��������� 7].[Sum-���] AS [��������� 7�], [�������� 7]![Sum-���] AS [�������� 7�], '
    + '[�������� 7].[Sum-���] AS [�������� 7�],  [��������� 7].[Sum-����] AS [��������� 7��], [�������� 7].[Sum-����] AS [�������� 7��], '
    +

    '[��������� 8]![Sum-���] AS [��������� 8�], [��������� 8].[Sum-���] AS [��������� 8�], [�������� 8]![Sum-���] AS [�������� 8�], '
    + '[�������� 8].[Sum-���] AS [�������� 8�], [��������� 8].[Sum-����] AS [��������� 8��], [�������� 8].[Sum-����] AS [�������� 8��] '
    + 'FROM [��������� 1], [��������� 2], [��������� 3], [��������� 4], [��������� 5], [��������� 6], '
    + '[��������� 7], [��������� 8], [�������� 1], [�������� 2], [�������� 3], [�������� 4], '
    + '[�������� 5], [�������� 6], [�������� 7], [�������� 8];';
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
  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.create ���������');
end;

function TBRWResultsOfTheProducts.GetValueLitr(i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempArray[i] / 1000));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.GetValueLitr ���������', result);
end;

function TBRWResultsOfTheProducts.GetValueDoses(i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i]));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.GetValueDoses ���������', result);
end;

function TBRWResultsOfTheProducts.GetValuePercent(i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i])) + '%';

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.GetValuePercent ���������', result);
end;
end.
