unit MQBBloodProduct;

interface

uses
  SysUtils, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs,
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
    NameStat1: TMFLabel;
    NameStat2: TMFLabel;
    NameStat3: TMFLabel;
    NameStat4: TMFLabel;
    NameStat5: TMFLabel;
    Title: TMFTitleLabel;
    ResultEdit1: TMFEdit;
    ResultEdit2: TMFEdit;
    ResultEdit3: TMFEdit;
    ResultEdit4: TMFEdit;
    ResultEdit5: TMFEdit;
    StartDateCal: TMFDateTimePicker;
    EndDateCal: TMFDateTimePicker;
    ButtonAction: TMFBitBtn;
    CurrentForm: TForm;
    TheAmountOfBloodOnPreserving: IBQBTheAmountOfBloodOnPreserving;
    TheNumberOfWholeBlood: IBQBTheNumberOfWholeBlood;
    TheNumberOfConservedBlood: IBQBTheNumberOfConservedBlood;
    TheAmountOfReinfusionWithAPA: IBQBTheAmountOfReinfusionWithAPA;
    TheAmountOfReinfusionWithTrombo: IBQBTheAmountOfReinfusionWithTrombo;
    function GetLabelStartDate(NameForm: TForm): TLabel;
    function GetLabelEndDate(NameForm: TForm): TLabel;
    function GetLabelNameStat1(NameForm: TForm): TLabel;
    function GetLabelNameStat2(NameForm: TForm): TLabel;
    function GetLabelNameStat3(NameForm: TForm): TLabel;
    function GetLabelNameStat4(NameForm: TForm): TLabel;
    function GetLabelNameStat5(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;
    function GetEdit1(NameForm: TForm): TEdit;
    function GetEdit2(NameForm: TForm): TEdit;
    function GetEdit3(NameForm: TForm): TEdit;
    function GetEdit4(NameForm: TForm): TEdit;
    function GetEdit5(NameForm: TForm): TEdit;
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
  GetLabelNameStat1(form);
  GetLabelNameStat2(form);
  GetLabelNameStat3(form);
  GetLabelNameStat4(form);
  GetLabelNameStat5(form);
  GetLabelTitle(form);

  GetCalendarStartDate(form);
  GetCalendarEndDate(form);

  GetEdit1(form);
  GetEdit2(form);
  GetEdit3(form);
  GetEdit4(form);
  GetEdit5(form);

  GetButtonAction(form);
  Show;
  inherited;
end;

destructor TMQBBloodProduct.destroy;
begin
  StartDate.destroy;
  EndDate.destroy;
  NameStat1.destroy;
  NameStat2.destroy;
  NameStat3.destroy;
  NameStat4.destroy;
  NameStat5.destroy;
  Title.destroy;

  EndDateCal.destroy;
  StartDateCal.destroy;

  ResultEdit1.destroy;
  ResultEdit2.destroy;
  ResultEdit3.destroy;
  ResultEdit4.destroy;
  ResultEdit5.destroy;

  ButtonAction.destroy;
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
    ResultEdit1.WriteText(TheAmountOfBloodOnPreserving.GetValue);
    TheAmountOfBloodOnPreserving := nil;

    if not Assigned(TheNumberOfWholeBlood) then
      TheNumberOfWholeBlood := TBQBTheNumberOfWholeBlood.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit2.WriteText(TheNumberOfWholeBlood.GetValue);
    TheNumberOfWholeBlood := nil;

    if not Assigned(TheNumberOfConservedBlood) then
      TheNumberOfConservedBlood := TBQBTheNumberOfConservedBlood.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit3.WriteText(TheNumberOfConservedBlood.GetValue);
    TheNumberOfConservedBlood := nil;

    if not Assigned(TheAmountOfReinfusionWithAPA) then
      TheAmountOfReinfusionWithAPA := TBQBTheAmountOfReinfusionWithAPA.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit4.WriteText(TheAmountOfReinfusionWithAPA.GetValue);
    TheAmountOfReinfusionWithAPA := nil;

    if not Assigned(TheAmountOfReinfusionWithTrombo) then
      TheAmountOfReinfusionWithTrombo :=
        TBQBTheAmountOfReinfusionWithTrombo.create(StartDateCal.GetDate,
        EndDateCal.GetDate);
    ResultEdit5.WriteText(TheAmountOfReinfusionWithTrombo.GetValue);
    TheAmountOfReinfusionWithTrombo := nil;

    ShowMessage('Запрос выполнен!');
  end;

end;

function TMQBBloodProduct.GetEdit1(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit1) then
    ResultEdit1 := TMFEdit.create;
  Result := ResultEdit1.GetEdit(520, 180, 100, 12, True, NameForm);
end;

function TMQBBloodProduct.GetEdit2(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit2) then
    ResultEdit2 := TMFEdit.create;
  Result := ResultEdit2.GetEdit(520, 220, 100, 12, True, NameForm);
end;

function TMQBBloodProduct.GetEdit3(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit3) then
    ResultEdit3 := TMFEdit.create;
  Result := ResultEdit3.GetEdit(520, 260, 100, 12, True, NameForm);
end;

function TMQBBloodProduct.GetEdit4(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit4) then
    ResultEdit4 := TMFEdit.create;
  Result := ResultEdit4.GetEdit(520, 300, 100, 12, True, NameForm);
end;

function TMQBBloodProduct.GetEdit5(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit5) then
    ResultEdit5 := TMFEdit.create;
  Result := ResultEdit5.GetEdit(520, 340, 100, 12, True, NameForm);
end;

function TMQBBloodProduct.GetButtonAction(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TMFBitBtn.create;
  Result := ButtonAction.GetBitBtn(360, 590, 'Сформировать', ButtonAct,
    NameForm);
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
end;

function TMQBBloodProduct.GetCalendarEndDate(NameForm: TForm): TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal := TMFDateTimePicker.create;
  Result := EndDateCal.GetDTPicker(250, 120, EncodeDate(YearOf(Now),
    MonthOf(Now), 1) - 1, NameForm);
end;

function TMQBBloodProduct.GetLabelEndDate(NameForm: TForm): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TMFLabel.create;
  Result := EndDate.GetTempLabel(50, 120, 20, 'Конечная дата:', NameForm);
end;

function TMQBBloodProduct.GetLabelNameStat1(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat1) then
    NameStat1 := TMFLabel.create;
  Result := NameStat1.GetTempLabel(50, 180, 20,
    'Количество крови на консервирование:', NameForm);
end;

function TMQBBloodProduct.GetLabelNameStat2(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat2) then
    NameStat2 := TMFLabel.create;
  Result := NameStat2.GetTempLabel(50, 220, 20, 'Количество цельной крови:',
    NameForm);
end;

function TMQBBloodProduct.GetLabelNameStat3(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat3) then
    NameStat3 := TMFLabel.create;
  Result := NameStat3.GetTempLabel(50, 260, 20,
    'Количество консервированной крови:', NameForm);
end;

function TMQBBloodProduct.GetLabelNameStat4(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat4) then
    NameStat4 := TMFLabel.create;
  Result := NameStat4.GetTempLabel(50, 300, 20, 'Объем реинфузии с АПА:',
    NameForm);
end;

function TMQBBloodProduct.GetLabelNameStat5(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat5) then
    NameStat5 := TMFLabel.create;
  Result := NameStat5.GetTempLabel(50, 340, 20, 'Объем реинфузии с цитофереза:',
    NameForm);
end;

function TMQBBloodProduct.GetLabelStartDate(NameForm: TForm): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TMFLabel.create;
  Result := StartDate.GetTempLabel(50, 80, 20, 'Начальная дата:', NameForm);
end;

function TMQBBloodProduct.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, 'Заготовка крови', NameForm);
end;

procedure TMQBBloodProduct.Show;
begin
  StartDate.Visible(True);
  EndDate.Visible(True);
  NameStat1.Visible(True);
  NameStat2.Visible(True);
  NameStat3.Visible(True);
  NameStat4.Visible(True);
  NameStat5.Visible(True);

  StartDateCal.Visible(True);
  EndDateCal.Visible(True);

  ResultEdit1.Visible(True);
  ResultEdit2.Visible(True);
  ResultEdit3.Visible(True);
  ResultEdit4.Visible(True);
  ResultEdit5.Visible(True);

  ButtonAction.Visible(True);
end;

end.
