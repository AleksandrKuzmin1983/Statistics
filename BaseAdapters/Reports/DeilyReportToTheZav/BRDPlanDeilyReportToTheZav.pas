unit BRDPlanDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IMRDPlanDeilyReportToTheZav = interface
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

  TMRDPlanDeilyReportToTheZav = class(TInterfacedObject, IMRDPlanDeilyReportToTheZav)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
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

constructor TMRDPlanDeilyReportToTheZav.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
end;

procedure TMRDPlanDeilyReportToTheZav.GetSQL(CSQL: String);
begin
  Try
    With TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add(CSQL);
      Open;
      TempValue:=CheckNull.CheckedValue(TempQuery.Fields[0].value);
      Close;
    end;
  Except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

function TMRDPlanDeilyReportToTheZav.GetPlanVolumeWholeBlood: string;
begin
  TempSQL:=
    'SELECT [(Нужный) К ежедневному отчету план].ОЦК AS [Цельная кровь (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDPlanDeilyReportToTheZav.GetPlanVolumeConsBlood: string;
begin
  TempSQL:=
    'SELECT [(Нужный) К ежедневному отчету план].ОКК AS [Консервированная кровь (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDPlanDeilyReportToTheZav.GetPlanVolumePlasmaTotal: string;
begin
  TempSQL:=
    'SELECT [(Нужный) К ежедневному отчету план].ОП AS [Объем плазмы (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDPlanDeilyReportToTheZav.GetPlanVolumePlasmaAPA: string;
begin
  TempSQL:=
    'SELECT [(Нужный) К ежедневному отчету план].ОАПА AS [Объем АПА (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDPlanDeilyReportToTheZav.GetPlanVolumeErSusp: string;
begin
  TempSQL:=
    'SELECT [(Нужный) К ежедневному отчету план].ОЭВ AS [Объем эр взвеси (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
end;

function TMRDPlanDeilyReportToTheZav.GetPlanBloodProcedures: string;
begin
  TempSQL:=
    'SELECT [(Нужный) К ежедневному отчету план].КПК AS [Процедуры крови (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRDPlanDeilyReportToTheZav.GetPlanAPAProcedures: string;
begin
  TempSQL:=
    'SELECT [(Нужный) К ежедневному отчету план].КПП AS [Процедуры плазмы (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRDPlanDeilyReportToTheZav.GetPlanTromboProcedures: string;
begin
  TempSQL:=
    'SELECT [(Нужный) К ежедневному отчету план].КПТ AS [Процедуры тромбо (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRDPlanDeilyReportToTheZav.GetWorksDay: string;
begin
  TempSQL:=
    'SELECT [(Нужный) К ежедневному отчету план].КРД AS [Кол-во рабочих дней] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

end.
