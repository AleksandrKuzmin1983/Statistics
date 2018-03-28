unit BRWMedicalExemptionsIncompleteWeek;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  TTempArray = record
    name: String;
    number: Integer;
    numberOuting: Integer;
  end;

  IBRWMedicalExemptionsIncompleteWeek = interface
    function GetValueName(i: Integer): string;
    function GetValueNumber(i: Integer): string;
    function GetValueOuting(i: Integer): string;
  end;

  TBRWMedicalExemptionsIncompleteWeek = class(TInterfacedObject,
    IBRWMedicalExemptionsIncompleteWeek)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempArray: array of TTempArray;
    TempArray2: array of string;
    TempArrayOuting: array of string;
    CSQL: String;
  public
    function GetValueName(i: Integer): string;
    function GetValueNumber(i: Integer): string;
    function GetValueOuting(i: Integer): string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRWMedicalExemptionsIncompleteWeek.create;
var
  i, j: Integer;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  CSQL := 'SELECT Taps.NameTap ' +
    'FROM TypesOfTaps INNER JOIN Taps ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((TypesOfTaps.Id)=1 Or (TypesOfTaps.Id)=2 Or (TypesOfTaps.Id)=4)) '
    + 'ORDER BY TypesOfTaps.Id, Taps.Код;';
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
  SetLength(TempArray, TempQuery.RecordCount);
  TempQuery.Recordset.MoveFirst;
  for i := 0 to TempQuery.RecordCount - 1 do
  begin
    TempArray[i].name :=
      VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
    TempArray[i].number := 0;
    TempArray[i].numberOuting := 0;
    TempQuery.Next;
  end;
  CSQL := 'SELECT Taps.NameTap, NewOKDK.Numb ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) '
    + 'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap)<=Date()-Weekday(Date())+1 And (NewOKDK.DateTap)>=Date()-Weekday(Date())-5) '
    + 'AND ((TypesOfTaps.Id)=1 Or (TypesOfTaps.Id)=2 Or (TypesOfTaps.Id)=4)) and (NewOKDK.Outing=false)'
    + 'ORDER BY Taps.NameTap;';
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
  if not TempQuery.IsEmpty then
  begin
    SetLength(TempArray2, TempQuery.RecordCount);
    TempQuery.First;
    for i := 0 to TempQuery.RecordCount - 1 do
    begin
      TempArray2[i] :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      TempQuery.Next;
    end;
    for i := 0 to Length(TempArray) - 1 do
    begin
      TempQuery.First;
      for j := 0 to Length(TempArray2) - 1 do
      begin
        if TempArray[i].name = TempArray2[j] then
          TempArray[i].number := CheckNull.CheckedValue
            (TempQuery.Fields[1].value);
        TempQuery.Next;
      end;
    end;
    TempQuery.Close;
  end;
  CSQL := 'SELECT Taps.NameTap, NewOKDK.Numb ' +
    'FROM TypesOfTaps INNER JOIN (Taps INNER JOIN NewOKDK ON Taps.NameTap = NewOKDK.Tap) '
    + 'ON TypesOfTaps.Id = Taps.TypeOfTap ' +
    'WHERE (((NewOKDK.DateTap)<=Date()-Weekday(Date())+1 And (NewOKDK.DateTap)>=Date()-Weekday(Date())-5) '
    + 'AND ((TypesOfTaps.Id)=1 Or (TypesOfTaps.Id)=2 Or (TypesOfTaps.Id)=4)) and (NewOKDK.Outing=true)'
    + 'ORDER BY Taps.NameTap;';
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
  if not TempQuery.IsEmpty then
  begin
    SetLength(TempArrayOuting, TempQuery.RecordCount);
    TempQuery.First;
    for i := 0 to TempQuery.RecordCount - 1 do
    begin
      TempArrayOuting[i] :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      TempQuery.Next;
    end;
    for i := 0 to Length(TempArray) - 1 do
    begin
      TempQuery.First;
      for j := 0 to Length(TempArrayOuting) - 1 do
      begin
        if TempArray[i].name = TempArrayOuting[j] then
          TempArray[i].numberOuting := CheckNull.CheckedValue
            (TempQuery.Fields[1].value);
        TempQuery.Next;
      end;
    end;
  end;
  TempQuery.Close;
end;

function TBRWMedicalExemptionsIncompleteWeek.GetValueNumber(i: Integer): string;

begin
  result := IntToStr(TempArray[i].number);
end;

function TBRWMedicalExemptionsIncompleteWeek.GetValueName(i: Integer): string;

begin
  result := TempArray[i].name;
end;

function TBRWMedicalExemptionsIncompleteWeek.GetValueOuting(i: Integer): string;
begin
  result := IntToStr(TempArray[i].numberOuting);
end;

end.
