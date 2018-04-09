unit MRDDeilyReportToTheZav;

interface

uses
  System.Classes, Winapi.Windows, System.SysUtils, CodeSiteLogging, Vcl.Controls, Vcl.Forms,
  Vcl.Menus, frxClass, frxDBSet, frxPreview, frxExportPDF, System.Win.Registry,
  BRDDeilyReportToTheZav,
  BRDPlanDeilyReportToTheZav,
  BRDStatInfoDeilyReportToTheZav,
  MFMainMenu,
  USGlobalVariant;

type
  TMRDDeilyReportToTheZav = class(TUSGlobalVariant)
  private
    TempForm: TForm;
    frxTempReport: TfrxReport;
    frxTempPreview: TfrxPreview;
    frxTempExportPDF: TfrxPDFExport;
    DailyReportTheZav: IBRDDeilyReportToTheZav;
    PlanDeilyReportToTheZav: IBRDPlanDeilyReportToTheZav;
    StatInfoDeilyReportToTheZav: IBRDStatInfoDeilyReportToTheZav;
    MainMenu: TMFMainMenu;
    procedure GetReport(CurrentForm: TForm);
    procedure GetMainMenu;
    procedure OnClickMenuClose(Sender: TObject);
    procedure OnClickPrintReport(Sender: TObject);
    procedure OnClickExportPDF(Sender: TObject);
    function GetDesktopFolderPath: string;
    procedure PreviewMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    { Private declarations }
  public
    constructor Create(form: TForm); override;
    destructor destroy; override;
    { Public declarations }
  end;

implementation

{ TVRDDailyReportTheKrayVer2 }

constructor TMRDDeilyReportToTheZav.Create(form: TForm);
begin
  TempForm := form;
  GetMainMenu;
  with TempForm do
  begin
    BorderStyle := bsSingle;
    Position := poScreenCenter;
    BorderIcons := BorderIcons - [biSystemMenu];
    Width := 860;
    Height := 750;
    OnMouseWheel := PreviewMouseWheel;
  end;
  GetReport(TempForm);
  frxTempReport.ShowReport;
  TempForm.ShowModal;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav.Create выполнена');
  inherited;
end;

destructor TMRDDeilyReportToTheZav.destroy;
begin
  FreeAndNil(frxTempPreview);
  FreeAndNil(frxTempReport);
  MainMenu.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav.destroy выполнена');
  inherited;
end;

procedure TMRDDeilyReportToTheZav.GetMainMenu;
begin
  if not Assigned(MainMenu) then
    MainMenu := TMFMainMenu.Create;
  MainMenu.GetTempMainMenu(TempForm);
  MainMenu.OnClickCloseForm(OnClickMenuClose);
  MainMenu.OnClickPrintReport(OnClickPrintReport);
  MainMenu.OnClickExportPDF(OnClickExportPDF);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav.GetMainMenu выполнена');
end;

procedure TMRDDeilyReportToTheZav.GetReport(CurrentForm: TForm);
var
  CurrentDir: string;
begin
  CurrentDir := ExtractFileDir(ExtractFileDir(ParamStr(0)));
  if not Assigned(DailyReportTheZav) then
    DailyReportTheZav := TBRDDeilyReportToTheZav.Create;

  if not Assigned(PlanDeilyReportToTheZav) then
    PlanDeilyReportToTheZav := TBRDPlanDeilyReportToTheZav.Create;

  if not Assigned(StatInfoDeilyReportToTheZav) then
    StatInfoDeilyReportToTheZav := TBRDStatInfoDeilyReportToTheZav.Create;

  if not Assigned(frxTempPreview) then
    frxTempPreview := TfrxPreview.Create(CurrentForm);
  frxTempPreview.Parent := CurrentForm;
  frxTempPreview.Align := alClient;

  if not Assigned(frxTempReport) then
    frxTempReport := TfrxReport.Create(CurrentForm);
  frxTempReport.Clear;
  frxTempReport.Preview := frxTempPreview;

  frxTempReport.LoadFromFile(CurrentDir +
    '\BaseAdapters\Reports\DeilyReportToTheZav\DeilyReportToTheZav.fr3');

  frxTempReport.Variables.Variables['VolumeWholeBlood'] :=
    '''' + DailyReportTheZav.GetVolumeWholeBlood + '''';
  frxTempReport.Variables.Variables['PercentWholeBlood'] :=
    '''' + DailyReportTheZav.GetPercentWholeBlood + '''';
  frxTempReport.Variables.Variables['VolumeConsBlood'] :=
    '''' + DailyReportTheZav.GetVolumeConsBlood + '''';
  frxTempReport.Variables.Variables['PercentConsBlood'] :=
    '''' + DailyReportTheZav.GetPercentConsBlood + '''';
  frxTempReport.Variables.Variables['VolumePlasmaTotal'] :=
    '''' + DailyReportTheZav.GetVolumePlasmaTotal + '''';
  frxTempReport.Variables.Variables['PercentPlasmaTotal'] :=
    '''' + DailyReportTheZav.GetPercentPlasmaTotal + '''';
  frxTempReport.Variables.Variables['VolumePlasmaAPA'] :=
    '''' + DailyReportTheZav.GetVolumePlasmaAPA + '''';
  frxTempReport.Variables.Variables['PercentPlasmaAPA'] :=
    '''' + DailyReportTheZav.GetPercentPlasmaAPA + '''';
  frxTempReport.Variables.Variables['VolumeErSusp'] :=
    '''' + DailyReportTheZav.GetVolumeErSusp + '''';
  frxTempReport.Variables.Variables['PercentErSusp'] :=
    '''' + DailyReportTheZav.GetPercentErSusp + '''';
  frxTempReport.Variables.Variables['VolumeTrombo'] :=
    '''' + DailyReportTheZav.GetVolumeTrombo + '''';
  frxTempReport.Variables.Variables['NumberDosesTromb'] :=
    '''' + DailyReportTheZav.GetNumberDosesTromb + '''';
  frxTempReport.Variables.Variables['NumberPacketsTromb'] :=
    '''' + DailyReportTheZav.GetNumberPacketsTromb + '''';

  frxTempReport.Variables.Variables['PlanVolumeWholeBlood'] :=
    '''' + PlanDeilyReportToTheZav.GetPlanVolumeWholeBlood + '''';
  frxTempReport.Variables.Variables['PlanVolumeConsBlood'] :=
    '''' + PlanDeilyReportToTheZav.GetPlanVolumeConsBlood + '''';
  frxTempReport.Variables.Variables['PlanVolumePlasmaTotal'] :=
    '''' + PlanDeilyReportToTheZav.GetPlanVolumePlasmaTotal + '''';
  frxTempReport.Variables.Variables['PlanVolumePlasmaAPA'] :=
    '''' + PlanDeilyReportToTheZav.GetPlanVolumePlasmaAPA + '''';
  frxTempReport.Variables.Variables['PlanVolumeErSusp'] :=
    '''' + PlanDeilyReportToTheZav.GetPlanVolumeErSusp + '''';
  frxTempReport.Variables.Variables['PlanBloodProcedures'] :=
    '''' + PlanDeilyReportToTheZav.GetPlanBloodProcedures + '''';
  frxTempReport.Variables.Variables['PlanAPAProcedures'] :=
    '''' + PlanDeilyReportToTheZav.GetPlanAPAProcedures + '''';
  frxTempReport.Variables.Variables['PlanTromboProcedures'] :=
    '''' + PlanDeilyReportToTheZav.GetPlanTromboProcedures + '''';
  frxTempReport.Variables.Variables['WorksDay'] :=
    '''' + PlanDeilyReportToTheZav.GetWorksDay + '''';

  frxTempReport.Variables.Variables['BloodNumberProceduresDone'] :=
    '''' + StatInfoDeilyReportToTheZav.GetBloodNumberProceduresDone + '''';
  frxTempReport.Variables.Variables['BloodRestImplementationOfThePlan'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetBloodRestImplementationOfThePlan + '''';
  frxTempReport.Variables.Variables['BloodPercentageOfPlanProcedures'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetBloodPercentageOfPlanProcedures + '''';
  frxTempReport.Variables.Variables['BloodTheNumberOfTreatmentsPerDay'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetBloodTheNumberOfTreatmentsPerDay + '''';
  frxTempReport.Variables.Variables
    ['BloodTheNumberOfTreatmentsPerDayWholeBlood'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetBloodTheNumberOfTreatmentsPerDayWholeBlood + '''';
  frxTempReport.Variables.Variables
    ['BloodNumberWholeBloodAtTheMomentToMatchThePlan'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetBloodNumberWholeBloodAtTheMomentToMatchThePlan + '''';
  frxTempReport.Variables.Variables['PlasmaNumberProceduresDone'] :=
    '''' + StatInfoDeilyReportToTheZav.GetPlasmaNumberProceduresDone + '''';
  frxTempReport.Variables.Variables['PlasmaRestImplementationOfThePlan'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetPlasmaRestImplementationOfThePlan + '''';
  frxTempReport.Variables.Variables['PlasmaPercentageOfPlanProcedures'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetPlasmaPercentageOfPlanProcedures + '''';
  frxTempReport.Variables.Variables['PlasmaTheNumberOfTreatmentsPerDay'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetPlasmaTheNumberOfTreatmentsPerDay + '''';
  frxTempReport.Variables.Variables['TromboNumberProceduresDone'] :=
    '''' + StatInfoDeilyReportToTheZav.GetTromboNumberProceduresDone + '''';
  frxTempReport.Variables.Variables['TromboRestImplementationOfThePlan'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetTromboRestImplementationOfThePlan + '''';
  frxTempReport.Variables.Variables['TromboPercentageOfPlanProcedures'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetTromboPercentageOfPlanProcedures + '''';
  frxTempReport.Variables.Variables['TromboTheNumberOfTreatmentsPerDay'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetTromboTheNumberOfTreatmentsPerDay + '''';
  frxTempReport.Variables.Variables['BloodTheNumberOfTreatmentsPerDayErSusp'] :=
    '''' + StatInfoDeilyReportToTheZav.
    GetBloodTheNumberOfTreatmentsPerDayErSusp + '''';

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav.GetReport выполнена');
end;

procedure TMRDDeilyReportToTheZav.OnClickExportPDF(Sender: TObject);
begin
  if not Assigned(frxTempExportPDF) then
    frxTempExportPDF := TfrxPDFExport.Create(TempForm);
  frxTempExportPDF.FileName := 'Ежедневный отчет для заведующей за ' +
    DateToStr(date()) + '. Лесосибирский филиал.pdf';
  frxTempExportPDF.DefaultPath := GetDesktopFolderPath + '\';
  frxTempReport.Export(frxTempExportPDF);
  frxTempReport.ShowReport;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav.OnClickExportPDF выполнена');
end;

procedure TMRDDeilyReportToTheZav.OnClickMenuClose(Sender: TObject);
begin
  TempForm.ModalResult := mrOk;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav.OnClickMenuClose выполнена');
end;

procedure TMRDDeilyReportToTheZav.OnClickPrintReport(Sender: TObject);
begin
  frxTempReport.Print;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav.OnClickPrintReport выполнена');
end;

function TMRDDeilyReportToTheZav.GetDesktopFolderPath: string;
var
  R: TRegistry;
begin
  R := TRegistry.Create;
  R.RootKey := HKEY_CURRENT_USER;
  R.OpenKey(
    '\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False);
  Result := R.ReadString('Desktop');
  R.CloseKey;
  R.Free;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav.GetDesktopFolderPath выполнена');
end;

procedure TMRDDeilyReportToTheZav.PreviewMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  frxTempPreview.MouseWheelScroll(WheelDelta);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRDDeilyReportToTheZav.PreviewMouseWheel выполнена');
end;
end.
