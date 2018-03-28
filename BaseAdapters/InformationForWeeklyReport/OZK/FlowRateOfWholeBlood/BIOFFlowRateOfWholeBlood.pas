unit BIOFFlowRateOfWholeBlood;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBIOFFlowRateOfWholeBlood = interface
    function GetKod(i: integer): string;
    function GetCancellationDate(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
    function GetReasonConsumption(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
    procedure destroy;
  end;

  TResultRecord = Record
  private
    Kod: string;
    CancellationDate: String;
    Volume: String;
    NumberOfDoses: String;
    ReasonConsumption: String;
  end;

  TBIOFFlowRateOfWholeBlood = class(TInterfacedObject,
    IBIOFFlowRateOfWholeBlood)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetCancellationDate(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
    function GetReasonConsumption(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOFFlowRateOfWholeBlood.GetContent;
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
  SQL := 'SELECT [Брак компонентов и другой расход].Код, [Брак компонентов и другой расход].ДАТАБР, '
    + '[Брак компонентов и другой расход].БЦКО, [Брак компонентов и другой расход].БЦКД, TypeOfDefects.TypeDef '
    + 'FROM TypeOfDefects INNER JOIN [Брак компонентов и другой расход] ON ' +
    'TypeOfDefects.TypeDef = [Брак компонентов и другой расход].БКЦП ' +
    'WHERE ((([Брак компонентов и другой расход].БЦКД)<>0)) ' +
    'ORDER BY [Брак компонентов и другой расход].ДАТАБР DESC;';
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
      ResultMass[i].CancellationDate :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Volume :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].NumberOfDoses :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      ResultMass[i].ReasonConsumption :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

procedure TBIOFFlowRateOfWholeBlood.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;
  CheckNull := nil;
end;

function TBIOFFlowRateOfWholeBlood.GetCancellationDate(i: integer): string;
begin
  result := ResultMass[i].CancellationDate;
end;

function TBIOFFlowRateOfWholeBlood.GetRowCount: integer;
begin
  result := Length(ResultMass);
end;

function TBIOFFlowRateOfWholeBlood.GetNumberOfDoses(i: integer): string;
begin
  result := ResultMass[i].NumberOfDoses;
end;

function TBIOFFlowRateOfWholeBlood.GetReasonConsumption(i: integer): string;
begin
  result := ResultMass[i].ReasonConsumption;
end;

function TBIOFFlowRateOfWholeBlood.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TBIOFFlowRateOfWholeBlood.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
