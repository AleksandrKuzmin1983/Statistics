unit MRWWeeklyIncompleteWeek;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Controls, CodeSiteLogging, Vcl.Forms, Vcl.Menus,
  System.Classes,
  frxClass, frxDBSet, frxPreview, frxExportPDF, System.Win.Registry, dialogs,
  variants,
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
  TMRWWeeklyIncompleteWeek = class(TUSGlobalVariant)
  private
    TempForm: TForm;
    frxTempReport: TfrxReport;
    frxTempPreview: TfrxPreview;
    frxTempExportPDF: TfrxPDFExport;
    frxDefect: TfrxUserDataSet;

    frxTempMasterData: TfrxMasterData;

    ar: array [0 .. 10, 0 .. 1] of string;
    IncompleteWeekFirstTable: IBRWIncompleteWeekFirstTable;
    TableForDefectIncompleteWeek: IBRWTableForDefectIncompleteWeek;
    ResultsOfTheProductsIncompleteWeek: IBRWResultsOfTheProductsIncompleteWeek;
    ResultsOfTheProductsIncompleteWeek2
      : IBRWResultsOfTheProductsIncompleteWeek2;
    DonorsAndProceduresIncompleteWeek: IBRWDonorsAndProceduresIncompleteWeek;
    DonorsAndProceduresIncompleteWeekOuting
      : IBRWDonorsAndProceduresIncompleteWeekOuting;
    MedicalExemptionsIncompleteWeek: IBRWMedicalExemptionsIncompleteWeek;
    Cancellation_KrayIncomlpeteWeek: IBRWCancellation_KrayIncomlpeteWeek;
    LPUConsultationIncompleteWeek: IBRWLPUConsultationIncompleteWeek;
    SecondTableIncompleteWeek: IBRWSecondTableIncompleteWeek;

    MainMenu: TMFMainMenu;
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
    constructor Create(form: TForm); override;
    destructor destroy; override;
    { Public declarations }
  end;

implementation

{ TVRDDailyReportTheKrayVer2 }

constructor TMRWWeeklyIncompleteWeek.Create(form: TForm);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.Create выполнена');
  inherited;
end;

destructor TMRWWeeklyIncompleteWeek.destroy;
begin
  FreeAndNil(frxTempPreview);
  FreeAndNil(frxTempReport);
  MainMenu.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.destroy выполнена');
  inherited;
end;

procedure TMRWWeeklyIncompleteWeek.GetMainMenu;
begin
  if not Assigned(MainMenu) then
    MainMenu := TMFMainMenu.Create;
  MainMenu.GetTempMainMenu(TempForm);
  MainMenu.OnClickCloseForm(OnClickMenuClose);
  MainMenu.OnClickPrintReport(OnClickPrintReport);
  MainMenu.OnClickExportPDF(OnClickExportPDF);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.GetMainMenu выполнена');
end;

procedure TMRWWeeklyIncompleteWeek.GetReport(CurrentForm: TForm);
var
  CurrentDir: string;
  i: Integer;
begin
  if not Assigned(frxTempPreview) then
    frxTempPreview := TfrxPreview.Create(CurrentForm);
  frxTempPreview.Parent := CurrentForm;
  frxTempPreview.Align := alClient;
  if not Assigned(frxTempReport) then
    frxTempReport := TfrxReport.Create(CurrentForm);
  frxTempReport.Clear;
  frxTempReport.Preview := frxTempPreview;
  CurrentDir := ExtractFileDir(ExtractFileDir(ParamStr(0)));
  frxTempReport.LoadFromFile(CurrentDir +
    '\BaseAdapters\Reports\WeeklyIncompleteWeek\IncompleteWeek.fr3');
  if not Assigned(frxDefect) then
    frxDefect := TfrxUserDataSet.Create(CurrentForm);
  frxTempMasterData := frxTempReport.FindObject('MasterData1')
    as TfrxMasterData;
  frxTempMasterData.DataSet := frxDefect;
  frxTempReport.OnGetValue := frxDefectGetValue;
  if not Assigned(TableForDefectIncompleteWeek) then
    TableForDefectIncompleteWeek := TBRWTableForDefectIncompleteWeek.Create;
  TableForDefectIncompleteWeek.GetContent;
  for i := 0 to TableForDefectIncompleteWeek.GetRowCount - 1 do
  begin
    ar[i, 0] := TableForDefectIncompleteWeek.GetTypeOfDefect(i) +
      TableForDefectIncompleteWeek.GetTypeOfProduct(i);
    ar[i, 1] := TableForDefectIncompleteWeek.GetVolume(i);
  end;
  frxDefect.RangeEnd := ReCount;
  frxDefect.RangeEndCount := TableForDefectIncompleteWeek.GetRowCount;
  // Заготовка план/факт
  if not Assigned(IncompleteWeekFirstTable) then
    IncompleteWeekFirstTable := TBRWIncompleteWeekFirstTable.Create;
  for i := 0 to 14 do
    if i <= 4 then
      frxTempReport.Variables.Variables['FirstTable' + IntToStr(i + 1)] :=
        '''' + IncompleteWeekFirstTable.GetValuePlan(i) + ''''
    else if i <= 9 then
      frxTempReport.Variables.Variables['FirstTable' + IntToStr(i + 1)] :=
        '''' + IncompleteWeekFirstTable.GetValueLitr(i) + ''''
    else
      frxTempReport.Variables.Variables['FirstTable' + IntToStr(i + 1)] :=
        '''' + IncompleteWeekFirstTable.GetValuePercent(i) + '''';

  frxTempReport.Variables.Variables['VolumeTrombo'] :=
    '''' + IncompleteWeekFirstTable.GetValueLitr(15) + '''';
  frxTempReport.Variables.Variables['NumberDosesTromb'] :=
    '''' + IncompleteWeekFirstTable.GetValueTromboPacketsDoses(16) + '''';
  frxTempReport.Variables.Variables['NumberPacketsTromb'] :=
    '''' + IncompleteWeekFirstTable.GetValueTromboPacketsDoses(17) + '''';

  // Заготовлено годной
  if not Assigned(SecondTableIncompleteWeek) then
    SecondTableIncompleteWeek := TBRWSecondTableIncompleteWeek.Create;
  frxTempReport.Variables.Variables['ProductWholeBlood'] :=
    '''' + SecondTableIncompleteWeek.GetProductWholeBlood + '''';
  frxTempReport.Variables.Variables['VolumeReinfusion'] :=
    '''' + SecondTableIncompleteWeek.GetVolumeReinfusion + '''';
  frxTempReport.Variables.Variables['PreparedFitProductionErSuspFiltr'] :=
    '''' + SecondTableIncompleteWeek.GetPreparedFitProductionErSuspFiltr + '''';
  frxTempReport.Variables.Variables['PreparedFitProductionErSusp'] :=
    '''' + SecondTableIncompleteWeek.GetPreparedFitProductionErSusp + '''';
  frxTempReport.Variables.Variables['PreparedFitProductionSZP'] :=
    '''' + SecondTableIncompleteWeek.GetPreparedFitProductionSZP + '''';
  frxTempReport.Variables.Variables['OutingProductWholeBlood'] :=
    '''' + SecondTableIncompleteWeek.GetOutingProductWholeBlood + '''';
  frxTempReport.Variables.Variables['OutingPreparedFitProductionErSuspFiltr'] :=
    '''' + SecondTableIncompleteWeek.
    GetOutingPreparedFitProductionErSuspFiltr + '''';
  frxTempReport.Variables.Variables['OutingPreparedFitProductionErSusp'] :=
    '''' + SecondTableIncompleteWeek.
    GetOutingPreparedFitProductionErSusp + '''';
  frxTempReport.Variables.Variables['OutingPreparedFitProductionSZP'] :=
    '''' + SecondTableIncompleteWeek.GetOutingPreparedFitProductionSZP + '''';
  // Выдача в ЛПУ
  if not Assigned(ResultsOfTheProductsIncompleteWeek) then
    ResultsOfTheProductsIncompleteWeek :=
      TBRWResultsOfTheProductsIncompleteWeek.Create;
  for i := 0 to 47 do
    if i <= 15 then
      frxTempReport.Variables.Variables['ResultInLPU' + IntToStr(i + 1)] :=
        '''' + ResultsOfTheProductsIncompleteWeek.GetValueLitr(i) + ''''
    else if i <= 31 then
      frxTempReport.Variables.Variables['ResultInLPU' + IntToStr(i + 1)] :=
        '''' + ResultsOfTheProductsIncompleteWeek.GetValueDoses(i) + ''''
    else
      frxTempReport.Variables.Variables['ResultInLPU' + IntToStr(i + 1)] :=
        '''' + ResultsOfTheProductsIncompleteWeek.GetValuePercent(i) + '''';

  // Выдача в ЛПУ2
  if not Assigned(ResultsOfTheProductsIncompleteWeek2) then
    ResultsOfTheProductsIncompleteWeek2 :=
      TBRWResultsOfTheProductsIncompleteWeek2.Create;
  for i := 0 to 47 do
    if i <= 15 then
      frxTempReport.Variables.Variables['2ResultInLPU' + IntToStr(i + 1)] :=
        '''' + ResultsOfTheProductsIncompleteWeek2.GetValueLitr(i) + ''''
    else if i <= 31 then
      frxTempReport.Variables.Variables['2ResultInLPU' + IntToStr(i + 1)] :=
        '''' + ResultsOfTheProductsIncompleteWeek2.GetValueDoses(i) + ''''
    else
      frxTempReport.Variables.Variables['2ResultInLPU' + IntToStr(i + 1)] :=
        '''' + ResultsOfTheProductsIncompleteWeek2.GetValuePercent(i) + '''';

  // Доноры и процедуры
  if not Assigned(DonorsAndProceduresIncompleteWeek) then
    DonorsAndProceduresIncompleteWeek :=
      TBRWDonorsAndProceduresIncompleteWeek.Create;
  frxTempReport.Variables.Variables['AddressedJust'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(0) + '''';
  frxTempReport.Variables.Variables['ExceptionTotal'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(1) + '''';
  frxTempReport.Variables.Variables['PreliminaryAnalysis'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(2) + '''';
  frxTempReport.Variables.Variables['AdmittedToDonation'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(3) + '''';
  frxTempReport.Variables.Variables['ProceduresTotal'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(4) + '''';
  frxTempReport.Variables.Variables['BloodProcedures'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(5) + '''';
  frxTempReport.Variables.Variables['PlasmaProceduresTotal'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(6) + '''';
  frxTempReport.Variables.Variables['APAProcedures'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(7) + '''';
  frxTempReport.Variables.Variables['TromboProcedures'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(8) + '''';
  frxTempReport.Variables.Variables['NotTaken'] :=
    '''' + DonorsAndProceduresIncompleteWeek.GetValue(9) + '''';
  if not Assigned(DonorsAndProceduresIncompleteWeekOuting) then
    DonorsAndProceduresIncompleteWeekOuting :=
      TBRWDonorsAndProceduresIncompleteWeekOuting.Create;
  frxTempReport.Variables.Variables['AddressedJustOuting'] :=
    '''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(0) + '''';
  frxTempReport.Variables.Variables['ExceptionTotalOuting'] :=
    '''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(1) + '''';
  frxTempReport.Variables.Variables['PreliminaryAnalysisOuting'] :=
    '''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(2) + '''';
  frxTempReport.Variables.Variables['AdmittedToDonationOuting'] :=
    '''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(3) + '''';
  frxTempReport.Variables.Variables['ProceduresTotalOuting'] :=
    '''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(4) + '''';
  frxTempReport.Variables.Variables['BloodProceduresOuting'] :=
    '''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(5) + '''';
  frxTempReport.Variables.Variables['NotTakenOuting'] :=
    '''' + DonorsAndProceduresIncompleteWeekOuting.GetValue(6) + '''';
  // Отводы
  if not Assigned(MedicalExemptionsIncompleteWeek) then
    MedicalExemptionsIncompleteWeek :=
      TBRWMedicalExemptionsIncompleteWeek.Create;
  for i := 0 to 19 do
  begin
    frxTempReport.Variables.Variables['MedicalExemptions' + IntToStr(i + 1)] :=
      '''' + MedicalExemptionsIncompleteWeek.GetValueName(i) + '''';
    if StrToInt(MedicalExemptionsIncompleteWeek.GetValueNumber(i)) = 0 then
      frxTempReport.Variables.Variables['MedicalExemptionsNumber' +
        IntToStr(i + 1)] := ''' '''
    else
      frxTempReport.Variables.Variables['MedicalExemptionsNumber' +
        IntToStr(i + 1)] := '''' + MedicalExemptionsIncompleteWeek.
        GetValueNumber(i) + '''';
    if StrToInt(MedicalExemptionsIncompleteWeek.GetValueOuting(i)) = 0 then
      frxTempReport.Variables.Variables['MedicalExemptionsOutingNumber' +
        IntToStr(i + 1)] := ''' '''
    else
      frxTempReport.Variables.Variables['MedicalExemptionsOutingNumber' +
        IntToStr(i + 1)] := '''' + MedicalExemptionsIncompleteWeek.
        GetValueOuting(i) + '''';
  end;
  if not Assigned(LPUConsultationIncompleteWeek) then
    LPUConsultationIncompleteWeek := TBRWLPUConsultationIncompleteWeek.Create;
  frxTempReport.Variables.Variables['Transfusiolog'] :=
    '''' + LPUConsultationIncompleteWeek.GetTransfusiolog + '''';
  frxTempReport.Variables.Variables['Laboratory'] :=
    '''' + LPUConsultationIncompleteWeek.GetLaboratory + '''';
  frxTempReport.Variables.Variables['CheckLPU'] :=
    '''' + LPUConsultationIncompleteWeek.GetCheckLPU + '''';
  if not Assigned(Cancellation_KrayIncomlpeteWeek) then
    Cancellation_KrayIncomlpeteWeek :=
      TBRWCancellation_KrayIncomlpeteWeek.Create;
  for i := 0 to 31 do
    if (i <= 7) or ((i >= 16) and (i <= 23)) then
      frxTempReport.Variables.Variables['Kray' + IntToStr(i + 1)] :=
        '''' + Cancellation_KrayIncomlpeteWeek.GetValueLitr(i) + ''''
    else
      frxTempReport.Variables.Variables['Kray' + IntToStr(i + 1)] :=
        '''' + Cancellation_KrayIncomlpeteWeek.GetValueDoses(i) + '''';
  ShowMessage('Недельный отчет сформирован ... возможно даже успешно!');

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.GetReport выполнена');
end;

procedure TMRWWeeklyIncompleteWeek.frxDefectGetValue(const VarName: String;
  var Value: Variant);
begin
  if CompareText(VarName, 'Name') = 0 then
    Value := ar[frxDefect.RecNo, 0];
  if CompareText(VarName, 'Volume') = 0 then
    Value := ar[frxDefect.RecNo, 1];

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.frxDefectGetValue выполнена');
end;

procedure TMRWWeeklyIncompleteWeek.OnClickExportPDF(Sender: TObject);
begin
  if not Assigned(frxTempExportPDF) then
    frxTempExportPDF := TfrxPDFExport.Create(TempForm);
  frxTempExportPDF.FileName := 'Недельный отчет. Сформирован ' +
    DateToStr(date()) + '. Лесосибирский филиал.pdf';
  frxTempExportPDF.DefaultPath := GetDesktopFolderPath + '\';
  frxTempReport.Export(frxTempExportPDF);
  frxTempReport.ShowReport;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.OnClickExportPDF выполнена');
end;

procedure TMRWWeeklyIncompleteWeek.OnClickMenuClose(Sender: TObject);
begin
  TempForm.ModalResult := mrOk;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.OnClickMenuClose выполнена');
end;

procedure TMRWWeeklyIncompleteWeek.OnClickPrintReport(Sender: TObject);
begin
  frxTempReport.Print;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.OnClickPrintReport выполнена');
end;

procedure TMRWWeeklyIncompleteWeek.PreviewMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  frxTempPreview.MouseWheelScroll(WheelDelta);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.PreviewMouseWheel выполнена');
end;

function TMRWWeeklyIncompleteWeek.GetDesktopFolderPath: string;
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMRWWeeklyIncompleteWeek.GetDesktopFolderPath выполнена');
end;

end.
