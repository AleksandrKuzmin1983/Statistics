unit MRWDonorsAndProceduresIncompleteWeek;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;
type
  IMRWDonorsAndProceduresIncompleteWeek = interface
    function GetValue(i: integer): string;
  end;

  TMRWDonorsAndProceduresIncompleteWeek = class(TInterfacedObject, IMRWDonorsAndProceduresIncompleteWeek)
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

constructor TMRWDonorsAndProceduresIncompleteWeek.create;
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
    'SELECT TOP 1 ' +

    '(SELECT NewOKDK.Numb ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ' +
    'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((TypesOfTaps.Id)=5)) and ((NewOKDK.Outing)=false) And ((NewOKDK.DateTap)<=Date()-Weekday(Date())+1 ' +
    'And (NewOKDK.DateTap)>=Date()-Weekday(Date())-5)) AS [Обратилось всего], ' +

    '(SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ' +
    'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) ' +
    'AND ((TypesOfTaps.Id)=1 Or (TypesOfTaps.Id)=2)) and ((NewOKDK.Outing)=false)) AS [Отведено всего], ' +

    '(SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ' +
    'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) ' +
    'AND ((TypesOfTaps.Id)=1) and ((NewOKDK.Outing)=false))) AS [Отведено по предвар анализам], ' +

    '[Обратилось всего]-[Отведено всего]- ' +
    '(SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ' +
    'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) ' +
    'AND ((TypesOfTaps.Id)=4) and ((NewOKDK.Outing)=false))) AS [Допущено всего], ' +

    '[Процедур крови всего]+[Плазмодач всего] AS [Процедур всего], ' +

    '[Кол-во процедур крови за неделю]![Проц крови за неделю] AS [Процедур крови всего], ' +

    '[Кол-во процедур плазмы в неделю]![Кол-во проц плазмы в неделю]+ ' +

    '[Кол-во проц тромбо в неделю]![Кол-во проц тромбо в неделю] AS [Плазмодач всего], ' +

    '[Кол-во процедур плазмы в неделю]![Кол-во проц плазмы в неделю] AS [Процедур АПА], ' +

    '[Кол-во проц тромбо в неделю]![Кол-во проц тромбо в неделю] AS [Процедур Тромбо], ' +

    '(SELECT Top 1 [Кол-во процедур крови за неделю]![Проц крови за неделю]+ ' +
    '[Кол-во процедур плазмы в неделю]![Кол-во проц плазмы в неделю]+ ' +
    '[Кол-во проц тромбо в неделю]![Кол-во проц тромбо в неделю] + ' +
    '((SELECT Sum(NewOKDK.Numb) AS [Sum-Numb] ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap) Between (Date()-Weekday(Date())-5) And (Date()-Weekday(Date())+1)) ' +
    'AND ((TypesOfTaps.Id)=3) and ((NewOKDK.Outing)=false)))) AS [Процедур всего] ' +
    'FROM [Кол-во процедур крови за неделю], [Кол-во процедур плазмы в неделю], [Кол-во проц тромбо в неделю], ' +
    'TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ON TypesOfTaps.Id = Taps.TypeOfTap) ' +

    'FROM [Кол-во процедур крови за неделю], [Кол-во процедур плазмы в неделю], ' +
    '[Кол-во проц тромбо в неделю], TypesOfTaps INNER JOIN ' +
    '(Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) ON TypesOfTaps.Id = Taps.TypeOfTap;';
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

function TMRWDonorsAndProceduresIncompleteWeek.GetValue(i: integer): string;
begin
  result:=VarToStr(FormatFloat('0',TempArray[i]));
end;
end.
