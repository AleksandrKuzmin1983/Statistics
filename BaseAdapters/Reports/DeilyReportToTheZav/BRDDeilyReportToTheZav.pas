unit BRDDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRDDeilyReportToTheZav = interface
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

  TBRDDeilyReportToTheZav = class(TInterfacedObject, IBRDDeilyReportToTheZav)
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

constructor TBRDDeilyReportToTheZav.create;
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

procedure TBRDDeilyReportToTheZav.GetSQL(CSQL: String);

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

function TBRDDeilyReportToTheZav.GetPercentWholeBlood: string;
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

function TBRDDeilyReportToTheZav.GetVolumeWholeBlood: string;
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

function TBRDDeilyReportToTheZav.GetPercentConsBlood: string;
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

function TBRDDeilyReportToTheZav.GetVolumeConsBlood: string;
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

function TBRDDeilyReportToTheZav.GetPercentPlasmaTotal: string;
begin
  TempSQL :=
    'SELECT (([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем плазмы]+'
    + '[(Нужный) Сумма крови и плазмы АПА]![Объем плазмы АПА])/1000)/[Plans]![ОП] AS [Пр плазмы] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], ' +
    '[(Нужный) Сумма крови и плазмы АПА], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDeilyReportToTheZav.GetVolumePlasmaTotal: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем плазмы]+'
    + '[(Нужный) Сумма крови и плазмы АПА]![Объем плазмы АПА])/1000 AS [Объем плазмы] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], [(Нужный) Сумма крови и плазмы АПА] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDeilyReportToTheZav.GetPercentPlasmaAPA: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Сумма крови и плазмы АПА]![Объем плазмы АПА]/1000)/[Plans]![ОАПА] AS [Пр плазмы] '
    + 'FROM [(Нужный) Сумма крови и плазмы АПА], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDeilyReportToTheZav.GetVolumePlasmaAPA: string;
begin
  TempSQL :=
    'SELECT [(Нужный) Сумма крови и плазмы АПА]![Объем плазмы АПА]/1000 AS [Объем плазмы] '
    + 'FROM [(Нужный) Сумма крови и плазмы АПА] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDeilyReportToTheZav.GetPercentErSusp: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем Эр взвеси]/1000)/[(Нужный) К ежедневному отчету план]![ОЭВ] AS [Пр эр взвесь] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDDeilyReportToTheZav.GetVolumeErSusp: string;
begin
  TempSQL :=
    'SELECT [(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем Эр взвеси]/1000 AS [Объем эр взвеси] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDeilyReportToTheZav.GetVolumeTrombo: string;
begin
  TempSQL :=
    'SELECT [(Нужный) Сумма крови и тромб-в]![Объем тромбоцитов]/1000 AS [Объем тромбоцитов] '
    + 'FROM [(Нужный) Сумма крови и тромб-в]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDDeilyReportToTheZav.GetNumberDosesTromb: string;
begin
  TempSQL := 'SELECT [(Нужный) Сумма крови и тромб-в].[Кол-во доз тромбо] ' +
    'FROM [(Нужный) Сумма крови и тромб-в]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue)) + ' д.';
end;

function TBRDDeilyReportToTheZav.GetNumberPacketsTromb: string;
begin
  TempSQL := 'SELECT [(Нужный) Сумма крови и тромб-в].[Кол-во пакетов] ' +
    'FROM [(Нужный) Сумма крови и тромб-в]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue)) + ' пак.';
end;

end.
