program MainForm;

uses
  Forms,
  MainFormUnit1 in 'MainFormUnit1.pas' {MyMainForm},
  GetDataSoursUnit1 in '..\Model\Connect\GetDataSoursUnit1.pas',
  VQNNumberOfDonations in '..\View\Queries\NumberOfDonations\VQNNumberOfDonations.pas',
  MQNTheNumberOfBloodDonations in '..\Model\Queries\NumberOfDonations\MQNTheNumberOfBloodDonations.pas',
  MQNTheNumberOfPlasmaDonations in '..\Model\Queries\NumberOfDonations\MQNTheNumberOfPlasmaDonations.pas',
  MQNTheNumberOfTromboDonations in '..\Model\Queries\NumberOfDonations\MQNTheNumberOfTromboDonations.pas',
  MQBTheNumberOfConservedBlood in '..\Model\Queries\BloodProduct\MQBTheNumberOfConservedBlood.pas',
  VQBBloodProduct in '..\View\Queries\BloodProduct\VQBBloodProduct.pas',
  MQBTheNumberOfWholeBlood in '..\Model\Queries\BloodProduct\MQBTheNumberOfWholeBlood.pas',
  UCheckNull in '..\Model\System\UCheckNull.pas',
  UMSMoldCleaning in '..\Model\System\UMSMoldCleaning.pas',
  UVFLabel in '..\View\FormObjects\UVFLabel.pas',
  UVFTitleLabel in '..\View\FormObjects\UVFTitleLabel.pas',
  UVFEdit in '..\View\FormObjects\UVFEdit.pas',
  UVFDateTimePicker in '..\View\FormObjects\UVFDateTimePicker.pas',
  UVFBitBtn in '..\View\FormObjects\UVFBitBtn.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyMainForm, MyMainForm);
  Application.Run;

end.
