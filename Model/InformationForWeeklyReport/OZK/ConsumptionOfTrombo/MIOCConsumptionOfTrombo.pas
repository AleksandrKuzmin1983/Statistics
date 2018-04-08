unit MIOCConsumptionOfTrombo;

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
  BIOCAddRecordConsumptionOfTrombo,
  BIOCDeleteRecordConsumptionOfTrombo,
  BIOCChangeRecordConsumptionOfTrombo,
  BIOCConsumptionOfTrombo,
  USGlobalVariant;

type

  TMIOCConsumptionOfTrombo = class(TUSGlobalVariant)
  private
    LabelCancellationDate: TMFLabel;
    LabelTheNameOfTrombo: TMFLabel;
    LabelVolume: TMFLabel;
    LabelNumberOfDoses: TMFLabel;
    LabelNumberOfPackets: TMFLabel;
    LabelReasonConsumption: TMFLabel;
    Title: TMFTitleLabel;
    SQL: String;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBIOCConsumptionOfTrombo;
    AddRecord: IBIOCAddRecordConsumptionOfTrombo;
    DeleteRecord: IBIOCDeleteRecordConsumptionOfTrombo;
    ChangeRecord: IBIOCChangeRecordConsumptionOfTrombo;

    EditVolume: TMFEdit;
    EditNumberOfDoses: TMFEdit;
    EditNumberOfPackets: TMFEdit;

    ProductList: TMFComboBox;
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
    function GetLabelTheNameOfTrombo(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberOfDoses(NameForm: TForm): TLabel;
    function GetLabelNumberOfPackets(NameForm: TForm): TLabel;
    function GetLabelReasonConsumption(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetEditVolume(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;
    function GetEditNumberOfPackets(NameForm: TForm): TEdit;

    function GetProductList(NameForm: TForm): TComboBox;
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

constructor TMIOCConsumptionOfTrombo.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelReportDate(form);
  GetLabelTheNameOfTrombo(form);
  GetLabelVolume(form);
  GetLabelNumberOfDoses(form);
  GetLabelNumberOfPackets(form);
  GetLabelReasonConsumption(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);
  GetEditNumberOfDoses(form);
  GetEditNumberOfPackets(form);

  GetProductList(form);
  GetReasonConsumption(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.create выполнена');
  inherited;
end;

destructor TMIOCConsumptionOfTrombo.destroy;
begin
  LabelCancellationDate.destroy;
  LabelTheNameOfTrombo.destroy;
  LabelVolume.destroy;
  LabelNumberOfDoses.destroy;
  LabelNumberOfPackets.destroy;
  LabelReasonConsumption.destroy;
  Title.destroy;

  StringGrid.destroy;

  EditVolume.destroy;
  EditNumberOfDoses.destroy;
  EditNumberOfPackets.destroy;

  ProductList.destroy;
  ReasonConsumption.destroy;

  CancellationDateCal.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.destroy выполнена');
  inherited;
end;

// Button

// Добавление новой записи

procedure TMIOCConsumptionOfTrombo.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  EditVolume.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolume.ReadText));
  EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberOfDoses.ReadText));
  if (EditVolume.ReadText = '0') or (EditNumberOfDoses.ReadText = '0') or
    (EditNumberOfPackets.ReadText = '0') or (ProductList.GetItemIndex = -1) or
    (ReasonConsumption.GetItemIndex = -1) then
  begin
    Showmessage('Все поля должны быть заполнены!');
    exit;
  End;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(AddRecord) then
      AddRecord := TBIOCAddRecordConsumptionOfTrombo.create;
    AddRecord.AddRecord(CancellationDateCal.GetDate,
      ProductList.GetItemsValue(ProductList.GetItemIndex), EditVolume.ReadText,
      EditNumberOfDoses.ReadText, EditNumberOfPackets.ReadText,
      ReasonConsumption.GetItemsValue(ReasonConsumption.GetItemIndex));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    Showmessage('Запись успешно добавлена!');
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  EditNumberOfPackets.WriteText('0');
  ReasonConsumption.WriteItemIndex(-1);
  ProductList.WriteItemIndex(-1);
  CancellationDateCal.WriteDateTime(StartOfTheWeek(Date) - 3);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.ButtonAdded выполнена');
end;

// Разблокировка кнопок

procedure TMIOCConsumptionOfTrombo.ButtonBlocked(Sender: TObject);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.ButtonBlocked выполнена');
end;

// Кнопка удаления

procedure TMIOCConsumptionOfTrombo.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBIOCDeleteRecordConsumptionOfTrombo.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0,
      StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    StringGrid.Visible(True);
    Showmessage('Запись успешно удалена!');
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  EditNumberOfPackets.WriteText('0');
  ProductList.WriteItemIndex(-1);
  ReasonConsumption.WriteItemIndex(-1);
  CancellationDateCal.WriteDateTime(StartOfTheWeek(Date) - 3);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.ButtonDeleted выполнена');
end;

// Внесение изменений

procedure TMIOCConsumptionOfTrombo.ButtonEdited(Sender: TObject);
var
  i: integer;
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

    CancellationDateCal.WriteDateTime
      (StrToDate(StringGrid.GetValue(1, StringGrid.CurrentRow)));
    for i := 0 to ProductList.GetItemsCount - 1 do
      if VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow))
        = ProductList.GetItemsValue(i) then
        ProductList.WriteItemIndex(i);
    if ProductList.GetItemIndex = -1 then
      Showmessage
        ('Название изменяемой продукции для данной записи задано не верно!' +
        chr(13) + 'Обратитесь к администратору!');
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(3,
      StringGrid.CurrentRow)));
    EditNumberOfDoses.WriteText(VarToStr(StringGrid.GetValue(4,
      StringGrid.CurrentRow)));
    EditNumberOfPackets.WriteText
      (VarToStr(StringGrid.GetValue(5, StringGrid.CurrentRow)));
    for i := 0 to ReasonConsumption.GetItemsCount - 1 do
      if VarToStr(StringGrid.GetValue(6, StringGrid.CurrentRow))
        = ReasonConsumption.GetItemsValue(i) then
        ReasonConsumption.WriteItemIndex(i);
    if ReasonConsumption.GetItemIndex = -1 then
      Showmessage('Причина списания у изменяемой записи задана не верно!' +
        chr(13) + 'Обратитесь к администратору!');

  end;
  if ButtonEdit.GetCaption = 'Сохранить изменения' then
  begin
    EditVolume.WriteText(CheckFillStrFields.CheckStringFields
      (EditVolume.ReadText));
    EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields
      (EditNumberOfDoses.ReadText));
    EditNumberOfPackets.WriteText(CheckFillStrFields.CheckStringFields
      (EditNumberOfPackets.ReadText));
    if (EditVolume.ReadText = '0') or (EditNumberOfDoses.ReadText = '0') or
      (EditNumberOfPackets.ReadText = '0') or (ProductList.GetItemIndex = -1) or
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
        ChangeRecord := TBIOCChangeRecordConsumptionOfTrombo.create;
      ChangeRecord.ChangeRecord(CancellationDateCal.GetDate,
        ProductList.GetItemsValue(ProductList.GetItemIndex),
        EditVolume.ReadText, EditNumberOfDoses.ReadText,
        EditNumberOfPackets.ReadText,
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
      EditNumberOfPackets.WriteText('0');
      ProductList.WriteItemIndex(-1);
      ReasonConsumption.WriteItemIndex(-1);
      CancellationDateCal.WriteDateTime(StartOfTheWeek(Date) - 3);
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end;
    EditVolume.WriteText('0');
    EditNumberOfDoses.WriteText('0');
    EditNumberOfPackets.WriteText('0');
    ProductList.WriteItemIndex(-1);
    ReasonConsumption.WriteItemIndex(-1);
    CancellationDateCal.WriteDateTime(StartOfTheWeek(Date) - 3);
  end;
  if ButtonEdit.GetCaption = 'Изменить' then
    ButtonEdit.ChangeCaption('Сохранить изменения')
  else
    ButtonEdit.ChangeCaption('Изменить');

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.ButtonEdited выполнена');
end;

// Создание кнопок

function TMIOCConsumptionOfTrombo.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetButtonAdd выполнена');
end;

function TMIOCConsumptionOfTrombo.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetButtonBlock выполнена');
end;

function TMIOCConsumptionOfTrombo.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetButtonDelete выполнена');
end;

function TMIOCConsumptionOfTrombo.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetButtonEdit выполнена');
end;

// TDateTimePicker

function TMIOCConsumptionOfTrombo.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(CancellationDateCal) then
    CancellationDateCal := TMFDateTimePicker.create;
  Result := CancellationDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date) - 3,
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetCalendarReportDateCal выполнена');
end;

// Edit

function TMIOCConsumptionOfTrombo.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TMFEdit.create;
  Result := EditVolume.GetEdit(400, 160, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetEditVolume выполнена');
end;

function TMIOCConsumptionOfTrombo.GetEditNumberOfDoses(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses) then
    EditNumberOfDoses := TMFEdit.create;
  Result := EditNumberOfDoses.GetEdit(400, 200, 185, 12, False, NameForm);
  EditNumberOfDoses.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetEditNumberOfDoses выполнена');
end;

function TMIOCConsumptionOfTrombo.GetEditNumberOfPackets
  (NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfPackets) then
    EditNumberOfPackets := TMFEdit.create;
  Result := EditNumberOfPackets.GetEdit(400, 240, 185, 12, False, NameForm);
  EditNumberOfPackets.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetEditNumberOfPackets выполнена');
end;

// Label

function TMIOCConsumptionOfTrombo.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, 'Расход тромбоконцентрата', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetLabelTitle выполнена');
end;

function TMIOCConsumptionOfTrombo.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelCancellationDate) then
    LabelCancellationDate := TMFLabel.create;
  Result := LabelCancellationDate.GetTempLabel(50, 80, 16, 'Дата расхода: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetLabelReportDate выполнена');
end;

function TMIOCConsumptionOfTrombo.GetLabelTheNameOfTrombo
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTheNameOfTrombo) then
    LabelTheNameOfTrombo := TMFLabel.create;
  Result := LabelTheNameOfTrombo.GetTempLabel(50, 120, 14,
    'Наименование продукции: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetLabelTheNameOfTrombo выполнена');
end;

function TMIOCConsumptionOfTrombo.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TMFLabel.create;
  Result := LabelVolume.GetTempLabel(50, 160, 14, 'Объем продукции: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetLabelVolume выполнена');
end;

function TMIOCConsumptionOfTrombo.GetLabelNumberOfDoses
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDoses) then
    LabelNumberOfDoses := TMFLabel.create;
  Result := LabelNumberOfDoses.GetTempLabel(50, 200, 14, 'Количество доз: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetLabelNumberOfDoses выполнена');
end;

function TMIOCConsumptionOfTrombo.GetLabelNumberOfPackets
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfPackets) then
    LabelNumberOfPackets := TMFLabel.create;
  Result := LabelNumberOfPackets.GetTempLabel(50, 240, 14,
    'Количество Пакетов: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetLabelNumberOfPackets выполнена');
end;

function TMIOCConsumptionOfTrombo.GetLabelReasonConsumption
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReasonConsumption) then
    LabelReasonConsumption := TMFLabel.create;
  Result := LabelReasonConsumption.GetTempLabel(50, 280, 14,
    'Причина списания: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetLabelReasonConsumption выполнена');
end;

// ComboBox

function TMIOCConsumptionOfTrombo.GetProductList(NameForm: TForm): TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TMFComboBox.create;
  Result := ProductList.GetComboBox('ProductList', 285, 120, 300, 14, NameForm);
  SQL := 'SELECT NameProducts.ShortName, NameProducts.id ' +
    'FROM NameProducts ' +
    'WHERE (((NameProducts.TypeProduct)="Тромбоциты") AND ((NameProducts.Visible)=True));';
  ProductList.TheContentOfTheList(SQL);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetProductList выполнена');
end;

function TMIOCConsumptionOfTrombo.GetReasonConsumption(NameForm: TForm)
  : TComboBox;
begin
  if not Assigned(ReasonConsumption) then
    ReasonConsumption := TMFComboBox.create;
  Result := ReasonConsumption.GetComboBox('ReasonConsumption', 285, 280, 300,
    14, NameForm);
  SQL := 'SELECT TypeOfDefects.TypeDef ' + 'FROM TypeOfDefects ' +
    'WHERE (((TypeOfDefects.Tromb)=True)) ' + 'ORDER BY TypeOfDefects.TypeDef;';
  ReasonConsumption.TheContentOfTheList(SQL);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetReasonConsumption выполнена');
end;

// StringGrid

function TMIOCConsumptionOfTrombo.GetStringGrid(NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i:=0; j:=0;
  if not Assigned(StringGrid) then
    StringGrid := TMFStringGrid.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 6, DT_LEFT, 4, DT_CENTER, 5,
    DT_CENTER, 7, DT_RIGHT);
  Result := StringGrid.GetStringGrid(40, 330, 820, 190, 7, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0, 50);
  StringGrid.ColWidth(1, 90);
  StringGrid.ColWidth(2, 240);
  StringGrid.ColWidth(3, 90);
  StringGrid.ColWidth(4, 80);
  StringGrid.ColWidth(5, 90);
  StringGrid.ColWidth(6, 170);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Наименование продукции');
  StringGrid.WriteCells(3, 0, 'Объем, мл');
  StringGrid.WriteCells(4, 0, 'Дозы, шт');
  StringGrid.WriteCells(5, 0, 'Пакеты, шт');
  StringGrid.WriteCells(6, 0, 'Причина расхода');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TBIOCConsumptionOfTrombo.create;
  ContentForStringGrid.GetContent;
  if ContentForStringGrid.GetRowCount > 0 then
    for i := 0 to ContentForStringGrid.GetRowCount - 1 do
    begin
      if StringGrid.GetValue(0, 1) <> '' then
        StringGrid.AddRowCount;
      StringGrid.WriteCells(0, i + 1, ContentForStringGrid.GetKod(j));
      StringGrid.WriteCells(1, i + 1,
        ContentForStringGrid.GetCancellationDate(j));
      StringGrid.WriteCells(2, i + 1,
        ContentForStringGrid.GetTheNameOfTheEnvironment(j));
      StringGrid.WriteCells(3, i + 1, ContentForStringGrid.GetVolume(j));
      StringGrid.WriteCells(4, i + 1, ContentForStringGrid.GetNumberOfDoses(j));
      StringGrid.WriteCells(5, i + 1,
        ContentForStringGrid.GetNumberOfPackets(j));
      StringGrid.WriteCells(6, i + 1,
        ContentForStringGrid.GetReasonConsumption(j));
      j := j + 1;
    end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.GetStringGrid выполнена');
end;

procedure TMIOCConsumptionOfTrombo.Show;
begin
  LabelCancellationDate.Visible(True);
  LabelTheNameOfTrombo.Visible(True);
  LabelVolume.Visible(True);
  LabelNumberOfDoses.Visible(True);
  LabelNumberOfPackets.Visible(True);
  LabelReasonConsumption.Visible(True);

  StringGrid.Visible(True);

  CancellationDateCal.Visible(True);

  EditVolume.Visible(True);
  EditNumberOfDoses.Visible(True);
  EditNumberOfPackets.Visible(True);

  ProductList.Visible(True);
  ReasonConsumption.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMIOCConsumptionOfTrombo.Show выполнена');
end;
end.
