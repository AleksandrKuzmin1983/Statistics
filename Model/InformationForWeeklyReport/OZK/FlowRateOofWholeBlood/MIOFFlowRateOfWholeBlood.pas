unit MIOFFlowRateOfWholeBlood;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  UCheckNull,
  GetAdoQuery;

type
  IMIOFFlowRateOfWholeBlood = interface
    function GetKod(i: integer): string;
    function GetCancellationDate(i: integer): string;
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
    Volume: String;
    NumberOfDoses: String;
    ReasonConsumption: String;
  end;

  TMIOFFlowRateOfWholeBlood = class(TInterfacedObject,
    IMIOFFlowRateOfWholeBlood)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetCancellationDate(i: integer): string;
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

procedure TMIOFFlowRateOfWholeBlood.AddSQL(SQL: string);
begin
  TempQuery.SQL.Add(SQL);
end;

procedure TMIOFFlowRateOfWholeBlood.Clear;
begin
  TempQuery.SQL.Clear;
end;

procedure TMIOFFlowRateOfWholeBlood.CloseConnect;
begin
  TempQuery.Close;
end;

constructor TMIOFFlowRateOfWholeBlood.create;
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
  SQL:='SELECT [���� ����������� � ������ ������].���, [���� ����������� � ������ ������].������, ' +
  '[���� ����������� � ������ ������].����, [���� ����������� � ������ ������].����, TypeOfDefects.TypeDef ' +
  'FROM TypeOfDefects INNER JOIN [���� ����������� � ������ ������] ON ' +
  'TypeOfDefects.TypeDef = [���� ����������� � ������ ������].���� ' +
  'WHERE ((([���� ����������� � ������ ������].����)<>0)) ' +
  'ORDER BY [���� ����������� � ������ ������].������ DESC;';
  Try
    TempQuery.SQL.Add(SQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  try
    TempQuery.Open;
  Except
    ShowMessage('��� ����������� � ���� ������!' + chr(13) + '���������� � ��������������!');
  end;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Kod:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].CancellationDate:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Volume:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].NumberOfDoses:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      ResultMass[i].ReasonConsumption:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

procedure TMIOFFlowRateOfWholeBlood.ExecSQL;
begin
  TempQuery.ExecSQL;
end;

function TMIOFFlowRateOfWholeBlood.GetCancellationDate(i: integer): string;
begin
  result := ResultMass[i].CancellationDate;
end;

function TMIOFFlowRateOfWholeBlood.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TMIOFFlowRateOfWholeBlood.GetNumberOfDoses(i: integer): string;
begin
  result := ResultMass[i].NumberOfDoses;
end;

function TMIOFFlowRateOfWholeBlood.GetReasonConsumption(i: integer): string;
begin
  result := ResultMass[i].ReasonConsumption;
end;

procedure TMIOFFlowRateOfWholeBlood.Insert;
begin
  TempQuery.Insert;
end;

procedure TMIOFFlowRateOfWholeBlood.OpenConnect;
begin
  TempQuery.Open;
end;

procedure TMIOFFlowRateOfWholeBlood.post;
begin
  TempQuery.Post;
end;

procedure TMIOFFlowRateOfWholeBlood.WriteValue(NumberField: integer;
  Value: Variant);
begin
  TempQuery.Fields[NumberField].Value:=Value;
end;

function TMIOFFlowRateOfWholeBlood.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TMIOFFlowRateOfWholeBlood.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;


end.
