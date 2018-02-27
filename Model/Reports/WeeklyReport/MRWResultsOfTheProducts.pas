unit MRWResultsOfTheProducts;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;
type
  IMRWResultsOfTheProducts = interface
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
    function GetValuePercent(i: integer): string;
  end;

  TMRWResultsOfTheProducts = class(TInterfacedObject, IMRWResultsOfTheProducts)
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

constructor TMRWResultsOfTheProducts.create;
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
    '[Городские 1]![Sum-ЛЗО] AS [Городские 1л], [Городские 1].[Sum-ЛЗД] AS [Городские 1д], [Районные 1]![Sum-ЛЗО] AS [Районные 1л], ' +
    '[Районные 1].[Sum-ЛЗД] AS [Районные 1д], [Городские 1].[Sum-ЛЗПР] AS [Городские 1пр],  [Районные 1].[Sum-ЛЗПР] AS [Районные 1пр], ' +

    '[Городские 2]![Sum-ЛЗО] AS [Городские 2л], [Городские 2].[Sum-ЛЗД] AS [Городские 2д], [Районные 2]![Sum-ЛЗО] AS [Районные 2л], ' +
    '[Районные 2].[Sum-ЛЗД] AS [Районные 2д], [Городские 2].[Sum-ЛЗПР] AS [Городские 2пр], [Районные 2].[Sum-ЛЗПР] AS [Районные 2пр], ' +

    '[Городские 3]![Sum-ЛЗО] AS [Городские 3л], [Городские 3].[Sum-ЛЗД] AS [Городские 3д], [Районные 3]![Sum-ЛЗО] AS [Районные 3л],  ' +
    '[Районные 3].[Sum-ЛЗД] AS [Районные 3д], [Городские 3].[Sum-ЛЗПР] AS [Городские 3пр], [Районные 3].[Sum-ЛЗПР] AS [Районные 3пр], ' +

    '[Городские 4]![Sum-ЛЗО] AS [Городские 4л], [Городские 4].[Sum-ЛЗД] AS [Городские 4д], [Районные 4]![Sum-ЛЗО] AS [Районные 4л], ' +
    '[Районные 4].[Sum-ЛЗД] AS [Районные 4д],[Городские 4].[Sum-ЛЗПР] AS [Городские 4пр], [Районные 4].[Sum-ЛЗПР] AS [Районные 4пр], ' +

    '[Городские 5]![Sum-ЛЗО] AS [Городские 5л], [Городские 5].[Sum-ЛЗД] AS [Городские 5д], [Районные 5]![Sum-ЛЗО] AS [Районные 5л],  ' +
    '[Районные 5].[Sum-ЛЗД] AS [Районные 5д],  [Городские 5].[Sum-ЛЗПР] AS [Городские 5пр], [Районные 5].[Sum-ЛЗПР] AS [Районные 5пр], ' +

    '[Городские 6]![Sum-ЛЗО] AS [Городские 6л], [Городские 6].[Sum-ЛЗД] AS [Городские 6д], [Районные 6]![Sum-ЛЗО] AS [Районные 6л], ' +
    '[Районные 6].[Sum-ЛЗД] AS [Районные 6д], [Городские 6].[Sum-ЛЗПР] AS [Городские 6пр], [Районные 6].[Sum-ЛЗПР] AS [Районные 6пр], ' +

    '[Городские 7]![Sum-ЛЗО] AS [Городские 7л], [Городские 7].[Sum-ЛЗД] AS [Городские 7д], [Районные 7]![Sum-ЛЗО] AS [Районные 7л], ' +
    '[Районные 7].[Sum-ЛЗД] AS [Районные 7д],  [Городские 7].[Sum-ЛЗПР] AS [Городские 7пр], [Районные 7].[Sum-ЛЗПР] AS [Районные 7пр], ' +

    '[Городские 8]![Sum-ЛЗО] AS [Городские 8л], [Городские 8].[Sum-ЛЗД] AS [Городские 8д], [Районные 8]![Sum-ЛЗО] AS [Районные 8л], ' +
    '[Районные 8].[Sum-ЛЗД] AS [Районные 8д], [Городские 8].[Sum-ЛЗПР] AS [Городские 8пр], [Районные 8].[Sum-ЛЗПР] AS [Районные 8пр] ' +
    'FROM [Городские 1], [Городские 2], [Городские 3], [Городские 4], [Городские 5], [Городские 6], ' +
    '[Городские 7], [Городские 8], [Районные 1], [Районные 2], [Районные 3], [Районные 4], ' +
    '[Районные 5], [Районные 6], [Районные 7], [Районные 8];';
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
end;

function TMRWResultsOfTheProducts.GetValueLitr(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0.000',TempArray[i]/1000));
end;

function TMRWResultsOfTheProducts.GetValueDoses(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0',TempArray[i]));
end;

function TMRWResultsOfTheProducts.GetValuePercent(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0',TempArray[i])) + '%';
end;
end.
