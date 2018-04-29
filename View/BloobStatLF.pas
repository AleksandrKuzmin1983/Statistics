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
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.CloseButtonClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  Close;
  CodeSite.Send('Завершение программы выполнено - ' + FormatDateTime('c', Now));
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
  CodeSite.Send('Запуск программы выполнен!!! - ' + FormatDateTime('c', Now));
  CodeSite.Send(' ');
end;

procedure TMyMainForm.HandlyHarvestingClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.HandlyHarvestingClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMHMManualHarvesting.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting - Создан');
end;

procedure TMyMainForm.AutoAferezClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.AutoAferezClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMHAAutomaticApheresis.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis - Создан');
end;

procedure TMyMainForm.CitoferezClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.CitoferezClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMHSSitoferez.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMHSSitoferez - Создан');
end;

procedure TMyMainForm.BCancellationClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.BCancellationClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIECCancellation.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIECCancellation - Создан');
end;

procedure TMyMainForm.ResultsInKrayClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.ResultsInKrayClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIETTheResultsInKray.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInKray - Создан');
end;

procedure TMyMainForm.ResultsLPUClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.ResultsLPUClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIETTheResultsInLPU.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU - Создан');
end;

procedure TMyMainForm.VIO_OKDKClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.VIO_OKDKClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIOOKDK.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOOKDK - Создан');
end;

procedure TMyMainForm.AdviceDoctorsClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.AdviceDoctorsClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIOAAdviceToDoctors.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors - Создан');
end;

procedure TMyMainForm.AmountUsableErSuspClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.AmountUsableErSuspClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIOATheAmountOfUsableErSusp.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOATheAmountOfUsableErSusp - Создан');
end;

procedure TMyMainForm.BCheckLPUClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.BCheckLPUClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIOCCheckLPU.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCCheckLPU - Создан');
end;

procedure TMyMainForm.ConsumptionErythrocyteEnvironmentsClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.ConsumptionErythrocyteEnvironmentsClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIOCConsumptionOfErythrocyteEnvironments.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfErythrocyteEnvironments - Создан');
end;

procedure TMyMainForm.ConsumptionPlazmaClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.ConsumptionPlazmaClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIOCConsumptionOfPlazma.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfPlazma - Создан');
end;

procedure TMyMainForm.ConsumptionTromboClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.ConsumptionTromboClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIOCConsumptionOfTrombo.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo - Создан');
end;

procedure TMyMainForm.FlowRateWholeBloodClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.FlowRateWholeBloodClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMIOFFlowRateOfWholeBlood.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood - Создан');
end;

procedure TMyMainForm.MonthlyPlanClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.MonthlyPlanClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMMMonthlyPlan.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan - Создан');
end;

procedure TMyMainForm.BloodProductionClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.BloodProductionClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMQBBloodProduct.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct - Создан');
end;

procedure TMyMainForm.HarvestingBloodComponentsByTypesClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.HarvestingBloodComponentsByTypesClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMQHHarvestingOfBloodComponentsByTypes.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQHHarvestingOfBloodComponentsByTypes - Создан');
end;

procedure TMyMainForm.QueryNumberOfDonationsClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.QueryNumberOfDonationsClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMQNNumberOfDonations.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations - Создан');
end;

procedure TMyMainForm.ProcurementOfComponentsTotalClick(Sender: TObject);
begin
  Image1.Visible:=False;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.ProcurementOfComponentsTotalClick');
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMQPProcurementOfTheComponentsTotal.Create(self);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal - Создан');
end;

procedure TMyMainForm.KrasnEveryDayClick(Sender: TObject);
begin
  Image1.Visible:=True;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.KrasnEveryDayClick');
  if not Assigned(ReportForm1) then
    Application.CreateForm(TForm, ReportForm1);
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMRDDailyReportTheKray.Create(ReportForm1);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDailyReportTheKray - Создан');
end;

procedure TMyMainForm.DeilyReportToTheZavClick(Sender: TObject);
begin
  Image1.Visible:=True;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.DeilyReportToTheZavClick');
  if not Assigned(ReportForm1) then
    Application.CreateForm(TForm, ReportForm1);
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
  GlobalVariant := TMRDDeilyReportToTheZav.Create(ReportForm1);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav - Создан');
end;

procedure TMyMainForm.WeeklyReportClick(Sender: TObject);
begin
  Image1.Visible:=True;
  CodeSite.Send(FormatDateTime('c', Now) + ' Нажата TMyMainForm.WeeklyReportClick');
  if MonthOf(StartOfTheWeek(Date() - 7)) = MonthOf(EndOfTheWeek(Date() - 7))
  then
  begin
    CodeSite.Send(FormatDateTime('c', Now) + ' Работаем с обычным недельным отчетом');
    if not Assigned(ReportForm1) then
      Application.CreateForm(TForm, ReportForm1);
    if Assigned(GlobalVariant) then
    begin
      GlobalVariant.destroy;
      CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
    end;
    GlobalVariant := TMRWWeeklyReport.Create(ReportForm1);
    CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyReport - Создан');
  end
  else
  begin
    CodeSite.Send(FormatDateTime('c', Now) + ' Работаем с переходящим недельным отчетом');
    if not Assigned(ReportForm1) then
      Application.CreateForm(TForm, ReportForm1);
    if Assigned(GlobalVariant) then
      GlobalVariant.destroy;
    CodeSite.Send(FormatDateTime('c', Now) + ' Предыдущий GlobalVariant удален');
    GlobalVariant := TMRWWeeklyIncompleteWeek.Create(ReportForm1);
    CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek - Создан');
  end;
end;

procedure TMyMainForm.Help1Click(Sender: TObject);
var
  CurrentDir: String;
  CurrentDirCHM: PChar;
begin
  ShellExecute(Application.Handle,'Open','..\chm\Справка.chm',nil,nil,SW_SHOW);
end;
end.
