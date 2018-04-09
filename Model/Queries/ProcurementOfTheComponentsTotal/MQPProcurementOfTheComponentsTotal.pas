unit MQPProcurementOfTheComponentsTotal;

interface

uses
  SysUtils, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, CodeSiteLogging, Vcl.ExtCtrls,
  BQPHarvestingOfErSuspensionsValumeTotal,
  BQPHarvestingOfErSuspensionsDosesTotal,
  BQPHarvestingOfPlasmaVolumeTotal,
  BQPHarvestingOfPlasmaDosesTotal,
  BQPHarvestingOfPlasmaBloodVolumeTotal,
  BQPHarvestingOfPlasmaBloodDosesTotal,
  BQPHarvestingOfPlasmaAPAVolumeTotal,
  BQPHarvestingOfPlasmaAPADosesTotal,
  BQPHarvestingOfTromboVolumeTotal,
  BQPHarvestingOfTromboDosesTotal,
  BQPHarvestingOfTromboPacetsTotal,
  BQPHarvestingOfFiltratVolumeTotal,
  BQPHarvestingOfFiltratDosesTotal,
  MFLabel,
  MFTitleLabel,
  MFEdit,
  MFDateTimePicker,
  MFBitBtn,
  MFPanel,
  USGlobalVariant;

type

  TMQPProcurementOfTheComponentsTotal = class(TUSGlobalVariant)
  private
    StartDate: TMFLabel;
    EndDate: TMFLabel;
    Volume: TMFLabel;
    Doses: TMFLabel;
    Pacets: TMFLabel;
    ErSuspLabel: TMFLabel;
    PlasmaTotalLabel: TMFLabel;
    PlasmaBloodLabel: TMFLabel;
    PlasmaAPALabel: TMFLabel;
    TromboLabel: TMFLabel;
    FiltratLabel: TMFLabel;

    Title: TMFTitleLabel;

    ErSuspVolume: TMFEdit;
    ErSuspDoses: TMFEdit;
    PlasmaTotalVolume: TMFEdit;
    PlasmaTotalDoses: TMFEdit;
    PlasmaBloodVolume: TMFEdit;
    PlasmaBloodDoses: TMFEdit;
    PlasmaAPAVolume: TMFEdit;
    PlasmaAPADoses: TMFEdit;
    TromboVolume: TMFEdit;
    TromboDoses: TMFEdit;
    TromboPacets: TMFEdit;
    FiltratVolume: TMFEdit;
    FiltratDoses: TMFEdit;

    StartDateCal: IMFDateTimePicker;
    EndDateCal: IMFDateTimePicker;

    PanelVertical: IMFPanel;
    PanelGorizontal: IMFPanel;

    ButtonAction: IMFBitBtn;

    CurrentForm: TForm;

    HarvestingOfErSuspensionsValumeTotal
      : IBQPHarvestingOfErSuspensionsValumeTotal;
    HarvestingOfErSuspensionsDosesTotal
      : IBQPHarvestingOfErSuspensionsDosesTotal;
    HarvestingOfPlasmaVolumeTotal: IBQPHarvestingOfPlasmaVolumeTotal;
    HarvestingOfPlasmaDosesTotal: IBQPHarvestingOfPlasmaDosesTotal;
    HarvestingOfPlasmaBloodVolumeTotal: IBQPHarvestingOfPlasmaBloodVolumeTotal;
    HarvestingOfPlasmaBloodDosesTotal: IBQPHarvestingOfPlasmaBloodDosesTotal;
    HarvestingOfPlasmaAPAVolumeTotal: IBQPHarvestingOfPlasmaAPAVolumeTotal;
    HarvestingOfPlasmaAPADosesTotal: IBQPHarvestingOfPlasmaAPADosesTotal;
    HarvestingOfTromboVolumeTotal: IBQPHarvestingOfTromboVolumeTotal;
    HarvestingOfTromboDosesTotal: IBQPHarvestingOfTromboDosesTotal;
    HarvestingOfTromboPacetsTotal: IBQPHarvestingOfTromboPacetsTotal;
    HarvestingOfFiltratVolumeTotal: IBQPHarvestingOfFiltratVolumeTotal;
    HarvestingOfFiltratDosesTotal: IBQPHarvestingOfFiltratDosesTotal;
    function GetLabelStartDate(NameForm: TForm): TLabel;
    function GetLabelEndDate(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelDoses(NameForm: TForm): TLabel;
    function GetLabelPacets(NameForm: TForm): TLabel;
    function GetErSuspLabel(NameForm: TForm): TLabel;
    function GetPlasmaTotalLabel(NameForm: TForm): TLabel;
    function GetPlasmaBloodLabel(NameForm: TForm): TLabel;
    function GetPlasmaAPALabel(NameForm: TForm): TLabel;
    function GetTromboLabel(NameForm: TForm): TLabel;
    function GetFiltratLabel(NameForm: TForm): TLabel;

    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetPanelVertical(NameForm: TForm): TPanel;
    function GetPanelGorizontal(NameForm: TForm): TPanel;

    function GetErSuspVolume(NameForm: TForm): TEdit;
    function GetErSuspDoses(NameForm: TForm): TEdit;
    function GetPlasmaTotalVolume(NameForm: TForm): TEdit;
    function GetPlasmaTotalDoses(NameForm: TForm): TEdit;
    function GetPlasmaBloodVolume(NameForm: TForm): TEdit;
    function GetPlasmaBloodDoses(NameForm: TForm): TEdit;
    function GetPlasmaAPAVolume(NameForm: TForm): TEdit;
    function GetPlasmaAPADoses(NameForm: TForm): TEdit;
    function GetTromboVolume(NameForm: TForm): TEdit;
    function GetTromboDoses(NameForm: TForm): TEdit;
    function GetTromboPacets(NameForm: TForm): TEdit;
    function GetFiltratVolume(NameForm: TForm): TEdit;
    function GetFiltratDoses(NameForm: TForm): TEdit;

    function GetCalendarStartDate(NameForm: TForm): TDateTimePicker;
    function GetCalendarEndDate(NameForm: TForm): TDateTimePicker;

    function GetButtonAction(NameForm: TForm): TBitBtn;
    procedure ButtonAct(Sender: TObject);
    procedure Show;
  public
    constructor create(form: TForm); override;
    destructor destroy; override;
  end;

implementation

{ TProcurementOfTheComponentsTotal }

constructor TMQPProcurementOfTheComponentsTotal.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelStartDate(CurrentForm);
  GetLabelEndDate(CurrentForm);
  GetLabelVolume(CurrentForm);
  GetLabelDoses(CurrentForm);
  GetLabelPacets(CurrentForm);
  GetErSuspLabel(CurrentForm);
  GetPlasmaTotalLabel(CurrentForm);
  GetPlasmaBloodLabel(CurrentForm);
  GetPlasmaAPALabel(CurrentForm);
  GetTromboLabel(CurrentForm);
  GetFiltratLabel(CurrentForm);

  GetLabelTitle(CurrentForm);

  GetCalendarStartDate(CurrentForm);
  GetCalendarEndDate(CurrentForm);

  GetPanelVertical(CurrentForm);
  GetPanelGorizontal(CurrentForm);

  GetErSuspVolume(CurrentForm);
  GetErSuspDoses(CurrentForm);
  GetPlasmaTotalVolume(CurrentForm);
  GetPlasmaTotalDoses(CurrentForm);
  GetPlasmaBloodVolume(CurrentForm);
  GetPlasmaBloodDoses(CurrentForm);
  GetPlasmaAPAVolume(CurrentForm);
  GetPlasmaAPADoses(CurrentForm);
  GetTromboVolume(CurrentForm);
  GetTromboDoses(CurrentForm);
  GetTromboPacets(CurrentForm);
  GetFiltratVolume(CurrentForm);
  GetFiltratDoses(CurrentForm);

  GetButtonAction(CurrentForm);
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.create выполнена');
  inherited;
end;

destructor TMQPProcurementOfTheComponentsTotal.destroy;
begin
  StartDate.destroy;
  EndDate.destroy;
  Volume.destroy;
  Doses.destroy;
  Pacets.destroy;
  ErSuspLabel.destroy;
  PlasmaTotalLabel.destroy;
  PlasmaBloodLabel.destroy;
  PlasmaAPALabel.destroy;
  TromboLabel.destroy;
  FiltratLabel.destroy;

  Title.destroy;

  ErSuspVolume.destroy;
  ErSuspDoses.destroy;
  PlasmaTotalVolume.destroy;
  PlasmaTotalDoses.destroy;
  PlasmaBloodVolume.destroy;
  PlasmaBloodDoses.destroy;
  PlasmaAPAVolume.destroy;
  PlasmaAPADoses.destroy;
  TromboVolume.destroy;
  TromboDoses.destroy;
  TromboPacets.destroy;
  FiltratVolume.destroy;
  FiltratDoses.destroy;

  StartDateCal.destroy;
  EndDateCal.destroy;

  PanelVertical.destroy;
  PanelGorizontal.destroy;

  ButtonAction.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.destroy выполнена');
  inherited;
end;

procedure TMQPProcurementOfTheComponentsTotal.ButtonAct(Sender: TObject);
begin
  if StartDateCal.GetDate > EndDateCal.GetDate then
  begin
    ShowMessage('Конечная дата не может быть меньше начальной');
    exit;
  end
  else
  begin
    if not Assigned(HarvestingOfErSuspensionsValumeTotal) then
      HarvestingOfErSuspensionsValumeTotal :=
        TBQPHarvestingOfErSuspensionsValumeTotal.create(StartDateCal.GetDate,
        EndDateCal.GetDate);
    ErSuspVolume.WriteText(HarvestingOfErSuspensionsValumeTotal.GetValue);
    HarvestingOfErSuspensionsValumeTotal := nil;

    if not Assigned(HarvestingOfErSuspensionsDosesTotal) then
      HarvestingOfErSuspensionsDosesTotal :=
        TBQPHarvestingOfErSuspensionsDosesTotal.create(StartDateCal.GetDate,
        EndDateCal.GetDate);
    ErSuspDoses.WriteText(HarvestingOfErSuspensionsDosesTotal.GetValue);
    HarvestingOfErSuspensionsDosesTotal := nil;

    if not Assigned(HarvestingOfPlasmaVolumeTotal) then
      HarvestingOfPlasmaVolumeTotal := TBQPHarvestingOfPlasmaVolumeTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    PlasmaTotalVolume.WriteText(HarvestingOfPlasmaVolumeTotal.GetValue);
    HarvestingOfPlasmaVolumeTotal := nil;

    if not Assigned(HarvestingOfPlasmaDosesTotal) then
      HarvestingOfPlasmaDosesTotal := TBQPHarvestingOfPlasmaDosesTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    PlasmaTotalDoses.WriteText(HarvestingOfPlasmaDosesTotal.GetValue);
    HarvestingOfPlasmaDosesTotal := nil;

    if not Assigned(HarvestingOfPlasmaBloodVolumeTotal) then
      HarvestingOfPlasmaBloodVolumeTotal :=
        TBQPHarvestingOfPlasmaBloodVolumeTotal.create(StartDateCal.GetDate,
        EndDateCal.GetDate);
    PlasmaBloodVolume.WriteText(HarvestingOfPlasmaBloodVolumeTotal.GetValue);
    HarvestingOfPlasmaBloodVolumeTotal := nil;

    if not Assigned(HarvestingOfPlasmaBloodDosesTotal) then
      HarvestingOfPlasmaBloodDosesTotal :=
        TBQPHarvestingOfPlasmaBloodDosesTotal.create(StartDateCal.GetDate,
        EndDateCal.GetDate);
    PlasmaBloodDoses.WriteText(HarvestingOfPlasmaBloodDosesTotal.GetValue);
    HarvestingOfPlasmaBloodDosesTotal := nil;

    if not Assigned(HarvestingOfPlasmaAPAVolumeTotal) then
      HarvestingOfPlasmaAPAVolumeTotal :=
        TBQPHarvestingOfPlasmaAPAVolumeTotal.create(StartDateCal.GetDate,
        EndDateCal.GetDate);
    PlasmaAPAVolume.WriteText(HarvestingOfPlasmaAPAVolumeTotal.GetValue);
    HarvestingOfPlasmaAPAVolumeTotal := nil;

    if not Assigned(HarvestingOfPlasmaAPADosesTotal) then
      HarvestingOfPlasmaAPADosesTotal :=
        TBQPHarvestingOfPlasmaAPADosesTotal.create(StartDateCal.GetDate,
        EndDateCal.GetDate);
    PlasmaAPADoses.WriteText(HarvestingOfPlasmaAPADosesTotal.GetValue);
    HarvestingOfPlasmaAPADosesTotal := nil;

    if not Assigned(HarvestingOfTromboVolumeTotal) then
      HarvestingOfTromboVolumeTotal := TBQPHarvestingOfTromboVolumeTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    TromboVolume.WriteText(HarvestingOfTromboVolumeTotal.GetValue);
    HarvestingOfTromboVolumeTotal := nil;

    if not Assigned(HarvestingOfTromboDosesTotal) then
      HarvestingOfTromboDosesTotal := TBQPHarvestingOfTromboDosesTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    TromboDoses.WriteText(HarvestingOfTromboDosesTotal.GetValue);
    HarvestingOfTromboDosesTotal := nil;

    if not Assigned(HarvestingOfTromboPacetsTotal) then
      HarvestingOfTromboPacetsTotal := TBQPHarvestingOfTromboPacetsTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    TromboPacets.WriteText(HarvestingOfTromboPacetsTotal.GetValue);
    HarvestingOfTromboPacetsTotal := nil;

    if not Assigned(HarvestingOfFiltratVolumeTotal) then
      HarvestingOfFiltratVolumeTotal :=
        TBQPHarvestingOfFiltratVolumeTotal.create(StartDateCal.GetDate,
        EndDateCal.GetDate);
    FiltratVolume.WriteText(HarvestingOfFiltratVolumeTotal.GetValue);
    HarvestingOfFiltratVolumeTotal := nil;

    if not Assigned(HarvestingOfFiltratDosesTotal) then
      HarvestingOfFiltratDosesTotal := TBQPHarvestingOfFiltratDosesTotal.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    FiltratDoses.WriteText(HarvestingOfFiltratDosesTotal.GetValue);
    HarvestingOfFiltratDosesTotal := nil;

    ShowMessage('Запрос выполнен!');
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.ButtonAct выполнена');
end;



// Button

function TMQPProcurementOfTheComponentsTotal.GetButtonAction
  (NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TMFBitBtn.create;
  Result := ButtonAction.GetBitBtn(360, 590, 'Сформировать', ButtonAct,
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetButtonAction выполнена');
end;

// DataTimePicker

function TMQPProcurementOfTheComponentsTotal.GetCalendarStartDate
  (NameForm: TForm): TDateTimePicker;
var
  CYear, CMonth: Word;
begin
  if MonthOf(Now) = 1 then
    CMonth := 12
  else
    CMonth := MonthOf(Now) - 1;
  if CMonth = 12 then
    CYear := YearOf(Now) - 1
  else
    CYear := YearOf(Now);
  if not Assigned(StartDateCal) then
    StartDateCal := TMFDateTimePicker.create;
  Result := StartDateCal.GetDTPicker(250, 80, EncodeDate(CYear, CMonth, 1),
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetCalendarStartDate выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetCalendarEndDate(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal := TMFDateTimePicker.create;
  Result := EndDateCal.GetDTPicker(250, 120, EncodeDate(YearOf(Now),
    MonthOf(Now), 1) - 1, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetCalendarEndDate выполнена');
end;

// Edit

function TMQPProcurementOfTheComponentsTotal.GetErSuspDoses
  (NameForm: TForm): TEdit;
begin
  if not Assigned(ErSuspDoses) then
    ErSuspDoses := TMFEdit.create;
  Result := ErSuspDoses.GetEdit(450, 220, 80, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetErSuspDoses выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetErSuspVolume
  (NameForm: TForm): TEdit;
begin
  if not Assigned(ErSuspVolume) then
    ErSuspVolume := TMFEdit.create;
  Result := ErSuspVolume.GetEdit(290, 220, 110, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetErSuspVolume выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetFiltratDoses
  (NameForm: TForm): TEdit;
begin
  if not Assigned(FiltratDoses) then
    FiltratDoses := TMFEdit.create;
  Result := FiltratDoses.GetEdit(450, 420, 80, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetFiltratDoses выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetFiltratVolume
  (NameForm: TForm): TEdit;
begin
  if not Assigned(FiltratVolume) then
    FiltratVolume := TMFEdit.create;
  Result := FiltratVolume.GetEdit(290, 420, 110, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetFiltratVolume выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPlasmaAPADoses
  (NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaAPADoses) then
    PlasmaAPADoses := TMFEdit.create;
  Result := PlasmaAPADoses.GetEdit(450, 340, 80, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPlasmaAPADoses выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPlasmaAPAVolume
  (NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaAPAVolume) then
    PlasmaAPAVolume := TMFEdit.create;
  Result := PlasmaAPAVolume.GetEdit(290, 340, 110, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPlasmaAPAVolume выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPlasmaBloodDoses
  (NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaBloodDoses) then
    PlasmaBloodDoses := TMFEdit.create;
  Result := PlasmaBloodDoses.GetEdit(450, 300, 80, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPlasmaBloodDoses выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPlasmaBloodVolume
  (NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaBloodVolume) then
    PlasmaBloodVolume := TMFEdit.create;
  Result := PlasmaBloodVolume.GetEdit(290, 300, 110, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPlasmaBloodVolume выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPlasmaTotalDoses
  (NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaTotalDoses) then
    PlasmaTotalDoses := TMFEdit.create;
  Result := PlasmaTotalDoses.GetEdit(450, 260, 80, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPlasmaTotalDoses выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPlasmaTotalVolume
  (NameForm: TForm): TEdit;
begin
  if not Assigned(PlasmaTotalVolume) then
    PlasmaTotalVolume := TMFEdit.create;
  Result := PlasmaTotalVolume.GetEdit(290, 260, 110, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPlasmaTotalVolume выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetTromboDoses
  (NameForm: TForm): TEdit;
begin
  if not Assigned(TromboDoses) then
    TromboDoses := TMFEdit.create;
  Result := TromboDoses.GetEdit(450, 380, 80, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetTromboDoses выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetTromboPacets
  (NameForm: TForm): TEdit;
begin
  if not Assigned(TromboPacets) then
    TromboPacets := TMFEdit.create;
  Result := TromboPacets.GetEdit(580, 380, 80, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetTromboPacets выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetTromboVolume
  (NameForm: TForm): TEdit;
begin
  if not Assigned(TromboVolume) then
    TromboVolume := TMFEdit.create;
  Result := TromboVolume.GetEdit(290, 380, 110, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetTromboVolume выполнена');
end;

procedure TMQPProcurementOfTheComponentsTotal.Show;
begin
  StartDate.Visible(True);
  EndDate.Visible(True);
  Volume.Visible(True);
  Doses.Visible(True);
  Pacets.Visible(True);
  ErSuspLabel.Visible(True);
  PlasmaTotalLabel.Visible(True);
  PlasmaBloodLabel.Visible(True);
  PlasmaAPALabel.Visible(True);
  TromboLabel.Visible(True);
  FiltratLabel.Visible(True);

  StartDateCal.Visible(True);
  EndDateCal.Visible(True);

  PanelVertical.Visible(True);
  PanelGorizontal.Visible(True);

  ErSuspVolume.Visible(True);
  ErSuspDoses.Visible(True);
  PlasmaTotalVolume.Visible(True);
  PlasmaTotalDoses.Visible(True);
  PlasmaBloodVolume.Visible(True);
  PlasmaBloodDoses.Visible(True);
  PlasmaAPAVolume.Visible(True);
  PlasmaAPADoses.Visible(True);
  TromboVolume.Visible(True);
  TromboDoses.Visible(True);
  TromboPacets.Visible(True);
  FiltratVolume.Visible(True);
  FiltratDoses.Visible(True);

  ButtonAction.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.Show выполнена');
end;

// Label

function TMQPProcurementOfTheComponentsTotal.GetErSuspLabel
  (NameForm: TForm): TLabel;
begin
  if not Assigned(ErSuspLabel) then
    ErSuspLabel := TMFLabel.create;
  Result := ErSuspLabel.GetTempLabel(50, 220, 16, 'Эр. взвесь:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetErSuspLabel выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPlasmaTotalLabel
  (NameForm: TForm): TLabel;
begin
  if not Assigned(PlasmaTotalLabel) then
    PlasmaTotalLabel := TMFLabel.create;
  Result := PlasmaTotalLabel.GetTempLabel(50, 260, 16, 'Плазма, всего:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPlasmaTotalLabel выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPlasmaBloodLabel
  (NameForm: TForm): TLabel;
begin
  if not Assigned(PlasmaBloodLabel) then
    PlasmaBloodLabel := TMFLabel.create;
  Result := PlasmaBloodLabel.GetTempLabel(50, 300, 16, 'Плазма, кровь:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPlasmaBloodLabel выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPlasmaAPALabel
  (NameForm: TForm): TLabel;
begin
  if not Assigned(PlasmaAPALabel) then
    PlasmaAPALabel := TMFLabel.create;
  Result := PlasmaAPALabel.GetTempLabel(50, 340, 16, 'Плазма, АПА:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPlasmaAPALabel выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetTromboLabel
  (NameForm: TForm): TLabel;
begin
  if not Assigned(TromboLabel) then
    TromboLabel := TMFLabel.create;
  Result := TromboLabel.GetTempLabel(50, 380, 16, 'Тромбоконцентрат:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetTromboLabel выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetFiltratLabel
  (NameForm: TForm): TLabel;
begin
  if not Assigned(FiltratLabel) then
    FiltratLabel := TMFLabel.create;
  Result := FiltratLabel.GetTempLabel(50, 420, 16, 'Фильтрат:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetFiltratLabel выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetLabelPacets
  (NameForm: TForm): TLabel;
begin
  if not Assigned(Pacets) then
    Pacets := TMFLabel.create;
  Result := Pacets.GetTempLabel(575, 180, 16, 'пакеты, шт.', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetLabelPacets выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetLabelDoses
  (NameForm: TForm): TLabel;
begin
  if not Assigned(Doses) then
    Doses := TMFLabel.create;
  Result := Doses.GetTempLabel(450, 180, 16, 'дозы, шт.', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetLabelDoses выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetLabelVolume
  (NameForm: TForm): TLabel;
begin
  if not Assigned(Volume) then
    Volume := TMFLabel.create;
  Result := Volume.GetTempLabel(300, 180, 16, 'объем, мл.', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetLabelVolume выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetLabelStartDate
  (NameForm: TForm): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TMFLabel.create;
  Result := StartDate.GetTempLabel(50, 80, 20, 'Начальная дата:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetLabelStartDate выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetLabelEndDate
  (NameForm: TForm): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TMFLabel.create;
  Result := EndDate.GetTempLabel(50, 120, 20, 'Конечная дата:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetLabelEndDate выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetLabelTitle
  (NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, 'Заготовка компонентов крови (общий)',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetLabelTitle выполнена');
end;

// Panel

function TMQPProcurementOfTheComponentsTotal.GetPanelGorizontal
  (NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGorizontal) then
    PanelGorizontal := TMFPanel.create;
  Result := PanelGorizontal.GetTempPanel(50, 210, 1, 670, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPanelGorizontal выполнена');
end;

function TMQPProcurementOfTheComponentsTotal.GetPanelVertical
  (NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertical) then
    PanelVertical := TMFPanel.create;
  Result := PanelVertical.GetTempPanel(260, 180, 300, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQPProcurementOfTheComponentsTotal.GetPanelVertical выполнена');
end;
end.
