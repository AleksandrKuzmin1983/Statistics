program MainForm;

uses
  Forms,
  MainFormUnit1 in 'MainFormUnit1.pas' {MyMainForm},
  GetDataSoursUnit1 in '..\Model\GetDataSoursUnit1.pas',
  Query1Unit1 in '..\Model\Query1Unit1.pas',
  Query2Unit1 in '..\Model\Query2Unit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyMainForm, MyMainForm);
  Application.Run;

end.
