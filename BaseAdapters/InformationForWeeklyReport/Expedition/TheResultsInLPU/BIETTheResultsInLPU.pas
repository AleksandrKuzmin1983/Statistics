unit BIETTheResultsInLPU;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBIETTheResultsInLPU = interface
    function GetKod(i: integer): string;
    function GetReportDate(i: integer): string;
    function GetTypeOfLPU(i: integer): string;
    function GetTheNameOfTheEnvironment(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumberOfDoses(i: integer): string;
    function GetPercentage(i: integer): string;
    function GetNumberOfPackets(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TResultRecord = Record
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

  TBIETTheResultsInLPU = class(TInterfacedObject, IBIETTheResultsInLPU)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
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
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIETTheResultsInLPU.GetContent;
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
  SQL := 'SELECT Exped.Код, Exped.ДАТАЛЗ, Exped.НС, TypeOfLPUandOther.NameRecord, '
    + 'Exped.ЛЗО, Exped.ЛЗД, Exped.ЛЗПР, Exped.ЛЗПАК ' +
    'FROM TypeOfLPUandOther INNER JOIN Exped ON TypeOfLPUandOther.NameRecord = Exped.ВЛЗ '
    + 'WHERE (((Exped.ЛЗД)>=0) AND ((TypeOfLPUandOther.TypeLPU)=True)) ' +
    'ORDER BY Exped.ДАТАЛЗ DESC;';
  Try
    TempQuery.SQL.Add(SQL);
  Except
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
      ResultMass[i].ReportDate :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].TypeOfLPU :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].TheNameOfTheEnvironment :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      ResultMass[i].Volume :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
      ResultMass[i].NumberOfDoses :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[5].value));
      ResultMass[i].Percentage :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[6].value));
      ResultMass[i].NumberOfPackets :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[7].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIETTheResultsInLPU.GetContent выполнена');
end;

function TBIETTheResultsInLPU.GetReportDate(i: integer): string;
begin
  result := ResultMass[i].ReportDate;
end;

function TBIETTheResultsInLPU.GetRowCount: integer;
begin
  result := Length(ResultMass);

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIETTheResultsInLPU.GetRowCount выполнена');
end;

function TBIETTheResultsInLPU.GetNumberOfDoses(i: integer): string;
begin
  result := ResultMass[i].NumberOfDoses;
end;

function TBIETTheResultsInLPU.GetNumberOfPackets(i: integer): string;
begin
  result := ResultMass[i].NumberOfPackets;
end;

function TBIETTheResultsInLPU.GetPercentage(i: integer): string;
begin
  result := ResultMass[i].Percentage;
end;

function TBIETTheResultsInLPU.GetTheNameOfTheEnvironment(i: integer): string;
begin
  result := ResultMass[i].TheNameOfTheEnvironment;
end;

function TBIETTheResultsInLPU.GetTypeOfLPU(i: integer): string;
begin
  result := ResultMass[i].TypeOfLPU;
end;

function TBIETTheResultsInLPU.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;
end;

function TBIETTheResultsInLPU.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;
end.
