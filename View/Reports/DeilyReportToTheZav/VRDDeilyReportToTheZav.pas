unit VRDDeilyReportToTheZav;

interface
uses
  Winapi.Windows, System.SysUtils, Vcl.Controls, Vcl.Forms, Vcl.Menus,
  frxClass, frxDBSet, frxPreview, frxExportPDF, System.Win.Registry,
  MRDDeilyReportToTheZav,
  MRDPlanDeilyReportToTheZav,
  MRDStatInfoDeilyReportToTheZav,
  UVFMainMenu,
  UMSGlobalVariant;

type
  TVRDDeilyReportToTheZav = class(TGlobalVariant)
  private
    TempForm: TForm;
    frxTempReport: TfrxReport;
    frxTempPreview: TfrxPreview;
    frxTempExportPDF:TfrxPDFExport;
    DailyReportTheZav: IMRDDeilyReportToTheZav;
    PlanDeilyReportToTheZav: IMRDPlanDeilyReportToTheZav;
    StatInfoDeilyReportToTheZav: IMRDStatInfoDeilyReportToTheZav;
    MainMenu: TUVFMainMenu;
    procedure GetReport(CurrentForm: TForm);
    procedure GetMainMenu;
    procedure OnClickMenuClose(Sender: TObject);
    procedure OnClickPrintReport(Sender: TObject);
    procedure OnClickExportPDF(Sender: TObject);
    function GetDesktopFolderPath: string;
    { Private declarations }
  public
    constructor Create(form: TForm);  override;
    destructor destroy;   override;
    { Public declarations }
  end;

implementation

{ TVRDDailyReportTheKrayVer2 }

constructor TVRDDeilyReportToTheZav.Create(form: TForm);
begin
  TempForm:=form;
  GetMainMenu;
  with TempForm do
  begin
    BorderStyle:=bsSingle;
    Position:=poScreenCenter;
    BorderIcons:=BorderIcons-[biSystemMenu];
    Width := 860;
    Height:=750;
  end;
  GetReport(TempForm);
  frxTempReport.ShowReport;
  TempForm.ShowModal;
  inherited;
end;

destructor TVRDDeilyReportToTheZav.destroy;
begin
  FreeAndNil(frxTempPreview);
  FreeAndNil(frxTempReport);
  MainMenu.destroy;
  inherited;
end;

procedure TVRDDeilyReportToTheZav.GetMainMenu;
begin
  if not Assigned(MainMenu) then
    MainMenu := TUVFMainMenu.create;
  MainMenu.GetTempMainMenu(TempForm);
  MainMenu.OnClickCloseForm(OnClickMenuClose);
  MainMenu.OnClickPrintReport(OnClickPrintReport);
  MainMenu.OnClickExportPDF(OnClickExportPDF);
end;

procedure TVRDDeilyReportToTheZav.GetReport(CurrentForm: TForm);
var
  CurrentDir: string;
begin
  CurrentDir:=ExtractFileDir(ExtractFileDir(ParamStr(0)));
  if not Assigned(DailyReportTheZav) then
    DailyReportTheZav := TMRDDeilyReportToTheZav.create;

  if not Assigned(PlanDeilyReportToTheZav) then
    PlanDeilyReportToTheZav := TMRDPlanDeilyReportToTheZav.create;

  if not Assigned(StatInfoDeilyReportToTheZav) then
    StatInfoDeilyReportToTheZav := TMRDStatInfoDeilyReportToTheZav.create;

  if not Assigned(frxTempPreview) then
    frxTempPreview:=TfrxPreview.Create(CurrentForm);
  frxTempPreview.Parent:=CurrentForm;
  frxTempPreview.Align:=alClient;

  if not Assigned(frxTempReport) then
    frxTempReport:=TfrxReport.Create(CurrentForm);
  frxTempReport.Clear;
  frxTempReport.Preview:=frxTempPreview;

  frxTempReport.LoadFromFile(CurrentDir + '\Model\Reports\DeilyReportToTheZav\DeilyReportToTheZav.fr3');

  frxTempReport.Variables.Variables['VolumeWholeBlood']:='''' + DailyReportTheZav.GetVolumeWholeBlood + '''';
  frxTempReport.Variables.Variables['PercentWholeBlood']:='''' + DailyReportTheZav.GetPercentWholeBlood + '''';
  frxTempReport.Variables.Variables['VolumeConsBlood']:='''' + DailyReportTheZav.GetVolumeConsBlood + '''';
  frxTempReport.Variables.Variables['PercentConsBlood']:='''' + DailyReportTheZav.GetPercentConsBlood + '''';
  frxTempReport.Variables.Variables['VolumePlasmaTotal']:='''' + DailyReportTheZav.GetVolumePlasmaTotal + '''';
  frxTempReport.Variables.Variables['PercentPlasmaTotal']:='''' + DailyReportTheZav.GetPercentPlasmaTotal + '''';
  frxTempReport.Variables.Variables['VolumePlasmaAPA']:='''' + DailyReportTheZav.GetVolumePlasmaAPA + '''';
  frxTempReport.Variables.Variables['PercentPlasmaAPA']:='''' + DailyReportTheZav.GetPercentPlasmaAPA + '''';
  frxTempReport.Variables.Variables['VolumeErSusp']:='''' + DailyReportTheZav.GetVolumeErSusp + '''';
  frxTempReport.Variables.Variables['PercentErSusp']:='''' + DailyReportTheZav.GetPercentErSusp + '''';
  frxTempReport.Variables.Variables['VolumeTrombo']:='''' + DailyReportTheZav.GetVolumeTrombo + '''';
  frxTempReport.Variables.Variables['NumberDosesTromb']:='''' + DailyReportTheZav.GetNumberDosesTromb + '''';
  frxTempReport.Variables.Variables['NumberPacketsTromb']:='''' + DailyReportTheZav.GetNumberPacketsTromb + '''';

  frxTempReport.Variables.Variables['PlanVolumeWholeBlood']:='''' + PlanDeilyReportToTheZav.GetPlanVolumeWholeBlood + '''';
  frxTempReport.Variables.Variables['PlanVolumeConsBlood']:='''' + PlanDeilyReportToTheZav.GetPlanVolumeConsBlood + '''';
  frxTempReport.Variables.Variables['PlanVolumePlasmaTotal']:='''' + PlanDeilyReportToTheZav.GetPlanVolumePlasmaTotal + '''';
  frxTempReport.Variables.Variables['PlanVolumePlasmaAPA']:='''' + PlanDeilyReportToTheZav.GetPlanVolumePlasmaAPA + '''';
  frxTempReport.Variables.Variables['PlanVolumeErSusp']:='''' + PlanDeilyReportToTheZav.GetPlanVolumeErSusp + '''';
  frxTempReport.Variables.Variables['PlanBloodProcedures']:='''' + PlanDeilyReportToTheZav.GetPlanBloodProcedures + '''';
  frxTempReport.Variables.Variables['PlanAPAProcedures']:='''' + PlanDeilyReportToTheZav.GetPlanAPAProcedures + '''';
  frxTempReport.Variables.Variables['PlanTromboProcedures']:='''' + PlanDeilyReportToTheZav.GetPlanTromboProcedures + '''';
  frxTempReport.Variables.Variables['WorksDay']:='''' + PlanDeilyReportToTheZav.GetWorksDay + '''';

  frxTempReport.Variables.Variables['BloodNumberProceduresDone']:='''' + StatInfoDeilyReportToTheZav.GetBloodNumberProceduresDone + '''';
  frxTempReport.Variables.Variables['BloodRestImplementationOfThePlan']:='''' + StatInfoDeilyReportToTheZav.GetBloodRestImplementationOfThePlan + '''';
  frxTempReport.Variables.Variables['BloodPercentageOfPlanProcedures']:='''' + StatInfoDeilyReportToTheZav.GetBloodPercentageOfPlanProcedures + '''';
  frxTempReport.Variables.Variables['BloodTheNumberOfTreatmentsPerDay']:='''' + StatInfoDeilyReportToTheZav.GetBloodTheNumberOfTreatmentsPerDay + '''';
  frxTempReport.Variables.Variables['BloodTheNumberOfTreatmentsPerDayWholeBlood']:='''' + StatInfoDeilyReportToTheZav.GetBloodTheNumberOfTreatmentsPerDayWholeBlood + '''';
  frxTempReport.Variables.Variables['BloodNumberWholeBloodAtTheMomentToMatchThePlan']:='''' + StatInfoDeilyReportToTheZav.GetBloodNumberWholeBloodAtTheMomentToMatchThePlan + '''';
  frxTempReport.Variables.Variables['PlasmaNumberProceduresDone']:='''' + StatInfoDeilyReportToTheZav.GetPlasmaNumberProceduresDone + '''';
  frxTempReport.Variables.Variables['PlasmaRestImplementationOfThePlan']:='''' + StatInfoDeilyReportToTheZav.GetPlasmaRestImplementationOfThePlan + '''';
  frxTempReport.Variables.Variables['PlasmaPercentageOfPlanProcedures']:='''' + StatInfoDeilyReportToTheZav.GetPlasmaPercentageOfPlanProcedures + '''';
  frxTempReport.Variables.Variables['PlasmaTheNumberOfTreatmentsPerDay']:='''' + StatInfoDeilyReportToTheZav.GetPlasmaTheNumberOfTreatmentsPerDay + '''';
  frxTempReport.Variables.Variables['TromboNumberProceduresDone']:='''' + StatInfoDeilyReportToTheZav.GetTromboNumberProceduresDone + '''';
  frxTempReport.Variables.Variables['TromboRestImplementationOfThePlan']:='''' + StatInfoDeilyReportToTheZav.GetTromboRestImplementationOfThePlan + '''';
  frxTempReport.Variables.Variables['TromboPercentageOfPlanProcedures']:='''' + StatInfoDeilyReportToTheZav.GetTromboPercentageOfPlanProcedures + '''';
  frxTempReport.Variables.Variables['TromboTheNumberOfTreatmentsPerDay']:='''' + StatInfoDeilyReportToTheZav.GetTromboTheNumberOfTreatmentsPerDay + '''';
end;

procedure TVRDDeilyReportToTheZav.OnClickExportPDF(Sender: TObject);
begin
  if not Assigned(frxTempExportPDF) then
    frxTempExportPDF:=TfrxPDFExport.Create(TempForm);
  frxTempExportPDF.FileName:='Ежедневный отчет для заведующей за ' + DateToStr(date()) + '. Лесосибирский филиал.';
  frxTempExportPDF.DefaultPath:=GetDesktopFolderPath + '\';
  frxTempReport.Export(frxTempExportPDF);
  frxTempReport.ShowReport;
end;

procedure TVRDDeilyReportToTheZav.OnClickMenuClose(Sender: TObject);
begin
  TempForm.ModalResult:=mrOk;
end;

procedure TVRDDeilyReportToTheZav.OnClickPrintReport(Sender: TObject);
begin
  frxTempReport.Print;
end;

function TVRDDeilyReportToTheZav.GetDesktopFolderPath: string;
var
  R: TRegistry;
begin
  R:=TRegistry.Create;
  R.RootKey:=HKEY_CURRENT_USER;
  R.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders',False);
  Result:=R.ReadString('Desktop');
  R.CloseKey;
  R.Free;
end;
end.
