program KKCKLFTests;
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
  TestGetAdoConnect in 'BaseAdapters\Connect\TestGetAdoConnect.pas',
  GetAdoConnect in '..\BaseAdapters\Connect\GetAdoConnect.pas',
  TestMFBitBtn in 'Model\FormObjects\TestMFBitBtn.pas',
  MFBitBtn in '..\Model\FormObjects\MFBitBtn.pas',
  MHAAutomaticApheresis in '..\Model\HarvestingOfTheDay\AutomaticApheresis\MHAAutomaticApheresis.pas',
  USCheckFillStringFields in '..\Systems\USCheckFillStringFields.pas',
  USBlockMainMenu in '..\Systems\USBlockMainMenu.pas',
  MFBitBtnAdd in '..\Model\FormObjects\MFBitBtnAdd.pas',
  MFBitBtnBlock in '..\Model\FormObjects\MFBitBtnBlock.pas',
  MFBitBtnDelete in '..\Model\FormObjects\MFBitBtnDelete.pas',
  MFBitBtnEdit in '..\Model\FormObjects\MFBitBtnEdit.pas',
  MFComboBox in '..\Model\FormObjects\MFComboBox.pas',
  MFDateTimePicker in '..\Model\FormObjects\MFDateTimePicker.pas',
  MFEdit in '..\Model\FormObjects\MFEdit.pas',
  MFLabel in '..\Model\FormObjects\MFLabel.pas',
  MFPanel in '..\Model\FormObjects\MFPanel.pas',
  MFStringGrid in '..\Model\FormObjects\MFStringGrid.pas',
  MFTitleLabel in '..\Model\FormObjects\MFTitleLabel.pas',
  USContentOfTheList in '..\Systems\USContentOfTheList.pas',
  BHAAutomaticApheresis in 'BaseAdapters\HarvestingOfTheDay\AutomaticApheresis\BHAAutomaticApheresis.pas',
  BHADeleteRecordAutomaticApheresis in 'BaseAdapters\HarvestingOfTheDay\AutomaticApheresis\BHADeleteRecordAutomaticApheresis.pas',
  BHAChangeRecordAutomaticApheresis in 'BaseAdapters\HarvestingOfTheDay\AutomaticApheresis\BHAChangeRecordAutomaticApheresis.pas',
  BHAAddRecordAutomaticApheresis in 'BaseAdapters\HarvestingOfTheDay\AutomaticApheresis\BHAAddRecordAutomaticApheresis.pas',
  USCheckForExistenceOfRecord in '..\Systems\USCheckForExistenceOfRecord.pas',
  USValueChecksOnTheAdequacy in '..\Systems\USValueChecksOnTheAdequacy.pas',
  USCheckNull in '..\Systems\USCheckNull.pas',
  USGlobalVariant in '..\Systems\USGlobalVariant.pas',
  TestMHAAutomaticApheresis in 'Model\HarvestingOfTheDay\AutomaticApheresis\TestMHAAutomaticApheresis.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.

