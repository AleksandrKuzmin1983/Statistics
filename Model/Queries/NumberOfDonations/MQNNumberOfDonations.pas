unit MQNNumberOfDonations;

interface

uses
  SysUtils, StdCtrls, Buttons, Variants,
  Vcl.ComCtrls, DateUtils, Forms, CodeSiteLogging, Dialogs,
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
    NumberOfBloodDonationsLabel: TMFLabel;
    NumberOfPlasmaDonationsLabel: TMFLabel;
    NumberOfTromboDonationsLabel: TMFLabel;

    Title: TMFTitleLabel;

    NumberOfBloodDonationsEdit: TMFEdit;
    NumberOfPlasmaDonationsEdit: TMFEdit;
    NumberOfTromboDonationsEdit: TMFEdit;

    StartDateCal: TMFDateTimePicker;
    EndDateCal: TMFDateTimePicker;

    ButtonAction: TMFBitBtn;

    CurrentForm: TForm;

    TheNumberOfBloodDonations: IBQNTheNumberOfBloodDonations;
    TheNumberOfPlasmaDonations: IBQNTheNumberOfPlasmaDonations;
    TheNumberOfTromboDonations: IBQNTheNumberOfTromboDonations;
    function GetLabelStartDate(NameForm: TForm): TLabel;
    function GetLabelEndDate(NameForm: TForm): TLabel;
    function GetNumberOfBloodDonationsLabel(NameForm: TForm): TLabel;
    function GetNumberOfPlasmaDonationsLabel(NameForm: TForm): TLabel;
    function GetNumberOfTromboDonationsLabel(NameForm: TForm): TLabel;

    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetNumberOfBloodDonationsEdit(NameForm: TForm): TEdit;
    function GetNumberOfPlasmaDonationsEdit(NameForm: TForm): TEdit;
    function GetNumberOfTromboDonationsEdit(NameForm: TForm): TEdit;

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
  GetNumberOfBloodDonationsLabel(CurrentForm);
  GetNumberOfPlasmaDonationsLabel(CurrentForm);
  GetNumberOfTromboDonationsLabel(CurrentForm);

  GetLabelTitle(CurrentForm);

  GetCalendarStartDate(CurrentForm);
  GetCalendarEndDate(CurrentForm);

  GetNumberOfBloodDonationsEdit(CurrentForm);
  GetNumberOfPlasmaDonationsEdit(CurrentForm);
  GetNumberOfTromboDonationsEdit(CurrentForm);

  GetButtonAction(CurrentForm);
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.create выполнена');
  inherited;
end;

destructor TMQNNumberOfDonations.destroy;
begin
  StartDate.destroy;
  EndDate.destroy;
  NumberOfBloodDonationsLabel.destroy;
  NumberOfPlasmaDonationsLabel.destroy;
  NumberOfTromboDonationsLabel.destroy;

  Title.destroy;

  NumberOfBloodDonationsEdit.destroy;
  NumberOfPlasmaDonationsEdit.destroy;
  NumberOfTromboDonationsEdit.destroy;

  StartDateCal.destroy;
  EndDateCal.destroy;

  ButtonAction.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.destroy выполнена');
  inherited;
end;

procedure TMQNNumberOfDonations.ButtonAct(Sender: TObject);
begin
  if StartDateCal.GetDate > EndDateCal.GetDate then
  begin
    ShowMessage(' онечна€ дата не может быть меньше начальной');
    exit;
  end
  else
  begin
    if not Assigned(TheNumberOfBloodDonations) then
      TheNumberOfBloodDonations := TBQNTheNumberOfBloodDonations.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    NumberOfBloodDonationsEdit.WriteText(TheNumberOfBloodDonations.GetValue);
    TheNumberOfBloodDonations := nil;

    if not Assigned(TheNumberOfPlasmaDonations) then
      TheNumberOfPlasmaDonations := TBQNTheNumberOfPlasmaDonations.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    NumberOfPlasmaDonationsEdit.WriteText(TheNumberOfPlasmaDonations.GetValue);
    TheNumberOfPlasmaDonations := nil;

    if not Assigned(TheNumberOfTromboDonations) then
      TheNumberOfTromboDonations := TBQNTheNumberOfTromboDonations.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    NumberOfTromboDonationsEdit.WriteText(TheNumberOfTromboDonations.GetValue);
    TheNumberOfTromboDonations := nil;

    ShowMessage('«апрос выполнен!');
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.ButtonAct выполнена');
end;

function TMQNNumberOfDonations.GetNumberOfBloodDonationsEdit(NameForm: TForm): TEdit;
begin
  if not Assigned(NumberOfBloodDonationsEdit) then
    NumberOfBloodDonationsEdit := TMFEdit.create;
  Result := NumberOfBloodDonationsEdit.GetEdit(440, 180, 100, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetNumberOfBloodDonationsEdit выполнена');
end;

function TMQNNumberOfDonations.GetNumberOfPlasmaDonationsEdit(NameForm: TForm): TEdit;
begin
  if not Assigned(NumberOfPlasmaDonationsEdit) then
    NumberOfPlasmaDonationsEdit := TMFEdit.create;
  Result := NumberOfPlasmaDonationsEdit.GetEdit(440, 220, 100, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetNumberOfPlasmaDonationsEdit выполнена');
end;

function TMQNNumberOfDonations.GetNumberOfTromboDonationsEdit(NameForm: TForm): TEdit;
begin
  if not Assigned(NumberOfTromboDonationsEdit) then
    NumberOfTromboDonationsEdit := TMFEdit.create;
  Result := NumberOfTromboDonationsEdit.GetEdit(440, 260, 100, 12, True, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetNumberOfTromboDonationsEdit выполнена');
end;

function TMQNNumberOfDonations.GetButtonAction(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TMFBitBtn.create;
  Result := ButtonAction.GetBitBtn(360, 590, ButtonAct,
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetButtonAction выполнена');
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetCalendarStartDate выполнена');
end;

function TMQNNumberOfDonations.GetCalendarEndDate(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal := TMFDateTimePicker.create;
  Result := EndDateCal.GetDTPicker(250, 120, EncodeDate(YearOf(Now),
    MonthOf(Now), 1) - 1, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetCalendarEndDate выполнена');
end;

function TMQNNumberOfDonations.GetLabelEndDate(NameForm: TForm): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TMFLabel.create;
  Result := EndDate.GetTempLabel(50, 120, 20, ' онечна€ дата:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetLabelEndDate выполнена');
end;

function TMQNNumberOfDonations.GetNumberOfBloodDonationsLabel(NameForm: TForm): TLabel;
begin
  if not Assigned(NumberOfBloodDonationsLabel) then
    NumberOfBloodDonationsLabel := TMFLabel.create;
  Result := NumberOfBloodDonationsLabel.GetTempLabel(50, 180, 20, ' оличество донаций крови:',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetNumberOfBloodDonationsLabel выполнена');
end;

function TMQNNumberOfDonations.GetNumberOfPlasmaDonationsLabel(NameForm: TForm): TLabel;
begin
  if not Assigned(NumberOfPlasmaDonationsLabel) then
    NumberOfPlasmaDonationsLabel := TMFLabel.create;
  Result := NumberOfPlasmaDonationsLabel.GetTempLabel(50, 220, 20, ' оличество донаций плазмы:',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetNumberOfPlasmaDonationsLabel выполнена');
end;

function TMQNNumberOfDonations.GetNumberOfTromboDonationsLabel(NameForm: TForm): TLabel;
begin
  if not Assigned(NumberOfTromboDonationsLabel) then
    NumberOfTromboDonationsLabel := TMFLabel.create;
  Result := NumberOfTromboDonationsLabel.GetTempLabel(50, 260, 20,
    ' оличество донаций цитофереза:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetNumberOfTromboDonationsLabel выполнена');
end;

function TMQNNumberOfDonations.GetLabelStartDate(NameForm: TForm): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TMFLabel.create;
  Result := StartDate.GetTempLabel(50, 80, 20, 'Ќачальна€ дата:', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetLabelStartDate выполнена');
end;

function TMQNNumberOfDonations.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, ' оличество донаций и заготовленной крови',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.GetLabelTitle выполнена');
end;

procedure TMQNNumberOfDonations.Show;
begin
  StartDate.Visible(True);
  EndDate.Visible(True);
  NumberOfBloodDonationsLabel.Visible(True);
  NumberOfPlasmaDonationsLabel.Visible(True);
  NumberOfTromboDonationsLabel.Visible(True);

  StartDateCal.Visible(True);
  EndDateCal.Visible(True);

  NumberOfBloodDonationsEdit.Visible(True);
  NumberOfPlasmaDonationsEdit.Visible(True);
  NumberOfTromboDonationsEdit.Visible(True);

  ButtonAction.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMQNNumberOfDonations.Show выполнена');
end;
end.
