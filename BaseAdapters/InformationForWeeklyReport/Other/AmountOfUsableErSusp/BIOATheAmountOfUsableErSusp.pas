unit BIOATheAmountOfUsableErSusp;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBIOATheAmountOfUsableErSusp = interface
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TResultRecord = Record
  private
    Kod: string;
    Date: String;
    Name: String;
    Volume: String;
  end;

  TBIOATheAmountOfUsableErSusp = class(TInterfacedObject,
    IBIOATheAmountOfUsableErSusp)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOATheAmountOfUsableErSusp.GetContent;
var
  i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  SQL := 'SELECT Exped.Код, Exped.ДАТАЛЗ, Exped.НС, Exped.ПГЭС ' +
    'FROM Exped INNER JOIN NameProducts ON Exped.НС = NameProducts.ShortName ' +
    'WHERE (((NameProducts.TypeProduct)="Эр взвесь") AND ((NameProducts.Production)=True)) AND ((Exped.ПГЭС)>0)'
    + 'ORDER BY Exped.ДАТАЛЗ desc;';
  Try
    TempQuery.SQL.Add(SQL);
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  try
    TempQuery.Open;
  Except
    ShowMessage('Нет подключения в базе данных!' + chr(13) +
      'Обратитесь к администратору!');
  end;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i := 0 to TempQuery.RecordCount - 1 do
    begin
      ResultMass[i].Kod :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Date :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Name :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].Volume :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

function TBIOATheAmountOfUsableErSusp.GetRowCount: integer;
begin
  result := Length(ResultMass);
end;

function TBIOATheAmountOfUsableErSusp.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TBIOATheAmountOfUsableErSusp.GetName(i: integer): string;
begin
  result := ResultMass[i].Name;
end;

function TBIOATheAmountOfUsableErSusp.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TBIOATheAmountOfUsableErSusp.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
