unit MainFormUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls, DateUtils,
  ActnMenus, Menus, Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, Generics.Collections, Contnrs, Bde.DBTables,
  Vcl.ComCtrls, Vcl.ExtCtrls, frxClass,
  VQNNumberOfDonations,
  VQBBloodProduct,
  VQPProcurementOfTheComponentsTotal,
  VQHHarvestingOfBloodComponentsByTypes,
  VIOATheAmountOfUsableErSusp,
  VIOAAdviceToDoctors,
  VIOCCheckLPU,
  VIETTheResultsInLPU,
  VIETTheResultsInKray,
  VIECCancellation,
  VIOCConsumptionOfErythrocyteEnvironments,
  VIOCConsumptionOfPlazma,
  VIOCConsumptionOfTrombo,
  VIOFFlowRateOfWholeBlood,
  VIOOKDK,
  VHAAutomaticApheresis,
  VHMManualHarvesting,
  VHSSitoferez,
  UMSMoldCleaning,
  UMSGlobalVariant,
  VRDDailyReportTheKray,
  VRDDeilyReportToTheZav,
  MRWTableForDefect,
  VRWWeeklyReport,
  Temp;

type
  TMyMainForm = class(TForm)
    MainMenu1: TMainMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    Help1: TMenuItem;
    CloseButton: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
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
    N23: TMenuItem;
    WeeklyReport: TMenuItem;
    N25: TMenuItem;
    QueryNumberOfDonations: TMenuItem;
    HarvestingBloodComponentsByTypes: TMenuItem;
    BloodProduction: TMenuItem;
    BitBtn1: TBitBtn;
    procedure CloseButtonClick(Sender: TObject);
    procedure QueryNumberOfDonationsClick(Sender: TObject);
    procedure BloodProductionClick(Sender: TObject);
    procedure ProcurementOfComponentsTotalClick(Sender: TObject);
    procedure HarvestingBloodComponentsByTypesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AmountUsableErSuspClick(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure AdviceDoctorsClick(Sender: TObject);
    procedure BCheckLPUClick(Sender: TObject);
    procedure ResultsLPUClick(Sender: TObject);
    procedure ResultsInKrayClick(Sender: TObject);
    procedure BCancellationClick(Sender: TObject);
    procedure ConsumptionErythrocyteEnvironmentsClick(Sender: TObject);
    procedure ConsumptionPlazmaClick(Sender: TObject);
    procedure ConsumptionTromboClick(Sender: TObject);
    procedure FlowRateWholeBloodClick(Sender: TObject);
    procedure VIO_OKDKClick(Sender: TObject);
    procedure HandlyHarvestingClick(Sender: TObject);
    procedure AutoAferezClick(Sender: TObject);
    procedure CitoferezClick(Sender: TObject);
    procedure KrasnEveryDayClick(Sender: TObject);
    procedure DeilyReportToTheZavClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure WeeklyReportClick(Sender: TObject);
   private
    GlobalVariant: TGlobalVariant;
    TableForDefect: TMRWTableForDefect;
  public

    { Public declarations }

  end;

var
  MyMainForm: TMyMainForm;
  ReportForm1: TForm;

implementation

{$R *.dfm}

procedure TMyMainForm.WeeklyReportClick(Sender: TObject);
begin
  if not Assigned(ReportForm1) then
    Application.CreateForm(TForm,ReportForm1);
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVRWWeeklyReport.Create(ReportForm1);

 { if not Assigned(TableForDefect) then
    TableForDefect:=TMRWTableForDefect.Create;
  TableForDefect.GetContent;
  Temp.Form3.GetResultMass;
  Temp.Form3.frxDefect.RangeEnd:=ReCount;
  Temp.Form3.frxDefect.RangeEndCount:=TableForDefect.GetRowCount;
  Temp.Form3.frxReport1.ShowReport;
  Temp.Form3.Show;}
end;


procedure TMyMainForm.DeilyReportToTheZavClick(Sender: TObject);
begin
  if not Assigned(ReportForm1) then
    Application.CreateForm(TForm,ReportForm1);
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVRDDeilyReportToTheZav.Create(ReportForm1);
end;

procedure TMyMainForm.KrasnEveryDayClick(Sender: TObject);
begin
  if not Assigned(ReportForm1) then
    Application.CreateForm(TForm,ReportForm1);
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVRDDailyReportTheKray.Create(ReportForm1);
end;

procedure TMyMainForm.AdviceDoctorsClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TAdviceToDoctors.Create(self);
end;

procedure TMyMainForm.AmountUsableErSuspClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TTheAmountOfUsableErSusp.Create(self);
end;

procedure TMyMainForm.AutoAferezClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVHAAutomaticApheresis.Create(self);
end;

procedure TMyMainForm.BCancellationClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVIECCancellation.Create(self);
end;

procedure TMyMainForm.BCheckLPUClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVIOCCheckLPU.Create(self);
end;

procedure TMyMainForm.BitBtn1Click(Sender: TObject);
begin
//  if not Assigned(TableForDefect) then
//    TableForDefect:=TMRWTableForDefect.Create;
//  TableForDefect.GetContent;
//  Temp.Form3.GetResultMass;
  Form3.frxUserDataSet1.RangeEnd:=ReCount;
  Form3.frxUserDataSet1.RangeEndCount:=5;
//  Temp.Form3.frxDefect.RangeEnd:=ReCount;
// Temp.Form3.frxDefect.RangeEndCount:=5;//TableForDefect.GetRowCount;
  Temp.Form3.frxReport1.ShowReport;
  Temp.Form3.Show;
end;

procedure TMyMainForm.BloodProductionClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TBloodProduct.Create(self);
end;

procedure TMyMainForm.HandlyHarvestingClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVHMManualHarvesting.Create(self);
end;

procedure TMyMainForm.HarvestingBloodComponentsByTypesClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant:=THarvestingOfBloodComponentsByTypes.create(self);
end;

procedure TMyMainForm.Help1Click(Sender: TObject);
begin
//
end;

procedure TMyMainForm.ResultsInKrayClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVIETTheResultsInKray.Create(self);
end;

procedure TMyMainForm.QueryNumberOfDonationsClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant:=TNumberOfDonations.create(self);
end;

procedure TMyMainForm.ResultsLPUClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVIETTheResultsInLPU.Create(self);
end;

procedure TMyMainForm.VIO_OKDKClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant:=TVIOOKDK.create(self);
end;



procedure TMyMainForm.CitoferezClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant:=TVHSSitoferez.create(self);
end;

procedure TMyMainForm.CloseButtonClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  Close;
end;

procedure TMyMainForm.ConsumptionErythrocyteEnvironmentsClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVIOCConsumptionOfErythrocyteEnvironments.Create(self);
end;

procedure TMyMainForm.ConsumptionPlazmaClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVIOCConsumptionOfPlazma.Create(self);
end;

procedure TMyMainForm.ConsumptionTromboClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVIOCConsumptionOfTrombo.Create(self);
end;

procedure TMyMainForm.FlowRateWholeBloodClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVIOFFlowRateOfWholeBlood.Create(self);
end;

procedure TMyMainForm.FormCreate(Sender: TObject);
var
  SysMenu:HMENU;
begin
  SysMenu := GetSystemMenu(Handle, false);
  Windows.EnableMenuItem(SysMenu, SC_CLOSE, MF_DISABLED or MF_GRAYED);
  GetSystemMenu(Handle, false);
  Perform(WM_NCPAINT, Handle, 0);
end;

procedure TMyMainForm.ProcurementOfComponentsTotalClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant:=TProcurementOfTheComponentsTotal.create(self);
end;

end.
