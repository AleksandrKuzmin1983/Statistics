unit MRWWeeklyIncompleteWeek;

interface
uses
  Winapi.Windows, System.SysUtils, Vcl.Controls, Vcl.Forms, Vcl.Menus, System.Classes,
  frxClass, frxDBSet, frxPreview, frxExportPDF, System.Win.Registry, dialogs, variants,
  BRWIncompleteWeekFirstTable,
  BRWTableForDefectIncompleteWeek,
  BRWLPUConsultationIncompleteWeek,
  BRWResultsOfTheProductsIncompleteWeek,
  BRWResultsOfTheProductsIncompleteWeek2,
  BRWDonorsAndProceduresIncompleteWeek,
  BRWDonorsAndProceduresIncompleteWeekOuting,
  BRWMedicalExemptionsIncompleteWeek,
  BRWCancellation_KrayIncomlpeteWeek,
  BRWSecondTableIncompleteWeek,
  MFMainMenu,
  USGlobalVariant;

type
  TVRWWeeklyIncompleteWeek = class(TGlobalVariant)
  private
    TempForm: TForm;
    frxTempReport: TfrxReport;
    frxTempPreview: TfrxPreview;
    frxTempExportPDF:TfrxPDFExport;
    frxDefect: TfrxUserDataSet;

    frxTempMasterData: TfrxMasterData;
    frxTempPage: TfrxReportPage;
    frxTempMemo: TfrxMemoView;

    RecNumber: integer;
    ar: array[0..10, 0..1] of string;
    IncompleteWeekFirstTable: IMRWIncompleteWeekFirstTable;
    TableForDefectIncompleteWeek: IMRWTableForDefectIncompleteWeek;
    ResultsOfTheProductsIncompleteWeek: IMRWResultsOfTheProductsIncompleteWeek;
    ResultsOfTheProductsIncompleteWeek2: IMRWResultsOfTheProductsIncompleteWeek2;
    DonorsAndProceduresIncompleteWeek: IMRWDonorsAndProceduresIncompleteWeek;
    DonorsAndProceduresIncompleteWeekOuting: IMRWDonorsAndProceduresIncompleteWeekOuting;
    MedicalExemptionsIncompleteWeek: IMRWMedicalExemptionsIncompleteWeek;
    Cancellation_KrayIncomlpeteWeek: IMRWCancellation_KrayIncomlpeteWeek;
    LPUConsultationIncompleteWeek: IMRWLPUConsultationIncompleteWeek;
    SecondTableIncompleteWeek: IMRWSecondTableIncompleteWeek;

    MainMenu: TUVFMainMenu;
    procedure GetReport(CurrentForm: TForm);
    procedure GetMainMenu;
    procedure OnClickMenuClose(Sender: TObject);
    procedure OnClickPrintReport(Sender: TObject);
    procedure OnClickExportPDF(Sender: TObject);
    procedure frxDefectGetValue(const VarName: String; var Value: Variant);
    procedure PreviewMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    function GetDesktopFolderPath: string;
    { Private declarations }
  public
    constructor Create(form: TForm);  override;
    destructor destroy;   override;
    { Public declarations }
  end;

implementation

{ TVRDDailyReportTheKrayVer2 }

constructor TVRWWeeklyIncompleteWeek.Create(form: TForm);
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
    OnMouseWheel:=PreviewMouseWheel;
  end;
  GetReport(TempForm);
  frxTempReport.ShowReport;
  TempForm.ShowModal;
  inherited;
end;

destructor TVRWWeeklyIncompleteWeek.destroy;
begin
  FreeAndNil(frxTempPreview);
  FreeAndNil(frxTempReport);
  MainMenu.destroy;
  inherited;
end;

procedure TVRWWeeklyIncompleteWeek.GetMainMenu;
begin
  if not Assigned(MainMenu) then
    MainMenu := TUVFMainMenu.create;
  MainMenu.GetTempMainMenu(TempForm);
  MainMenu.OnClickCloseForm(OnClickMenuClose);
  MainMenu.OnClickPrintReport(OnClickPrintReport);
  MainMenu.OnClickExportPDF(OnClickExportPDF);
end;

procedure TVRWWeeklyIncompleteWeek.GetReport(CurrentForm: TForm);
var
  CurrentDir: string;
  i: integer;
begin
  if not Assigned(frxTempPreview) then
    frxTempPreview:=TfrxPreview.Create(CurrentForm);
  frxTempPreview.Parent:=CurrentForm;
  frxTempPreview.Align:=alClient;
  if not Assigned(frxTempReport) then
    frxTempReport:=TfrxReport.Create(CurrentForm);
  frxTempReport.Clear;
  frxTempReport.Preview:=frxTempPreview;
  CurrentDir:=ExtractFileDir(ExtractFileDir(ParamStr(0)));
  frxTempReport.LoadFromFile(CurrentDir + '\BaseAdapters\Reports\WeeklyIncompleteWeek\IncompleteWeek.fr3');
  if not Assigned(frxDefect) then
    frxDefect := TfrxUserDataSet.create(CurrentForm);
  frxTempMasterData:=frxTempReport.FindObject('MasterData1') as TfrxMasterData;
  frxTempMasterData.DataSet:=frxDefect;
  frxTempReport.OnGetValue:=frxDefectGetValue;
  if not Assigned(TableForDefectIncompleteWeek) then
    TableForDefectIncompleteWeek := TMRWTableForDefectIncompleteWeek.create;
  TableForDefectIncompleteWeek.GetContent;
  for i:=0 to TableForDefectIncompleteWeek.GetRowCount-1 do
  begin
    ar[i,0]:=TableForDefectIncompleteWeek.GetTypeOfDefect(i)+TableForDefectIncompleteWeek.GetTypeOfProduct(i);
    ar[i,1]:=TableForDefectIncompleteWeek.GetVolume(i);
  end;
  frxDefect.RangeEnd:=ReCount;
  frxDefect.RangeEndCount:=TableForDefectIncompleteWeek.GetRowCount;
// Заготовка план/факт
  if not Assigned(IncompleteWeekFirstTable) then
    IncompleteWeekFirstTable := TMRWIncompleteWeekFirstTable.create;
  for i := 0 to 14 do
    if i<=4 then
      frxTempReport.Variables.Variables['FirstTable' + IntToStr(i+1)]:='''' + IncompleteWeekFirstTable.GetValuePlan(i) + ''''
    else
      if i<=9 then
        frxTempReport.Variables.Variables['FirstTable' + IntToStr(i+1)]:='''' + IncompleteWeekFirstTable.GetValueLitr(i) + ''''
      else
        frxTempReport.Variables.Variables['FirstTable' + IntToStr(i+1)]:='''' + IncompleteWeekFirstTable.GetValuePercent(i) + '''';

  frxTempReport.Variables.Variables['VolumeTrombo']:='''' + IncompleteWeekFirstTable.GetValueLitr(15) + '''';
  frxTempReport.Variables.Variables['NumberDosesTromb']:='''' + IncompleteWeekFirstTable.GetValueTromboPacketsDoses(16) + '''';
  frxTempReport.Variables.Variables['NumberPacketsTromb']:='''' + IncompleteWeekFirstTable.GetValueTromboPacketsDoses(17) + '''';

//Заготовлено годной
  if not Assigned(SecondTableIncompleteWeek) then
    SecondTableIncompleteWeek := TMRWSecondTableIncompleteWeek.create;
  frxTempReport.Variables.Variables['ProductWholeBlood']:='''' + SecondTableIncompleteWeek.GetProductWholeBlood + '''';
  frxTempReport.Variables.Variables['VolumeReinfusion']:='''' + SecondTableIncompleteWeek.GetVolumeReinfusion + '''';
  frxTempReport.Variables.Variables['PreparedFitProductionErSuspFiltr']:='''' + SecondTableIncompleteWeek.GetPreparedFitProductionErSuspFiltr + '''';
  frxTempReport.Variables.Variables['PreparedFitProductionErSusp']:='''' + SecondTableIncompleteWeek.GetPreparedFitProductionErSusp + '''';
  frxTempReport.Variables.Variables['PreparedFitProductionSZP']:='''' + SecondTableIncompleteWeek.GetPreparedFitProductionSZP + '''';
  frxTempReport.Variables.Variables['OutingProductWholeBlood']:='''' + SecondTableIncompleteWeek.GetOutingProductWholeBlood + '''';
  frxTempReport.Variables.Variables['OutingPreparedFitProductionErSuspFiltr']:='''' + SecondTableIncompleteWeek.GetOutingPreparedFitProductionErSuspFiltr + '''';
  frxTempReport.Variables.Variables['OutingPreparedFitProductionErSusp']:='''' + SecondTableIncompleteWeek.GetOutingPreparedFitProductionErSusp + '''';
  frxTempReport.Variables.Variables['OutingPreparedFitProductionSZP']:='''' + SecondTableIncompleteWeek.GetOutingPreparedFitProductionSZP + '''';
//Выдача в ЛПУ
  if not Assigned(ResultsOfTheProductsIncompleteWeek) then
    ResultsOfTheProductsIncompleteWeek := TMRWResultsOfTheProductsIncompleteWeek.create;
  for i := 0 to 47 do
    if i<=15 then
      frxTempReport.Variables.Variables['ResultInLPU' + IntToStr(i+1)]:='''' + ResultsOfTheProductsIncompleteWeek.GetValueLitr(i) + ''''
    else
      if i<=31 then
        frxTempReport.Variables.Variables['ResultInLPU' + IntToStr(i+1)]:='''' + ResultsOfTheProductsIncompleteWeek.GetValueDoses(i) + ''''
      else
        frxTempReport.Variables.Variables['ResultInLPU' + IntToStr(i+1)]:='''' + ResultsOfTheProductsIncompleteWeek.GetValuePercent(i) + '''';

//Выдача в ЛПУ2
  if not Assigned(ResultsOfTheProductsIncompleteWeek2) then
    ResultsOfTheProductsIncompleteWeek2 := TMRWResultsOfTheProductsIncompleteWeek2.create;
  for i := 0 to 47 do
    if i<=15 then
      frxTempReport.Variables.Variables['2ResultInLPU' + IntToStr(i+1)]:='''' + ResultsOfTheProductsIncompleteWeek2.GetValueLitr(i) + ''''
    else
      if i<=31 then
        frxTempReport.Variables.Variables['2ResultInLPU' + IntToStr(i+1)]:='''' + ResultsOfTheProductsIncompleteWeek2.GetValueDoses(i) + ''''
      else
        frxTempReport.Variables.Variables['2ResultInLPU' + IntToStr(i+1)]:='''' + ResultsOfTheProductsIncompleteWeek2.GetValuePercent(i) + '''';

//Доноры и процедуры
  if not Assigned(DonorsAndProceduresIncompleteWeek) then
    DonorsAndProceduresIncompleteWeek := TMRWDonorsAndProceduresIncompleteWeek.create;
  frxTempReport.Variables.Variables['AddressedJust']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(0) + '''';
  frxTempReport.Variables.Variables['ExceptionTotal']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(1) + '''';
  frxTempReport.Variables.Variables['PreliminaryAnalysis']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(2) + '''';
  frxTempReport.Variables.Variables['AdmittedToDonation']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(3) + '''';
  frxTempReport.Variables.Variables['ProceduresTotal']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(4) + '''';
  frxTempReport.Variables.Variables['BloodProcedures']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(5) + '''';
  frxTempReport.Variables.Variables['PlasmaProceduresTotal']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(6) + '''';
  frxTempReport.Variables.Variables['APAProcedures']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(7) + '''';
  frxTempReport.Variables.Variables['TromboProcedures']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(8) + '''';
  frxTempReport.Variables.Variables['NotTaken']:='''' + DonorsAndProceduresIncompleteWeek.GetValue(9) + '''';
  if not Assigned(DonorsAndProceduresIncompleteWeekOuting) then
    DonorsAndProceduresIncompleteWeekOuting := TMRWDonorsAndProceduresIncompleteWeekOuting.create;
  frxTempReport.Variables.Variables['AddressedJustOuting']:='''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(0) + '''';
  frxTempReport.Variables.Variables['ExceptionTotalOuting']:='''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(1) + '''';
  frxTempReport.Variables.Variables['PreliminaryAnalysisOuting']:='''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(2) + '''';
  frxTempReport.Variables.Variables['AdmittedToDonationOuting']:='''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(3) + '''';
  frxTempReport.Variables.Variables['ProceduresTotalOuting']:='''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(4) + '''';
  frxTempReport.Variables.Variables['BloodProceduresOuting']:='''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(5) + '''';
  frxTempReport.Variables.Variables['NotTakenOuting']:='''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(6) + '''';
  //Отводы
  if not Assigned(MedicalExemptionsIncompleteWeek) then
    MedicalExemptionsIncompleteWeek := TMRWMedicalExemptionsIncompleteWeek.create;
  for i := 0 to 19 do
  begin
    frxTempReport.Variables.Variables['MedicalExemptions' + IntToStr(i+1)]:='''' + MedicalExemptionsIncompleteWeek.GetValueName(i) + '''';
    if StrToInt(MedicalExemptionsIncompleteWeek.GetValueNumber(i))=0 then frxTempReport.Variables.Variables['MedicalExemptionsNumber' + IntToStr(i+1)]:=''' '''
      else frxTempReport.Variables.Variables['MedicalExemptionsNumber' + IntToStr(i+1)]:='''' + MedicalExemptionsIncompleteWeek.GetValueNumber(i) + '''';
    if StrToInt(MedicalExemptionsIncompleteWeek.GetValueOuting(i))=0 then frxTempReport.Variables.Variables['MedicalExemptionsOutingNumber' + IntToStr(i+1)]:=''' '''
      else frxTempReport.Variables.Variables['MedicalExemptionsOutingNumber' + IntToStr(i+1)]:='''' + MedicalExemptionsIncompleteWeek.GetValueOuting(i) + '''';
  end;
  if not Assigned(LPUConsultationIncompleteWeek) then
    LPUConsultationIncompleteWeek := TMRWLPUConsultationIncompleteWeek.create;
  frxTempReport.Variables.Variables['Transfusiolog']:='''' + LPUConsultationIncompleteWeek.GetTransfusiolog + '''';
  frxTempReport.Variables.Variables['Laboratory']:='''' + LPUConsultationIncompleteWeek.GetLaboratory + '''';
  frxTempReport.Variables.Variables['CheckLPU']:='''' + LPUConsultationIncompleteWeek.GetCheckLPU + '''';
  if not Assigned(Cancellation_KrayIncomlpeteWeek) then
    Cancellation_KrayIncomlpeteWeek := TMRWCancellation_KrayIncomlpeteWeek.create;
  for i := 0 to 31 do
    if (i<=7) or ((i>=16) and (i<=23)) then
      frxTempReport.Variables.Variables['Kray' + IntToStr(i+1)]:='''' + Cancellation_KrayIncomlpeteWeek.GetValueLitr(i) + ''''
    else
      frxTempReport.Variables.Variables['Kray' + IntToStr(i+1)]:='''' + Cancellation_KrayIncomlpeteWeek.GetValueDoses(i) + '''';
  ShowMessage('Недельный отчет сформирован ... возможно даже успешно!');
end;

procedure TVRWWeeklyIncompleteWeek.frxDefectGetValue(const VarName: String; var Value: Variant);
begin
    if CompareText(VarName, 'Name') = 0 then
      Value := ar[frxDefect.RecNo, 0];
    if CompareText(VarName, 'Volume') = 0 then
      Value := ar[frxDefect.RecNo, 1];
end;

procedure TVRWWeeklyIncompleteWeek.OnClickExportPDF(Sender: TObject);
begin
  if not Assigned(frxTempExportPDF) then
    frxTempExportPDF:=TfrxPDFExport.Create(TempForm);
  frxTempExportPDF.FileName:='Недельный отчет. Сформирован ' + DateToStr(date()) + '. Лесосибирский филиал.pdf';
  frxTempExportPDF.DefaultPath:=GetDesktopFolderPath + '\';
  frxTempReport.Export(frxTempExportPDF);
  frxTempReport.ShowReport;
end;

procedure TVRWWeeklyIncompleteWeek.OnClickMenuClose(Sender: TObject);
begin
  TempForm.ModalResult:=mrOk;
end;

procedure TVRWWeeklyIncompleteWeek.OnClickPrintReport(Sender: TObject);
begin
  frxTempReport.Print;
end;

procedure TVRWWeeklyIncompleteWeek.PreviewMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  frxTempPreview.MouseWheelScroll(WheelDelta);
end;

function TVRWWeeklyIncompleteWeek.GetDesktopFolderPath: string;
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
