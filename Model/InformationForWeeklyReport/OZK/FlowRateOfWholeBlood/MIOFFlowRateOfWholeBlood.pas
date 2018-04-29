unit MIOFFlowRateOfWholeBlood;

interface

uses
  WinProcs, SysUtils, StdCtrls, Buttons, CodeSiteLogging, Vcl.Grids,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants, Data.DB,
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
  MFComboBox,
  BIOFAddRecordFlowRateOfWholeBlood,
  BIOFDeleteRecordFlowRateOfWholeBlood,
  BIOFChangeRecordFlowRateOfWholeBlood,
  BIOFFlowRateOfWholeBlood,
  USGlobalVariant;

type

  TMIOFFlowRateOfWholeBlood = class(TUSGlobalVariant)
  private
    LabelCancellationDate: TMFLabel;
    LabelVolume: TMFLabel;
    LabelNumberOfDoses: TMFLabel;
    LabelReasonConsumption: TMFLabel;
    Title: TMFTitleLabel;
    SQL: String;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBIOFFlowRateOfWholeBlood;
    AddRecord: IBIOFAddRecordFlowRateOfWholeBlood;
    DeleteRecord: IBIOFDeleteRecordFlowRateOfWholeBlood;
    ChangeRecord: IBIOFChangeRecordFlowRateOfWholeBlood;

    EditVolume: TMFEdit;
    EditNumberOfDoses: TMFEdit;

    ReasonConsumption: TMFComboBox;

    CancellationDateCal: TMFDateTimePicker;
    CheckFillStrFields: IUSCheckFillStringFields;
    BlockMainMenu: IUSBlockMainMenu;

    ButtonAdd: TMFBitBtnAdd;
    ButtonDelete: TMFBitBtnDelete;
    ButtonEdit: TMFBitBtnEdit;
    ButtonBlock: TMFBitBtnBlock;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberOfDoses(NameForm: TForm): TLabel;
    function GetLabelReasonConsumption(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetEditVolume(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;

    function GetReasonConsumption(NameForm: TForm): TComboBox;

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

constructor TMIOFFlowRateOfWholeBlood.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelReportDate(form);
  GetLabelVolume(form);
  GetLabelNumberOfDoses(form);
  GetLabelReasonConsumption(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);
  GetEditNumberOfDoses(form);

  GetReasonConsumption(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.create выполнена');
  inherited;
end;

destructor TMIOFFlowRateOfWholeBlood.destroy;
begin
  LabelCancellationDate.destroy;
  LabelVolume.destroy;
  LabelNumberOfDoses.destroy;
  LabelReasonConsumption.destroy;
  Title.destroy;

  StringGrid.destroy;

  CancellationDateCal.destroy;

  EditVolume.destroy;
  EditNumberOfDoses.destroy;

  ReasonConsumption.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.destroy выполнена');
  inherited;
end;

// Button

// Добавление новой записи

procedure TMIOFFlowRateOfWholeBlood.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  EditVolume.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolume.ReadText));
  EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberOfDoses.ReadText));
  if (EditVolume.ReadText = '0') or (EditNumberOfDoses.ReadText = '0') or
    (ReasonConsumption.GetItemIndex = -1) then
  begin
    Showmessage('Все поля должны быть заполнены!');
    exit;
  End;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(AddRecord) then
      AddRecord := TBIOFAddRecordFlowRateOfWholeBlood.create;
    AddRecord.AddRecord(CancellationDateCal.GetDate, EditVolume.ReadText,
      EditNumberOfDoses.ReadText,
      ReasonConsumption.GetItemsValue(ReasonConsumption.GetItemIndex));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    Showmessage('Запись успешно добавлена!');
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  ReasonConsumption.WriteItemIndex(-1);
  CancellationDateCal.WriteDateTime(StartOfTheWeek(Date) - 3);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.ButtonAdded выполнена');
end;

// Разблокировка кнопок

procedure TMIOFFlowRateOfWholeBlood.ButtonBlocked(Sender: TObject);
begin
  if ButtonBlock.GetTag=1 then
  begin
    ButtonEdit.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    ButtonBlock.ChangeTag(2);
    ButtonBlock.ChangeGlyph;
  end
  else
  begin
    ButtonEdit.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    ButtonBlock.ChangeTag(1);
    ButtonBlock.ChangeGlyph;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.ButtonBlocked выполнена');
end;

// Кнопка удаления

procedure TMIOFFlowRateOfWholeBlood.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBIOFDeleteRecordFlowRateOfWholeBlood.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0,
      StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    StringGrid.Visible(True);
    Showmessage('Запись успешно удалена!');
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  ReasonConsumption.WriteItemIndex(-1);
  CancellationDateCal.WriteDateTime(StartOfTheWeek(Date) - 3);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.ButtonDeleted выполнена');
end;

// Внесение изменений

procedure TMIOFFlowRateOfWholeBlood.ButtonEdited(Sender: TObject);
var
  i: integer;
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  if not Assigned(BlockMainMenu) then
    BlockMainMenu := TUSBlockMainMenu.create;
  if ButtonEdit.GetTag = 1 then
  begin
    BlockMainMenu.BlockMainMenu(False, CurrentForm);
    ButtonBlock.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    StringGrid.Enabled(False);

    CancellationDateCal.WriteDateTime
      (StrToDate(StringGrid.GetValue(1, StringGrid.CurrentRow)));
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(2,
      StringGrid.CurrentRow)));
    EditNumberOfDoses.WriteText(VarToStr(StringGrid.GetValue(3,
      StringGrid.CurrentRow)));
    for i := 0 to ReasonConsumption.GetItemsCount - 1 do
      if VarToStr(StringGrid.GetValue(4, StringGrid.CurrentRow))
        = ReasonConsumption.GetItemsValue(i) then
        ReasonConsumption.WriteItemIndex(i);
    if ReasonConsumption.GetItemIndex = -1 then
      Showmessage('Причина расхода у изменяемой записи задана не верно!' +
        chr(13) + 'Обратитесь к администратору!');
  end;
  if ButtonEdit.GetTag = 2 then
  begin
    EditVolume.WriteText(CheckFillStrFields.CheckStringFields
      (EditVolume.ReadText));
    EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields
      (EditNumberOfDoses.ReadText));
    if (EditVolume.ReadText = '0') or (EditNumberOfDoses.ReadText = '0') or
      (ReasonConsumption.GetItemIndex = -1) then
    begin
      Showmessage('Все поля должны быть заполнены!');
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
        ChangeRecord := TBIOFChangeRecordFlowRateOfWholeBlood.create;
      ChangeRecord.ChangeRecord(CancellationDateCal.GetDate,
        EditVolume.ReadText, EditNumberOfDoses.ReadText,
        ReasonConsumption.GetItemsValue(ReasonConsumption.GetItemIndex),
        StringGrid.GetValue(0, StringGrid.CurrentRow));
      GetStringGrid(CurrentForm);
      StringGrid.Visible(True);
      Showmessage('Запись успешно изменена!');
    end
    else
    begin
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      ReasonConsumption.WriteItemIndex(-1);
      CancellationDateCal.WriteDateTime(StartOfTheWeek(Date) - 3);
      ButtonEdit.ChangeTag(1);
      ButtonEdit.ChangeGlyph;
      exit;
    end;
    EditVolume.WriteText('0');
    EditNumberOfDoses.WriteText('0');
    ReasonConsumption.WriteItemIndex(-1);
    CancellationDateCal.WriteDateTime(StartOfTheWeek(Date) - 3);
  end;
  if ButtonEdit.GetTag = 1 then
  begin
    ButtonEdit.ChangeTag(2);
    ButtonEdit.ChangeGlyph;
  end
  else
  begin
    ButtonEdit.ChangeTag(1);
    ButtonEdit.ChangeGlyph;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.ButtonEdited выполнена');
end;

// Создание кнопок

function TMIOFFlowRateOfWholeBlood.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetButtonAdd выполнена');
end;

function TMIOFFlowRateOfWholeBlood.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetButtonBlock выполнена');
end;

function TMIOFFlowRateOfWholeBlood.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetButtonDelete выполнена');
end;

function TMIOFFlowRateOfWholeBlood.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetButtonEdit выполнена');
end;

// TDateTimePicker

function TMIOFFlowRateOfWholeBlood.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(CancellationDateCal) then
    CancellationDateCal := TMFDateTimePicker.create;
  Result := CancellationDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date) - 3,
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetCalendarReportDateCal выполнена');
end;

// Edit

function TMIOFFlowRateOfWholeBlood.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TMFEdit.create;
  Result := EditVolume.GetEdit(400, 120, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetEditVolume выполнена');
end;

function TMIOFFlowRateOfWholeBlood.GetEditNumberOfDoses(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses) then
    EditNumberOfDoses := TMFEdit.create;
  Result := EditNumberOfDoses.GetEdit(400, 160, 185, 12, False, NameForm);
  EditNumberOfDoses.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetEditNumberOfDoses выполнена');
end;

// Label

function TMIOFFlowRateOfWholeBlood.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, 'Расход цельной консервированнай крови',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetLabelTitle выполнена');
end;

function TMIOFFlowRateOfWholeBlood.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelCancellationDate) then
    LabelCancellationDate := TMFLabel.create;
  Result := LabelCancellationDate.GetTempLabel(50, 80, 16, 'Дата расхода: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetLabelReportDate выполнена');
end;

function TMIOFFlowRateOfWholeBlood.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TMFLabel.create;
  Result := LabelVolume.GetTempLabel(50, 120, 14, 'Объем продукции: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetLabelVolume выполнена');
end;

function TMIOFFlowRateOfWholeBlood.GetLabelNumberOfDoses
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDoses) then
    LabelNumberOfDoses := TMFLabel.create;
  Result := LabelNumberOfDoses.GetTempLabel(50, 160, 14, 'Количество доз: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetLabelNumberOfDoses выполнена');
end;

function TMIOFFlowRateOfWholeBlood.GetLabelReasonConsumption
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReasonConsumption) then
    LabelReasonConsumption := TMFLabel.create;
  Result := LabelReasonConsumption.GetTempLabel(50, 200, 14,
    'Причина списания: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetLabelReasonConsumption выполнена');
end;

// ComboBox

function TMIOFFlowRateOfWholeBlood.GetReasonConsumption(NameForm: TForm)
  : TComboBox;
begin
  if not Assigned(ReasonConsumption) then
    ReasonConsumption := TMFComboBox.create;
  Result := ReasonConsumption.GetComboBox('ReasonConsumption', 285, 200, 300,
    14, NameForm);
  Try
    SQL := 'SELECT TypeOfDefects.TypeDef ' + 'FROM TypeOfDefects ' +
      'WHERE (((TypeOfDefects.Other)=True)) ' +
      'ORDER BY TypeOfDefects.TypeDef;';
    ReasonConsumption.TheContentOfTheList(SQL);
  Except
    On e: EDatabaseError do
      MessageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetReasonConsumption выполнена');
end;

// StringGrid

function TMIOFFlowRateOfWholeBlood.GetStringGrid(NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  j := 0;
  i := 0;
  if not Assigned(StringGrid) then
    StringGrid := TMFStringGrid.create;
  Result := StringGrid.GetStringGrid(40, 330, 820, 190, 5, 2, 12, NameForm);
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 2, DT_RIGHT, 3, DT_CENTER, 4,
    DT_LEFT, 7, DT_RIGHT);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0, 50);
  StringGrid.ColWidth(1, 90);
  StringGrid.ColWidth(2, 90);
  StringGrid.ColWidth(3, 80);
  StringGrid.ColWidth(4, 170);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Объем, мл');
  StringGrid.WriteCells(3, 0, 'Дозы, шт');
  StringGrid.WriteCells(4, 0, 'Причина расхода');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TBIOFFlowRateOfWholeBlood.create;
  ContentForStringGrid.GetContent;
  if ContentForStringGrid.GetRowCount > 0 then
    for i := 0 to ContentForStringGrid.GetRowCount - 1 do
    begin
      if StringGrid.GetValue(0, 1) <> '' then
        StringGrid.AddRowCount;
      StringGrid.WriteCells(0, i + 1, ContentForStringGrid.GetKod(j));
      StringGrid.WriteCells(1, i + 1,
        ContentForStringGrid.GetCancellationDate(j));
      StringGrid.WriteCells(2, i + 1, ContentForStringGrid.GetVolume(j));
      StringGrid.WriteCells(3, i + 1, ContentForStringGrid.GetNumberOfDoses(j));
      StringGrid.WriteCells(4, i + 1,
        ContentForStringGrid.GetReasonConsumption(j));
      j := j + 1;
    end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.GetStringGrid выполнена');
end;

procedure TMIOFFlowRateOfWholeBlood.Show;
begin
  LabelCancellationDate.Visible(True);
  LabelVolume.Visible(True);
  LabelNumberOfDoses.Visible(True);
  LabelReasonConsumption.Visible(True);

  StringGrid.Visible(True);

  CancellationDateCal.Visible(True);

  EditVolume.Visible(True);
  EditNumberOfDoses.Visible(True);

  ReasonConsumption.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOFFlowRateOfWholeBlood.Show выполнена');
end;

end.
