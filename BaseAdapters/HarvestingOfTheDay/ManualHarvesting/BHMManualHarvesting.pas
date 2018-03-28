unit BHMManualHarvesting;

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
    NumberOfDosesVolume450: String;
    NumberOfDosesVolume350: String;
    SentToPreserving: String;
    ForLaboratoryResearch: String;
    AllWholeBlood: String;
    AllStoredBlood: String;
    VolomeErSusp: String;
    NumberOfDosesErSusp: String;
    TypeErSusp: String;
    VolomePlazma: String;
    NumberOfDosesPlazma: String;
    TypePlazma: String;
    VolomeFiltrat: String;
    NumberOfDosesFiltrat: String;
    VolomeDefect: String;
    NumberOfDosesDefect: String;
    TypeDefect: String;
    Outing: String;
  end;

  IMHMManualHarvesting = interface
    function GetDate(i: integer): string;
    function GetNumberOfDonors(i: integer): string;
    function GetNumberOfDosesVolume450(i: integer): string;
    function GetNumberOfDosesVolume350(i: integer): string;
    function GetSentToPreserving(i: integer): string;
    function GetForLaboratoryResearch(i: integer): string;
    function GetAllWholeBlood(i: integer): string;
    function GetAllStoredBlood(i: integer): string;
    function GetVolomeErSusp(i: integer): string;
    function GetNumberOfDosesErSusp(i: integer): string;
    function GetTypeErSusp(i: integer): string;
    function GetVolomePlazma(i: integer): string;
    function GetNumberOfDosesPlazma(i: integer): string;
    function GetTypePlazma(i: integer): string;
    function GetVolomeFiltrat(i: integer): string;
    function GetNumberOfDosesFiltrat(i: integer): string;
    function GetVolomeDefect(i: integer): string;
    function GetNumberOfDosesDefect(i: integer): string;
    function GetTypeDefect(i: integer): string;
    function GetOuting(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TMHMManualHarvesting = class(TInterfacedObject,
    IMHMManualHarvesting)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetDate(i: integer): string;
    function GetNumberOfDonors(i: integer): string;
    function GetNumberOfDosesVolume450(i: integer): string;
    function GetNumberOfDosesVolume350(i: integer): string;
    function GetSentToPreserving(i: integer): string;
    function GetForLaboratoryResearch(i: integer): string;
    function GetAllWholeBlood(i: integer): string;
    function GetAllStoredBlood(i: integer): string;
    function GetVolomeErSusp(i: integer): string;
    function GetNumberOfDosesErSusp(i: integer): string;
    function GetTypeErSusp(i: integer): string;
    function GetVolomePlazma(i: integer): string;
    function GetNumberOfDosesPlazma(i: integer): string;
    function GetTypePlazma(i: integer): string;
    function GetVolomeFiltrat(i: integer): string;
    function GetNumberOfDosesFiltrat(i: integer): string;
    function GetVolomeDefect(i: integer): string;
    function GetNumberOfDosesDefect(i: integer): string;
    function GetTypeDefect(i: integer): string;
    function GetOuting(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

function TMHMManualHarvesting.GetAllStoredBlood(i: integer): string;
begin
  result := ResultMass[i].AllStoredBlood;
end;

function TMHMManualHarvesting.GetAllWholeBlood(i: integer): string;
begin
  result := ResultMass[i].AllWholeBlood;
end;

procedure TMHMManualHarvesting.GetContent;
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
  SQL:='SELECT Top 100 Blood.ДатаК, Blood.КДК, BloodDoza.[450], BloodDoza.[350], Blood.НаКонК, ' +
  'Blood.ЛабК, Blood.ЦелК, Blood.КонК, BloodErSusp.КЭВ, BloodErSusp.ДЭВ, BloodErSusp.ВидЭВ, ' +
  'BloodPlasma.КПЛ, BloodPlasma.ДПЛ, BloodPlasma.ВидПЛ, Filtrat.КФ, Filtrat.ДФ, BloodBrak.КБР, ' +
  'BloodBrak.ДБР, BloodBrak.ВидБР, Blood.Выезд ' +
  'FROM ((((Blood INNER JOIN BloodDoza ON Blood.ДатаК = BloodDoza.ДатаК) ' +
  'INNER JOIN BloodErSusp ON BloodDoza.КодД = BloodErSusp.Код) ' +
  'INNER JOIN BloodPlasma ON BloodErSusp.Код = BloodPlasma.КодЭ) ' +
  'INNER JOIN Filtrat ON BloodPlasma.КодЭ = Filtrat.КодП) ' +
  'INNER JOIN BloodBrak ON Filtrat.КодП = BloodBrak.КодФ ' +
  'ORDER BY Blood.ДатаК DESC;';
  try
    TempQuery.SQL.Add(SQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
  try
    TempQuery.Open;
  Except
    ShowMessage('Нет подключения в базе данных (MHMManualHarvesting)!' + chr(13) + 'Обратитесь к администратору!');
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
      ResultMass[i].NumberOfDosesVolume450:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].NumberOfDosesVolume350:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      ResultMass[i].SentToPreserving:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
      ResultMass[i].ForLaboratoryResearch:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[5].value));
      ResultMass[i].AllWholeBlood:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[6].value));
      ResultMass[i].AllStoredBlood:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[7].value));
      ResultMass[i].VolomeErSusp:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[8].value));
      ResultMass[i].NumberOfDosesErSusp:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[9].value));
      ResultMass[i].TypeErSusp:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[10].value));
      ResultMass[i].VolomePlazma:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[11].value));
      ResultMass[i].NumberOfDosesPlazma:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[12].value));
      ResultMass[i].TypePlazma:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[13].value));
      ResultMass[i].VolomeFiltrat:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[14].value));
      ResultMass[i].NumberOfDosesFiltrat:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[15].value));
      ResultMass[i].VolomeDefect:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[16].value));
      ResultMass[i].NumberOfDosesDefect:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[17].value));
      ResultMass[i].TypeDefect:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[18].value));
      if VarToStr(CheckNull.CheckedValue(TempQuery.Fields[19].value))='True' then ResultMass[i].Outing:='Да' else ResultMass[i].Outing:='Нет';
      TempQuery.Next;
    end;
  end;
  Except
    ShowMessage('Не могу взять данные с базы данных для заполнения таблицы (MHMManualHarvesting)!' + chr(13) + 'Обратитесь к администратору!');
  End;
  TempQuery.Close;
end;

function TMHMManualHarvesting.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TMHMManualHarvesting.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TMHMManualHarvesting.GetForLaboratoryResearch(i: integer): string;
begin
  result := ResultMass[i].ForLaboratoryResearch;
end;

function TMHMManualHarvesting.GetSentToPreserving(i: integer): string;
begin
  result := ResultMass[i].SentToPreserving;
end;

function TMHMManualHarvesting.GetTypeDefect(i: integer): string;
begin
  result := ResultMass[i].TypeDefect;
end;

function TMHMManualHarvesting.GetTypeErSusp(i: integer): string;
begin
  result := ResultMass[i].TypeErSusp;
end;

function TMHMManualHarvesting.GetTypePlazma(i: integer): string;
begin
  result := ResultMass[i].TypePlazma;
end;

function TMHMManualHarvesting.GetVolomeDefect(i: integer): string;
begin
  result := ResultMass[i].VolomeDefect;
end;

function TMHMManualHarvesting.GetVolomeErSusp(i: integer): string;
begin
  result := ResultMass[i].VolomeErSusp;
end;

function TMHMManualHarvesting.GetVolomeFiltrat(i: integer): string;
begin
  result := ResultMass[i].VolomeFiltrat;
end;

function TMHMManualHarvesting.GetVolomePlazma(i: integer): string;
begin
  result := ResultMass[i].VolomePlazma;
end;

function TMHMManualHarvesting.GetNumberOfDonors(i: integer): string;
begin
  result := ResultMass[i].NumberOfDonors;
end;

function TMHMManualHarvesting.GetNumberOfDosesDefect(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesDefect;
end;

function TMHMManualHarvesting.GetNumberOfDosesErSusp(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesErSusp;
end;

function TMHMManualHarvesting.GetNumberOfDosesFiltrat(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesFiltrat;
end;

function TMHMManualHarvesting.GetNumberOfDosesPlazma(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesPlazma;
end;

function TMHMManualHarvesting.GetNumberOfDosesVolume350(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesVolume350;
end;

function TMHMManualHarvesting.GetNumberOfDosesVolume450(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesVolume450;
end;

function TMHMManualHarvesting.GetOuting(i: integer): string;
begin
  result := ResultMass[i].Outing;
end;

end.
