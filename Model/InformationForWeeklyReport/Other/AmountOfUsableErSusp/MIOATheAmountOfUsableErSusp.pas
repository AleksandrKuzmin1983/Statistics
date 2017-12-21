unit MIOATheAmountOfUsableErSusp;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  UCheckNull,
  GetAdoQuery;

type
  IAmountOfUsableErSusp = interface
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetRowCount: integer;
    procedure OpenConnect;
    procedure Insert;
    procedure post;
    procedure CloseConnect;
    procedure ExecSQL;
    procedure Clear;
    procedure AddSQL(SQL: string);
    procedure WriteValue(NumberField: integer; Value: Variant);
    procedure GetContent;
  end;

  TResultRecord=Record
  private
    Kod: string;
    Date: String;
    Name: String;
    Volume: String;
  end;

  TAmountOfUsableErSusp = class(TInterfacedObject,
    IAmountOfUsableErSusp)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetRowCount: integer;
    procedure OpenConnect;
    procedure Insert;
    procedure post;
    procedure CloseConnect;
    procedure ExecSQL;
    procedure Clear;
    procedure AddSQL(SQL: string);
    procedure WriteValue(NumberField: integer; Value: Variant);
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TAmountOfUsableErSusp.AddSQL(SQL: string);
begin
  TempQuery.SQL.Add(SQL);
end;

procedure TAmountOfUsableErSusp.Clear;
begin
  TempQuery.SQL.Clear;
end;

procedure TAmountOfUsableErSusp.CloseConnect;
begin
  TempQuery.Close;
end;

procedure TAmountOfUsableErSusp.GetContent;
var i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  SQL:='SELECT Exped.Код, Exped.ДАТАЛЗ, Exped.НС, Exped.ПГЭС ' +
  'FROM Exped INNER JOIN NameProducts ON Exped.НС = NameProducts.ShortName ' +
  'WHERE (((NameProducts.TypeProduct)="Эр взвесь") AND ((NameProducts.Production)=True)) AND ((Exped.ПГЭС)>0)' +
  'ORDER BY Exped.ДАТАЛЗ desc;';
  Try
    TempQuery.SQL.Add(SQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  try
    TempQuery.Open;
  Except
    ShowMessage('Нет подключения в базе данных!' + chr(13) + 'Обратитесь к администратору!');
  end;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Kod:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Date:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Name:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].Volume:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

procedure TAmountOfUsableErSusp.ExecSQL;
begin
  TempQuery.ExecSQL;
end;

function TAmountOfUsableErSusp.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TAmountOfUsableErSusp.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

procedure TAmountOfUsableErSusp.Insert;
begin
  TempQuery.Insert;
end;

procedure TAmountOfUsableErSusp.OpenConnect;
begin
  TempQuery.Open;
end;

procedure TAmountOfUsableErSusp.post;
begin
  TempQuery.Post;
end;

procedure TAmountOfUsableErSusp.WriteValue(NumberField: integer;
  Value: Variant);
begin
  TempQuery.Fields[NumberField].Value:=Value;
end;

function TAmountOfUsableErSusp.GetName(i: integer): string ;
begin
  result := ResultMass[i].Name;
end;

function TAmountOfUsableErSusp.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TAmountOfUsableErSusp.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
