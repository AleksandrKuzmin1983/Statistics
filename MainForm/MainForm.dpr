program MainForm;

uses
  Forms,
  MainFormUnit1 in 'MainFormUnit1.pas' {MyMainForm},
  ConnectingUnit1 in 'ConnectingUnit1.pas',
  GetDataSoursUnit1 in 'GetDataSoursUnit1.pas',
  Query1Unit1 in 'Query1Unit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyMainForm, MyMainForm);
  Application.Run;

end.
