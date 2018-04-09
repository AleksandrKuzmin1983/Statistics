unit BRWSecondTable;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWSecondTable = interface
    function GetProductWholeBlood: string;
    function GetVolumeReinfusion: string;
    function GetPreparedFitProductionErSuspFiltr: string;
    function GetPreparedFitProductionErSusp: string;
    function GetPreparedFitProductionSZP: string;
    function GetOutingProductWholeBlood: string;
    function GetOutingPreparedFitProductionErSuspFiltr: string;
    function GetOutingPreparedFitProductionErSusp: string;
    function GetOutingPreparedFitProductionSZP: string;
  end;

  TBRWSecondTable = class(TInterfacedObject, IBRWSecondTable)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempValue: Real;
    TempSQL: String;
    procedure GetSQL(CSQL: String);
  public
    function GetProductWholeBlood: string;
    function GetVolumeReinfusion: string;
    function GetPreparedFitProductionErSuspFiltr: string;
    function GetPreparedFitProductionErSusp: string;
    function GetPreparedFitProductionSZP: string;
    function GetOutingProductWholeBlood: string;
    function GetOutingPreparedFitProductionErSuspFiltr: string;
    function GetOutingPreparedFitProductionErSusp: string;
    function GetOutingPreparedFitProductionSZP: string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRWSecondTable.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.create выполнена');
end;

procedure TBRWSecondTable.GetSQL(CSQL: String);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.GetSQL выполнена');
end;

function TBRWSecondTable.GetProductWholeBlood: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Подсчет комп и крови за пред неделю]![Объем цельной крови]+ '
    + '[(Нужный) Сумма крови и плазмы АПА за пред неделю]![Объем цельной крови АПА]+ '
    + '[(Нужный) Сумма крови и тромб-в за пред неделю]![Объем цельной крови с цитофереза])/1000 '
    + 'AS [Заготовка цел крови за неделю] ' +
    'FROM [(Нужный) Подсчет комп и крови за пред неделю], ' +
    '[(Нужный) Сумма крови и плазмы АПА за пред неделю], ' +
    '[(Нужный) Сумма крови и тромб-в за пред неделю];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.GetProductWholeBlood выполнена', result);
end;

function TBRWSecondTable.GetVolumeReinfusion: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Сумма крови и плазмы АПА за пред неделю]![Объем консерв крови АПА]+'
    + '[(Нужный) Сумма крови и тромб-в за пред неделю]![Объем консервированной крови с цитофереза])/1000-'
    + '([(Нужный) Сумма крови и плазмы АПА за пред неделю]![Объем плазмы АПА]+'
    + '[(Нужный) Сумма крови и тромб-в за пред неделю]![Объем тромбоцитов])/1000 AS [Реинфузия за неделю] '
    + 'FROM [(Нужный) Сумма крови и плазмы АПА за пред неделю], ' +
    '[(Нужный) Сумма крови и тромб-в за пред неделю];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTable.GetVolumeReinfusion выполнена', result);
end;

function TBRWSecondTable.GetPreparedFitProductionErSuspFiltr: string;
begin
  TempSQL :=
    'SELECT [Произведено годной Эр вз 1]![Sum-ПГЭС]/1000 AS [Эр вз (010)] ' +
    'FROM [Произведено годной Эр вз 1];';
  GetSQL(TempSQL);
  result := 'Эр вз фил - ' + VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTable.GetPreparedFitProductionErSuspFiltr выполнена', result);
end;

function TBRWSecondTable.GetPreparedFitProductionErSusp: string;
begin
  TempSQL :=
    'SELECT [Произведено годной Эр вз 2]![Sum-ПГЭС]/1000 AS [Эр вз (008)] ' +
    'FROM [Произведено годной Эр вз 2];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
  if result = '0,000' then
    result := ''
  else
    result := 'Эр вз - ' + result;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTable.GetPreparedFitProductionErSusp выполнена', result);
end;

function TBRWSecondTable.GetPreparedFitProductionSZP: string;
begin
  TempSQL :=
    'SELECT ([(Нужный) Подсчет комп и крови за пред неделю]![Объем плазмы]+' +
    '[(Нужный) Сумма крови и плазмы АПА за пред неделю]![Объем плазмы АПА]-' +
    '[К недельному объем плазмы]![Sum-БПО])/1000 AS [Произведено годной плазмы] '
    + 'FROM [(Нужный) Подсчет комп и крови за пред неделю], ' +
    '[(Нужный) Сумма крови и плазмы АПА за пред неделю], [К недельному объем плазмы];';
  GetSQL(TempSQL);
  result := 'СЗП - ' + VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWSecondTable.GetPreparedFitProductionSZP выполнена', result);
end;

//
function TBRWSecondTable.GetOutingProductWholeBlood: string;
begin
  TempSQL := 'SELECT Sum(Blood.ЦелК)/1000 AS [Sum-ЦелК] ' +
    'FROM Blood INNER JOIN FactoryCal ON Blood.ДатаК = FactoryCal.День ' +
    'WHERE (((Blood.Выезд)=True) ' +
    'AND ((Year([blood].[ДатаК]))=Year(Now())) ' +
    'AND ((FactoryCal.День)<=Date()-Weekday(Date())+1 ' +
    'And (FactoryCal.День)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  if TempValue = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.GetOutingProductWholeBlood выполнена', result);
end;

function TBRWSecondTable.GetOutingPreparedFitProductionErSuspFiltr: string;
begin
  TempSQL := 'SELECT Sum(Exped.ПГЭС)/1000 AS [Sum-ПГЭС] ' + 'FROM Exped ' +
    'WHERE (((Exped.НС)=(select ShortName from NameProducts where NameProducts.id=5) '
    + 'Or (Exped.НС)="None") AND ((Exped.ДАТАЛЗ)<=Date()-Weekday(Date())+1 ' +
    'And (Exped.ДАТАЛЗ)>=Date()-Weekday(Date())-5) AND ((Exped.Выезд)=True)) ' +
    'OR (((Exped.ДАТАЛЗ)=#1/1/2015#));';
  GetSQL(TempSQL);
  if TempValue = 0 then
    result := ' '
  else
    result := 'Эр вз фил - ' + VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.GetOutingPreparedFitProductionErSuspFiltr выполнена', result);
end;

function TBRWSecondTable.GetOutingPreparedFitProductionErSusp: string;
begin
  TempSQL := 'SELECT Sum(Exped.ПГЭС)/1000 AS [Sum-ПГЭС] ' + 'FROM Exped ' +
    'WHERE (((Exped.НС)=(select ShortName from NameProducts where NameProducts.id=4) '
    + 'Or (Exped.НС)="None") AND ((Exped.ДАТАЛЗ)<=Date()-Weekday(Date())+1 ' +
    'And (Exped.ДАТАЛЗ)>=Date()-Weekday(Date())-5) AND ((Exped.Выезд)=True)) ' +
    'OR (((Exped.ДАТАЛЗ)=#1/1/2015#));';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
  if TempValue = 0 then
    result := ' '
  else
    result := 'Эр вз - ' + result;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.GetOutingPreparedFitProductionErSusp выполнена', result);
end;

function TBRWSecondTable.GetOutingPreparedFitProductionSZP: string;
begin
  TempSQL := 'SELECT Sum(BloodPlasma.КПЛ)/1000 AS [Sum-КПЛ] ' +
    'FROM (((Blood INNER JOIN BloodDoza ON Blood.ДатаК = BloodDoza.ДатаК) ' +
    'INNER JOIN BloodErSusp ON BloodDoza.КодД = BloodErSusp.Код) ' +
    'INNER JOIN BloodPlasma ON BloodErSusp.Код = BloodPlasma.КодЭ) ' +
    'INNER JOIN FactoryCal ON Blood.ДатаК = FactoryCal.День ' +
    'WHERE (((Blood.Выезд)=True) AND ((Year([blood].[ДатаК]))=Year(Now())) ' +
    'AND ((FactoryCal.День)<=Date()-Weekday(Date())+1 ' +
    'And (FactoryCal.День)>=Date()-Weekday(Date())-5));';
  GetSQL(TempSQL);
  if TempValue = 0 then
    result := ' '
  else
    result := 'СЗП - ' + VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWResultsOfTheProducts.GetOutingPreparedFitProductionSZP выполнена', result);
end;

end.
