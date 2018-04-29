unit MIETTheResultsInLPU;

interface

uses
  WinProcs, SysUtils, StdCtrls, Buttons, CodeSiteLogging, Vcl.Grids, Data.DB,
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
  MFComboBox,
  BIEAddRecordResultsInLPU,
  BIEDeleteRecordResultsInLPU,
  BIEChangeRecordResultsInLPU,
  BIETTheResultsInLPU,
  USGlobalVariant;

type

  TMIETTheResultsInLPU = class(TUSGlobalVariant)
  private
    LabelReportDate: TMFLabel;
    LabelTheNameOfTheEnvironment: TMFLabel;
    LabelTypeOfLPU: TMFLabel;
    LabelVolume: TMFLabel;
    LabelNumberOfDoses: TMFLabel;
    LabelPercentage: TMFLabel;
    LabelNumberOfPackets: TMFLabel;
    Title: TMFTitleLabel;
    SQL: String;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBIETTheResultsInLPU;
    AddRecord: IBIEAddRecordResultsInLPU;
    DeleteRecord: IBIEDeleteRecordResultsInLPU;
    ChangeRecord: IBIEChangeRecordResultsInLPU;

    EditVolume: TMFEdit;
    EditNumberOfDoses: TMFEdit;
    EditPercentage: TMFEdit;
    EditNumberOfPackets: TMFEdit;

    ProductList: TMFComboBox;
    TypeLPUList: TMFComboBox;

    ReportDateCal: TMFDateTimePicker;
    CheckFillStrFields: IUSCheckFillStringFields;
    BlockMainMenu: IUSBlockMainMenu;

    ButtonAdd: TMFBitBtnAdd;
    ButtonDelete: TMFBitBtnDelete;
    ButtonEdit: TMFBitBtnEdit;
    ButtonBlock: TMFBitBtnBlock;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelTheNameOfTheEnvironment(NameForm: TForm): TLabel;
    function GetLabelTypeOfLPU(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberOfDoses(NameForm: TForm): TLabel;
    function GetLabelPercentage(NameForm: TForm): TLabel;
    function GetLabelNumberOfPackets(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetEditVolume(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;
    function GetEditPercentage(NameForm: TForm): TEdit;
    function GetEditNumberOfPackets(NameForm: TForm): TEdit;

    function GetProductList(NameForm: TForm): TComboBox;
    function GetTypeLPUList(NameForm: TForm): TComboBox;

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

constructor TMIETTheResultsInLPU.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelReportDate(form);
  GetLabelTheNameOfTheEnvironment(form);
  GetLabelTypeOfLPU(form);
  GetLabelVolume(form);
  GetLabelNumberOfDoses(form);
  GetLabelPercentage(form);
  GetLabelNumberOfPackets(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);
  GetEditNumberOfDoses(form);
  GetEditPercentage(form);
  GetEditNumberOfPackets(form);

  GetProductList(form);
  GetTypeLPUList(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.create выполнена');
  inherited;
end;

destructor TMIETTheResultsInLPU.destroy;
begin
  LabelReportDate.destroy;
  LabelTheNameOfTheEnvironment.destroy;
  LabelTypeOfLPU.destroy;
  LabelVolume.destroy;
  LabelNumberOfDoses.destroy;
  LabelPercentage.destroy;
  LabelNumberOfPackets.destroy;
  Title.destroy;

  StringGrid.destroy;

  EditVolume.destroy;
  EditNumberOfDoses.destroy;
  EditPercentage.destroy;
  EditNumberOfPackets.destroy;

  ProductList.destroy;
  TypeLPUList.destroy;

  ReportDateCal.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.destroy выполнена');
  inherited;
end;

// Button

// Добавление новой записи

procedure TMIETTheResultsInLPU.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  EditVolume.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolume.ReadText));
  EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberOfDoses.ReadText));
  EditPercentage.WriteText(CheckFillStrFields.CheckStringFields
    (EditPercentage.ReadText));
  EditNumberOfPackets.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberOfPackets.ReadText));
  if (EditVolume.ReadText = '0') or (EditNumberOfDoses.ReadText = '0') or
    (EditPercentage.ReadText = '0') or (ProductList.GetItemIndex = -1) or
    (TypeLPUList.GetItemIndex = -1) then
  begin
    Showmessage('Все поля должны быть заполнены!');
    exit;
  End;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(AddRecord) then
      AddRecord := TBIEAddRecordResultsInLPU.create;
    AddRecord.AddRecord(ReportDateCal.GetDate,
      ProductList.GetItemsValue(ProductList.GetItemIndex),
      TypeLPUList.GetItemsValue(TypeLPUList.GetItemIndex), EditVolume.ReadText,
      EditNumberOfDoses.ReadText, EditPercentage.ReadText,
      EditNumberOfPackets.ReadText);
    Showmessage('Запись успешно добавлена!');
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  EditPercentage.WriteText('0');
  EditNumberOfPackets.WriteText('0');
  ProductList.WriteItemIndex(-1);
  TypeLPUList.WriteItemIndex(-1);
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.ButtonAdded выполнена');
end;

// Разблокировка кнопок

procedure TMIETTheResultsInLPU.ButtonBlocked(Sender: TObject);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.ButtonBlocked выполнена');
end;

// Кнопка удаления

procedure TMIETTheResultsInLPU.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBIEDeleteRecordResultsInLPU.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0,
      StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    Showmessage('Запись успешно удалена!');
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  EditPercentage.WriteText('0');
  EditNumberOfPackets.WriteText('0');
  ProductList.WriteItemIndex(-1);
  TypeLPUList.WriteItemIndex(-1);
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.ButtonDeleted выполнена');
end;

// Внесение изменений

procedure TMIETTheResultsInLPU.ButtonEdited(Sender: TObject);
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

    ReportDateCal.WriteDateTime(StrToDate(StringGrid.GetValue(1,
      StringGrid.CurrentRow)));
    for i := 0 to ProductList.GetItemsCount - 1 do
      if VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow))
        = ProductList.GetItemsValue(i) then
        ProductList.WriteItemIndex(i);
    if ProductList.GetItemIndex = -1 then
      Showmessage
        ('Название изменяемой продукции для данной записи задано не верно!' +
        chr(13) + 'Обратитесь к администратору!');
    for i := 0 to TypeLPUList.GetItemsCount - 1 do
      if VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow))
        = TypeLPUList.GetItemsValue(i) then
        TypeLPUList.WriteItemIndex(i);
    if TypeLPUList.GetItemIndex = -1 then
      Showmessage('Вид ЛПУ для данной записи задан не верно!' + chr(13) +
        'Обратитесь к администратору!');
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(4,
      StringGrid.CurrentRow)));
    EditNumberOfDoses.WriteText(VarToStr(StringGrid.GetValue(5,
      StringGrid.CurrentRow)));
    EditPercentage.WriteText(VarToStr(StringGrid.GetValue(6,
      StringGrid.CurrentRow)));
    EditNumberOfPackets.WriteText
      (VarToStr(StringGrid.GetValue(7, StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetTag = 2 then
  begin
    EditVolume.WriteText(CheckFillStrFields.CheckStringFields
      (EditVolume.ReadText));
    EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields
      (EditNumberOfDoses.ReadText));
    EditPercentage.WriteText(CheckFillStrFields.CheckStringFields
      (EditPercentage.ReadText));
    EditNumberOfPackets.WriteText(CheckFillStrFields.CheckStringFields
      (EditNumberOfPackets.ReadText));
    if (EditVolume.ReadText = '0') or (EditNumberOfDoses.ReadText = '0') or
      (EditPercentage.ReadText = '0') or (ProductList.GetItemIndex = -1) or
      (TypeLPUList.GetItemIndex = -1) then
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
        ChangeRecord := TBIEChangeRecordResultsInLPU.create;
      ChangeRecord.ChangeRecord(ReportDateCal.GetDate,
        ProductList.GetItemsValue(ProductList.GetItemIndex),
        TypeLPUList.GetItemsValue(TypeLPUList.GetItemIndex),
        EditVolume.ReadText, EditNumberOfDoses.ReadText,
        EditPercentage.ReadText, EditNumberOfPackets.ReadText,
        StringGrid.GetValue(0, StringGrid.CurrentRow));
      GetStringGrid(CurrentForm);
      StringGrid.Visible(True);
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      EditPercentage.WriteText('0');
      EditNumberOfPackets.WriteText('0');
      ProductList.WriteItemIndex(-1);
      TypeLPUList.WriteItemIndex(-1);
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
      ButtonEdit.ChangeTag(1);
      ButtonEdit.ChangeGlyph;
      Showmessage('Запись успешно изменена!');
      exit;
    end
    else
    begin
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      EditPercentage.WriteText('0');
      EditNumberOfPackets.WriteText('0');
      ProductList.WriteItemIndex(-1);
      TypeLPUList.WriteItemIndex(-1);
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
      ButtonEdit.ChangeTag(1);
      ButtonEdit.ChangeGlyph;
      exit;
    end;
    EditVolume.WriteText('0');
    EditNumberOfDoses.WriteText('0');
    EditPercentage.WriteText('0');
    EditNumberOfPackets.WriteText('0');
    ProductList.WriteItemIndex(-1);
    TypeLPUList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
  end;
  if ButtonEdit.GetTag = 1 then
  begin
    ButtonEdit.ChangeTag(2);
    ButtonEdit.ChangeGlyph;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.ButtonEdited выполнена');
end;

// Создание кнопок

function TMIETTheResultsInLPU.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetButtonAdd выполнена');
end;

function TMIETTheResultsInLPU.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetButtonBlock выполнена');
end;

function TMIETTheResultsInLPU.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetButtonDelete выполнена');
end;

function TMIETTheResultsInLPU.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetButtonEdit выполнена');
end;

// TDateTimePicker

function TMIETTheResultsInLPU.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal := TMFDateTimePicker.create;
  Result := ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date) - 7,
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetCalendarReportDateCal выполнена');
end;

// Edit

function TMIETTheResultsInLPU.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TMFEdit.create;
  Result := EditVolume.GetEdit(400, 185, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetEditVolume выполнена');
end;

function TMIETTheResultsInLPU.GetEditNumberOfDoses(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses) then
    EditNumberOfDoses := TMFEdit.create;
  Result := EditNumberOfDoses.GetEdit(400, 220, 185, 12, False, NameForm);
  EditNumberOfDoses.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetEditNumberOfDoses выполнена');
end;

function TMIETTheResultsInLPU.GetEditPercentage(NameForm: TForm): TEdit;
begin
  if not Assigned(EditPercentage) then
    EditPercentage := TMFEdit.create;
  Result := EditPercentage.GetEdit(400, 255, 185, 12, False, NameForm);
  EditPercentage.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetEditPercentage выполнена');
end;

function TMIETTheResultsInLPU.GetEditNumberOfPackets(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfPackets) then
    EditNumberOfPackets := TMFEdit.create;
  Result := EditNumberOfPackets.GetEdit(400, 290, 185, 12, False, NameForm);
  EditNumberOfPackets.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetEditNumberOfPackets выполнена');
end;

// Label

function TMIETTheResultsInLPU.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, 'Выдача трансфузионных сред в ЛПУ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetLabelTitle выполнена');
end;

function TMIETTheResultsInLPU.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TMFLabel.create;
  Result := LabelReportDate.GetTempLabel(50, 80, 16, 'Отчетная неделя: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetLabelReportDate выполнена');
end;

function TMIETTheResultsInLPU.GetLabelTheNameOfTheEnvironment
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTheNameOfTheEnvironment) then
    LabelTheNameOfTheEnvironment := TMFLabel.create;
  Result := LabelTheNameOfTheEnvironment.GetTempLabel(50, 115, 14,
    'Наименование продукции: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetLabelTheNameOfTheEnvironment выполнена');
end;

function TMIETTheResultsInLPU.GetLabelTypeOfLPU(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTypeOfLPU) then
    LabelTypeOfLPU := TMFLabel.create;
  Result := LabelTypeOfLPU.GetTempLabel(50, 150, 14, 'Вид ЛПУ: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetLabelTypeOfLPU выполнена');
end;

function TMIETTheResultsInLPU.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TMFLabel.create;
  Result := LabelVolume.GetTempLabel(50, 185, 14, 'Объем продукции: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetLabelVolume выполнена');
end;

function TMIETTheResultsInLPU.GetLabelNumberOfDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDoses) then
    LabelNumberOfDoses := TMFLabel.create;
  Result := LabelNumberOfDoses.GetTempLabel(50, 220, 14, 'Количество доз: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetLabelNumberOfDoses выполнена');
end;

function TMIETTheResultsInLPU.GetLabelPercentage(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelPercentage) then
    LabelPercentage := TMFLabel.create;
  Result := LabelPercentage.GetTempLabel(50, 255, 14,
    'Процент от объема по заявкам: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetLabelPercentage выполнена');
end;

function TMIETTheResultsInLPU.GetLabelNumberOfPackets(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfPackets) then
    LabelNumberOfPackets := TMFLabel.create;
  Result := LabelNumberOfPackets.GetTempLabel(50, 290, 14,
    'Количество пакетов тромбоконцентрата: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetLabelNumberOfPackets выполнена');
end;

// ComboBox

function TMIETTheResultsInLPU.GetProductList(NameForm: TForm): TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TMFComboBox.create;
  Result := ProductList.GetComboBox('ProductList', 285, 115, 300, 14, NameForm);
  SQL := 'SELECT NameProducts.ShortName, NameProducts.id ' +
    'FROM NameProducts ' + 'WHERE (NameProducts.ForExped=True);';
  ProductList.TheContentOfTheList(SQL);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetProductList выполнена');
end;

function TMIETTheResultsInLPU.GetTypeLPUList(NameForm: TForm): TComboBox;
begin
  if not Assigned(TypeLPUList) then
    TypeLPUList := TMFComboBox.create;
  Result := TypeLPUList.GetComboBox('TypeLPUList', 400, 150, 185, 14, NameForm);
  SQL := 'SELECT TypeOfLPUandOther.NameRecord ' + 'FROM TypeOfLPUandOther ' +
    'WHERE (((TypeOfLPUandOther.TypeLPU)=True));';
  TypeLPUList.TheContentOfTheList(SQL);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetTypeLPUList выполнена');
end;

procedure TMIETTheResultsInLPU.Show;
begin
  LabelReportDate.Visible(True);
  LabelTheNameOfTheEnvironment.Visible(True);
  LabelTypeOfLPU.Visible(True);
  LabelVolume.Visible(True);
  LabelNumberOfDoses.Visible(True);
  LabelPercentage.Visible(True);
  LabelNumberOfPackets.Visible(True);

  StringGrid.Visible(True);

  ReportDateCal.Visible(True);

  EditVolume.Visible(True);
  EditNumberOfDoses.Visible(True);
  EditPercentage.Visible(True);
  EditNumberOfPackets.Visible(True);

  ProductList.Visible(True);
  TypeLPUList.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.Show выполнена');
end;

// StringGrid

function TMIETTheResultsInLPU.GetStringGrid(NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TMFStringGrid.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 4, DT_RIGHT, 5, DT_RIGHT, 6,
    DT_RIGHT, 7, DT_RIGHT);
  Result := StringGrid.GetStringGrid(40, 330, 820, 190, 8, 2, 11, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0, 40);
  StringGrid.ColWidth(1, 75);
  StringGrid.ColWidth(2, 230);
  StringGrid.ColWidth(3, 110);
  StringGrid.ColWidth(4, 80);
  StringGrid.ColWidth(5, 70);
  StringGrid.ColWidth(6, 100);
  StringGrid.ColWidth(7, 85);
  StringGrid.Visible(True);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Наименование продукции');
  StringGrid.WriteCells(3, 0, 'Вид ЛПУ');
  StringGrid.WriteCells(4, 0, 'Объем, мл');
  StringGrid.WriteCells(5, 0, 'Дозы, шт');
  StringGrid.WriteCells(6, 0, '% выполнения');
  StringGrid.WriteCells(7, 0, 'Пакеты, шт');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TBIETTheResultsInLPU.create;
  ContentForStringGrid.GetContent;
  if ContentForStringGrid.GetRowCount > 0 then
    for i := 0 to ContentForStringGrid.GetRowCount - 1 do
    begin
      if StringGrid.GetValue(0, 1) <> '' then
        StringGrid.AddRowCount;
      StringGrid.WriteCells(0, i + 1, ContentForStringGrid.GetKod(j));
      StringGrid.WriteCells(1, i + 1, ContentForStringGrid.GetReportDate(j));
      StringGrid.WriteCells(2, i + 1, ContentForStringGrid.GetTypeOfLPU(j));
      StringGrid.WriteCells(3, i + 1,
        ContentForStringGrid.GetTheNameOfTheEnvironment(j));
      StringGrid.WriteCells(4, i + 1, ContentForStringGrid.GetVolume(j));
      StringGrid.WriteCells(5, i + 1, ContentForStringGrid.GetNumberOfDoses(j));
      StringGrid.WriteCells(6, i + 1, ContentForStringGrid.GetPercentage(j));
      StringGrid.WriteCells(7, i + 1,
        ContentForStringGrid.GetNumberOfPackets(j));
      j := j + 1;
    end;

    CodeSite.Send(FormatDateTime('c', Now) + ' TMIETTheResultsInLPU.GetStringGrid выполнена');
end;

end.
