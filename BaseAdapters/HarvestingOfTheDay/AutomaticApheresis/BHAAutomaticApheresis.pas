unit BHAAutomaticApheresis;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type

  TResultRecord = Record
  private
    Date: String;
    NumberOfDonors: String;
    SentToPreserving: String;
    ForLaboratoryResearch: String;
    AllWholeBlood: String;
    AllStoredBlood: String;
    VolomePlazma: String;
    NumberOfDosesPlazma: String;
    TypePlazma: String;
    VolomeDefect: String;
    NumberOfDosesDefect: String;
    TypeDefect: String;
  end;

  IBHAAutomaticApheresis = interface
    function GetDate(i: integer): string;
    function GetNumberOfDonors(i: integer): string;
    function GetSentToPreserving(i: integer): string;
    function GetForLaboratoryResearch(i: integer): string;
    function GetAllWholeBlood(i: integer): string;
    function GetAllStoredBlood(i: integer): string;
    function GetVolomePlazma(i: integer): string;
    function GetNumberOfDosesPlazma(i: integer): string;
    function GetTypePlazma(i: integer): string;
    function GetVolomeDefect(i: integer): string;
    function GetNumberOfDosesDefect(i: integer): string;
    function GetTypeDefect(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TBHAAutomaticApheresis = class(TInterfacedObject, IBHAAutomaticApheresis)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetDate(i: integer): string;
    function GetNumberOfDonors(i: integer): string;
    function GetSentToPreserving(i: integer): string;
    function GetForLaboratoryResearch(i: integer): string;
    function GetAllWholeBlood(i: integer): string;
    function GetAllStoredBlood(i: integer): string;
    function GetVolomePlazma(i: integer): string;
    function GetNumberOfDosesPlazma(i: integer): string;
    function GetTypePlazma(i: integer): string;
    function GetVolomeDefect(i: integer): string;
    function GetNumberOfDosesDefect(i: integer): string;
    function GetTypeDefect(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }

function TBHAAutomaticApheresis.GetAllStoredBlood(i: integer): string;
begin
  result := ResultMass[i].AllStoredBlood;
end;

function TBHAAutomaticApheresis.GetAllWholeBlood(i: integer): string;
begin
  result := ResultMass[i].AllWholeBlood;
end;

procedure TBHAAutomaticApheresis.GetContent;
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
  SQL := 'SELECT top 100 Plasma.�����, Plasma.���, Plasma.������, Plasma.����, Plasma.����, '
    + 'Plasma.����, PlasmaComponents.����, PlasmaComponents.����, PlasmaComponents.������, '
    + 'PlazmaBrak.����, PlazmaBrak.����, PlazmaBrak.������ ' +
    'FROM ((Plasma INNER JOIN PlazmaDoza ON Plasma.����� = PlazmaDoza.�����) ' +
    'INNER JOIN PlasmaComponents ON PlazmaDoza.����� = PlasmaComponents.�����) '
    + 'INNER JOIN PlazmaBrak ON PlasmaComponents.����� = PlazmaBrak.����� ' +
    'ORDER BY Plasma.����� DESC;';
  try
    TempQuery.SQL.Add(SQL);
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  end;
  try
    TempQuery.Open;
  Except
    ShowMessage('��� ����������� � ���� ������ (MHAAutomaticApheresis)!' +
      chr(13) + '���������� � ��������������!');
  end;
  Try
    if not TempQuery.IsEmpty then
    begin
      SetLength(ResultMass, TempQuery.RecordCount);
      TempQuery.Recordset.MoveFirst;
      for i := 0 to TempQuery.RecordCount - 1 do
      begin
        ResultMass[i].Date :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
        ResultMass[i].NumberOfDonors :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
        ResultMass[i].SentToPreserving :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
        ResultMass[i].ForLaboratoryResearch :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
        ResultMass[i].AllWholeBlood :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
        ResultMass[i].AllStoredBlood :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[5].value));
        ResultMass[i].VolomePlazma :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[6].value));
        ResultMass[i].NumberOfDosesPlazma :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[7].value));
        ResultMass[i].TypePlazma :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[8].value));
        ResultMass[i].VolomeDefect :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[9].value));
        ResultMass[i].NumberOfDosesDefect :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[10].value));
        ResultMass[i].TypeDefect :=
          VarToStr(CheckNull.CheckedValue(TempQuery.Fields[11].value));
        TempQuery.Next;
      end;
    end;
  Except
    ShowMessage
      ('�� ���� ����� ������ � ���� ������ ��� ���������� ������� (MHAAutomaticApheresis)!'
      + chr(13) + '���������� � ��������������!');
  End;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAAutomaticApheresis.GetContent ���������');
end;

function TBHAAutomaticApheresis.GetRowCount: integer;
begin
  result := Length(ResultMass);

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAAutomaticApheresis.GetRowCount ���������', result);
end;

function TBHAAutomaticApheresis.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TBHAAutomaticApheresis.GetForLaboratoryResearch(i: integer): string;
begin
  result := ResultMass[i].ForLaboratoryResearch;
end;

function TBHAAutomaticApheresis.GetSentToPreserving(i: integer): string;
begin
  result := ResultMass[i].SentToPreserving;
end;

function TBHAAutomaticApheresis.GetTypeDefect(i: integer): string;
begin
  result := ResultMass[i].TypeDefect;
end;

function TBHAAutomaticApheresis.GetTypePlazma(i: integer): string;
begin
  result := ResultMass[i].TypePlazma;
end;

function TBHAAutomaticApheresis.GetVolomeDefect(i: integer): string;
begin
  result := ResultMass[i].VolomeDefect;
end;

function TBHAAutomaticApheresis.GetVolomePlazma(i: integer): string;
begin
  result := ResultMass[i].VolomePlazma;
end;

function TBHAAutomaticApheresis.GetNumberOfDonors(i: integer): string;
begin
  result := ResultMass[i].NumberOfDonors;
end;

function TBHAAutomaticApheresis.GetNumberOfDosesDefect(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesDefect;
end;

function TBHAAutomaticApheresis.GetNumberOfDosesPlazma(i: integer): string;
begin
  result := ResultMass[i].NumberOfDosesPlazma;
end;
end.
