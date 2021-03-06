program MainForm;

uses
  Forms,
  MainFormUnit1 in 'MainFormUnit1.pas' {MyMainForm},
  GetAdoQuery in '..\Model\Connect\GetAdoQuery.pas',
  VQNNumberOfDonations in '..\View\Queries\NumberOfDonations\VQNNumberOfDonations.pas',
  MQNTheNumberOfBloodDonations in '..\Model\Queries\NumberOfDonations\MQNTheNumberOfBloodDonations.pas',
  MQNTheNumberOfPlasmaDonations in '..\Model\Queries\NumberOfDonations\MQNTheNumberOfPlasmaDonations.pas',
  MQNTheNumberOfTromboDonations in '..\Model\Queries\NumberOfDonations\MQNTheNumberOfTromboDonations.pas',
  MQBTheAmountOfBloodOnPreserving in '..\Model\Queries\BloodProduct\MQBTheAmountOfBloodOnPreserving.pas',
  VQBBloodProduct in '..\View\Queries\BloodProduct\VQBBloodProduct.pas',
  MQBTheNumberOfWholeBlood in '..\Model\Queries\BloodProduct\MQBTheNumberOfWholeBlood.pas',
  UCheckNull in '..\Model\System\UCheckNull.pas',
  UMSMoldCleaning in '..\Model\System\UMSMoldCleaning.pas',
  UVFLabel in '..\View\FormObjects\UVFLabel.pas',
  UVFTitleLabel in '..\View\FormObjects\UVFTitleLabel.pas',
  UVFEdit in '..\View\FormObjects\UVFEdit.pas',
  UVFDateTimePicker in '..\View\FormObjects\UVFDateTimePicker.pas',
  UVFBitBtn in '..\View\FormObjects\UVFBitBtn.pas',
  MQBTheNumberOfConservedBlood in '..\Model\Queries\BloodProduct\MQBTheNumberOfConservedBlood.pas',
  MQBTheAmountOfReinfusionWithAPA in '..\Model\Queries\BloodProduct\MQBTheAmountOfReinfusionWithAPA.pas',
  MQBTheAmountOfReinfusionWithTrombo in '..\Model\Queries\BloodProduct\MQBTheAmountOfReinfusionWithTrombo.pas',
  MQPHarvestingOfErSuspensionsValumeTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfErSuspensionsValumeTotal.pas',
  VQPProcurementOfTheComponentsTotal in '..\View\Queries\ProcurementOfTheComponentsTotal\VQPProcurementOfTheComponentsTotal.pas' {/ UVFPanel in '..\View\FormObjects\UVFPanel.pas';},
  UVFPanel in '..\View\FormObjects\UVFPanel.pas',
  MQPHarvestingOfErSuspensionsDosesTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfErSuspensionsDosesTotal.pas',
  MQPHarvestingOfPlasmaVolumeTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfPlasmaVolumeTotal.pas',
  MQPHarvestingOfPlasmaDosesTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfPlasmaDosesTotal.pas',
  MQPHarvestingOfPlasmaBloodVolumeTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfPlasmaBloodVolumeTotal.pas',
  MQPHarvestingOfPlasmaBloodDosesTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfPlasmaBloodDosesTotal.pas',
  MQPHarvestingOfPlasmaAPAVolumeTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfPlasmaAPAVolumeTotal.pas',
  MQPHarvestingOfPlasmaAPADosesTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfPlasmaAPADosesTotal.pas',
  MQPHarvestingOfTromboVolumeTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfTromboVolumeTotal.pas',
  MQPHarvestingOfTromboDosesTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfTromboDosesTotal.pas',
  MQPHarvestingOfTromboPacetsTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfTromboPacetsTotal.pas',
  MQPHarvestingOfFiltratVolumeTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfFiltratVolumeTotal.pas',
  MQPHarvestingOfFiltratDosesTotal in '..\Model\Queries\ProcurementOfTheComponentsTotal\MQPHarvestingOfFiltratDosesTotal.pas',
  VQHHarvestingOfBloodComponentsByTypes in '..\View\Queries\HarvestingOfBloodComponentsByTypes\VQHHarvestingOfBloodComponentsByTypes.pas',
  UVFStringGrid in '..\View\FormObjects\UVFStringGrid.pas',
  MQHBloodComponents in '..\Model\Queries\HarvestingOfBloodComponentsByTypes\MQHBloodComponents.pas',
  MQHBloodComponentsPlasma in '..\Model\Queries\HarvestingOfBloodComponentsByTypes\MQHBloodComponentsPlasma.pas',
  MQHPlasmaAPA in '..\Model\Queries\HarvestingOfBloodComponentsByTypes\MQHPlasmaAPA.pas',
  MQHTrombo in '..\Model\Queries\HarvestingOfBloodComponentsByTypes\MQHTrombo.pas',
  UVFComboBox in '..\View\FormObjects\UVFComboBox.pas',
  UVFBitBtnSave in '..\View\FormObjects\UVFBitBtnSave.pas',
  UVFBitBtnDelete in '..\View\FormObjects\UVFBitBtnDelete.pas',
  UVFBitBtnBlock in '..\View\FormObjects\UVFBitBtnBlock.pas',
  UVFBitBtnAdd in '..\View\FormObjects\UVFBitBtnAdd.pas',
  UVFDBGrid in '..\View\FormObjects\UVFDBGrid.pas',
  UVFDBNavigator in '..\View\FormObjects\UVFDBNavigator.pas',
  UMSGContentOfTheList in '..\Model\System\GetContent\UMSGContentOfTheList.pas',
  UMCGetDataSource in '..\Model\Connect\UMCGetDataSource.pas',
  UVFBitBtnEdit in '..\View\FormObjects\UVFBitBtnEdit.pas',
  UMSBlockMainMenu in '..\Model\System\UMSBlockMainMenu.pas',
  VIOATheAmountOfUsableErSusp in '..\View\InformationForWeeklyReport\Other\AmountOfUsableErSusp\VIOATheAmountOfUsableErSusp.pas',
  MIOATheAmountOfUsableErSusp in '..\Model\InformationForWeeklyReport\Other\AmountOfUsableErSusp\MIOATheAmountOfUsableErSusp.pas',
  MIOAAdviceToDoctors in '..\Model\InformationForWeeklyReport\Other\AdviceToDoctors\MIOAAdviceToDoctors.pas',
  VIOAAdviceToDoctors in '..\View\InformationForWeeklyReport\Other\AdviceToDoctors\VIOAAdviceToDoctors.pas',
  UMSCheckFillStringFields in '..\Model\System\UMSCheckFillStringFields.pas',
  MIOCCheckLPU in '..\Model\InformationForWeeklyReport\Other\CheckLPU\MIOCCheckLPU.pas',
  VIOCCheckLPU in '..\View\InformationForWeeklyReport\Other\CheckLPU\VIOCCheckLPU.pas',
  VIETTheResultsInLPU in '..\View\InformationForWeeklyReport\Expedition\TheResultsInLPU\VIETTheResultsInLPU.pas',
  MIETTheResultsInLPU in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInLPU\MIETTheResultsInLPU.pas',
  VIETTheResultsInKray in '..\View\InformationForWeeklyReport\Expedition\TheResultsInKray\VIETTheResultsInKray.pas',
  MIETTheResultsInKray in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInKray\MIETTheResultsInKray.pas',
  MIECCancellation in '..\Model\InformationForWeeklyReport\Expedition\Cancellation\MIECCancellation.pas',
  VIECCancellation in '..\View\InformationForWeeklyReport\Expedition\Cancellation\VIECCancellation.pas',
  MIOCConsumptionOfErythrocyteEnvironments in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\MIOCConsumptionOfErythrocyteEnvironments.pas',
  VIOCConsumptionOfErythrocyteEnvironments in '..\View\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\VIOCConsumptionOfErythrocyteEnvironments.pas',
  MIOCConsumptionOfPlazma in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\MIOCConsumptionOfPlazma.pas',
  VIOCConsumptionOfPlazma in '..\View\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\VIOCConsumptionOfPlazma.pas',
  MIOCConsumptionOfTrombo in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\MIOCConsumptionOfTrombo.pas',
  VIOCConsumptionOfTrombo in '..\View\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\VIOCConsumptionOfTrombo.pas',
  VIOFFlowRateOfWholeBlood in '..\View\InformationForWeeklyReport\OZK\FlowRateOfWholeBlood\VIOFFlowRateOfWholeBlood.pas',
  MIOFFlowRateOfWholeBlood in '..\Model\InformationForWeeklyReport\OZK\FlowRateOofWholeBlood\MIOFFlowRateOfWholeBlood.pas',
  VIOOKDK in '..\View\InformationForWeeklyReport\OKDK\VIOOKDK.pas',
  MIOOKDK in '..\Model\InformationForWeeklyReport\OKDK\MIOOKDK.pas',
  MIOCurrentType in '..\Model\InformationForWeeklyReport\OKDK\MIOCurrentType.pas',
  MIOTypeOfSelectRow in '..\Model\InformationForWeeklyReport\OKDK\MIOTypeOfSelectRow.pas',
  MIONameTypeOfSelectRow in '..\Model\InformationForWeeklyReport\OKDK\MIONameTypeOfSelectRow.pas',
  MIOAddRecord in '..\Model\InformationForWeeklyReport\OKDK\MIOAddRecord.pas',
  MIODeleteRecord in '..\Model\InformationForWeeklyReport\OKDK\MIODeleteRecord.pas',
  MIOChangeRecord in '..\Model\InformationForWeeklyReport\OKDK\MIOChangeRecord.pas',
  MIECAddRecordCancellation in '..\Model\InformationForWeeklyReport\Expedition\Cancellation\MIECAddRecordCancellation.pas',
  MIECDeleteRecordCancellation in '..\Model\InformationForWeeklyReport\Expedition\Cancellation\MIECDeleteRecordCancellation.pas',
  MIEChangeRecordCancellation in '..\Model\InformationForWeeklyReport\Expedition\Cancellation\MIEChangeRecordCancellation.pas',
  MIEChangeRecordResultsInKray in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInKray\MIEChangeRecordResultsInKray.pas',
  MIEAddRecordResultsInKray in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInKray\MIEAddRecordResultsInKray.pas',
  MIEDeleteRecordResultsInKray in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInKray\MIEDeleteRecordResultsInKray.pas',
  MIEAddRecordResultsInLPU in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInLPU\MIEAddRecordResultsInLPU.pas',
  MIEChangeRecordResultsInLPU in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInLPU\MIEChangeRecordResultsInLPU.pas',
  MIEDeleteRecordResultsInLPU in '..\Model\InformationForWeeklyReport\Expedition\TheResultsInLPU\MIEDeleteRecordResultsInLPU.pas',
  MIOAAddRecordResultsInAdviceToDoctor in '..\Model\InformationForWeeklyReport\Other\AdviceToDoctors\MIOAAddRecordResultsInAdviceToDoctor.pas',
  MIOAChangeRecordResultsInAdviceToDoctor in '..\Model\InformationForWeeklyReport\Other\AdviceToDoctors\MIOAChangeRecordResultsInAdviceToDoctor.pas',
  MIOADeleteRecordResultsInAdviceToDoctor in '..\Model\InformationForWeeklyReport\Other\AdviceToDoctors\MIOADeleteRecordResultsInAdviceToDoctor.pas',
  MIOADeleteRecordResultsAmountOfUsableErSusp in '..\Model\InformationForWeeklyReport\Other\AmountOfUsableErSusp\MIOADeleteRecordResultsAmountOfUsableErSusp.pas',
  MIOAAddRecordResultsAmountOfUsableErSusp in '..\Model\InformationForWeeklyReport\Other\AmountOfUsableErSusp\MIOAAddRecordResultsAmountOfUsableErSusp.pas',
  MIOAChangeRecordResultsAmountOfUsableErSusp in '..\Model\InformationForWeeklyReport\Other\AmountOfUsableErSusp\MIOAChangeRecordResultsAmountOfUsableErSusp.pas',
  MIOCAddRecordResultsCheckLPU in '..\Model\InformationForWeeklyReport\Other\CheckLPU\MIOCAddRecordResultsCheckLPU.pas',
  MIOCChangeRecordResultsCheckLPU in '..\Model\InformationForWeeklyReport\Other\CheckLPU\MIOCChangeRecordResultsCheckLPU.pas',
  MIOCDeleteRecordResultsCheckLPU in '..\Model\InformationForWeeklyReport\Other\CheckLPU\MIOCDeleteRecordResultsCheckLPU.pas',
  MIOCAddRecordConsumption in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\MIOCAddRecordConsumption.pas',
  MIOCChangeRecordConsumption in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\MIOCChangeRecordConsumption.pas',
  MIOCDeleteRecordConsumption in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfErythrocyteEnvironments\MIOCDeleteRecordConsumption.pas',
  MIOCAddRecordConsumptionOfPlazma in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\MIOCAddRecordConsumptionOfPlazma.pas',
  MIOCChangeRecordConsumptionOfPlazma in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\MIOCChangeRecordConsumptionOfPlazma.pas',
  MIOCDeleteRecordConsumptionOfPlazma in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfPlazma\MIOCDeleteRecordConsumptionOfPlazma.pas',
  MIOCAddRecordConsumptionOfTrombo in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\MIOCAddRecordConsumptionOfTrombo.pas',
  MIOCChangeRecordConsumptionOfTrombo in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\MIOCChangeRecordConsumptionOfTrombo.pas',
  MIOCDeleteRecordConsumptionOfTrombo in '..\Model\InformationForWeeklyReport\OZK\ConsumptionOfTrombo\MIOCDeleteRecordConsumptionOfTrombo.pas',
  MIOFAddRecordFlowRateOfWholeBlood in '..\Model\InformationForWeeklyReport\OZK\FlowRateOofWholeBlood\MIOFAddRecordFlowRateOfWholeBlood.pas',
  MIOFChangeRecordFlowRateOfWholeBlood in '..\Model\InformationForWeeklyReport\OZK\FlowRateOofWholeBlood\MIOFChangeRecordFlowRateOfWholeBlood.pas',
  MIOFDeleteRecordFlowRateOfWholeBlood in '..\Model\InformationForWeeklyReport\OZK\FlowRateOofWholeBlood\MIOFDeleteRecordFlowRateOfWholeBlood.pas',
  VHMManualHarvesting in '..\View\HarvestingOfTheDay\ManualHarvesting\VHMManualHarvesting.pas',
  UVFCheckBox in '..\View\FormObjects\UVFCheckBox.pas',
  MHMManualHarvesting in '..\Model\HarvestingOfTheDay\ManualHarvesting\MHMManualHarvesting.pas',
  MHMAddRecordManualHarvesting in '..\Model\HarvestingOfTheDay\ManualHarvesting\MHMAddRecordManualHarvesting.pas',
  MHMDeleteRecordManualHarvesting in '..\Model\HarvestingOfTheDay\ManualHarvesting\MHMDeleteRecordManualHarvesting.pas',
  UMSGlobalVariant in '..\Model\System\UMSGlobalVariant.pas',
  MHMChangeRecordManualHarvesting in '..\Model\HarvestingOfTheDay\ManualHarvesting\MHMChangeRecordManualHarvesting.pas',
  VHAAutomaticApheresis in '..\View\HarvestingOfTheDay\AutomaticApheresis\VHAAutomaticApheresis.pas',
  MHAAutomaticApheresis in '..\Model\HarvestingOfTheDay\AutomaticApheresis\MHAAutomaticApheresis.pas',
  MHADeleteRecordAutomaticApheresis in '..\Model\HarvestingOfTheDay\AutomaticApheresis\MHADeleteRecordAutomaticApheresis.pas',
  MHAAddRecordAutomaticApheresis in '..\Model\HarvestingOfTheDay\AutomaticApheresis\MHAAddRecordAutomaticApheresis.pas',
  MHAChangeRecordAutomaticApheresis in '..\Model\HarvestingOfTheDay\AutomaticApheresis\MHAChangeRecordAutomaticApheresis.pas',
  UMSCheckForExistenceOfRecord in '..\Model\System\UMSCheckForExistenceOfRecord.pas',
  UMSValueChecksOnTheAdequacy in '..\Model\System\UMSValueChecksOnTheAdequacy.pas',
  VHSSitoferez in '..\View\HarvestingOfTheDay\Sitoferez\VHSSitoferez.pas',
  MHSSitoferez in '..\Model\HarvestingOfTheDay\Sitoferez\MHSSitoferez.pas',
  MHSDeleteRecordSitoferez in '..\Model\HarvestingOfTheDay\Sitoferez\MHSDeleteRecordSitoferez.pas',
  MHSAddRecordSitoferez in '..\Model\HarvestingOfTheDay\Sitoferez\MHSAddRecordSitoferez.pas',
  MHSChangeRecordSitoferez in '..\Model\HarvestingOfTheDay\Sitoferez\MHSChangeRecordSitoferez.pas',
  MRDDailyReportToTheKray in '..\Model\Reports\DailyReportToTheKray\MRDDailyReportToTheKray.pas',
  VRDDailyReportTheKray in '..\View\Reports\DailyReportToTheKray\VRDDailyReportTheKray.pas' {$R *.res},
  UVFMainMenu in '..\View\FormObjects\UVFMainMenu.pas',
  MRDDeilyReportToTheZav in '..\Model\Reports\DeilyReportToTheZav\MRDDeilyReportToTheZav.pas',
  VRDDeilyReportToTheZav in '..\View\Reports\DeilyReportToTheZav\VRDDeilyReportToTheZav.pas',
  MRDPlanDeilyReportToTheZav in '..\Model\Reports\DeilyReportToTheZav\MRDPlanDeilyReportToTheZav.pas',
  MRDStatInfoDeilyReportToTheZav in '..\Model\Reports\DeilyReportToTheZav\MRDStatInfoDeilyReportToTheZav.pas',
  VRWWeeklyReport in '..\View\Reports\WeeklyReport\VRWWeeklyReport.pas',
  MRWWeeklyReportProduction in '..\Model\Reports\WeeklyReport\MRWWeeklyReportProduction.pas',
  MRWTableForDefect in '..\Model\Reports\WeeklyReport\MRWTableForDefect.pas',
  MRWSecondTable in '..\Model\Reports\WeeklyReport\MRWSecondTable.pas',
  MRWDonorsAndProcedures in '..\Model\Reports\WeeklyReport\MRWDonorsAndProcedures.pas',
  MRWResultsOfTheProducts in '..\Model\Reports\WeeklyReport\MRWResultsOfTheProducts.pas',
  MRWDonorsAndProceduresOuting in '..\Model\Reports\WeeklyReport\MRWDonorsAndProceduresOuting.pas',
  MRWReasonsForMedicalExemptions in '..\Model\Reports\WeeklyReport\MRWReasonsForMedicalExemptions.pas',
  MRWLPUConsultation in '..\Model\Reports\WeeklyReport\MRWLPUConsultation.pas',
  MRWCancellation_Kray in '..\Model\Reports\WeeklyReport\MRWCancellation_Kray.pas',
  MRWIncompleteWeekFirstTable in '..\Model\Reports\WeeklyIncompleteWeek\MRWIncompleteWeekFirstTable.pas',
  VRWWeeklyIncompleteWeek in '..\View\Reports\WeeklyIncompleteWeek\VRWWeeklyIncompleteWeek.pas',
  MRWTableForDefectIncompleteWeek in '..\Model\Reports\WeeklyIncompleteWeek\MRWTableForDefectIncompleteWeek.pas',
  MRWSecondTableIncompleteWeek in '..\Model\Reports\WeeklyIncompleteWeek\MRWSecondTableIncompleteWeek.pas',
  MRWResultsOfTheProductsIncompleteWeek in '..\Model\Reports\WeeklyIncompleteWeek\MRWResultsOfTheProductsIncompleteWeek.pas',
  MRWDonorsAndProceduresIncompleteWeek in '..\Model\Reports\WeeklyIncompleteWeek\MRWDonorsAndProceduresIncompleteWeek.pas',
  MRWDonorsAndProceduresIncompleteWeekOuting in '..\Model\Reports\WeeklyIncompleteWeek\MRWDonorsAndProceduresIncompleteWeekOuting.pas',
  MRWMedicalExemptionsIncompleteWeek in '..\Model\Reports\WeeklyIncompleteWeek\MRWMedicalExemptionsIncompleteWeek.pas',
  MRWLPUConsultationIncompleteWeek in '..\Model\Reports\WeeklyIncompleteWeek\MRWLPUConsultationIncompleteWeek.pas',
  MRWCancellation_KrayIncomlpeteWeek in '..\Model\Reports\WeeklyIncompleteWeek\MRWCancellation_KrayIncomlpeteWeek.pas',
  MRWResultsOfTheProductsIncompleteWeek2 in '..\Model\Reports\WeeklyIncompleteWeek\MRWResultsOfTheProductsIncompleteWeek2.pas',
  MMMonthlyPlan in '..\Model\MonthlyPlan\MMMonthlyPlan.pas',
  VMMonthlyPlan in '..\View\MonthlyPlan\VMMonthlyPlan.pas',
  MMDeleteRecordMonthlyPlan in '..\Model\MonthlyPlan\MMDeleteRecordMonthlyPlan.pas',
  MMChangeRecordMonthlyPlan in '..\Model\MonthlyPlan\MMChangeRecordMonthlyPlan.pas',
  MMAddRecoedMonthlyPlan in '..\Model\MonthlyPlan\MMAddRecoedMonthlyPlan.pas',
  UVFListBox in '..\View\FormObjects\UVFListBox.pas',
  MMListOfDate in '..\Model\MonthlyPlan\MMListOfDate.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyMainForm, MyMainForm);
  Application.Run;
end.
