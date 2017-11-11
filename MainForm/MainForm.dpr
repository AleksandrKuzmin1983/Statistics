program MainForm;

uses
  Forms,
  MainFormUnit1 in 'MainFormUnit1.pas' {MyMainForm},
  ConnectingUnit1 in 'ConnectingUnit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyMainForm, MyMainForm);
  Application.Run;

end.
