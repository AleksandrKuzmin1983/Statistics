unit MIOAAdviceToDoctors;

interface

uses
  WinProcs, SysUtils, StdCtrls, CodeSiteLogging, Buttons, Vcl.Grids, Data.DB,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,
  USCheckFillStringFields,
  USBlockMainMenu,
  MFLabel,
  MFTitleLabel,
  MFEdit,
  MFDateTimePicker,
  MFBitBtnAdd,
  MFBitBtnDelete,
  MFBitBtnEdit,
  MFBitBtnBlock,
  MFStringGrid,
  BIOAAddRecordResultsInAdviceToDoctor,
  BIOADeleteRecordResultsInAdviceToDoctor,
  BIOAChangeRecordResultsInAdviceToDoctor,
  BIOAAdviceToDoctors,
  USGlobalVariant;

type

  TMIOAAdviceToDoctors = class(TUSGlobalVariant)
  private
    LabelReportDate: TMFLabel;
    LabelTheDoctorTransfuziolog: TMFLabel;
    LabelMedicalLaboratoryScientist: TMFLabel;
    Title: TMFTitleLabel;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBIOAAdviceToDoctors;
    AddRecord: IBIOAAddRecordResultsInAdviceToDoctor;
    DeleteRecord: IBIOADeleteRecordResultsInAdviceToDoctor;
    ChangeRecord: IBIOAChangeRecordResultsInAdviceToDoctor;

    EditTheDoctorTransfuziolog: TMFEdit;
    EditMedicalLaboratoryScientist: TMFEdit;

    ReportDateCal: TMFDateTimePicker;
    CheckFillStrFields: IUSCheckFillStringFields;
    BlockMainMenu: IUSBlockMainMenu;

    ButtonAdd: TMFBitBtnAdd;
    ButtonDelete: TMFBitBtnDelete;
    ButtonEdit: TMFBitBtnEdit;
    ButtonBlock: TMFBitBtnBlock;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelTheDoctorTransfuziolog(NameForm: TForm): TLabel;
    function GetLabelMedicalLaboratoryScientist(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;
    function GetEditTheDoctorTransfuziolog(NameForm: TForm): TEdit;
    function GetEditMedicalLaboratoryScientist(NameForm: TForm): TEdit;
    function GetCalendarReportDateCal(NameForm: TForm): TDateTimePicker;

    function GetButtonEdit(NameForm: TForm): TBitBtn;
    procedure ButtonEdited(Sender: TObject);
    function GetButtonAdd(NameForm: TForm): TBitBtn;
    procedure ButtonAdded(Sender: TObject);
    function GetButtonDelete(NameForm: TForm): TBitBtn;
    procedure ButtonDeleted(Sender: TObject);
    function GetButtonBlock(NameForm: TForm): TBitBtn;
    procedure ButtonBlocked(Sender: TObject);
    procedure Show;
  public
    constructor create(form: TForm); override;
    destructor destroy; override;
  end;

implementation

{ TBloodProduct }

constructor TMIOAAdviceToDoctors.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelReportDate(form);
  GetLabelTheDoctorTransfuziolog(form);
  GetLabelMedicalLaboratoryScientist(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditTheDoctorTransfuziolog(form);
  GetEditMedicalLaboratoryScientist(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.create ���������');
  inherited;
end;

destructor TMIOAAdviceToDoctors.destroy;
begin
  LabelReportDate.destroy;
  LabelTheDoctorTransfuziolog.destroy;
  LabelMedicalLaboratoryScientist.destroy;
  Title.destroy;

  StringGrid.destroy;

  EditTheDoctorTransfuziolog.destroy;
  EditMedicalLaboratoryScientist.destroy;

  ReportDateCal.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.destroy ���������');
  inherited;
end;

// Button

// ���������� ����� ������

procedure TMIOAAdviceToDoctors.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  EditTheDoctorTransfuziolog.WriteText
    (CheckFillStrFields.CheckStringFields(EditTheDoctorTransfuziolog.ReadText));
  EditMedicalLaboratoryScientist.WriteText
    (CheckFillStrFields.CheckStringFields
    (EditMedicalLaboratoryScientist.ReadText));
  if (EditMedicalLaboratoryScientist.ReadText = '0') and
    (EditTheDoctorTransfuziolog.ReadText = '0') then
  begin
    Showmessage
      ('���� �� ���� �� ����� "���������� ������������ ���������������" � "���������� ������������ ����������" ������ ���� ������� �� ����!');
    exit;
  End;
  if MessageDlg('��������� ������?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(AddRecord) then
      AddRecord := TBIOAAddRecordResultsInAdviceToDoctor.create;
    AddRecord.AddRecord(ReportDateCal.GetDate,
      EditTheDoctorTransfuziolog.ReadText,
      EditMedicalLaboratoryScientist.ReadText);
    Showmessage('������ ������� ���������!');
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
  end;
  EditTheDoctorTransfuziolog.WriteText('0');
  EditMedicalLaboratoryScientist.WriteText('0');
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.ButtonAdded ���������');
end;

// ������������� ������

procedure TMIOAAdviceToDoctors.ButtonBlocked(Sender: TObject);
begin
  if ButtonBlock.GetCaption then
  begin
    ButtonEdit.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    ButtonBlock.ChangeCaption(True);
  end
  else
  begin
    ButtonEdit.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    ButtonBlock.ChangeCaption(False);
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.ButtonBlocked ���������');
end;

// ������ ��������

procedure TMIOAAdviceToDoctors.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('������� ������ ����� ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBIOADeleteRecordResultsInAdviceToDoctor.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0,
      StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    Showmessage('������ ������� �������!');
  end;
  EditTheDoctorTransfuziolog.WriteText('0');
  EditMedicalLaboratoryScientist.WriteText('0');
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.ButtonDeleted ���������');
end;

// �������� ���������

procedure TMIOAAdviceToDoctors.ButtonEdited(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  if not Assigned(BlockMainMenu) then
    BlockMainMenu := TUSBlockMainMenu.create;
  if ButtonEdit.GetCaption = '��������' then
  begin
    BlockMainMenu.BlockMainMenu(False, CurrentForm);
    ButtonBlock.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    StringGrid.Enabled(False);
    ReportDateCal.WriteDateTime(StrToDate(StringGrid.GetValue(1,
      StringGrid.CurrentRow)));
    EditTheDoctorTransfuziolog.WriteText
      (VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow)));
    EditMedicalLaboratoryScientist.WriteText
      (VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetCaption = '��������� ���������' then
  begin
    EditTheDoctorTransfuziolog.WriteText
      (CheckFillStrFields.CheckStringFields
      (EditTheDoctorTransfuziolog.ReadText));
    EditMedicalLaboratoryScientist.WriteText
      (CheckFillStrFields.CheckStringFields
      (EditMedicalLaboratoryScientist.ReadText));
    if (EditMedicalLaboratoryScientist.ReadText = '0') and
      (EditTheDoctorTransfuziolog.ReadText = '0') then
    begin
      Showmessage
        ('���� �� ���� �� ����� "���������� ������������ ���������������" � "���������� ������������ ����������" ������ ���� ������� �� ����!'
        + char(13) +
        '���� ������ ���������� �������, �� �������� ��������� � �������������� ������� "������� ������"!');
      exit;
    End;
    BlockMainMenu.BlockMainMenu(True, CurrentForm);
    ButtonBlock.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    StringGrid.Enabled(True);
    if MessageDlg('��������� ���������?', mtConfirmation, [mbYes, mbNo], 0) = 6
    then
    begin
      if not Assigned(ChangeRecord) then
        ChangeRecord := TBIOAChangeRecordResultsInAdviceToDoctor.create;
      ChangeRecord.ChangeRecord(ReportDateCal.GetDate,
        EditTheDoctorTransfuziolog.ReadText,
        EditMedicalLaboratoryScientist.ReadText,
        StringGrid.GetValue(0, StringGrid.CurrentRow));
      GetStringGrid(CurrentForm);
      StringGrid.Visible(True);
      Showmessage('������ ������� ��������!');
    end
    else
    begin
      EditTheDoctorTransfuziolog.WriteText('0');
      EditMedicalLaboratoryScientist.WriteText('0');
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
      ButtonEdit.ChangeCaption('��������');
      exit;
    end;
    EditTheDoctorTransfuziolog.WriteText('0');
    EditMedicalLaboratoryScientist.WriteText('0');
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
  end;
  if ButtonEdit.GetCaption = '��������' then
    ButtonEdit.ChangeCaption('��������� ���������')
  else
    ButtonEdit.ChangeCaption('��������');

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.ButtonEdited ���������');
end;

// �������� ������

function TMIOAAdviceToDoctors.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetButtonAdd ���������');
end;

function TMIOAAdviceToDoctors.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetButtonBlock ���������');
end;

function TMIOAAdviceToDoctors.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetButtonDelete ���������');
end;

function TMIOAAdviceToDoctors.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetButtonEdit ���������');
end;

// TDateTimePicker

function TMIOAAdviceToDoctors.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal := TMFDateTimePicker.create;
  Result := ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date) - 7,
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetCalendarReportDateCal ���������');
end;

// Edit

function TMIOAAdviceToDoctors.GetEditTheDoctorTransfuziolog
  (NameForm: TForm): TEdit;
begin
  if not Assigned(EditTheDoctorTransfuziolog) then
    EditTheDoctorTransfuziolog := TMFEdit.create;
  Result := EditTheDoctorTransfuziolog.GetEdit(450, 130, 135, 12, False,
    NameForm);
  EditTheDoctorTransfuziolog.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetEditTheDoctorTransfuziolog ���������');
end;

function TMIOAAdviceToDoctors.GetEditMedicalLaboratoryScientist
  (NameForm: TForm): TEdit;
begin
  if not Assigned(EditMedicalLaboratoryScientist) then
    EditMedicalLaboratoryScientist := TMFEdit.create;
  Result := EditMedicalLaboratoryScientist.GetEdit(450, 180, 135, 12, False,
    NameForm);
  EditMedicalLaboratoryScientist.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetEditMedicalLaboratoryScientist ���������');
end;

// Label

function TMIOAAdviceToDoctors.GetLabelMedicalLaboratoryScientist
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelMedicalLaboratoryScientist) then
    LabelMedicalLaboratoryScientist := TMFLabel.create;
  Result := LabelMedicalLaboratoryScientist.GetTempLabel(50, 180, 14,
    '���������� ������������ ����������: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetLabelMedicalLaboratoryScientist ���������');
end;

function TMIOAAdviceToDoctors.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TMFLabel.create;
  Result := LabelReportDate.GetTempLabel(50, 80, 16, '�������� ������: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetLabelReportDate ���������');
end;

function TMIOAAdviceToDoctors.GetLabelTheDoctorTransfuziolog
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTheDoctorTransfuziolog) then
    LabelTheDoctorTransfuziolog := TMFLabel.create;
  Result := LabelTheDoctorTransfuziolog.GetTempLabel(50, 130, 14,
    '���������� ������������ ���������������: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetLabelTheDoctorTransfuziolog ���������');
end;

function TMIOAAdviceToDoctors.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(16,
    '���������� ����������� ������������ ������-��������������� � ������-����������',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetLabelTitle ���������');
end;

// StringGrid

function TMIOAAdviceToDoctors.GetStringGrid(NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TMFStringGrid.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 1, DT_LEFT, 2, DT_CENTER, 3,
    DT_CENTER, 4, DT_CENTER);
  Result := StringGrid.GetStringGrid(50, 280, 800, 240, 4, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0, 60);
  StringGrid.ColWidth(1, 100);
  StringGrid.ColWidth(2, 130);
  StringGrid.ColWidth(3, 100);
  StringGrid.WriteCells(0, 0, '���');
  StringGrid.WriteCells(1, 0, '����');
  StringGrid.WriteCells(2, 0, '���������������');
  StringGrid.WriteCells(3, 0, '����������');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TBIOAAdviceToDoctors.create;
  ContentForStringGrid.GetContent;
  if ContentForStringGrid.GetRowCount > 0 then
    for i := 0 to ContentForStringGrid.GetRowCount - 1 do
    begin
      if StringGrid.GetValue(0, 1) <> '' then
        StringGrid.AddRowCount;
      StringGrid.WriteCells(0, i + 1, ContentForStringGrid.GetKod(j));
      StringGrid.WriteCells(1, i + 1, ContentForStringGrid.GetDate(j));
      StringGrid.WriteCells(2, i + 1, ContentForStringGrid.GetTransfuziolog(j));
      StringGrid.WriteCells(3, i + 1,
        ContentForStringGrid.GetLaboratoryScientist(j));
      j := j + 1;
    end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.GetStringGrid ���������');
end;

procedure TMIOAAdviceToDoctors.Show;
begin
  LabelReportDate.Visible(True);
  LabelTheDoctorTransfuziolog.Visible(True);
  LabelMedicalLaboratoryScientist.Visible(True);

  StringGrid.Visible(True);

  ReportDateCal.Visible(True);

  EditTheDoctorTransfuziolog.Visible(True);
  EditMedicalLaboratoryScientist.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOAAdviceToDoctors.Show ���������');
end;

end.
