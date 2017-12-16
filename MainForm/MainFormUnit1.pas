unit MainFormUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls, DateUtils,
  ActnMenus, Menus, Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, Generics.Collections, Contnrs, Bde.DBTables,
  Vcl.ComCtrls, Vcl.ExtCtrls,
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
  UMSMoldCleaning;

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
    N9: TMenuItem;
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
    N1: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    QueryNumberOfDonations: TMenuItem;
    HarvestingBloodComponentsByTypes: TMenuItem;
    BloodProduction: TMenuItem;
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
   private
    NumberOfDonations: IVQNNumberOfDonations;
    BloodProduct: IBloodProduct;
    ProcurementOfTheComponentsTotal: IProcurementOfTheComponentsTotal;
    HarvestingOfBloodComponentsByTypes: IHarvestingOfBloodComponentsByTypes;
    TheAmountOfUsableErSusp: ITheAmountOfUsableErSusp;
    AdviceToDoctors: IAdviceToDoctors;
    CheckLPU: IVIOCCheckLPU;
    TheResultsInLPU: IVIETTheResultsInLPU;
    TheResultsInKray: IVIETTheResultsInKray;
    Cancellation: IVIECCancellation;
    ConsumptionOfErythrocyte: IVIOCConsumptionOfErythrocyteEnvironments;
    ConsumptionOfPlazma: IVIOCConsumptionOfPlazma;
    ConsumptionOfTrombo: IVIOCConsumptionOfTrombo;
    FlowRateOfWholeBlood: IVIOFFlowRateOfWholeBlood;
    CleanForm1: TMSMoldCleaning;
  public

    { Public declarations }

  end;

var
  MyMainForm: TMyMainForm;

implementation

{$R *.dfm}
// Запросы/Количество донаций

procedure TMyMainForm.AdviceDoctorsClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(AdviceToDoctors) then
    AdviceToDoctors:=nil;
  AdviceToDoctors := TAdviceToDoctors.Create(self);
end;

procedure TMyMainForm.AmountUsableErSuspClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(TheAmountOfUsableErSusp) then
    BloodProduct:=nil;
  TheAmountOfUsableErSusp := TTheAmountOfUsableErSusp.Create(self);
end;

procedure TMyMainForm.BCancellationClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(Cancellation) then
    Cancellation:=nil;
  Cancellation := TVIECCancellation.Create(self);
end;

procedure TMyMainForm.BCheckLPUClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(CheckLPU) then
    CheckLPU:=nil;
  CheckLPU := TVIOCCheckLPU.Create(self);
end;

procedure TMyMainForm.BloodProductionClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(BloodProduct) then
    BloodProduct:=nil;
  BloodProduct := TBloodProduct.Create(self);
end;

procedure TMyMainForm.HarvestingBloodComponentsByTypesClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(HarvestingOfBloodComponentsByTypes) then
    HarvestingOfBloodComponentsByTypes:=nil;
  HarvestingOfBloodComponentsByTypes := THarvestingOfBloodComponentsByTypes.Create(self);
end;

procedure TMyMainForm.Help1Click(Sender: TObject);
begin
//
end;

procedure TMyMainForm.ResultsInKrayClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(HarvestingOfBloodComponentsByTypes) then
    TheResultsInKray:=nil;
  TheResultsInKray := TVIETTheResultsInKray.Create(self);
end;

procedure TMyMainForm.QueryNumberOfDonationsClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(NumberOfDonations) then
    NumberOfDonations:=nil;
  NumberOfDonations := TNumberOfDonations.Create(self);
end;

procedure TMyMainForm.ResultsLPUClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(TheResultsInLPU) then
    TheResultsInLPU:=nil;
  TheResultsInLPU := TVIETTheResultsInLPU.Create(self);
end;

procedure TMyMainForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMyMainForm.ConsumptionErythrocyteEnvironmentsClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(ConsumptionOfErythrocyte) then
    ConsumptionOfErythrocyte := nil;
  ConsumptionOfErythrocyte := TVIOCConsumptionOfErythrocyteEnvironments.Create(self);
end;

procedure TMyMainForm.ConsumptionPlazmaClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(ConsumptionOfPlazma) then
    ConsumptionOfPlazma := nil;
  ConsumptionOfPlazma := TVIOCConsumptionOfPlazma.Create(self);
end;

procedure TMyMainForm.ConsumptionTromboClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(ConsumptionOfTrombo) then
    ConsumptionOfTrombo := nil;
  ConsumptionOfTrombo := TVIOCConsumptionOfTrombo.Create(self);
end;

procedure TMyMainForm.FlowRateWholeBloodClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(FlowRateOfWholeBlood) then
    FlowRateOfWholeBlood := nil;
  FlowRateOfWholeBlood := TVIOFFlowRateOfWholeBlood.Create(self);
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
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(ProcurementOfTheComponentsTotal) then
    ProcurementOfTheComponentsTotal := nil;
  ProcurementOfTheComponentsTotal := TProcurementOfTheComponentsTotal.Create(self);
end;

end.
