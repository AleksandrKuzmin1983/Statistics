program MainForm;

uses
  Forms,
  MainFormUnit1 in 'MainFormUnit1.pas' {MyMainForm} ,
  GetDataSoursUnit1 in '..\Model\Connect\GetDataSoursUnit1.pas',
  VQNNumberOfDonations
    in '..\View\Queries\NumberOfDonations\VQNNumberOfDonations.pas',
  MQNTheNumberOfBloodDonations
    in '..\Model\Queries\NumberOfDonations\MQNTheNumberOfBloodDonations.pas',
  MQNTheNumberOfPlasmaDonations
    in '..\Model\Queries\NumberOfDonations\MQNTheNumberOfPlasmaDonations.pas',
  MQNTheNumberOfTromboDonations
    in '..\Model\Queries\NumberOfDonations\MQNTheNumberOfTromboDonations.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyMainForm, MyMainForm);
  Application.Run;

end.
