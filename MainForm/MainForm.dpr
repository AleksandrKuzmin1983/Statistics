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
  VIOAAdviceToDoctors in '..\View\InformationForWeeklyReport\Other\AdviceToDoctors\VIOAAdviceToDoctors.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyMainForm, MyMainForm);
  Application.Run;

end.
