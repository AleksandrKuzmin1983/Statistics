unit MIOATheAmountOfUsableErSusp;

interface

uses
  WinProcs, SysUtils, StdCtrls, Buttons, Vcl.Grids, Data.DB,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,
  USCheckFillStringFields,
  USBlockMainMenu,
  MFComboBox,
  MFLabel,
  MFTitleLabel,
  MFEdit,
  MFDateTimePicker,
  MFBitBtnAdd,
  MFBitBtnDelete,
  MFBitBtnEdit,
  MFBitBtnBlock,
  MFStringGrid,
  BIOAAddRecordResultsAmountOfUsableErSusp,
  BIOADeleteRecordResultsAmountOfUsableErSusp,
  BIOAChangeRecordResultsAmountOfUsableErSusp,
  BIOATheAmountOfUsableErSusp,
  USGlobalVariant;

type

  TMIOATheAmountOfUsableErSusp = class(TUSGlobalVariant)
  private
    LabelReportDate: TMFLabel;
    LabelProductList: TMFLabel;
    LabelVolume: TMFLabel;
    Title: TMFTitleLabel;
    SQL: String;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBIOATheAmountOfUsableErSusp;
    AddRecord: IBIOAAddRecordResultsAmountOfUsableErSusp;
    DeleteRecord: IBIOADeleteRecordResultsAmountOfUsableErSusp;
    ChangeRecord: IBIOAChangeRecordResultsAmountOfUsableErSusp;

    EditVolume: TMFEdit;
    ProductList: TMFComboBox;

    ReportDateCal: TMFDateTimePicker;
    CheckStrFields: IUSCheckFillStringFields;
    BlockMainMenu: IUSBlockMainMenu;

    ButtonAdd: TMFBitBtnAdd;
    ButtonDelete: TMFBitBtnDelete;
    ButtonEdit: TMFBitBtnEdit;
    ButtonBlock: TMFBitBtnBlock;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelProductList(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;
    function GetEditVolume(NameForm: TForm): TEdit;
    function GetProductList(NameForm: TForm): TComboBox;
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

constructor TMIOATheAmountOfUsableErSusp.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelReportDate(form);
  GetLabelProductList(form);
  GetLabelVolume(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);

  GetProductList(form);
  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  Show;
  inherited;
end;

destructor TMIOATheAmountOfUsableErSusp.destroy;
begin
  LabelReportDate.destroy;
  LabelProductList.destroy;
  LabelVolume.destroy;
  Title.destroy;

  StringGrid.destroy;

  EditVolume.destroy;
  ProductList.destroy;

  ReportDateCal.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;
  inherited;
end;

// Button

// Добавление новой записи

procedure TMIOATheAmountOfUsableErSusp.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckStrFields) then
    CheckStrFields := TUSCheckFillStringFields.create;
  EditVolume.WriteText(CheckStrFields.CheckStringFields(EditVolume.ReadText));
  if (EditVolume.ReadText = '0') then
  begin
    Showmessage
      ('Поле "Произведено годной продукции, мл" должно быть заполнено!');
    exit;
  End;
  if ProductList.GetItemIndex = -1 then
  begin
    Showmessage('Вид продукции не задан!');
    exit;
  end;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(ChangeRecord) then
      AddRecord := TBIOAAddRecordResultsAmountOfUsableErSusp.create;
    AddRecord.AddRecord(ReportDateCal.GetDate,
      ProductList.GetItemsValue(ProductList.GetItemIndex), EditVolume.ReadText);
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    Showmessage('Запись успешно добавлена!');
  end;
  EditVolume.WriteText('0');
  ProductList.WriteItemIndex(-1);
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
end;

// Разблокировка кнопок

procedure TMIOATheAmountOfUsableErSusp.ButtonBlocked(Sender: TObject);
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

procedure TMIOATheAmountOfUsableErSusp.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBIOADeleteRecordResultsAmountOfUsableErSusp.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0,
      StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    Showmessage('Запись успешно удалена!');
  end;
  EditVolume.WriteText('0');
  ProductList.WriteItemIndex(-1);
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
end;

// Внесение изменений

procedure TMIOATheAmountOfUsableErSusp.ButtonEdited(Sender: TObject);
var
  i: integer;
begin
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
    for i := 0 to ProductList.GetItemsCount - 1 do
      if VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow))
        = ProductList.GetItemsValue(i) then
        ProductList.WriteItemIndex(i);
    if ProductList.GetItemIndex = -1 then
      Showmessage('Название продукции для данной записи задано не верно!');
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(3,
      StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetCaption = 'Сохранить изменения' then
  begin
    if not Assigned(CheckStrFields) then
      CheckStrFields := TUSCheckFillStringFields.create;
    EditVolume.WriteText(CheckStrFields.CheckStringFields(EditVolume.ReadText));
    if (EditVolume.ReadText = '0') then
    begin
      Showmessage
        ('Поле "Произведено годной продукции, мл" должно быть заполнено!' +
        char(13) +
        'Если значение необходимо удалить, то отмените изменения и воспользуйтесь кнопкой "Удалить запись"!');
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
        ChangeRecord := TBIOAChangeRecordResultsAmountOfUsableErSusp.create;
      ChangeRecord.ChangeRecord(ReportDateCal.GetDate,
        ProductList.GetItemsValue(ProductList.GetItemIndex),
        EditVolume.ReadText, StringGrid.GetValue(0, StringGrid.CurrentRow));
      GetStringGrid(CurrentForm);
      StringGrid.Visible(True);
      Showmessage('Запись успешно изменена!');
    end
    else
    begin
      EditVolume.WriteText('0');
      ProductList.WriteItemIndex(-1);
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end;
    EditVolume.WriteText('0');
    ProductList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date) - 7);
  end;
  if ButtonEdit.GetCaption = 'Изменить' then
    ButtonEdit.ChangeCaption('Сохранить изменения')
  else
    ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок

function TMIOATheAmountOfUsableErSusp.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TMIOATheAmountOfUsableErSusp.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TMIOATheAmountOfUsableErSusp.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TMIOATheAmountOfUsableErSusp.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

// TDateTimePicker

function TMIOATheAmountOfUsableErSusp.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal := TMFDateTimePicker.create;
  Result := ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date) - 7,
    NameForm);
end;

// Edit

function TMIOATheAmountOfUsableErSusp.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TMFEdit.create;
  Result := EditVolume.GetEdit(400, 180, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);
end;

// Label

function TMIOATheAmountOfUsableErSusp.GetLabelReportDate
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TMFLabel.create;
  Result := LabelReportDate.GetTempLabel(50, 80, 16, 'Отчетная неделя: ',
    NameForm);
end;

function TMIOATheAmountOfUsableErSusp.GetLabelProductList
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProductList) then
    LabelProductList := TMFLabel.create;
  Result := LabelProductList.GetTempLabel(50, 130, 16, 'Название продукци: ',
    NameForm);
end;

function TMIOATheAmountOfUsableErSusp.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TMFLabel.create;
  Result := LabelVolume.GetTempLabel(50, 180, 16,
    'Произведено годной продукции, мл: ', NameForm);
end;

function TMIOATheAmountOfUsableErSusp.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(18,
    'Объем годных эритроцитарных сред заготовленных за отчетную неделю',
    NameForm);
end;

// ComboBox

function TMIOATheAmountOfUsableErSusp.GetProductList(NameForm: TForm)
  : TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TMFComboBox.create;
  Result := ProductList.GetComboBox('ProductList', 270, 130, 315, 14, NameForm);
  SQL := 'SELECT NameProducts.ShortName, NameProducts.id FROM NameProducts ' +
    'WHERE (((NameProducts.TypeProduct)="Эр взвесь") And NameProducts.Production=True);';
  ProductList.TheContentOfTheList(SQL);
end;

function TMIOATheAmountOfUsableErSusp.GetStringGrid(NameForm: TForm)
  : TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TMFStringGrid.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 1, DT_LEFT, 2, DT_LEFT, 3,
    DT_RIGHT, 4, DT_CENTER);
  Result := StringGrid.GetStringGrid(50, 280, 800, 240, 4, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0, 60);
  StringGrid.ColWidth(1, 100);
  StringGrid.ColWidth(2, 300);
  StringGrid.ColWidth(3, 100);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Наименование продукции, шт');
  StringGrid.WriteCells(3, 0, 'Объем, мл');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TBIOATheAmountOfUsableErSusp.create;
  ContentForStringGrid.GetContent;
  if ContentForStringGrid.GetRowCount > 0 then
    for i := 0 to ContentForStringGrid.GetRowCount - 1 do
    begin
      if StringGrid.GetValue(0, 1) <> '' then
        StringGrid.AddRowCount;
      StringGrid.WriteCells(0, i + 1, ContentForStringGrid.GetKod(j));
      StringGrid.WriteCells(1, i + 1, ContentForStringGrid.GetDate(j));
      StringGrid.WriteCells(2, i + 1, ContentForStringGrid.GetName(j));
      StringGrid.WriteCells(3, i + 1, ContentForStringGrid.GetVolume(j));
      j := j + 1;
    end;
end;

procedure TMIOATheAmountOfUsableErSusp.Show;
begin
  LabelReportDate.Visible(True);
  LabelProductList.Visible(True);
  LabelVolume.Visible(True);

  StringGrid.Visible(True);

  ReportDateCal.Visible(True);

  EditVolume.Visible(True);

  ProductList.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);
end;

end.
