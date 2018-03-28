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
    '[Городские 1 (пере)].[Sum-ЛЗО] AS Гор1, [Городские 2 (пере)].[Sum-ЛЗО] AS Гор2, '
    + '[Городские 3 (пере)].[Sum-ЛЗО] AS Гор3, [Городские 4 (пере)].[Sum-ЛЗО] AS Гор4, '
    + '[Городские 5 (пере)].[Sum-ЛЗО] AS Гор5, [Городские 6 (пере)].[Sum-ЛЗО] AS Гор6, '
    + '[Городские 7 (пере)].[Sum-ЛЗО] AS Гор7, [Городские 8 (пере)].[Sum-ЛЗО] AS Гор8, '
    +

    '[Районные 1 (пере)].[Sum-ЛЗО] AS Рай1, [Районные 2 (пере)].[Sum-ЛЗО] AS Рай2, '
    + '[Районные 3 (пере)].[Sum-ЛЗО] AS Рай3, [Районные 4 (пере)].[Sum-ЛЗО] AS Рай4, '
    + '[Районные 5 (пере)].[Sum-ЛЗО] AS Рай5, [Районные 6 (пере)].[Sum-ЛЗО] AS Рай6, '
    + '[Районные 7 (пере)].[Sum-ЛЗО] AS Рай7, [Районные 8 (пере)].[Sum-ЛЗО] AS Рай8, '
    +

    '[Городские 1 (пере)].[Sum-ЛЗД] AS [Гор1 д], [Городские 2 (пере)].[Sum-ЛЗД] AS [Гор2 д], '
    + '[Городские 3 (пере)].[Sum-ЛЗД] AS [Гор3 д], [Городские 4 (пере)].[Sum-ЛЗД] AS [Гор4 д], '
    + '[Городские 5 (пере)].[Sum-ЛЗД] AS [Гор5 д], [Городские 6 (пере)].[Sum-ЛЗД] AS [Гор6 д], '
    + '[Городские 7 (пере)].[Sum-ЛЗД] AS [Гор7 д], [Городские 8 (пере)].[Sum-ЛЗД] AS [Гор8 д], '
    +

    '[Районные 1 (пере)].[Sum-ЛЗД] AS [Рай1 д], [Районные 2 (пере)].[Sum-ЛЗД] AS [Рай2 д], '
    + '[Районные 3 (пере)].[Sum-ЛЗД] AS [Рай3 д], [Районные 4 (пере)].[Sum-ЛЗД] AS [Рай4 д], '
    + '[Районные 5 (пере)].[Sum-ЛЗД] AS [Рай5 д], [Районные 6 (пере)].[Sum-ЛЗД] AS [Рай6 д], '
    + '[Районные 7 (пере)].[Sum-ЛЗД] AS [Рай7 д], [Районные 8 (пере)].[Sum-ЛЗД] AS [Рай8 д], '
    +

    '[Городские 1 (пере)].[Sum-ЛЗПР] AS [Гор1 пр], [Городские 2 (пере)].[Sum-ЛЗПР] AS [Гор2 пр], '
    + '[Городские 3 (пере)].[Sum-ЛЗПР] AS [Гор3 пр], [Городские 4 (пере)].[Sum-ЛЗПР] AS [Гор4 пр], '
    + '[Городские 5 (пере)].[Sum-ЛЗПР] AS [Гор5 пр], [Городские 6 (пере)].[Sum-ЛЗПР] AS [Гор6 пр], '
    + '[Городские 7 (пере)].[Sum-ЛЗПР] AS [Гор7 пр], [Городские 8 (пере)].[Sum-ЛЗПР] AS [Гор8 пр], '
    +

    '[Районные 1 (пере)].[Sum-ЛЗПР] AS [Рай1 пр], [Районные 2 (пере)].[Sum-ЛЗПР] AS [Рай2 пр], '
    + '[Районные 3 (пере)].[Sum-ЛЗПР] AS [Рай3 пр], [Районные 4 (пере)].[Sum-ЛЗПР] AS [Рай4 пр], '
    + '[Районные 5 (пере)].[Sum-ЛЗПР] AS [Рай5 пр], [Районные 6 (пере)].[Sum-ЛЗПР] AS [Рай6 пр], '
    + '[Районные 7 (пере)].[Sum-ЛЗПР] AS [Рай7 пр], [Районные 8 (пере)].[Sum-ЛЗПР] AS [Рай8 пр] '
    +

    'FROM [Городские 1 (пере)], [Городские 2 (пере)], [Городские 3 (пере)], [Городские 4 (пере)], '
    + '[Городские 5 (пере)], [Городские 6 (пере)], [Городские 7 (пере)], [Районные 1 (пере)], '
    + '[Районные 2 (пере)], [Районные 3 (пере)], [Районные 4 (пере)], [Районные 5 (пере)], '
    + '[Районные 6 (пере)], [Районные 7 (пере)], [Районные 8 (пере)], [Городские 8 (пере)];';
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
