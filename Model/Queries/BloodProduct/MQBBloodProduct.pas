unit MQBBloodProduct;

interface

uses
  SysUtils, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, CodeSiteLogging,
  BQBTheAmountOfBloodOnPreserving,
  BQBTheNumberOfWholeBlood,
  BQBTheNumberOfConservedBlood,
  BQBTheAmountOfReinfusionWithAPA,
  BQBTheAmountOfReinfusionWithTrombo,
  MFLabel,
  MFTitleLabel,
  MFEdit,
  MFDateTimePicker,
  MFBitBtn,
  USGlobalVariant;

type

  TMQBBloodProduct = class(TUSGlobalVariant)
  private
    StartDate: TMFLabel;
    EndDate: TMFLabel;
    StartDateCal: TMFDateTimePicker;
    EndDateCal: TMFDateTimePicker;
    AmountOfBloodForPreservationLabel: TMFLabel;
    AmountOfWholeBloodLabel: TMFLabel;
    AmountOfCannedBloodLabel: TMFLabel;
    VolumeOfReinfusionWithAPALabel: TMFLabel;
    VolumeOfReinfusionWithSitoferesLabel: TMFLabel;
    Title: TMFTitleLabel;
    AmountOfBloodForPreservationEdit: TMFEdit;
    AmountOfWholeBloodEdit: TMFEdit;
    AmountOfCannedBloodEdit: TMFEdit;
    VolumeOfReinfusionWithAPAEdit: TMFEdit;
    VolumeOfReinfusionWithSitoferesEdit: TMFEdit;
    ButtonAction: TMFBitBtn;
    CurrentForm: TForm;
    TheAmountOfBloodOnPreserving: IBQBTheAmountOfBloodOnPreserving;
    TheNumberOfWholeBlood: IBQBTheNumberOfWholeBlood;
    TheNumberOfConservedBlood: IBQBTheNumberOfConservedBlood;
    TheAmountOfReinfusionWithAPA: IBQBTheAmountOfReinfusionWithAPA;
    TheAmountOfReinfusionWithTrombo: IBQBTheAmountOfReinfusionWithTrombo;
    function GetLabelStartDate(NameForm: TForm): TLabel;
    function GetLabelEndDate(NameForm: TForm): TLabel;
    function GetAmountOfBloodForPreservationLabel(NameForm: TForm): TLabel;
    function GetAmountOfWholeBloodLabel(NameForm: TForm): TLabel;
    function GetAmountOfCannedBloodLabel(NameForm: TForm): TLabel;
    function GetVolumeOfReinfusionWithAPALabel(NameForm: TForm): TLabel;
    function GetVolumeOfReinfusionWithSitoferesLabel(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;
    function GetAmountOfBloodForPreservationEdit(NameForm: TForm): TEdit;
    function GetAmountOfWholeBloodEdit(NameForm: TForm): TEdit;
    function GetAmountOfCannedBloodEdit(NameForm: TForm): TEdit;
    function GetVolumeOfReinfusionWithAPAEdit(NameForm: TForm): TEdit;
    function GetVolumeOfReinfusionWithSitoferesEdit(NameForm: TForm): TEdit;
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

{ TBloodProduct }
constructor TMQBBloodProduct.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelStartDate(form);
  GetLabelEndDate(form);
  GetAmountOfBloodForPreservationLabel(form);
  GetAmountOfWholeBloodLabel(form);
  GetAmountOfCannedBloodLabel(form);
  GetVolumeOfReinfusionWithAPALabel(form);
  GetVolumeOfReinfusionWithSitoferesLabel(form);
  GetLabelTitle(form);

  GetCalendarStartDate(form);
  GetCalendarEndDate(form);

  GetAmountOfBloodForPreservationEdit(form);
  GetAmountOfWholeBloodEdit(form);
  GetAmountOfCannedBloodEdit(form);
  GetVolumeOfReinfusionWithAPAEdit(form);
  GetVolumeOfReinfusionWithSitoferesEdit(form);

  GetButtonAction(form);
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.create выполнена');
  inherited;
end;

destructor TMQBBloodProduct.destroy;
begin
  StartDate.destroy;
  EndDate.destroy;
  AmountOfBloodForPreservationLabel.destroy;
  AmountOfWholeBloodLabel.destroy;
  AmountOfCannedBloodLabel.destroy;
  VolumeOfReinfusionWithAPALabel.destroy;
  VolumeOfReinfusionWithSitoferesLabel.destroy;
  Title.destroy;

  EndDateCal.destroy;
  StartDateCal.destroy;

  AmountOfBloodForPreservationEdit.destroy;
  AmountOfWholeBloodEdit.destroy;
  AmountOfCannedBloodEdit.destroy;
  VolumeOfReinfusionWithAPAEdit.destroy;
  VolumeOfReinfusionWithSitoferesEdit.destroy;

  ButtonAction.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.destroy выполнена');
  inherited;
end;

procedure TMQBBloodProduct.ButtonAct(Sender: TObject);
begin
  if StartDateCal.GetDate > GetCalendarEndDate(CurrentForm).Date then
  begin
    ShowMessage('Конечная дата не может быть меньше начальной');
    exit;
  end
  else
  begin
    if not Assigned(TheNumberOfConservedBlood) then
      TheAmountOfBloodOnPreserving := TBQBTheAmountOfBloodOnPreserving.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    AmountOfBloodForPreservationEdit.WriteText(TheAmountOfBloodOnPreserving.GetValue);
    TheAmountOfBloodOnPreserving := nil;

    if not Assigned(TheNumberOfWholeBlood) then
      TheNumberOfWholeBlood := TBQBTheNumberOfWholeBlood.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    AmountOfWholeBloodEdit.WriteText(TheNumberOfWholeBlood.GetValue);
    TheNumberOfWholeBlood := nil;

    if not Assigned(TheNumberOfConservedBlood) then
      TheNumberOfConservedBlood := TBQBTheNumberOfConservedBlood.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    AmountOfCannedBloodEdit.WriteText(TheNumberOfConservedBlood.GetValue);
    TheNumberOfConservedBlood := nil;

    if not Assigned(TheAmountOfReinfusionWithAPA) then
      TheAmountOfReinfusionWithAPA := TBQBTheAmountOfReinfusionWithAPA.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    VolumeOfReinfusionWithAPAEdit.WriteText(TheAmountOfReinfusionWithAPA.GetValue);
    TheAmountOfReinfusionWithAPA := nil;

    if not Assigned(TheAmountOfReinfusionWithTrombo) then
      TheAmountOfReinfusionWithTrombo :=
        TBQBTheAmountOfReinfusionWithTrombo.create(StartDateCal.GetDate,
        EndDateCal.GetDate);
    VolumeOfReinfusionWithSitoferesEdit.WriteText(TheAmountOfReinfusionWithTrombo.GetValue);
    TheAmountOfReinfusionWithTrombo := nil;

    ShowMessage('Запрос выполнен!');
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.ButtonAct выполнена');
end;

function TMQBBloodProduct.GetAmountOfBloodForPreservationEdit(NameForm: TForm): TEdit;
begin
  if not Assigned(AmountOfBloodForPreservationEdit) then
    AmountOfBloodForPreservationEdit := TMFEdit.create;
  Result := AmountOfBloodForPreservationEdit.GetEdit(520, 180, 100, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetEdit1 выполнена');
end;

function TMQBBloodProduct.GetAmountOfWholeBloodEdit(NameForm: TForm): TEdit;
begin
  if not Assigned(AmountOfWholeBloodEdit) then
    AmountOfWholeBloodEdit := TMFEdit.create;
  Result := AmountOfWholeBloodEdit.GetEdit(520, 220, 100, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetAmountOfWholeBloodEdit выполнена');
end;

function TMQBBloodProduct.GetAmountOfCannedBloodEdit(NameForm: TForm): TEdit;
begin
  if not Assigned(AmountOfCannedBloodEdit) then
    AmountOfCannedBloodEdit := TMFEdit.create;
  Result := AmountOfCannedBloodEdit.GetEdit(520, 260, 100, 12, True, NameForm);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetAmountOfCannedBloodEdit выполнена');
end;

function TMQBBloodProduct.GetVolumeOfReinfusionWithAPAEdit(NameForm: TForm): TEdit;
begin
  if not Assigned(VolumeOfReinfusionWithAPAEdit) then
    VolumeOfReinfusionWithAPAEdit := TMFEdit.create;
  Result := VolumeOfReinfusionWithAPAEdit.GetEdit(520, 300, 100, 12, True, NameForm);
  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetVolumeOfReinfusionWithAPAEdit выполнена');
end;

function TMQBBloodProduct.GetVolumeOfReinfusionWithSitoferesEdit(NameForm: TForm): TEdit;
begin
  if not Assigned(VolumeOfReinfusionWithSitoferesEdit) then
    VolumeOfReinfusionWithSitoferesEdit := TMFEdit.create;
  Result := VolumeOfReinfusionWithSitoferesEdit.GetEdit(520, 340, 100, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetVolumeOfReinfusionWithSitoferesEdit выполнена');
end;

function TMQBBloodProduct.GetButtonAction(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TMFBitBtn.create;
  Result := ButtonAction.GetBitBtn(360, 590, 'Сформировать', ButtonAct,
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetButtonAction выполнена');
end;

function TMQBBloodProduct.GetCalendarStartDate(NameForm: TForm)
  : TDateTimePicker;
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetCalendarStartDate выполнена');
end;

function TMQBBloodProduct.GetCalendarEndDate(NameForm: TForm): TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal := TMFDateTimePicker.create;
  Result := EndDateCal.GetDTPicker(250, 120, EncodeDate(YearOf(Now),
    MonthOf(Now), 1) - 1, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetCalendarEndDate выполнена');
end;

function TMQBBloodProduct.GetLabelEndDate(NameForm: TForm): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TMFLabel.create;
  Result := EndDate.GetTempLabel(50, 120, 20, 'Конечная дата:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetLabelEndDate выполнена');
end;

function TMQBBloodProduct.GetAmountOfBloodForPreservationLabel(NameForm: TForm): TLabel;
begin
  if not Assigned(AmountOfBloodForPreservationLabel) then
    AmountOfBloodForPreservationLabel := TMFLabel.create;
  Result := AmountOfBloodForPreservationLabel.GetTempLabel(50, 180, 20,
    'Количество крови на консервирование:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetAmountOfBloodForPreservationLabel выполнена');
end;

function TMQBBloodProduct.GetAmountOfWholeBloodLabel(NameForm: TForm): TLabel;
begin
  if not Assigned(AmountOfWholeBloodLabel) then
    AmountOfWholeBloodLabel := TMFLabel.create;
  Result := AmountOfWholeBloodLabel.GetTempLabel(50, 220, 20, 'Количество цельной крови:',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetAmountOfWholeBloodLabel выполнена');
end;

function TMQBBloodProduct.GetAmountOfCannedBloodLabel(NameForm: TForm): TLabel;
begin
  if not Assigned(AmountOfCannedBloodLabel) then
    AmountOfCannedBloodLabel := TMFLabel.create;
  Result := AmountOfCannedBloodLabel.GetTempLabel(50, 260, 20,
    'Количество консервированной крови:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetAmountOfCannedBloodLabel выполнена');
end;

function TMQBBloodProduct.GetVolumeOfReinfusionWithAPALabel(NameForm: TForm): TLabel;
begin
  if not Assigned(VolumeOfReinfusionWithAPALabel) then
    VolumeOfReinfusionWithAPALabel := TMFLabel.create;
  Result := VolumeOfReinfusionWithAPALabel.GetTempLabel(50, 300, 20, 'Объем реинфузии с АПА:',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetVolumeOfReinfusionWithAPALabel выполнена');
end;

function TMQBBloodProduct.GetVolumeOfReinfusionWithSitoferesLabel(NameForm: TForm): TLabel;
begin
  if not Assigned(VolumeOfReinfusionWithSitoferesLabel) then
    VolumeOfReinfusionWithSitoferesLabel := TMFLabel.create;
  Result := VolumeOfReinfusionWithSitoferesLabel.GetTempLabel(50, 340, 20, 'Объем реинфузии с цитофереза:',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetVolumeOfReinfusionWithSitoferesLabel выполнена');
end;

function TMQBBloodProduct.GetLabelStartDate(NameForm: TForm): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TMFLabel.create;
  Result := StartDate.GetTempLabel(50, 80, 20, 'Начальная дата:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetLabelStartDate выполнена');
end;

function TMQBBloodProduct.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, 'Заготовка крови', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetLabelTitle выполнена');
end;

procedure TMQBBloodProduct.Show;
begin
  StartDate.Visible(True);
  EndDate.Visible(True);
  AmountOfBloodForPreservationLabel.Visible(True);
  AmountOfWholeBloodLabel.Visible(True);
  AmountOfCannedBloodLabel.Visible(True);
  VolumeOfReinfusionWithAPALabel.Visible(True);
  VolumeOfReinfusionWithSitoferesLabel.Visible(True);

  StartDateCal.Visible(True);
  EndDateCal.Visible(True);

  AmountOfBloodForPreservationEdit.Visible(True);
  AmountOfWholeBloodEdit.Visible(True);
  AmountOfCannedBloodEdit.Visible(True);
  VolumeOfReinfusionWithAPAEdit.Visible(True);
  VolumeOfReinfusionWithSitoferesEdit.Visible(True);

  ButtonAction.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQBBloodProduct.GetLabelTitle выполнена');
end;

end.
