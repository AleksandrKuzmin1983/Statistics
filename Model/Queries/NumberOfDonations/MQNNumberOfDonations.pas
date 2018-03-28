unit MQNNumberOfDonations;

interface

uses
  SysUtils, StdCtrls, Buttons, Variants,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs,
  BQNTheNumberOfBloodDonations,
  BQNTheNumberOfPlasmaDonations,
  BQNTheNumberOfTromboDonations,
  MFLabel,
  MFTitleLabel,
  MFEdit,
  MFDateTimePicker,
  MFBitBtn,
  USGlobalVariant;

type

  TMQNNumberOfDonations = class(TUSGlobalVariant)
  private
    StartDate: TMFLabel;
    EndDate: TMFLabel;
    NameStat1: TMFLabel;
    NameStat2: TMFLabel;
    NameStat3: TMFLabel;

    Title: TMFTitleLabel;

    ResultEdit1: TMFEdit;
    ResultEdit2: TMFEdit;
    ResultEdit3: TMFEdit;

    StartDateCal: TMFDateTimePicker;
    EndDateCal: TMFDateTimePicker;

    ButtonAction: TMFBitBtn;

    CurrentForm: TForm;

    TheNumberOfBloodDonations: IBQNTheNumberOfBloodDonations;
    TheNumberOfPlasmaDonations: IBQNTheNumberOfPlasmaDonations;
    TheNumberOfTromboDonations: IBQNTheNumberOfTromboDonations;
    function GetLabelStartDate(NameForm: TForm): TLabel;
    function GetLabelEndDate(NameForm: TForm): TLabel;
    function GetLabelNameStat1(NameForm: TForm): TLabel;
    function GetLabelNameStat2(NameForm: TForm): TLabel;
    function GetLabelNameStat3(NameForm: TForm): TLabel;

    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetEdit1(NameForm: TForm): TEdit;
    function GetEdit2(NameForm: TForm): TEdit;
    function GetEdit3(NameForm: TForm): TEdit;

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

{ TNumberOfDonations }

constructor TMQNNumberOfDonations.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelStartDate(CurrentForm);
  GetLabelEndDate(CurrentForm);
  GetLabelNameStat1(CurrentForm);
  GetLabelNameStat2(CurrentForm);
  GetLabelNameStat3(CurrentForm);

  GetLabelTitle(CurrentForm);

  GetCalendarStartDate(CurrentForm);
  GetCalendarEndDate(CurrentForm);

  GetEdit1(CurrentForm);
  GetEdit2(CurrentForm);
  GetEdit3(CurrentForm);

  GetButtonAction(CurrentForm);
  Show;
  inherited;
end;

destructor TMQNNumberOfDonations.destroy;
begin
  StartDate.destroy;
  EndDate.destroy;
  NameStat1.destroy;
  NameStat2.destroy;
  NameStat3.destroy;

  Title.destroy;

  ResultEdit1.destroy;
  ResultEdit2.destroy;
  ResultEdit3.destroy;

  StartDateCal.destroy;
  EndDateCal.destroy;

  ButtonAction.destroy;
  inherited;
end;

procedure TMQNNumberOfDonations.ButtonAct(Sender: TObject);
begin
  if StartDateCal.GetDate > EndDateCal.GetDate then
  begin
    ShowMessage('Конечная дата не может быть меньше начальной');
    exit;
  end
  else
  begin
    if not Assigned(TheNumberOfBloodDonations) then
      TheNumberOfBloodDonations := TBQNTheNumberOfBloodDonations.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit1.WriteText(TheNumberOfBloodDonations.GetValue);
    TheNumberOfBloodDonations := nil;

    if not Assigned(TheNumberOfPlasmaDonations) then
      TheNumberOfPlasmaDonations := TBQNTheNumberOfPlasmaDonations.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit2.WriteText(TheNumberOfPlasmaDonations.GetValue);
    TheNumberOfPlasmaDonations := nil;

    if not Assigned(TheNumberOfTromboDonations) then
      TheNumberOfTromboDonations := TBQNTheNumberOfTromboDonations.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit3.WriteText(TheNumberOfTromboDonations.GetValue);
    TheNumberOfTromboDonations := nil;

    ShowMessage('Запрос выполнен!');
  end;
end;

function TMQNNumberOfDonations.GetEdit1(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit1) then
    ResultEdit1 := TMFEdit.create;
  Result := ResultEdit1.GetEdit(440, 180, 100, 12, True, NameForm);
end;

function TMQNNumberOfDonations.GetEdit2(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit2) then
    ResultEdit2 := TMFEdit.create;
  Result := ResultEdit2.GetEdit(440, 220, 100, 12, True, NameForm);
end;

function TMQNNumberOfDonations.GetEdit3(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit3) then
    ResultEdit3 := TMFEdit.create;
  Result := ResultEdit3.GetEdit(440, 260, 100, 12, True, NameForm);
end;

function TMQNNumberOfDonations.GetButtonAction(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TMFBitBtn.create;
  Result := ButtonAction.GetBitBtn(360, 590, 'Сформировать', ButtonAct,
    NameForm);
end;

function TMQNNumberOfDonations.GetCalendarStartDate(NameForm: TForm)
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

function TMQNNumberOfDonations.GetCalendarEndDate(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal := TMFDateTimePicker.create;
  Result := EndDateCal.GetDTPicker(250, 120, EncodeDate(YearOf(Now),
    MonthOf(Now), 1) - 1, NameForm);
end;

function TMQNNumberOfDonations.GetLabelEndDate(NameForm: TForm): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TMFLabel.create;
  Result := EndDate.GetTempLabel(50, 120, 20, 'Конечная дата:', NameForm);
end;

function TMQNNumberOfDonations.GetLabelNameStat1(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat1) then
    NameStat1 := TMFLabel.create;
  Result := NameStat1.GetTempLabel(50, 180, 20, 'Количество донаций крови:',
    NameForm);
end;

function TMQNNumberOfDonations.GetLabelNameStat2(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat2) then
    NameStat2 := TMFLabel.create;
  Result := NameStat2.GetTempLabel(50, 220, 20, 'Количество донаций плазмы:',
    NameForm);
end;

function TMQNNumberOfDonations.GetLabelNameStat3(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat3) then
    NameStat3 := TMFLabel.create;
  Result := NameStat3.GetTempLabel(50, 260, 20,
    'Количество донаций цитофереза:', NameForm);
end;

function TMQNNumberOfDonations.GetLabelStartDate(NameForm: TForm): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TMFLabel.create;
  Result := StartDate.GetTempLabel(50, 80, 20, 'Начальная дата:', NameForm);
end;

function TMQNNumberOfDonations.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, 'Количество донаций и заготовленной крови',
    NameForm);
end;

procedure TMQNNumberOfDonations.Show;
begin
  StartDate.Visible(True);
  EndDate.Visible(True);
  NameStat1.Visible(True);
  NameStat2.Visible(True);
  NameStat3.Visible(True);

  StartDateCal.Visible(True);
  EndDateCal.Visible(True);

  ResultEdit1.Visible(True);
  ResultEdit2.Visible(True);
  ResultEdit3.Visible(True);

  ButtonAction.Visible(True);
end;

end.
