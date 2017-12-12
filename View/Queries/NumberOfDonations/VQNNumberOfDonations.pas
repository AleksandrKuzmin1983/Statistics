unit VQNNumberOfDonations;

interface

uses
  SysUtils, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs,
  MQNTheNumberOfBloodDonations,
  MQNTheNumberOfPlasmaDonations,
  MQNTheNumberOfTromboDonations,
  UVFLabel,
  UVFTitleLabel,
  UVFEdit,
  UVFDateTimePicker,
  UVFBitBtn;

type
  IVQNNumberOfDonations = interface
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
  end;

  TNumberOfDonations = class(TInterfacedObject, IVQNNumberOfDonations)
  private
    StartDate: ITempLabelTag5;
    EndDate: ITempLabelTag5;
    NameStat1: ITempLabelTag5;
    NameStat2: ITempLabelTag5;
    NameStat3: ITempLabelTag5;

    Title: ITitleLabelTag5;

    ResultEdit1: IEditTag5;
    ResultEdit2: IEditTag5;
    ResultEdit3: IEditTag5;

    StartDateCal: IDTPickerTag5;
    EndDateCal: IDTPickerTag5;

    ButtonAction: IBitBtnTag5;

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
  public
    constructor create(form: TForm);
  end;

implementation

{ TNumberOfDonations }

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
  Result:=ButtonAction.GetBitBtn(385, 510, '������������', ButtonAct, NameForm);
end;

function TNumberOfDonations.GetCalendarStartDate(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(StartDateCal) then
    StartDateCal:=TDTPickerTag5.Create;
  result:=StartDateCal.GetDTPicker(250, 80, EncodeDate(YearOf(Now), MonthOf(Now) - 1, 1), NameForm);
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

end.
