unit BRWCancellation_Kray;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;
type
  IMRWCancellation_Kray = interface
    function GetValueLitr(i: integer): string;
    function GetValueDoses(i: integer): string;
  end;

  TMRWCancellation_Kray = class(TInterfacedObject, IMRWCancellation_Kray)
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
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TMRWCancellation_Kray.create;
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
    'SELECT [Край 1]![Sum-ЛЗО] AS [Эр взвесь с ресусп р-ром, фильтрованная], ' +
    '[Край 2]![Sum-ЛЗО] AS [Эр взвесь с ресусп р-ром], [Край 3]![Sum-ЛЗО] AS [Эр взвесь с физио р-ром], ' +
    '[Край 4]![Sum-ЛЗО] AS [СЗП кар], [Край 5]![Sum-ЛЗО] AS [СЗП вирусинактив-я], ' +
    '[Край 6]![Sum-ЛЗО] AS [Криопреципитат зам], [Край 7]![Sum-ЛЗО] AS [Концентрат тромбоцитов], ' +
    '[Край 8]![Sum-ЛЗО] AS Перфторан, [Край 1].[Sum-ЛЗД] AS [Эр взвесь с ресусп р-ром, фильтрованная, д], ' +
    '[Край 2].[Sum-ЛЗД] AS [Эр взвесь с ресусп р-ром, д], [Край 3].[Sum-ЛЗД] AS [Эр взвесь с физио р-ром, д],  ' +
    '[Край 4].[Sum-ЛЗД] AS [СЗП кар, д], [Край 5].[Sum-ЛЗД] AS [СЗП вирусинактив-я, д], ' +
    '[Край 6].[Sum-ЛЗД] AS [Криопреципитат зам, д], [Край 7].[Sum-ЛЗД] AS [Концентрат тромбоцитов, д], ' +
    '[Край 8].[Sum-ЛЗД] AS [Перфторан, д], [Край сп 1]![Sum-ЛЗО] AS [Сп Эр взвесь с ресусп р-ром, фильтрованная], ' +
    '[Край сп 2]![Sum-ЛЗО] AS [Сп Эр взвесь с ресусп р-ром], [Край сп 3]![Sum-ЛЗО] AS [Сп Эр взвесь с физио р-ром],  ' +
    '[Край сп 4]![Sum-ЛЗО] AS [Сп СЗП кар], [Край сп 5]![Sum-ЛЗО] AS [Сп СЗП вирусинактив-я], ' +
    '[Край сп 6]![Sum-ЛЗО] AS [Сп Криопреципитат зам], [Край сп 7]![Sum-ЛЗО] AS [Сп Концентрат тромбоцитов], ' +
    '[Край сп 8]![Sum-ЛЗО] AS [Сп Перфторан], [Край сп 1].[Sum-ЛЗД] AS [Сп Эр взвесь с ресусп р-ром, фильтрованная, д], ' +
    '[Край сп 2].[Sum-ЛЗД] AS [Сп Эр взвесь с ресусп р-ром, д], [Край сп 3].[Sum-ЛЗД] AS [Сп Эр взвесь с физио р-ром, д],  ' +
    '[Край сп 4].[Sum-ЛЗД] AS [Сп СЗП кар, д], [Край сп 5].[Sum-ЛЗД] AS [Сп СЗП вирусинактив-я, д], ' +
    '[Край сп 6].[Sum-ЛЗД] AS [Сп Криопреципитат зам, д], [Край сп 7].[Sum-ЛЗД] AS [Сп Концентрат тромбоцитов, д], ' +
    '[Край сп 8].[Sum-ЛЗД] AS [Сп Перфторан, д] ' +
    'FROM [Край 1], [Край 2], [Край 3], [Край 4], [Край 5], [Край 6], [Край 7], ' +
    '[Край сп 1], [Край сп 2], [Край сп 3], [Край сп 4], [Край сп 5], [Край сп 6], [Край сп 7], [Край 8], [Край сп 8]; ';
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

function TMRWCancellation_Kray.GetValueLitr(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0.000',TempArray[i]/1000));
end;

function TMRWCancellation_Kray.GetValueDoses(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0',TempArray[i]));
end;
end.
