unit BRDPlanDeilyReportToTheZav;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPercentConsBlood выполнена');
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPercentConsBlood выполнена');
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumeWholeBlood: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОЦК AS [Цельная кровь (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPlanVolumeWholeBlood выполнена', result);
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumeConsBlood: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОКК AS [Консервированная кровь (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPlanVolumeConsBlood выполнена', result);
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumePlasmaTotal: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОП AS [Объем плазмы (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPlanVolumePlasmaTotal выполнена', result);
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumePlasmaAPA: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОАПА AS [Объем АПА (план)] ' +
    'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPlanVolumePlasmaAPA выполнена', result);
end;

function TBRDPlanDeilyReportToTheZav.GetPlanVolumeErSusp: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].ОЭВ AS [Объем эр взвеси (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0.000', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPlanVolumeErSusp выполнена', result);
end;

function TBRDPlanDeilyReportToTheZav.GetPlanBloodProcedures: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].КПК AS [Процедуры крови (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPlanBloodProcedures выполнена', result);
end;

function TBRDPlanDeilyReportToTheZav.GetPlanAPAProcedures: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].КПП AS [Процедуры плазмы (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPlanAPAProcedures выполнена', result);
end;

function TBRDPlanDeilyReportToTheZav.GetPlanTromboProcedures: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].КПТ AS [Процедуры тромбо (план)] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetPlanTromboProcedures выполнена', result);
end;

function TBRDPlanDeilyReportToTheZav.GetWorksDay: string;
begin
  TempSQL :=
    'SELECT [(Нужный) К ежедневному отчету план].КРД AS [Кол-во рабочих дней] '
    + 'FROM [(Нужный) К ежедневному отчету план];';
  GetSQL(TempSQL);
  result := VarToStr(FormatFloat('0', TempValue));

  CodeSite.Send(FormatDateTime('c', Now) + ' TBRDPlanDeilyReportToTheZav.GetWorksDay выполнена', result);
end;

end.
