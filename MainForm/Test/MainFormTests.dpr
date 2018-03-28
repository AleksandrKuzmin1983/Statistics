program MainFormTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  GetAdoConnect in '..\..\BaseAdapters\Connect\GetAdoConnect.pas',
  TestGetAdoQuery in 'Model\Connect\TestGetAdoQuery.pas',
  BHAAddRecordAutomaticApheresis in '..\..\BaseAdapters\HarvestingOfTheDay\AutomaticApheresis\BHAAddRecordAutomaticApheresis.pas',
  TestUCheckNull in 'Model\System\TestUCheckNull.pas',
  USCheckNull in '..\..\System\USCheckNull.pas',
  TestMHAAddRecordAutomaticApheresis in 'Model\HarvestingOfTheDay\AutomaticApheresis\TestMHAAddRecordAutomaticApheresis.pas';

{$R *.res}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.

