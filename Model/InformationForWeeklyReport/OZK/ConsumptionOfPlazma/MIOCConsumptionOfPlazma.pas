unit MIOCConsumptionOfPlazma;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  UCheckNull,
  GetAdoQuery;

type
  IMIOCConsumptionOfPlazma = interface
    function GetKod(i: integer): string;
    function GetCancellationDate(i: integer): string;
    function GetTheNameOfTheEnvironment(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
    function GetReasonConsumption(i: integer): string;
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
    CancellationDate: String;
    TheNameOfPlazma: String;
    Volume: String;
    NumberOfDoses: String;
    ReasonConsumption: String;
  end;

  TMIOCConsumptionOfPlazma = class(TInterfacedObject,
    IMIOCConsumptionOfPlazma)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetCancellationDate(i: integer): string;
    function GetTheNameOfTheEnvironment(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
    function GetReasonConsumption(i: integer): string;
    function GetRowCount: integer;
    procedure OpenConnect;
    procedure Insert;
    procedure post;
    procedure CloseConnect;
    procedure ExecSQL;
    procedure Clear;
    procedure AddSQL(SQL: string);
    procedure WriteValue(NumberField: integer; Value: Variant);
    constructor create;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOCConsumptionOfPlazma.AddSQL(SQL: string);
begin
  TempQuery.SQL.Add(SQL);
end;

procedure TMIOCConsumptionOfPlazma.Clear;
begin
  TempQuery.SQL.Clear;
end;

procedure TMIOCConsumptionOfPlazma.CloseConnect;
begin
  TempQuery.Close;
end;

constructor TMIOCConsumptionOfPlazma.create;
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
  SQL:='SELECT [Брак компонентов и другой расход].Код, [Брак компонентов и другой расход].ДАТАБР, ' +
  'NameProducts.ShortName, [Брак компонентов и другой расход].БПО, ' +
  '[Брак компонентов и другой расход].БПД, TypeOfDefects.TypeDef ' +
  'FROM NameProducts INNER JOIN (TypeOfDefects INNER JOIN [Брак компонентов и другой расход] ' +
  'ON TypeOfDefects.TypeDef = [Брак компонентов и другой расход].БПП) ON ' +
  'NameProducts.ShortName = [Брак компонентов и другой расход].БПВ ' +
  'WHERE ((([Брак компонентов и другой расход].БПД)<>0) AND ((NameProducts.Visible)=True) ' +
  'AND ((NameProducts.TypeProduct)="Плазма")) ' +
  'ORDER BY [Брак компонентов и другой расход].ДАТАБР DESC;';
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
      ResultMass[i].CancellationDate:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].TheNameOfPlazma:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].Volume:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      ResultMass[i].NumberOfDoses:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
      ResultMass[i].ReasonConsumption:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[5].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

procedure TMIOCConsumptionOfPlazma.ExecSQL;
begin
  TempQuery.ExecSQL;
end;

function TMIOCConsumptionOfPlazma.GetCancellationDate(i: integer): string;
begin
  result := ResultMass[i].CancellationDate;
end;

function TMIOCConsumptionOfPlazma.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TMIOCConsumptionOfPlazma.GetNumberOfDoses(i: integer): string;
begin
  result := ResultMass[i].NumberOfDoses;
end;

function TMIOCConsumptionOfPlazma.GetReasonConsumption(i: integer): string;
begin
  result := ResultMass[i].ReasonConsumption;
end;

procedure TMIOCConsumptionOfPlazma.Insert;
begin
  TempQuery.Insert;
end;

procedure TMIOCConsumptionOfPlazma.OpenConnect;
begin
  TempQuery.Open;
end;

procedure TMIOCConsumptionOfPlazma.post;
begin
  TempQuery.Post;
end;

procedure TMIOCConsumptionOfPlazma.WriteValue(NumberField: integer;
  Value: Variant);
begin
  TempQuery.Fields[NumberField].Value:=Value;
end;

function TMIOCConsumptionOfPlazma.GetTheNameOfTheEnvironment(i: integer): string;
begin
  result := ResultMass[i].TheNameOfPlazma;
end;

function TMIOCConsumptionOfPlazma.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TMIOCConsumptionOfPlazma.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;


end.
