unit BRDStatInfoDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRDStatInfoDeilyReportToTheZav = interface
    function GetBloodNumberProceduresDone: string;
    function GetBloodRestImplementationOfThePlan: string;
    function GetBloodPercentageOfPlanProcedures: string;
    function GetBloodTheNumberOfTreatmentsPerDay: string;
    function GetBloodTheNumberOfTreatmentsPerDayWholeBlood: string;
    function GetBloodNumberWholeBloodAtTheMomentToMatchThePlan: string;
    function GetPlasmaNumberProceduresDone: string;
    function GetPlasmaRestImplementationOfThePlan: string;
    function GetPlasmaPercentageOfPlanProcedures: string;
    function GetPlasmaTheNumberOfTreatmentsPerDay: string;
    function GetTromboNumberProceduresDone: string;
    function GetTromboRestImplementationOfThePlan: string;
    function GetTromboPercentageOfPlanProcedures: string;
    function GetTromboTheNumberOfTreatmentsPerDay: string;
    function GetBloodTheNumberOfTreatmentsPerDayErSusp: string;
  end;

  TBRDStatInfoDeilyReportToTheZav = class(TInterfacedObject,
    IBRDStatInfoDeilyReportToTheZav)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempValue: Real;
    TempSQL: String;
    procedure GetSQL(CSQL: String);
  public
    function GetBloodNumberProceduresDone: string;
    function GetBloodRestImplementationOfThePlan: string;
    function GetBloodPercentageOfPlanProcedures: string;
    function GetBloodTheNumberOfTreatmentsPerDay: string;
    function GetBloodTheNumberOfTreatmentsPerDayWholeBlood: string;
    function GetBloodNumberWholeBloodAtTheMomentToMatchThePlan: string;
    function GetPlasmaNumberProceduresDone: string;
    function GetPlasmaRestImplementationOfThePlan: string;
    function GetPlasmaPercentageOfPlanProcedures: string;
    function GetPlasmaTheNumberOfTreatmentsPerDay: string;
    function GetTromboNumberProceduresDone: string;
    function GetTromboRestImplementationOfThePlan: string;
    function GetTromboPercentageOfPlanProcedures: string;
    function GetTromboTheNumberOfTreatmentsPerDay: string;
    function GetBloodTheNumberOfTreatmentsPerDayErSusp: string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRDStatInfoDeilyReportToTheZav.create;
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

procedure TBRDStatInfoDeilyReportToTheZav.GetSQL(CSQL: String);

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

function TBRDStatInfoDeilyReportToTheZav.GetBloodNumberProceduresDone: string;
begin
  TempSQL :=
    'SELECT [(Нужный) Подсчет компонентов и крови за текущий месяц].[Кол-во процедур крови] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodRestImplementationOfThePlan: string;
begin
  TempSQL :=
    'SELECT [Plans]![КПК]-[(Нужный) Подсчет компонентов и крови за текущий месяц]'
    + '![Кол-во процедур крови] AS [Остаток до плана по процедурам крови]' +
    'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodPercentageOfPlanProcedures: string;
begin
  TempSQL := 'SELECT ([(Нужный) Подсчет компонентов и крови за текущий месяц]' +
    '![Кол-во процедур крови])/([Plans]![КПК]) AS [% процедур крови] ' +
    'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodTheNumberOfTreatmentsPerDay: string;
begin
  TempSQL :=
    'SELECT IIf(([Plans]![КРД]-[(Нужный) К ежедневному отчету (календарь)]' +
    '![Кол-во отработанных дней в текущем месяце])=0,([Plans]![КПК]-[(Нужный) Подсчет компонентов и крови за текущий месяц]'
    + '![Кол-во процедур крови])/1,([Plans]![КПК]-[(Нужный) Подсчет компонентов и крови за текущий месяц]'
    + '![Кол-во процедур крови])/([Plans]![КРД]-[(Нужный) К ежедневному отчету (календарь)]'
    + '![Кол-во отработанных дней в текущем месяце])) AS [Кол-во необходимых процедур в день] '
    + 'FROM [(Нужный) Подсчет компонентов и крови за текущий месяц], ' +
    '[(Нужный) К ежедневному отчету план], [(Нужный) К ежедневному отчету (календарь)]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodTheNumberOfTreatmentsPerDayWholeBlood: string;
begin
  TempSQL :=
    'SELECT IIf([(Нужный) К ежедневному отчету план]![КРД]=[(Нужный) К ежедневному отчету (календарь)]![Кол-во отработанных дней в текущем месяце],'
    + '999,IIf(([(Нужный) К ежедневному отчету план]![ОЦК]-' +
  // 999 - "План не выполнен!"
    '[VolumeWholeBloodPerMomentMonth]![Объем цельной крови]-1.4*' +
    '([PlasmaRestImplementationOfThePlan]![Остаток по процедурам до плана АПА]))<0,'
    + '0,([(Нужный) К ежедневному отчету план]![ОЦК]-' +
    '[VolumeWholeBloodPerMomentMonth]![Объем цельной крови]-1.4*' +
    '([PlasmaRestImplementationOfThePlan]![Остаток по процедурам до плана АПА]))/'
    + '(0.47*([(Нужный) К ежедневному отчету план]![КРД]-' +
    '[(Нужный) К ежедневному отчету (календарь)]![Кол-во отработанных дней в текущем месяце])))) '
    + 'AS [Кол-во проц от плана крови] ' +
    'FROM [(Нужный) К ежедневному отчету план], [(Нужный) К ежедневному отчету (календарь)], '
    + 'VolumeWholeBloodPerMomentMonth, PlasmaRestImplementationOfThePlan;';
  GetSQL(TempSQL);
  if TempValue = 999 then
    result := 'План не выполнен!'
  else
    result := VarToStr(FormatFloat('0.0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodNumberWholeBloodAtTheMomentToMatchThePlan: string;
begin
  TempSQL :=
    'SELECT ([Plans]![ОЦК]/[Plans]![КРД])*([(Нужный) К ежедневному отчету (календарь)]'
    + '![Кол-во отработанных дней в текущем месяце]) AS TargetValue ' +
    'FROM [(Нужный) К ежедневному отчету (календарь)], Plans ' +
    'WHERE (((Month([Plans].[ДатаПлан]))=Month(Now())) AND ((Year([Plans].[ДатаПлан]))=Year(Now())));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.GetPlasmaNumberProceduresDone: string;
begin
  TempSQL :=
    'SELECT [(Нужный) Сумма крови и плазмы АПА].[Кол-во процедур плазмы] ' +
    'FROM [(Нужный) Сумма крови и плазмы АПА];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetPlasmaRestImplementationOfThePlan: string;
begin
  TempSQL := 'SELECT IIf(([Plans]![КПП]-[(Нужный) Сумма крови и плазмы АПА]' +
    '![Кол-во процедур плазмы]<0),0,[Plans]![КПП]-[(Нужный) Сумма крови и плазмы АПА]'
    + '![Кол-во процедур плазмы]) AS [Остаток по процедурам до плана АПА] ' +
    'FROM [(Нужный) Сумма крови и плазмы АПА], [(Нужный) К ежедневному отчету план] ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetPlasmaPercentageOfPlanProcedures: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Сумма крови и плазмы АПА]![Кол-во процедур плазмы])/([Plans]![КПП]) AS [% процедур плазмы] '
    + 'FROM [(Нужный) Сумма крови и плазмы АПА], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100)) + '%';
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetPlasmaTheNumberOfTreatmentsPerDay: string;
begin
  TempSQL := 'SELECT IIf([Plans]![КПП]-[(Нужный) Сумма крови и плазмы АПА]' +
    '![Кол-во процедур плазмы]<0,0,IIf(([Plans]![КРД]-[(Нужный) К ежедневному отчету (календарь)]'
    + '![Кол-во отработанных дней в текущем месяце])=0,([Plans]![КПП]-[(Нужный) Сумма крови и плазмы АПА]'
    + '![Кол-во процедур плазмы])/1,([Plans]![КПП]-[(Нужный) Сумма крови и плазмы АПА]'
    + '![Кол-во процедур плазмы])/([Plans]![КРД]-[(Нужный) К ежедневному отчету (календарь)]'
    + '![Кол-во отработанных дней в текущем месяце]))) AS [Кол-во необходимых процедур АПА в день] '
    + 'FROM [(Нужный) Сумма крови и плазмы АПА], [(Нужный) К ежедневному отчету план], '
    + '[(Нужный) К ежедневному отчету (календарь)];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.GetTromboNumberProceduresDone: string;
begin
  TempSQL :=
    'SELECT [(Нужный) Сумма крови и тромб-в].[Кол-во процедур цитофереза] ' +
    'FROM [(Нужный) Сумма крови и тромб-в]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetTromboRestImplementationOfThePlan: string;
begin
  TempSQL :=
    'SELECT [Plans]![КПТ]-[(Нужный) Сумма крови и тромб-в]![Кол-во процедур цитофереза] AS [Остаток по процедурам тромбо] '
    + 'FROM [(Нужный) К ежедневному отчету план], [(Нужный) Сумма крови и тромб-в]; ';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetTromboPercentageOfPlanProcedures: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Сумма крови и тромб-в]![Кол-во процедур цитофереза])/([Plans]![КПТ]) AS [% процедур тромбо] '
    + 'FROM [(Нужный) Сумма крови и тромб-в], [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue * 100) + '%');
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetTromboTheNumberOfTreatmentsPerDay: string;
begin
  TempSQL :=
    'SELECT IIf(([Plans]![КРД]-[(Нужный) К ежедневному отчету (календарь)]' +
    '![Кол-во отработанных дней в текущем месяце])=0,([Plans]![КПТ]-[(Нужный) Сумма крови и тромб-в]'
    + '![Кол-во процедур цитофереза])/1,([Plans]![КПТ]-[(Нужный) Сумма крови и тромб-в]'
    + '![Кол-во процедур цитофереза])/([Plans]![КРД]-[(Нужный) К ежедневному отчету (календарь)]'
    + '![Кол-во отработанных дней в текущем месяце])) AS [Кол-во необх-х процедур тромбо] '
    + 'FROM [(Нужный) К ежедневному отчету план], [(Нужный) К ежедневному отчету (календарь)], '
    + '[(Нужный) Сумма крови и тромб-в];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.0', TempValue));
end;

function TBRDStatInfoDeilyReportToTheZav.
  GetBloodTheNumberOfTreatmentsPerDayErSusp: string;
begin
  TempSQL := 'SELECT (([(Нужный) К ежедневному отчету план]![ОЭВ]*1000-' +
    '[(Нужный) Подсчет компонентов и крови за текущий месяц]![Объем Эр взвеси])/320)/'
    + 'IIf([(Нужный) К ежедневному отчету план]![КРД]-' +
    '[(Нужный) К ежедневному отчету (календарь)]![Кол-во отработанных дней в текущем месяце]=0,1,'
    + '[(Нужный) К ежедневному отчету план]![КРД]-' +
    '[(Нужный) К ежедневному отчету (календарь)]![Кол-во отработанных дней в текущем месяце]) AS [Искомая величина]'
    + 'FROM [(Нужный) К ежедневному отчету план], [(Нужный) Подсчет компонентов и крови за текущий месяц], '
    + '[(Нужный) К ежедневному отчету (календарь)];';
  GetSQL(TempSQL);
  if TempValue < 0 then
    result := 'План выполнен'
  else
    result := VarToStr(FormatFloat('0.0', TempValue));
end;

end.
