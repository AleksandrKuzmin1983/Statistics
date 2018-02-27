unit MRWDonorsAndProceduresIncompleteWeekOuting;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;
type
  IMRWDonorsAndProceduresIncompleteWeekOuting = interface
    function GetValue(i: integer): string;
  end;

  TMRWDonorsAndProceduresIncompleteWeekOuting = class(TInterfacedObject, IMRWDonorsAndProceduresIncompleteWeekOuting)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
    TempArray: array of real;
    TempValue: Real;
    TempSQL: String;
    CSQL: String;
  public
    function GetValue(i: integer): string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TMRWDonorsAndProceduresIncompleteWeekOuting.create;
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
    'SELECT TOP 1 (SELECT NewOKDK.Numb ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ' +
    'ON TypesOfTaps.Id = Taps.TypeOfTap  WHERE (((TypesOfTaps.Id)=5)) and ((NewOKDK.Outing)=true) ' +
    'And ((NewOKDK.DateTap)<=Date()-Weekday(Date())+1  And (NewOKDK.DateTap)>=Date()-Weekday(Date())-5)) ' +
    'AS [Обратилось всего], (SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ' +
    'ON Taps.NameTap = NewOKDK.Tap) ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) ' +
    'and ((NewOKDK.Outing)=true) AND ((TypesOfTaps.Id)=1 Or (TypesOfTaps.Id)=2))) ' +
    'AS [Отведено всего], (SELECT Sum(NewOKDK.Numb) ' +
    'AS [Sum-Numb] FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ' +
    'ON Taps.NameTap = NewOKDK.Tap)  ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) ' +
    'And (Date()-Weekday(Date())+1)) and ((NewOKDK.Outing)=true) ' +
    'AND ((TypesOfTaps.Id)=1))) AS [Отведено по предвар анализам], ' +    '[Обратилось всего]-[Отведено всего]-(SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] ' +    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ' +
    'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) ' +
    'and ((NewOKDK.Outing)=true)  AND ((TypesOfTaps.Id)=4))) ' +
    'AS [Допущено всего], [Количество процедур крови за неделю (выезд)]![Проц крови за неделю] ' +
    'AS [Процедур всего], [Количество процедур крови за неделю (выезд)]![Проц крови за неделю] ' +
    'AS [Процедур крови всего], (SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ' +
    'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) ' +
    'and ((NewOKDK.Outing)=true) AND ((TypesOfTaps.Id)=3))) AS [Не взято] ' +
    'FROM [Количество процедур крови за неделю (выезд)], ' +
    'TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ' +
    'ON TypesOfTaps.Id = Taps.TypeOfTap;';
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

function TMRWDonorsAndProceduresIncompleteWeekOuting.GetValue(i: integer): string;
begin
  if TempArray[i]=0 then result:=' ' else result:=VarToStr(FormatFloat('0',TempArray[i]));
end;

end.
