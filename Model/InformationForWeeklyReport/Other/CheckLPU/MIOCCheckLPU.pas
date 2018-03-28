unit MIOCCheckLPU;

interface

uses
  WinProcs, SysUtils, StdCtrls, Buttons, Vcl.Grids, Data.DB,
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
  BIOCAddRecordResultsCheckLPU,
  BIOCDeleteRecordResultsCheckLPU,
  BIOCChangeRecordResultsCheckLPU,
  BIOCCheckLPU,
  USGlobalVariant;

type

  TMIOCCheckLPU = class(TUSGlobalVariant)
  private
    LabelReportDate: TMFLabel;
    LabelCheckLPU: TMFLabel;
    Title: TMFTitleLabel;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBIOCCheckLPU;
    AddRecord: IBIOCAddRecordResultsCheckLPU;
    DeleteRecord: IBIOCDeleteRecordResultsCheckLPU;
    ChangeRecord: IBIOCChangeRecordResultsCheckLPU;

    EditCheckLPU: TMFEdit;

    ReportDateCal: TMFDateTimePicker;
    CheckFillStrFields: IUSCheckFillStringFields;
    BlockMainMenu: IUSBlockMainMenu;

    ButtonAdd: TMFBitBtnAdd;
    ButtonDelete: TMFBitBtnDelete;
    ButtonEdit: TMFBitBtnEdit;
    ButtonBlock: TMFBitBtnBlock;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelCheckLPU(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;
    function GetEditCheckLPU(NameForm: TForm): TEdit;
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

constructor TMIOCCheckLPU.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelReportDate(form);
  GetLabelCheckLPU(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditCheckLPU(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  Show;
  inherited;
end;

destructor TMIOCCheckLPU.destroy;
begin
  LabelReportDate.destroy;
  LabelCheckLPU.destroy;
  Title.destroy;

  StringGrid.destroy;

  EditCheckLPU.destroy;

  ReportDateCal.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;
  inherited;
end;

// Button

// Добавление новой записи

procedure TMIOCCheckLPU.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  EditCheckLPU.WriteText(CheckFillStrFields.CheckStringFields
    (EditCheckLPU.ReadText));
  if (EditCheckLPU.ReadText = '0') then
  begin
    Showmessage('Поле "Количество проверок ЛПУ" должно быть заполнено!');
    exit;
  End;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(AddRecord) then
      AddRecord := TBIOCAddRecordResultsCheckLPU.create;
    AddRecord.AddRecord(ReportDateCal.GetDate, EditCheckLPU.ReadText);
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    Showmessage('Запись успешно добавлена!');
  end;
  EditCheckLPU.WriteText('0');
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
end;

// Разблокировка кнопок

procedure TMIOCCheckLPU.ButtonBlocked(Sender: TObject);
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
end;

// Кнопка удаления

procedure TMIOCCheckLPU.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBIOCDeleteRecordResultsCheckLPU.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0,
      StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    Showmessage('Запись успешно удалена!');
  end;
  EditCheckLPU.WriteText('0');
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
end;

// Внесение изменений

procedure TMIOCCheckLPU.ButtonEdited(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  if not Assigned(BlockMainMenu) then
    BlockMainMenu := TUSBlockMainMenu.create;
  if ButtonEdit.GetCaption = 'Изменить' then
  begin
    BlockMainMenu.BlockMainMenu(False, CurrentForm);
    ButtonBlock.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    StringGrid.Enabled(False);
    ReportDateCal.WriteDateTime(StrToDate(StringGrid.GetValue(1,
      StringGrid.CurrentRow)));
    EditCheckLPU.WriteText(VarToStr(StringGrid.GetValue(2,
      StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetCaption = 'Сохранить изменения' then
  begin
    EditCheckLPU.WriteText(CheckFillStrFields.CheckStringFields
      (EditCheckLPU.ReadText));
    if (EditCheckLPU.ReadText = '0') then
    begin
      Showmessage('Поле "Количество проверок ЛПУ" должно быть заполнено!' +
        char(13) +
        'Если запись необходимо удалить, то отмените изменения и воспользуйтесь кнопкой "Удалить запись"!');
      exit;
    End;
    BlockMainMenu.BlockMainMenu(True, CurrentForm);
    ButtonBlock.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    StringGrid.Enabled(True);
    if MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0) = 6
    then
    begin
      if not Assigned(ChangeRecord) then
        ChangeRecord := TBIOCChangeRecordResultsCheckLPU.create;
      ChangeRecord.ChangeRecord(ReportDateCal.GetDate, EditCheckLPU.ReadText,
        StringGrid.GetValue(0, StringGrid.CurrentRow));
      GetStringGrid(CurrentForm);
      StringGrid.Visible(True);
      Showmessage('Запись успешно изменена!');
    end
    else
    begin
      EditCheckLPU.WriteText('0');
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end;
    EditCheckLPU.WriteText('0');
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
  end;
  if ButtonEdit.GetCaption = 'Изменить' then
    ButtonEdit.ChangeCaption('Сохранить изменения')
  else
    ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок

function TMIOCCheckLPU.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TMIOCCheckLPU.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TMIOCCheckLPU.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TMIOCCheckLPU.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

// TDateTimePicker

function TMIOCCheckLPU.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal := TMFDateTimePicker.create;
  Result := ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date) - 7,
    NameForm);
end;

// Edit

function TMIOCCheckLPU.GetEditCheckLPU(NameForm: TForm): TEdit;
begin
  if not Assigned(EditCheckLPU) then
    EditCheckLPU := TMFEdit.create;
  Result := EditCheckLPU.GetEdit(450, 130, 135, 12, False, NameForm);
  EditCheckLPU.NumberOnly(True);
end;

// Label

function TMIOCCheckLPU.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TMFLabel.create;
  Result := LabelReportDate.GetTempLabel(50, 80, 16, 'Отчетная неделя: ',
    NameForm);
end;

function TMIOCCheckLPU.GetLabelCheckLPU(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelCheckLPU) then
    LabelCheckLPU := TMFLabel.create;
  Result := LabelCheckLPU.GetTempLabel(50, 130, 14,
    'Количество консультаций трансфузиологом: ', NameForm);
end;

function TMIOCCheckLPU.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, 'Количество проведенных проверок ЛПУ',
    NameForm);
end;

// StringGrid

function TMIOCCheckLPU.GetStringGrid(NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TMFStringGrid.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 1, DT_LEFT, 2, DT_CENTER, 3,
    DT_CENTER, 4, DT_CENTER);
  Result := StringGrid.GetStringGrid(50, 280, 800, 240, 3, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0, 60);
  StringGrid.ColWidth(1, 100);
  StringGrid.ColWidth(2, 160);
  StringGrid.Visible(True);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Количество проверок');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TBIOCCheckLPU.create;
  ContentForStringGrid.GetContent;
  if ContentForStringGrid.GetRowCount > 0 then
    for i := 0 to ContentForStringGrid.GetRowCount - 1 do
    begin
      if StringGrid.GetValue(0, 1) <> '' then
        StringGrid.AddRowCount;
      StringGrid.WriteCells(0, i + 1, ContentForStringGrid.GetKod(j));
      StringGrid.WriteCells(1, i + 1, ContentForStringGrid.GetDate(j));
      StringGrid.WriteCells(2, i + 1, ContentForStringGrid.GetCheckLPU(j));
      j := j + 1;
    end;
end;

procedure TMIOCCheckLPU.Show;
begin
  LabelReportDate.Visible(True);
  LabelCheckLPU.Visible(True);

  StringGrid.Visible(True);

  ReportDateCal.Visible(True);

  EditCheckLPU.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);
end;

end.
