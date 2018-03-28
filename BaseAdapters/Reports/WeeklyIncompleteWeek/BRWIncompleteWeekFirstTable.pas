unit BRWIncompleteWeekFirstTable;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWIncompleteWeekFirstTable = interface
    function GetValueLitr(i: integer): string;
    function GetValuePlan(i: integer): string;
    function GetValuePercent(i: integer): string;
    function GetValueTromboPacketsDoses(i: integer): string;
  end;

  TBRWIncompleteWeekFirstTable = class(TInterfacedObject,
    IBRWIncompleteWeekFirstTable)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempArray: array of real;
    CSQL: String;
  public
    function GetValueLitr(i: integer): string;
    function GetValuePlan(i: integer): string;
    function GetValuePercent(i: integer): string;
    function GetValueTromboPacketsDoses(i: integer): string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRWIncompleteWeekFirstTable.create;
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
  CSQL := 'SELECT [(Нужный) К еженедельному отчету план].ОЦК AS [Цельная кровь (план)], '
    + '[(Нужный) К еженедельному отчету план].ОКК AS [Конс кровь (план)], ' +
    '[(Нужный) К еженедельному отчету план].ОП AS [Объем плазмы всего (план)], '
    + '[(Нужный) К еженедельному отчету план].ОАПА AS [Объем АПА (план)], ' +
    '[(Нужный) К еженедельному отчету план].ОЭВ AS [Объем эр сред (план)], ' +
    '([(Нужный) Подсчет комп и крови до предыдущей пятницы]![Объем цельной крови]+  '
    + '[(Нужный) Сумма крови и плазмы АПА до предыдущей пятницы]![Объем цельной крови АПА]+ '
    + '[(Нужный) Сумма крови и тромб-в до предыдущей пятницы]![Объем цельной крови с цитофереза]) AS [Объем цельной крови], '
    + '([(Нужный) Подсчет комп и крови до предыдущей пятницы]![Объем консервированной крови]+  '
    + '[(Нужный) Сумма крови и плазмы АПА до предыдущей пятницы]![Объем консерв крови АПА]+ '
    + '[(Нужный) Сумма крови и тромб-в до предыдущей пятницы]![Объем консервированной крови с цитофереза]) AS [Объем конс крови], '
    + '([(Нужный) Подсчет комп и крови до предыдущей пятницы]![Объем плазмы]+ '
    + '[(Нужный) Сумма крови и плазмы АПА до предыдущей пятницы]![Объем плазмы АПА]) AS [Объем плазмы всего], '
    + '[(Нужный) Сумма крови и плазмы АПА до предыдущей пятницы]![Объем плазмы АПА] AS [Объем АПА], '
    + '[(Нужный) Подсчет комп и крови до предыдущей пятницы]![Объем Эр взвеси] AS [Объем эр сред], '
    + '([(Нужный) Подсчет комп и крови до предыдущей пятницы]![Объем цельной крови]+ '
    + '[(Нужный) Сумма крови и плазмы АПА до предыдущей пятницы]![Объем цельной крови АПА]+ '
    + '[(Нужный) Сумма крови и тромб-в до предыдущей пятницы]![Объем цельной крови с цитофереза])/ '
    + '[(Нужный) К еженедельному отчету план].ОЦК AS [Пр цельной крови], ' +
    '([(Нужный) Подсчет комп и крови до предыдущей пятницы]![Объем консервированной крови]+ '
    + '[(Нужный) Сумма крови и плазмы АПА до предыдущей пятницы]![Объем консерв крови АПА]+ '
    + '[(Нужный) Сумма крови и тромб-в до предыдущей пятницы]![Объем консервированной крови с цитофереза])/ '
    + '[(Нужный) К еженедельному отчету план].ОКК AS [Пр конс крови], ' +
    '([(Нужный) Подсчет комп и крови до предыдущей пятницы]![Объем плазмы]+ ' +
    '[(Нужный) Сумма крови и плазмы АПА до предыдущей пятницы]![Объем плазмы АПА])/ '
    + '[(Нужный) К еженедельному отчету план].ОП AS [Пр плазмы всего], ' +
    '[(Нужный) Сумма крови и плазмы АПА до предыдущей пятницы]![Объем плазмы АПА]/ '
    + '[(Нужный) К еженедельному отчету план].ОАПА AS [Пр плазма АПА], ' +
    '[(Нужный) Подсчет комп и крови до предыдущей пятницы]![Объем Эр взвеси]/ '
    + '[(Нужный) К еженедельному отчету план].ОЭВ AS [Пр эр среды], ' +
    '[(Нужный) Сумма крови и тромб-в до предыдущей пятницы]![Объем тромбоцитов] AS [Объем тромбоцитов], '
    + '[(Нужный) Сумма крови и тромб-в до предыдущей пятницы].[Sum-Sum-ДПЛТ] AS [Тромбо дозы], '
    + '[(Нужный) Сумма крови и тромб-в до предыдущей пятницы].[Sum-Sum-ПакТ] AS [Тромбо пакеты] '
    + 'FROM [(Нужный) Подсчет комп и крови до предыдущей пятницы], ' +
    '[(Нужный) Сумма крови и плазмы АПА до предыдущей пятницы], [(Нужный) Сумма крови и тромб-в до предыдущей пятницы], '
    + '[(Нужный) К ежедневному отчету план], [К недельному объем плазмы], ' +
    '[(Нужен) К недельному ОКДК], [(Нужный) К еженедельному отчету план];';
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

function TBRWIncompleteWeekFirstTable.GetValueLitr(i: integer): string;

begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempArray[i] / 1000));
end;

function TBRWIncompleteWeekFirstTable.GetValuePlan(i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempArray[i]));
end;

function TBRWIncompleteWeekFirstTable.GetValuePercent(i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i] / 10)) + '%';
end;

function TBRWIncompleteWeekFirstTable.GetValueTromboPacketsDoses
  (i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i]));
end;

end.
