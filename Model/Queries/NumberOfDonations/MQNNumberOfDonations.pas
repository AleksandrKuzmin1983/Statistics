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
  IVQNNumberOfDonations = interface
  end;

  TNumberOfDonations = class(TGlobalVariant)
  private
    StartDate: TTempLabelTag5;
    EndDate: TTempLabelTag5;
    NameStat1: TTempLabelTag5;
    NameStat2: TTempLabelTag5;
    NameStat3: TTempLabelTag5;

    Title: TTitleLabelTag5;

    ResultEdit1: TEditTag5;
    ResultEdit2: TEditTag5;
    ResultEdit3: TEditTag5;

    StartDateCal: TDTPickerTag5;
    EndDateCal: TDTPickerTag5;

    ButtonAction: TBitBtnTag5;

    CurrentForm: TForm;

    TheNumberOfBloodDonations: ITheNumberOfBloodDonations;
    TheNumberOfPlasmaDonations: ITheNumberOfPlasmaDonations;
    TheNumberOfTromboDonations: ITheNumberOfTromboDonations;
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

constructor TNumberOfDonations.create(form: TForm);
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

destructor TNumberOfDonations.destroy;
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

procedure TNumberOfDonations.ButtonAct(Sender: TObject);
begin
  if StartDateCal.GetDate > EndDateCal.GetDate then
  begin
    ShowMessage('�������� ���� �� ����� ���� ������ ���������');
    exit;
  end
  else
  begin
    if not Assigned(TheNumberOfBloodDonations) then
      TheNumberOfBloodDonations := TTheNumberOfBloodDonations.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit1.WriteText(TheNumberOfBloodDonations.GetValue);
    TheNumberOfBloodDonations := nil;

    if not Assigned(TheNumberOfPlasmaDonations) then
      TheNumberOfPlasmaDonations := TTheNumberOfPlasmaDonations.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit2.WriteText(TheNumberOfPlasmaDonations.GetValue);
    TheNumberOfPlasmaDonations := nil;

    if not Assigned(TheNumberOfTromboDonations) then
      TheNumberOfTromboDonations := TTheNumberOfTromboDonations.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    ResultEdit3.WriteText(TheNumberOfTromboDonations.GetValue);
    TheNumberOfTromboDonations := nil;

    ShowMessage('������ ��������!');
  end;
end;

function TNumberOfDonations.GetEdit1(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit1) then
    ResultEdit1 := TEditTag5.create;
  Result:=ResultEdit1.GetEdit(440, 180, 100, 12, True, NameForm);
end;

function TNumberOfDonations.GetEdit2(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit2) then
    ResultEdit2 := TEditTag5.create;
  Result:=ResultEdit2.GetEdit(440, 220, 100, 12, True, NameForm);
end;

function TNumberOfDonations.GetEdit3(NameForm: TForm): TEdit;
begin
  if not Assigned(ResultEdit3) then
    ResultEdit3 := TEditTag5.create;
  Result:=ResultEdit3.GetEdit(440, 260, 100, 12, True, NameForm);
end;

function TNumberOfDonations.GetButtonAction(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TBitBtnTag5.create;
  Result:=ButtonAction.GetBitBtn(360, 590, '������������', ButtonAct, NameForm);
end;

function TNumberOfDonations.GetCalendarStartDate(NameForm: TForm)
  : TDateTimePicker;
var
  CYear, CMonth: Word;
begin
  if MonthOf(Now)=1 then CMonth:=12 else CMonth:=MonthOf(Now) - 1;
  if CMonth=12 then CYear:=YearOf(Now)-1 else CYear:=YearOf(Now);
  if not Assigned(StartDateCal) then
    StartDateCal:=TDTPickerTag5.Create;
  result:=StartDateCal.GetDTPicker(250, 80, EncodeDate(CYear, CMonth, 1), NameForm);
end;

function TNumberOfDonations.GetCalendarEndDate(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal:=TDTPickerTag5.Create;
  result:=EndDateCal.GetDTPicker(250, 120, EncodeDate(YearOf(Now), MonthOf(Now), 1) - 1, NameForm);
end;

function TNumberOfDonations.GetLabelEndDate(NameForm: TForm): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TTempLabelTag5.create;
  Result:=EndDate.GetTempLabel(50, 120, 20, '�������� ����:', NameForm);
end;

function TNumberOfDonations.GetLabelNameStat1(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat1) then
    NameStat1 := TTempLabelTag5.create;
  Result:=NameStat1.GetTempLabel(50, 180, 20, '���������� ������� �����:', NameForm);
end;

function TNumberOfDonations.GetLabelNameStat2(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat2) then
    NameStat2 := TTempLabelTag5.create;
  Result:=NameStat2.GetTempLabel(50, 220, 20, '���������� ������� ������:', NameForm);
end;

function TNumberOfDonations.GetLabelNameStat3(NameForm: TForm): TLabel;
begin
  if not Assigned(NameStat3) then
    NameStat3 := TTempLabelTag5.create;
  Result:=NameStat3.GetTempLabel(50, 260, 20, '���������� ������� ����������:', NameForm);
end;

function TNumberOfDonations.GetLabelStartDate(NameForm: TForm): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TTempLabelTag5.create;
  Result:=StartDate.GetTempLabel(50, 80, 20, '��������� ����:', NameForm);
end;

function TNumberOfDonations.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  Result:=Title.GetTitleLabel(25, '���������� ������� � ������������� �����', NameForm);
end;

procedure TNumberOfDonations.Show;
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
