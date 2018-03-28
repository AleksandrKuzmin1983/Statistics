unit BMMonthlyPlan;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type

  TResultRecord=Record
  private
    Date: String;
    VolumeWholeBlood: String;
    VolumeStoredBlood: String;
    VolumePlasmaTotal: String;
    ProceduresBlood: String;
    ProceduresPlasmaAPA: String;
    ProceduresTrombo: String;
    VolumePlasmaAPA: String;
    VolumeErSusp: String;
    VolumeTrombo: String;
    NumberWorkDays: String;
  end;

  IMMMonthlyPlan = interface
    function GetDate(i: integer): string;
    function GetVolumeWholeBlood(i: integer): string;
    function GetVolumeStoredBlood(i: integer): string;
    function GetVolumePlasmaTotal(i: integer): string;
    function GetProceduresBlood(i: integer): string;
    function GetProceduresPlasmaAPA(i: integer): string;
    function GetProceduresTrombo(i: integer): string;
    function GetVolumePlasmaAPA(i: integer): string;
    function GetVolumeErSusp(i: integer): string;
    function GetVolumeTrombo(i: integer): string;
    function GetNumberWorkDays(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

  TMMMonthlyPlan = class(TInterfacedObject,
    IMMMonthlyPlan)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetDate(i: integer): string;
    function GetVolumeWholeBlood(i: integer): string;
    function GetVolumeStoredBlood(i: integer): string;
    function GetVolumePlasmaTotal(i: integer): string;
    function GetProceduresBlood(i: integer): string;
    function GetProceduresPlasmaAPA(i: integer): string;
    function GetProceduresTrombo(i: integer): string;
    function GetVolumePlasmaAPA(i: integer): string;
    function GetVolumeErSusp(i: integer): string;
    function GetVolumeTrombo(i: integer): string;
    function GetNumberWorkDays(i: integer): string;
    function GetRowCount: integer;
    procedure GetContent;
  end;

implementation

{ TTheNumberOfTromboDonations }



procedure TMMMonthlyPlan.GetContent;
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
  SQL:='SELECT Plans.�������� AS [�������� �����], Plans.��� AS [����� ������� �����], ' +
  'Plans.��� AS [����� ���������������� �����], Plans.�� AS [����� ������], ' +
  'Plans.��� AS [��������� �����], Plans.��� AS [��������� ������], ' +
  'Plans.��� AS [��������� ����������], Plans.���� AS [����� ���], ' +
  'Plans.��� AS [����� �� ����], Plans.����, Plans.��� AS [���-�� ������� ����] ' +
  'FROM Plans ORDER BY Plans.�������� DESC;';
  try
    TempQuery.SQL.Add(SQL);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
  try
    TempQuery.Open;
  Except
    ShowMessage('��� ����������� � ���� ������ (TMMMonthlyPlan)!' + chr(13) + '���������� � ��������������!');
  end;
  Try
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Date:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].VolumeWholeBlood:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].VolumeStoredBlood:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].VolumePlasmaTotal:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      ResultMass[i].ProceduresBlood:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[4].value));
      ResultMass[i].ProceduresPlasmaAPA:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[5].value));
      ResultMass[i].ProceduresTrombo:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[6].value));
      ResultMass[i].VolumePlasmaAPA:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[7].value));
      ResultMass[i].VolumeErSusp:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[8].value));
      ResultMass[i].VolumeTrombo:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[9].value));
      ResultMass[i].NumberWorkDays:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[10].value));
      TempQuery.Next;
    end;
  end;
  Except
    ShowMessage('�� ���� ����� ������ � ���� ������ ��� ���������� ������� (TMMMonthlyPlan)!' + chr(13) + '���������� � ��������������!');
  End;
  TempQuery.Close;
end;

function TMMMonthlyPlan.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

function TMMMonthlyPlan.GetVolumeStoredBlood(i: integer): string;
begin
  result := ResultMass[i].VolumeStoredBlood;
end;

function TMMMonthlyPlan.GetVolumePlasmaTotal(i: integer): string;
begin
  result := ResultMass[i].VolumePlasmaTotal;
end;

function TMMMonthlyPlan.GetProceduresBlood(i: integer): string;
begin
  result := ResultMass[i].ProceduresBlood;
end;

function TMMMonthlyPlan.GetProceduresPlasmaAPA(i: integer): string;
begin
  result := ResultMass[i].ProceduresPlasmaAPA;
end;

function TMMMonthlyPlan.GetProceduresTrombo(i: integer): string;
begin
  result := ResultMass[i].ProceduresTrombo;
end;

function TMMMonthlyPlan.GetVolumePlasmaAPA(i: integer): string;
begin
  result := ResultMass[i].VolumePlasmaAPA;
end;

function TMMMonthlyPlan.GetVolumeErSusp(i: integer): string;
begin
  result := ResultMass[i].VolumeErSusp;
end;

function TMMMonthlyPlan.GetVolumeTrombo(i: integer): string;
begin
  result := ResultMass[i].VolumeTrombo;
end;

function TMMMonthlyPlan.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TMMMonthlyPlan.GetVolumeWholeBlood(i: integer): string;
begin
  result := ResultMass[i].VolumeWholeBlood;
end;

function TMMMonthlyPlan.GetNumberWorkDays(i: integer): string;
begin
  result := ResultMass[i].NumberWorkDays;
end;
end.
