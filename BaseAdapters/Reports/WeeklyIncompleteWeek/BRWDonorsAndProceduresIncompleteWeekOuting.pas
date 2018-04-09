unit BRWDonorsAndProceduresIncompleteWeekOuting;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRWDonorsAndProceduresIncompleteWeekOuting = interface
    function GetValue(i: integer): string;
  end;

  TBRWDonorsAndProceduresIncompleteWeekOuting = class(TInterfacedObject,
    IBRWDonorsAndProceduresIncompleteWeekOuting)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempArray: array of real;
    CSQL: String;
  public
    function GetValue(i: integer): string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRWDonorsAndProceduresIncompleteWeekOuting.create;
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
  CSQL := 'SELECT TOP 1 (SELECT NewOKDK.Numb ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) '
    + 'ON TypesOfTaps.Id = Taps.TypeOfTap  WHERE (((TypesOfTaps.Id)=5)) and ((NewOKDK.Outing)=true) '
    + 'And ((NewOKDK.DateTap)<=Date()-Weekday(Date())+1  And (NewOKDK.DateTap)>=Date()-Weekday(Date())-5)) '
    + 'AS [Обратилось всего], (SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ' +
    'ON Taps.NameTap = NewOKDK.Tap) ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) '
    + 'and ((NewOKDK.Outing)=true) AND ((TypesOfTaps.Id)=1 Or (TypesOfTaps.Id)=2))) '
    + 'AS [Отведено всего], (SELECT Sum(NewOKDK.Numb) ' +
    'AS [Sum-Numb] FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ' +
    'ON Taps.NameTap = NewOKDK.Tap)  ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) ' +
    'And (Date()-Weekday(Date())+1)) and ((NewOKDK.Outing)=true) ' +
    'AND ((TypesOfTaps.Id)=1))) AS [Отведено по предвар анализам], ' +
    '[Обратилось всего]-[Отведено всего]-(SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] '
    + 'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) '
    + 'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) '
    + 'and ((NewOKDK.Outing)=true)  AND ((TypesOfTaps.Id)=4))) ' +
    'AS [Допущено всего], [Количество процедур крови за неделю (выезд)]![Проц крови за неделю] '
    + 'AS [Процедур всего], [Количество процедур крови за неделю (выезд)]![Проц крови за неделю] '
    + 'AS [Процедур крови всего], (SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) '
    + 'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) '
    + 'and ((NewOKDK.Outing)=true) AND ((TypesOfTaps.Id)=3))) AS [Не взято] ' +
    'FROM [Количество процедур крови за неделю (выезд)], ' +
    'TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) '
    + 'ON TypesOfTaps.Id = Taps.TypeOfTap;';
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWDonorsAndProceduresIncompleteWeekOuting.create выполнена');
end;

function TBRWDonorsAndProceduresIncompleteWeekOuting.GetValue
  (i: integer): string;
begin
  if TempArray[i] = 0 then
    result := ' '
  else
    result := VarToStr(FormatFloat('0', TempArray[i]));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRWDonorsAndProceduresIncompleteWeekOuting.GetValue выполнена', result);
end;

end.
