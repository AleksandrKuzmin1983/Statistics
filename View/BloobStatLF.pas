unit BloobStatLF;

interface

uses
  Windows, Messages, SysUtils, ShellApi, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls, DateUtils,
  ActnMenus, Menus, Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, Generics.Collections, Contnrs, Bde.DBTables,
  Vcl.ComCtrls, Vcl.ExtCtrls, frxClass, CodeSiteLogging,

  MHAAutomaticApheresis,
  MHMManualHarvesting,
  MHSSitoferez,

  MIECCancellation,
  MIETTheResultsInKray,
  MIETTheResultsInLPU,

  MIOOKDK,

  MIOAAdviceToDoctors,
  MIOATheAmountOfUsableErSusp,
  MIOCCheckLPU,

  MIOCConsumptionOfErythrocyteEnvironments,
  MIOCConsumptionOfPlazma,
  MIOCConsumptionOfTrombo,
  MIOFFlowRateOfWholeBlood,

  MMMonthlyPlan,

  MQBBloodProduct,
  MQHHarvestingOfBloodComponentsByTypes,
  MQNNumberOfDonations,
  MQPProcurementOfTheComponentsTotal,

  MRDDailyReportTheKray,
  MRDDeilyReportToTheZav,
  MRWWeeklyIncompleteWeek,
  MRWWeeklyReport,

  USGlobalVariant,
  BRWTableForDefect, Vcl.Imaging.GIFImg;
type
  TMyMainForm = class(TForm)
    MainMenu1: TMainMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    Help1: TMenuItem;
    CloseButton: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    MonthlyPlan: TMenuItem;
    HandlyHarvesting: TMenuItem;
    AutoAferez: TMenuItem;
    Citoferez: TMenuItem;
    VIO_OKDK: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    ResultsLPU: TMenuItem;
    ResultsInKray: TMenuItem;
    BCancellation: TMenuItem;
    AmountUsableErSusp: TMenuItem;
    AdviceDoctors: TMenuItem;
    BCheckLPU: TMenuItem;
    N7: TMenuItem;
    ConsumptionErythrocyteEnvironments: TMenuItem;
    ConsumptionPlazma: TMenuItem;
    ConsumptionTrombo: TMenuItem;
    FlowRateWholeBlood: TMenuItem;
    DeilyReportToTheZav: TMenuItem;
    KrasnEveryDay: TMenuItem;
    WeeklyReport: TMenuItem;
    QueryNumberOfDonations: TMenuItem;
    HarvestingBloodComponentsByTypes: TMenuItem;
    BloodProduction: TMenuItem;
    Image1: TImage;
    frxReport1: TfrxReport;

    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure HandlyHarvestingClick(Sender: TObject);
    procedure AutoAferezClick(Sender: TObject);
    procedure CitoferezClick(Sender: TObject);

    procedure BCancellationClick(Sender: TObject);
    procedure ResultsInKrayClick(Sender: TObject);
    procedure ResultsLPUClick(Sender: TObject);

    procedure VIO_OKDKClick(Sender: TObject);

    procedure AdviceDoctorsClick(Sender: TObject);
    procedure AmountUsableErSuspClick(Sender: TObject);
    procedure BCheckLPUClick(Sender: TObject);

    procedure ConsumptionErythrocyteEnvironmentsClick(Sender: TObject);
    procedure ConsumptionPlazmaClick(Sender: TObject);
    procedure ConsumptionTromboClick(Sender: TObject);
    procedure FlowRateWholeBloodClick(Sender: TObject);

    procedure MonthlyPlanClick(Sender: TObject);

    procedure BloodProductionClick(Sender: TObject);
    procedure HarvestingBloodComponentsByTypesClick(Sender: TObject);
    procedure QueryNumberOfDonationsClick(Sender: TObject);
    procedure ProcurementOfComponentsTotalClick(Sender: TObject);

    procedure KrasnEveryDayClick(Sender: TObject);
    procedure DeilyReportToTheZavClick(Sender: TObject);
    procedure WeeklyReportClick(Sender: TObject);

    procedure Help1Click(Sender: TObject);
  private
    GlobalVariant: TUSGlobalVariant;
    TableForDefect: TBRWTableForDefect;
  public

    { Public declarations }

  end;

var
  MyMainForm: TMyMainForm;
  ReportForm1: TForm;

implementation

{$R *.dfm}

procedure TMyMainForm.CloseButtonClick(Sender: TObject);
begin
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.CloseButtonClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  Close;
  CodeSite.Send('���������� ��������� ��������� - ' + FormatDateTime('c', Now));
end;

procedure TMyMainForm.FormCreate(Sender: TObject);
var
  SysMenu: HMENU;
begin
  SysMenu := GetSystemMenu(Handle, false);
  Windows.EnableMenuItem(SysMenu, SC_CLOSE, MF_DISABLED or MF_GRAYED);
  GetSystemMenu(Handle, false);
  Perform(WM_NCPAINT, Handle, 0);
  MyMainForm.Color:=$ACFE98;

  CodeSite.Destination := TCodeSiteDestination.Create(CodeSite);
  CodeSite.Destination.LogFile.FilePath:=ExtractFilePath(Application.ExeName) + '/logs';
  CodeSite.Destination.LogFile.FileName:='Log.csl';
  CodeSite.Destination.LogFile.Active:=true;
  CodeSite.Destination.LogFile.MaxSize:=3072;
  CodeSite.Send(' ');
  CodeSite.Send('������ ��������� ��������!!! - ' + FormatDateTime('c', Now));
  CodeSite.Send(' ');
end;

procedure TMyMainForm.HandlyHarvestingClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.HandlyHarvestingClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMHMManualHarvesting.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting - ������');
end;

procedure TMyMainForm.AutoAferezClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.AutoAferezClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMHAAutomaticApheresis.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis - ������');
end;

procedure TMyMainForm.CitoferezClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.CitoferezClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMHSSitoferez.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMHSSitoferez - ������');
end;

procedure TMyMainForm.BCancellationClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.BCancellationClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIECCancellation.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation - ������');
end;

procedure TMyMainForm.ResultsInKrayClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.ResultsInKrayClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIETTheResultsInKray.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInKray - ������');
end;

procedure TMyMainForm.ResultsLPUClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.ResultsLPUClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIETTheResultsInLPU.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU - ������');
end;

procedure TMyMainForm.VIO_OKDKClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.VIO_OKDKClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIOOKDK.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOOKDK - ������');
end;

procedure TMyMainForm.AdviceDoctorsClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.AdviceDoctorsClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIOAAdviceToDoctors.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors - ������');
end;

procedure TMyMainForm.AmountUsableErSuspClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.AmountUsableErSuspClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIOATheAmountOfUsableErSusp.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOATheAmountOfUsableErSusp - ������');
end;

procedure TMyMainForm.BCheckLPUClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.BCheckLPUClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIOCCheckLPU.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCCheckLPU - ������');
end;

procedure TMyMainForm.ConsumptionErythrocyteEnvironmentsClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.ConsumptionErythrocyteEnvironmentsClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIOCConsumptionOfErythrocyteEnvironments.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfErythrocyteEnvironments - ������');
end;

procedure TMyMainForm.ConsumptionPlazmaClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.ConsumptionPlazmaClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIOCConsumptionOfPlazma.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfPlazma - ������');
end;

procedure TMyMainForm.ConsumptionTromboClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.ConsumptionTromboClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIOCConsumptionOfTrombo.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo - ������');
end;

procedure TMyMainForm.FlowRateWholeBloodClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.FlowRateWholeBloodClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMIOFFlowRateOfWholeBlood.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood - ������');
end;

procedure TMyMainForm.MonthlyPlanClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.MonthlyPlanClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMMMonthlyPlan.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan - ������');
end;

procedure TMyMainForm.BloodProductionClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.BloodProductionClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMQBBloodProduct.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct - ������');
end;

procedure TMyMainForm.HarvestingBloodComponentsByTypesClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.HarvestingBloodComponentsByTypesClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMQHHarvestingOfBloodComponentsByTypes.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQHHarvestingOfBloodComponentsByTypes - ������');
end;

procedure TMyMainForm.QueryNumberOfDonationsClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.QueryNumberOfDonationsClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMQNNumberOfDonations.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations - ������');
end;

procedure TMyMainForm.ProcurementOfComponentsTotalClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.ProcurementOfComponentsTotalClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMQPProcurementOfTheComponentsTotal.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal - ������');
end;

procedure TMyMainForm.KrasnEveryDayClick(Sender: TObject);
begin
  Image1.Visible:=True;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.KrasnEveryDayClick');
  if not Assigned(ReportForm1) then
    Application.CreateForm(TForm, ReportForm1);
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMRDDailyReportTheKray.Create(ReportForm1);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDailyReportTheKray - ������');
end;

procedure TMyMainForm.DeilyReportToTheZavClick(Sender: TObject);
begin
  Image1.Visible:=True;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.DeilyReportToTheZavClick');
  if not Assigned(ReportForm1) then
    Application.CreateForm(TForm, ReportForm1);
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
  GlobalVariant := TMRDDeilyReportToTheZav.Create(ReportForm1);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav - ������');
end;

procedure TMyMainForm.WeeklyReportClick(Sender: TObject);
begin
  Image1.Visible:=True;
  CodeSite.Send(FormatDateTime('c', Now) + ' ������ TMyMainForm.WeeklyReportClick');
  if MonthOf(StartOfTheWeek(Date() - 7)) = MonthOf(EndOfTheWeek(Date() - 7))
  then
  begin
    CodeSite.Send(FormatDateTime('c', Now) + ' �������� � ������� ��������� �������');
    if not Assigned(ReportForm1) then
      Application.CreateForm(TForm, ReportForm1);
    if Assigned(GlobalVariant) then
    begin
      GlobalVariant.destroy;
      CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
    end;
    GlobalVariant := TMRWWeeklyReport.Create(ReportForm1);
    CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyReport - ������');
  end
  else
  begin
    CodeSite.Send(FormatDateTime('c', Now) + ' �������� � ����������� ��������� �������');
    if not Assigned(ReportForm1) then
      Application.CreateForm(TForm, ReportForm1);
    if Assigned(GlobalVariant) then
      GlobalVariant.destroy;
    CodeSite.Send(FormatDateTime('c', Now) + ' ���������� GlobalVariant ������');
    GlobalVariant := TMRWWeeklyIncompleteWeek.Create(ReportForm1);
    CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek - ������');
  end;
end;

procedure TMyMainForm.Help1Click(Sender: TObject);
var
  CurrentDir: String;
  CurrentDirCHM: PChar;
begin
  ShellExecute(Application.Handle,'Open','..\chm\�������.chm',nil,nil,SW_SHOW);
end;
end.
