program MainForm;

uses
  Forms,
  MainFormUnit1 in 'MainFormUnit1.pas' {MyMainForm},
  GetDataSoursUnit1 in '..\Model\Connect\GetDataSoursUnit1.pas',
  QNumberOfDonations in '..\View\Queries\NumberOfDonations\QNumberOfDonations.pas',
  UTheNumberOfBloodDonations in '..\Model\Queries\NumberOfDonations\UTheNumberOfBloodDonations.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyMainForm, MyMainForm);
  Application.Run;

end.
