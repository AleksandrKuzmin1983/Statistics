unit MIETTheResultsInLPU;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  UCheckNull,
  GetAdoQuery;

type
  IMIETTheResultsInLPU = interface
    function GetKod(i: integer): string;
    function GetReportDate(i: integer): string;
    function GetTypeOfLPU(i: integer): string;
    function GetTheNameOfTheEnvironment(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
    function GetPercentage(i: integer): string;
    function GetNumberOfPackets(i: integer): string;
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
    ReportDate: String;
    TypeOfLPU: String;
    TheNameOfTheEnvironment: String;
    Volume: String;
    NumberOfDoses: String;
    Percentage: String;
    NumberOfPackets: String;
  end;

  TMIETTheResultsInLPU = class(TInterfacedObject,
    IMIETTheResultsInLPU)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetReportDate(i: integer): string;
    function GetTypeOfLPU(i: integer): string;
    function GetTheNameOfTheEnvironment(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
    function GetPercentage(i: integer): string;
    function GetNumberOfPackets(i: integer): string;
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

procedure TMIETTheResultsInLPU.AddSQL(SQL: string);
begin
  TempQuery.SQL.Add(SQL);
end;

procedure TMIETTheResultsInLPU.Clear;
begin
  TempQuery.SQL.Clear;
end;

procedure TMIETTheResultsInLPU.CloseConnect;
begin
  TempQuery.Close;
end;

constructor TMIETTheResultsInLPU.create;
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
  SQL:='SELECT Exped.Код, Exped.ДАТАЛЗ, Exped.НС, TypeOfLPUandOther.NameRecord, ' +
  'Exped.ЛЗО, Exped.ЛЗД, Exped.ЛЗПР, Exped.ЛЗПАК ' +
  'FROM TypeOfLPUandOther INNER JOIN Exped ON TypeOfLPUandOther.NameRecord = Exped.ВЛЗ ' +
  'WHERE (((Exped.ЛЗД)>=0) AND ((TypeOfLPUandOther.TypeLPU)=True)) ' +
  'ORDER BY Exped.ДАТАЛЗ DESC;';
  Try
    TempQuery.SQL.Add(SQL);
  Except
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
      ResultMass[i].ReportDate:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].TypeOfLPU:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].TheNameOfTheEnvironment:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      ResultMass[i].Volume:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
      ResultMass[i].NumberOfDoses:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[5].value));
      ResultMass[i].Percentage:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[6].value));
      ResultMass[i].NumberOfPackets:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[7].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

procedure TMIETTheResultsInLPU.ExecSQL;
begin
  TempQuery.ExecSQL;
end;

function TMIETTheResultsInLPU.GetReportDate(i: integer): string;
begin
  result := ResultMass[i].ReportDate;
end;

function TMIETTheResultsInLPU.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TMIETTheResultsInLPU.GetNumberOfDoses(i: integer): string;
begin
  result := ResultMass[i].NumberOfDoses;
end;

function TMIETTheResultsInLPU.GetNumberOfPackets(i: integer): string;
begin
  result := ResultMass[i].NumberOfPackets;
end;

function TMIETTheResultsInLPU.GetPercentage(i: integer): string;
begin
  result := ResultMass[i].Percentage;
end;

procedure TMIETTheResultsInLPU.Insert;
begin
  TempQuery.Insert;
end;

procedure TMIETTheResultsInLPU.OpenConnect;
begin
  TempQuery.Open;
end;

procedure TMIETTheResultsInLPU.post;
begin
  TempQuery.Post;
end;

procedure TMIETTheResultsInLPU.WriteValue(NumberField: integer;
  Value: Variant);
begin
  TempQuery.Fields[NumberField].Value:=Value;
end;

function TMIETTheResultsInLPU.GetTheNameOfTheEnvironment(i: integer): string;
begin
  result := ResultMass[i].TheNameOfTheEnvironment;
end;

function TMIETTheResultsInLPU.GetTypeOfLPU(i: integer): string;
begin
  result := ResultMass[i].TypeOfLPU;
end;

function TMIETTheResultsInLPU.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TMIETTheResultsInLPU.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;
end.
