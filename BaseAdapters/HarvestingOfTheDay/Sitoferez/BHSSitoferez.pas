unit BHSSitoferez;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type

  TResultRecord=Record
  private
    Date: String;
    NumberOfDonors: String;
    SentToPreserving: String;
    ForLaboratoryResearch: String;
    AllWholeBlood: String;
    AllStoredBlood: String;
    VolumeTrombo: String;
    NumberOfPacketsTrombo: String;
    NumberOfDosesTrombo: String;
    TypeTrombo: String;
    VolomeDefect: String;
    NumberOfPacketsDefect: String;
    NumberOfDosesDefect: String;
    TypeDefect: String;
  end;

  IMHSSitoferez = interface
    function GetDate(i: integer): string;
    function GetNumberOfDonors(i: integer): string;
    function GetSentToPreserving(i: integer): string;
    function GetForLaboratoryResearch(i: integer): string;
    function GetAllWholeBlood(i: integer): string;
    function GetAllStoredBlood(i: integer): string;
    function GetVolomeTrombo(i: integer): string;
    function GetNumberOfPacketsTrombo(i: integer): string;
    function GetNumberOfDosesTrombo(i: integer): string;
    function GetTypeTrombo(i: integer): string;
    function GetVolomeDefect(i: integer): string;
    function GetNumberOfPacketsDefect(i: integer): string;
    function GetNumberOfDosesDefect(i: integer): string;
    function GetTypeDefect(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TMHSSitoferez = class(TInterfacedObject,
    IMHSSitoferez)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetDate(i: integer): string;
    function GetNumberOfDonors(i: integer): string;
    function GetSentToPreserving(i: integer): string;
    function GetForLaboratoryResearch(i: integer): string;
    function GetAllWholeBlood(i: integer): string;
    function GetAllStoredBlood(i: integer): string;
    function GetVolomeTrombo(i: integer): string;
    function GetNumberOfPacketsTrombo(i: integer): string;
    function GetNumberOfDosesTrombo(i: integer): string;
    function GetTypeTrombo(i: integer): string;
    function GetVolomeDefect(i: integer): string;
    function GetNumberOfPacketsDefect(i: integer): string;
    function GetNumberOfDosesDefect(i: integer): string;
    function GetTypeDefect(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

function TMHSSitoferez.GetAllStoredBlood(i: integer): string;
begin
  result := ResultMass[i].AllStoredBlood;
end;

function TMHSSitoferez.GetAllWholeBlood(i: integer): string;
begin
  result := ResultMass[i].AllWholeBlood;
end;

procedure TMHSSitoferez.GetContent;
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
  SQL:='SELECT Tromb.ДатаТ, Tromb.КДТ, Tromb.НаКонТ, Tromb.ЛабТ, Tromb.ЦелТ, Tromb.КонТ, ' +
  'TrombComponents.КПЛТ, TrombComponents.ПакТ, TrombComponents.ДПЛТ, TrombComponents.ВидТ, ' +
  'TrombBrak.КБРТ, TrombBrak.КПБТ, TrombBrak.ДБРТ, TrombBrak.ВидБРТ ' +
  'FROM Tromb INNER JOIN (TrombDoza INNER JOIN (TrombComponents INNER JOIN ' +
  'TrombBrak ON TrombComponents.КодДТ = TrombBrak.КодКТ) ON ' +
  'TrombDoza.КодТ = TrombComponents.КодДТ) ON Tromb.ДатаТ = TrombDoza.ДатаТ ' +
  'WHERE  Tromb.ДатаТ<>#01/01/2015#' +
  'ORDER BY Tromb.ДатаТ DESC;';
  try
    TempQuery.SQL.Add(SQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
  try
    TempQuery.Open;
  Except
    ShowMessage('Нет подключения в базе данных (MHAAutomaticApheresis)!' + chr(13) + 'Обратитесь к администратору!');
  end;
  Try
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Date:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].NumberOfDonors:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].SentToPreserving:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].ForLaboratoryResearch:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      ResultMass[i].AllWholeBlood:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
      ResultMass[i].AllStoredBlood:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[5].value));
      ResultMass[i].VolumeTrombo:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[6].value));
      ResultMass[i].NumberOfPacketsTrombo:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[7].value));
      ResultMass[i].NumberOfDosesTrombo:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[8].value));
      ResultMass[i].TypeTrombo:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[9].value));
      ResultMass[i].VolomeDefect:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[10].value));
      ResultMass[i].NumberOfPacketsDefect:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[11].value));
      ResultMass[i].NumberOfDosesDefect:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[12].value));
      ResultMass[i].TypeDefect:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[13].value));
      TempQuery.Next;
    end;
  end;
  Except
    ShowMessage('Не могу взять данные с базы данных для заполнения таблицы (MHAAutomaticApheresis)!' + chr(13) + 'Обратитесь к администратору!');
  End;
  TempQuery.Close;
end;

function TMHSSitoferez.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TMHSSitoferez.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TMHSSitoferez.GetForLaboratoryResearch(i: integer): string;
begin
  result := ResultMass[i].ForLaboratoryResearch;
end;

function TMHSSitoferez.GetSentToPreserving(i: integer): string;
begin
  result := ResultMass[i].SentToPreserving;
end;

function TMHSSitoferez.GetTypeDefect(i: integer): string;
begin
  result := ResultMass[i].TypeDefect;
end;

function TMHSSitoferez.GetTypeTrombo(i: integer): string;
begin
  result := ResultMass[i].TypeTrombo;
end;

function TMHSSitoferez.GetVolomeDefect(i: integer): string;
begin
  result := ResultMass[i].VolomeDefect;
end;

function TMHSSitoferez.GetVolomeTrombo(i: integer): string;
begin
  result := ResultMass[i].VolumeTrombo;
end;

function TMHSSitoferez.GetNumberOfDonors(i: integer): string;
begin
  result := ResultMass[i].NumberOfDonors;
end;


function TMHSSitoferez.GetNumberOfPacketsTrombo(i: integer): string;
begin
  result := ResultMass[i].NumberOfPacketsTrombo;
end;

function TMHSSitoferez.GetNumberOfPacketsDefect(i: integer): string;
begin
  result := ResultMass[i].NumberOfPacketsDefect;
end;

function TMHSSitoferez.GetNumberOfDosesDefect(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesDefect;
end;

function TMHSSitoferez.GetNumberOfDosesTrombo(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesTrombo;
end;
end.
