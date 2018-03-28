unit BRDPlanDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBRDPlanDeilyReportToTheZav = interface
    function GetPlanVolumeWholeBlood: string;
    function GetPlanVolumeConsBlood: string;
    function GetPlanVolumePlasmaTotal: string;
    function GetPlanVolumePlasmaAPA: string;
    function GetPlanVolumeErSusp: string;
    function GetPlanBloodProcedures: string;
    function GetPlanAPAProcedures: string;
    function GetPlanTromboProcedures: string;
    function GetWorksDay: string;
  end;

  TBRDPlanDeilyReportToTheZav = class(TInterfacedObject,
    IBRDPlanDeilyReportToTheZav)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
    TempValue: Real;
    TempSQL: String;
    procedure GetSQL(CSQL: String);
  public
    function GetPlanVolumeWholeBlood: string;
    function GetPlanVolumeConsBlood: string;
    function GetPlanVolumePlasmaTotal: string;
    function GetPlanVolumePlasmaAPA: string;
    function GetPlanVolumeErSusp: string;
    function GetPlanBloodProcedures: string;
    function GetPlanAPAProcedures: string;
    function GetPlanTromboProcedures: string;
    function GetWorksDay: string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBRDPlanDeilyReportToTheZav.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
end;

procedure TBRDPlanDeilyReportToTheZav.GetSQL(CSQL: String);

begin
  Try
    With TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add(CSQL);
      Open;
      TempValue := CheckNull.CheckedValue(TempQuery.Fields[0].value);
      Close;
    end;
  Except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumeWholeBlood: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОЦК AS [Цельная кровь (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumeConsBlood: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОКК AS [Консервированная кровь (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumePlasmaTotal: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОП AS [Объем плазмы (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumePlasmaAPA: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОАПА AS [Объем АПА (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumeErSusp: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОЭВ AS [Объем эр взвеси (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));
end;

function TBRDPlanDeilyReportToTheZav.GetPlanBloodProcedures: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].КПК AS [Процедуры крови (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

function TBRDPlanDeilyReportToTheZav.GetPlanAPAProcedures: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].КПП AS [Процедуры плазмы (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

function TBRDPlanDeilyReportToTheZav.GetPlanTromboProcedures: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].КПТ AS [Процедуры тромбо (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

function TBRDPlanDeilyReportToTheZav.GetWorksDay: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].КРД AS [Кол-во рабочих дней] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));
end;

end.
