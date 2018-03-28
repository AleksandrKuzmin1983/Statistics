unit BRDDailyReportToTheKray;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRDDailyReportToTheKray = interface
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

  TBRDDailyReportToTheKray = class(TInterfacedObject, IBRDDailyReportToTheKray)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
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

constructor TBRDDailyReportToTheKray.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
end;

procedure TBRDDailyReportToTheKray.GetSQL(CSQL: String);

begin
  Try
    With TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add(CSQL);
      Open;
      TempValue := CheckNull.CheckedValue(TempQuery.Fields[0].value);
      Close;
    end;
  Except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

function TBRDDailyReportToTheKray.GetPercentWholeBlood: string;
begin
  TempSQL :=
    'SELECT (([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем цельной крови]+'
    + '[(Нужный) Сумма крови и плазмы АПА]![Объем цельной крови АПА]+' +
    '[(Нужный) Сумма крови и тромб-в]![Объем цельной крови с цитофереза])/1000)/[Plans]![ОЦК] AS [Пр цельной] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], [(Нужный) Сумма крови и плазмы АПА], '
    + '[(Нужный) К ежедневному отчету план], [(Нужный) К ежедневному отчету (календарь)], '
    + '[(Нужный) Сумма крови и тромб-в];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDailyReportToTheKray.GetVolumeWholeBlood: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем цельной крови]+'
    + '[(Нужный) Сумма крови и плазмы АПА]![Объем цельной крови АПА]+' +
    '[(Нужный) Сумма крови и тромб-в]![Объем цельной крови с цитофереза])/1000 AS [Объем цельной крови] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], [(Нужный) Сумма крови и плазмы АПА], '
    + '[(Нужный) Сумма крови и тромб-в];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDailyReportToTheKray.GetPercentConsBlood: string;
begin
  TempSQL :=
    'SELECT (([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем консервированной крови]+'
    + '[(Нужный) Сумма крови и плазмы АПА]![Объем консерв крови АПА]+' +
    '[(Нужный) Сумма крови и тромб-в]![Объем консервированной крови с цитофереза])/1000)/[Plans]![ОКК] AS [Пр консервированной] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], ' +
    '[(Нужный) Сумма крови и плазмы АПА], [(Нужный) К ежедневному отчету план], '
    + '[(Нужный) К ежедневному отчету (календарь)], [(Нужный) Сумма крови и тромб-в];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDailyReportToTheKray.GetVolumeConsBlood: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем консервированной крови]+'
    + '[(Нужный) Сумма крови и плазмы АПА]![Объем консерв крови АПА]+' +
    '[(Нужный) Сумма крови и тромб-в]![Объем консервированной крови с цитофереза])/1000 AS [Объем консервированной крови] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], ' +
    '[(Нужный) Сумма крови и плазмы АПА], [(Нужный) Сумма крови и тромб-в];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDailyReportToTheKray.GetPercentPlasmaTotal: string;
begin
  TempSQL :=
    'SELECT (([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем плазмы]+'
    + '[(Нужный) Сумма крови и плазмы АПА]![Объем плазмы АПА])/1000)/[Plans]![ОП] AS [Пр плазмы] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], ' +
    '[(Нужный) Сумма крови и плазмы АПА], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDailyReportToTheKray.GetVolumePlasmaTotal: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем плазмы]+'
    + '[(Нужный) Сумма крови и плазмы АПА]![Объем плазмы АПА])/1000 AS [Объем плазмы] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], [(Нужный) Сумма крови и плазмы АПА] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDailyReportToTheKray.GetPercentPlasmaAPA: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Сумма крови и плазмы АПА]![Объем плазмы АПА]/1000)/[Plans]![ОАПА] AS [Пр плазмы] '
    + 'FROM [(Нужный) Сумма крови и плазмы АПА], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDailyReportToTheKray.GetVolumePlasmaAPA: string;
begin
  TempSQL :=
    'SELECT [(Нужный) Сумма крови и плазмы АПА]![Объем плазмы АПА]/1000 AS [Объем плазмы] '
    + 'FROM [(Нужный) Сумма крови и плазмы АПА] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDailyReportToTheKray.GetPercentErSusp: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем Эр взвеси]/1000)/[(Нужный) К ежедневному отчету план]![ОЭВ] AS [Пр эр взвесь] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDailyReportToTheKray.GetVolumeErSusp: string;
begin
  TempSQL :=
    'SELECT [(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем Эр взвеси]/1000 AS [Объем эр взвеси] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDailyReportToTheKray.GetVolumeTrombo: string;
begin
  TempSQL :=
    'SELECT [(Нужный) Сумма крови и тромб-в]![Объем тромбоцитов]/1000 AS [Объем тромбоцитов] '
    + 'FROM [(Нужный) Сумма крови и тромб-в]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDailyReportToTheKray.GetNumberDosesTromb: string;
begin
  TempSQL := 'SELECT [(Нужный) Сумма крови и тромб-в].[Кол-во доз тромбо] ' +
    'FROM [(Нужный) Сумма крови и тромб-в]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue)) + ' д.';
end;

function TBRDDailyReportToTheKray.GetNumberPacketsTromb: string;
begin
  TempSQL := 'SELECT [(Нужный) Сумма крови и тромб-в].[Кол-во пакетов] ' +
    'FROM [(Нужный) Сумма крови и тромб-в]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue)) + ' пак.';
end;

end.
