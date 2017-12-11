unit MIOATheAmountOfUsableErSuspVer2;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs,
  UCheckNull,
  GetAdoQuery;

type
  IAmountOfUsableErSuspVer2 = interface
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
  end;

  TResultRecord=Record
  private
    Kod: string;
    Date: String;
    Name: String;
    Volume: String;
  end;

  TAmountOfUsableErSuspVer2 = class(TInterfacedObject,
    IAmountOfUsableErSuspVer2)
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
    constructor create;
    procedure WriteValue(NumberField: integer; Value: Variant);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TAmountOfUsableErSuspVer2.AddSQL(SQL: string);
begin
  TempQuery.SQL.Add(SQL);
end;

procedure TAmountOfUsableErSuspVer2.Clear;
begin
  TempQuery.SQL.Clear;
end;

procedure TAmountOfUsableErSuspVer2.CloseConnect;
begin
  TempQuery.Close;
end;

constructor TAmountOfUsableErSuspVer2.create;
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
  SQL:='SELECT Exped. Ó‰, Exped.ƒ¿“¿À«, Exped.Õ—, Exped.œ√›— ' +
  'FROM Exped INNER JOIN NameProducts ON Exped.Õ— = NameProducts.ShortName ' +
  'WHERE (((NameProducts.TypeProduct)="› ‚Á‚ÂÒ¸") AND ((NameProducts.Production)=True)) AND ((Exped.œ√›—)>0)' +
  'ORDER BY Exped.ƒ¿“¿À« desc;';
  TempQuery.SQL.Add(SQL);
  TempQuery.Open;
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

procedure TAmountOfUsableErSuspVer2.ExecSQL;
begin
  TempQuery.ExecSQL;
end;

function TAmountOfUsableErSuspVer2.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TAmountOfUsableErSuspVer2.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

procedure TAmountOfUsableErSuspVer2.Insert;
begin
  TempQuery.Insert;
end;

procedure TAmountOfUsableErSuspVer2.OpenConnect;
begin
  TempQuery.Open;
end;

procedure TAmountOfUsableErSuspVer2.post;
begin
  TempQuery.Post;
end;

procedure TAmountOfUsableErSuspVer2.WriteValue(NumberField: integer;
  Value: Variant);
begin
  TempQuery.Fields[NumberField].Value:=Value;
end;

function TAmountOfUsableErSuspVer2.GetName(i: integer): string ;
begin
  result := ResultMass[i].Name;
end;

function TAmountOfUsableErSuspVer2.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TAmountOfUsableErSuspVer2.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
