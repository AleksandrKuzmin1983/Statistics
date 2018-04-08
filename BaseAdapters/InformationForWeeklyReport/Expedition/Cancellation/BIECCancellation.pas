unit BIECCancellation;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBIECCancellation = interface
    function GetKod(i: integer): string;
    function GetReportDate(i: integer): string;
    function GetTheNameOfTheEnvironment(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
    function GetNumberOfPackets(i: integer): string;
    function GetRowCount: integer;
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

  TBIECCancellation = class(TInterfacedObject, IBIECCancellation)
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
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIECCancellation.GetContent;
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
    + 'WHERE (((Exped.ЛЗД)>=0) AND ((TypeOfLPUandOther.Cancellation)=True)) ' +
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
    ShowMessage('Нет подключения в базе данных (MIECCancellation)!' + chr(13) +
      'Обратитесь к администратору!');
  end;
  Try
    if not TempQuery.IsEmpty then
    begin
      SetLength(ResultMass, TempQuery.RecordCount);
      TempQuery.Recordset.MoveFirst;
      for i := 0 to TempQuery.RecordCount - 1 do
      begin
        ResultMass[i].Kod :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
        ResultMass[i].ReportDate :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
        ResultMass[i].TheNameOfTheEnvironment :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
        ResultMass[i].Volume :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
        ResultMass[i].NumberOfDoses :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
        ResultMass[i].NumberOfPackets :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[5].value));
        TempQuery.Next;
      end;
    end;
  Except
    ShowMessage
      ('Не могу взять данные с базы данных для заполнения таблицы (MIECCancellation)!'
      + chr(13) + 'Обратитесь к администратору!');
  End;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIECCancellation.GetContent выполнена');
end;

function TBIECCancellation.GetReportDate(i: integer): string;
begin
  result := ResultMass[i].ReportDate;
end;

function TBIECCancellation.GetRowCount: integer;
begin
  result := Length(ResultMass);

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIECCancellation.GetRowCount выполнена', result);
end;

function TBIECCancellation.GetNumberOfDoses(i: integer): string;
begin
  result := ResultMass[i].NumberOfDoses;
end;

function TBIECCancellation.GetNumberOfPackets(i: integer): string;
begin
  result := ResultMass[i].NumberOfPackets;
end;

function TBIECCancellation.GetTheNameOfTheEnvironment(i: integer): string;
begin
  result := ResultMass[i].TheNameOfTheEnvironment;
end;

function TBIECCancellation.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TBIECCancellation.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
