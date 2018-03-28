unit BIETTheResultsInKray;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBIETTheResultsInKray = interface
    function GetKod(i: integer): string;
    function GetReportDate(i: integer): string;
    function GetTheNameOfTheEnvironment(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
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
    procedure GetContent;
  end;

  TResultRecord = Record
  private
    Kod: string;
    ReportDate: String;
    TheNameOfTheEnvironment: String;
    Volume: String;
    NumberOfDoses: String;
    NumberOfPackets: String;
  end;

  TBIETTheResultsInKray = class(TInterfacedObject, IBIETTheResultsInKray)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetReportDate(i: integer): string;
    function GetTheNameOfTheEnvironment(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
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
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIETTheResultsInKray.AddSQL(SQL: string);
begin
  TempQuery.SQL.Add(SQL);
end;

procedure TBIETTheResultsInKray.Clear;
begin
  TempQuery.SQL.Clear;
end;

procedure TBIETTheResultsInKray.CloseConnect;
begin
  TempQuery.Close;
end;

procedure TBIETTheResultsInKray.GetContent;
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
  SQL := 'SELECT Exped.Код, Exped.ДАТАЛЗ, Exped.НС, Exped.ЛЗО, Exped.ЛЗД, Exped.ЛЗПАК '
    + 'FROM TypeOfLPUandOther INNER JOIN Exped ON TypeOfLPUandOther.NameRecord = Exped.ВЛЗ '
    + 'WHERE (((Exped.ЛЗД)>=0) AND ((TypeOfLPUandOther.Krasn)=True)) ' +
    'ORDER BY Exped.ДАТАЛЗ DESC;';
  try
    TempQuery.SQL.Add(SQL);
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  end;
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
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
      ResultMass[i].ReportDate :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].Value));
      ResultMass[i].TheNameOfTheEnvironment :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].Value));
      ResultMass[i].Volume :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].Value));
      ResultMass[i].NumberOfDoses :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].Value));
      ResultMass[i].NumberOfPackets :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[5].Value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

procedure TBIETTheResultsInKray.ExecSQL;
begin
  TempQuery.ExecSQL;
end;

function TBIETTheResultsInKray.GetReportDate(i: integer): string;
begin
  result := ResultMass[i].ReportDate;
end;

function TBIETTheResultsInKray.GetRowCount: integer;
begin
  result := Length(ResultMass);
end;

function TBIETTheResultsInKray.GetNumberOfDoses(i: integer): string;
begin
  result := ResultMass[i].NumberOfDoses;
end;

function TBIETTheResultsInKray.GetNumberOfPackets(i: integer): string;
begin
  result := ResultMass[i].NumberOfPackets;
end;

procedure TBIETTheResultsInKray.Insert;
begin
  Try
    TempQuery.Insert;
  Except
    ShowMessage('Не могу добавить запись к базу данных (MIETTheResultsInKray)!'
      + chr(13) + 'Обратитесь к администратору!');
  End;

end;

procedure TBIETTheResultsInKray.OpenConnect;
begin
  Try
    TempQuery.Open;
  Except
    ShowMessage('Не могу подключиться к базе данных (MIETTheResultsInKray)!' +
      chr(13) + 'Обратитесь к администратору!');
  End;
end;

procedure TBIETTheResultsInKray.post;
begin
  Try
    TempQuery.post;
  Except
    ShowMessage
      ('Не могу сохранить изменения в базе данных (MIETTheResultsInKray)!' +
      chr(13) + 'Обратитесь к администратору!');
  End;
end;

procedure TBIETTheResultsInKray.WriteValue(NumberField: integer;
  Value: Variant);
begin
  Try
    TempQuery.Fields[NumberField].Value := Value;
  Except
    ShowMessage('Не могу записать значение поля (MIETTheResultsInKray)!' +
      chr(13) + 'Обратитесь к администратору!');
  End;
end;

function TBIETTheResultsInKray.GetTheNameOfTheEnvironment(i: integer): string;
begin
  result := ResultMass[i].TheNameOfTheEnvironment;
end;

function TBIETTheResultsInKray.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TBIETTheResultsInKray.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
