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
  VIOOKDK,
  VHMManualHarvesting,
  UMSMoldCleaning,
  UMSGlobalVariant;

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
    procedure VIO_OKDKClick(Sender: TObject);
    procedure HandlyHarvestingClick(Sender: TObject);
   private
//    NumberOfDonations: IVQNNumberOfDonations;
//    BloodProduct: IBloodProduct;
//    ProcurementOfTheComponentsTotal: IProcurementOfTheComponentsTotal;
//    HarvestingOfBloodComponentsByTypes: IHarvestingOfBloodComponentsByTypes;
//    TheAmountOfUsableErSusp: ITheAmountOfUsableErSusp;
//    AdviceToDoctors: IAdviceToDoctors;
//    CheckLPU: IVIOCCheckLPU;
    TheResultsInLPU: IVIETTheResultsInLPU;
    TheResultsInKray: IVIETTheResultsInKray;
    Cancellation: IVIECCancellation;
//    ConsumptionOfErythrocyte: IVIOCConsumptionOfErythrocyteEnvironments;
//    ConsumptionOfPlazma: IVIOCConsumptionOfPlazma;
//    ConsumptionOfTrombo: IVIOCConsumptionOfTrombo;
//    FlowRateOfWholeBlood: IVIOFFlowRateOfWholeBlood;
    ManualHarvesting: IVHMManualHarvesting;
  //  OKDK: IVIOOKDK;
    CleanForm1: IMSMoldCleaning;
    GlobalVariant: TGlobalVariant;
  public

    { Public declarations }

  end;

var
  MyMainForm: TMyMainForm;

implementation

{$R *.dfm}

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

procedure TMyMainForm.BCancellationClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1 := TMSMoldCleaning.Create;
  CleanForm1.CleanForm(self);

  if not Assigned(Cancellation) then
    Cancellation:=nil;
  Cancellation := TVIECCancellation.Create(self);
end;

procedure TMyMainForm.BCheckLPUClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TVIOCCheckLPU.Create(self);
end;

procedure TMyMainForm.BloodProductionClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant := TBloodProduct.Create(self);
end;

procedure TMyMainForm.HandlyHarvestingClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1 := TMSMoldCleaning.Create;
  CleanForm1.CleanForm(self);

  if not Assigned(ManualHarvesting) then
    ManualHarvesting:=nil;
  ManualHarvesting := TVHMManualHarvesting.Create(self);
end;

procedure TMyMainForm.HarvestingBloodComponentsByTypesClick(Sender: TObject);
begin
{  if not Assigned(CleanForm1) then
    CleanForm1 := TMSMoldCleaning.Create;
  CleanForm1.CleanForm(self);

  if not Assigned(HarvestingOfBloodComponentsByTypes) then
    HarvestingOfBloodComponentsByTypes:=nil;
  HarvestingOfBloodComponentsByTypes := THarvestingOfBloodComponentsByTypes.Create(self);}
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
  if not Assigned(CleanForm1) then
    CleanForm1 := TMSMoldCleaning.Create;
  CleanForm1.CleanForm(self);

  if not Assigned(TheResultsInKray) then
    TheResultsInKray:=nil;
  TheResultsInKray := TVIETTheResultsInKray.Create(self);
end;

procedure TMyMainForm.QueryNumberOfDonationsClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant:=TNumberOfDonations.create(self);
end;

procedure TMyMainForm.ResultsLPUClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1 := TMSMoldCleaning.Create;
  CleanForm1.CleanForm(self);

  if not Assigned(TheResultsInLPU) then
    TheResultsInLPU:=nil;
  TheResultsInLPU := TVIETTheResultsInLPU.Create(self);
end;

procedure TMyMainForm.VIO_OKDKClick(Sender: TObject);
begin
  if Assigned(GlobalVariant) then
    GlobalVariant.destroy;
  GlobalVariant:=TVIOOKDK.create(self);
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
