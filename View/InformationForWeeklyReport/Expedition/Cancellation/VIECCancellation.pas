unit VIECCancellation;

interface

uses
  WinProcs, SysUtils, StdCtrls, Buttons, Vcl.Grids, Data.DB,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,
  UMSCheckFillStringFields,
  UMSBlockMainMenu,
  UVFLabel,
  UVFTitleLabel,
  UVFEdit,
  UVFDateTimePicker,
  UVFBitBtnAdd,
  UVFBitBtnDelete,
  UVFBitBtnEdit,
  UVFBitBtnBlock,
  UVFStringGrid,
  UVFComboBox,
  MIEChangeRecordCancellation,
  MIECDeleteRecordCancellation,
  MIECAddRecordCancellation,
  MIECCancellation;

type
  IVIECCancellation = interface
  end;

  TVIECCancellation = class(TInterfacedObject, IVIECCancellation)
  private
    LabelReportDate: ITempLabelTag5;
    LabelTheNameOfTheEnvironment: ITempLabelTag5;
    LabelVolume: ITempLabelTag5;
    LabelNumberOfDoses: ITempLabelTag5;
    LabelNumberOfPackets: ITempLabelTag5;
    Title: ITitleLabelTag5;
    SQL: String;

    StringGrid: IStringGridTag5;
    ContentForStringGrid: IMIECCancellation;
    AddRecord: IMIECAddRecordCancellation;
    DeleteRecord: IMIECDeleteRecordCancellation;
    ChangeRecord: IMIEChangeRecordCancellation;

    EditVolume: IEditTag5;
    EditNumberOfDoses: IEditTag5;
    EditNumberOfPackets: IEditTag5;

    ProductList: IComboboxTag5;

    ReportDateCal: IDTPickerTag5;
    CheckFillStrFields: ICheckFillStringFields;
    BlockMainMenu: IBlockMainMenu;

    ButtonAdd: IBitBtnAddTag5;
    ButtonDelete: IBitBtnDeleteTag5;
    ButtonEdit: IBitBtnEditTag5;
    ButtonBlock: IBitBtnBlockTag5;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelTheNameOfTheEnvironment(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberOfDoses(NameForm: TForm): TLabel;
    function GetLabelNumberOfPackets(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetEditVolume(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;
    function GetEditNumberOfPackets(NameForm: TForm): TEdit;

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
  public
    constructor create(form: TForm);
  end;

implementation

{ TBloodProduct }

constructor TVIECCancellation.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelReportDate(form);
  GetLabelTheNameOfTheEnvironment(form);
  GetLabelVolume(form);
  GetLabelNumberOfDoses(form);
  GetLabelNumberOfPackets(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);
  GetEditNumberOfDoses(form);
  GetEditNumberOfPackets(form);

  GetProductList(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

//Button

// Добавление новой записи

procedure TVIECCancellation.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
  EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses.ReadText));
  EditNumberOfPackets.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfPackets.ReadText));
  if (EditVolume.ReadText='0') or (EditNumberOfDoses.ReadText='0') or (ProductList.GetItemIndex=-1) then
    begin
      Showmessage('Все поля должны быть заполнены!');
      exit;
    End;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(AddRecord) then
      AddRecord := TMIECAddRecordCancellation.create;
    AddRecord.AddRecord(ReportDateCal.GetDate, ProductList.GetItemsValue(ProductList.GetItemIndex), EditVolume.ReadText,
      EditNumberOfDoses.ReadText, EditNumberOfPackets.ReadText);
    ShowMessage('Запись успешно добавлена!');
    GetStringGrid(CurrentForm);
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  EditNumberOfPackets.WriteText('0');
  ProductList.WriteItemIndex(-1);
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Разблокировка кнопок

procedure TVIECCancellation.ButtonBlocked(Sender: TObject);
begin
  if ButtonBlock.GetCaption then
  begin
    ButtonEdit.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    ButtonBlock.ChangeCaption(True);
  end else
  begin
    ButtonEdit.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    ButtonBlock.ChangeCaption(False);
  end;
end;

//Кнопка удаления

procedure TVIECCancellation.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TMIECDeleteRecordCancellation.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount-1);
    ShowMessage('Запись успешно удалена!');
  end;
  EditVolume.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  EditNumberOfPackets.WriteText('0');
  ProductList.WriteItemIndex(-1);
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Внесение изменений

procedure TVIECCancellation.ButtonEdited(Sender: TObject);
var
  i: integer;
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  if not Assigned(BlockMainMenu) then
    BlockMainMenu := TBlockMainMenu.create;
  if ButtonEdit.GetCaption='Изменить' then
  begin
    BlockMainMenu.BlockMainMenu(False, CurrentForm);
    ButtonBlock.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    StringGrid.Enabled(False);

    ReportDateCal.WriteDateTime(StrToDate(StringGrid.GetValue(1, StringGrid.CurrentRow)));
    for i:=0 to ProductList.GetItemsCount-1 do
      if VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow))=ProductList.GetItemsValue(i) then  ProductList.WriteItemIndex(i);
    if ProductList.GetItemIndex=-1 then ShowMessage('Название изменяемой продукции для данной записи задано не верно!' + chr(13) + 'Обратитесь к администратору!');
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow)));
    EditNumberOfDoses.WriteText(VarToStr(StringGrid.GetValue(4, StringGrid.CurrentRow)));
    EditNumberOfPackets.WriteText(VarToStr(StringGrid.GetValue(5, StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetCaption='Сохранить изменения' then
  begin
    EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
    EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses.ReadText));
    EditNumberOfPackets.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfPackets.ReadText));
    if (EditVolume.ReadText='0') or (EditNumberOfDoses.ReadText='0') or (ProductList.GetItemIndex=-1) then
    begin
      Showmessage('Все поля должны быть заполнены!');
      exit;
    End;
    BlockMainMenu.BlockMainMenu(True, CurrentForm);
    ButtonBlock.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    StringGrid.Enabled(True);
  if MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(ChangeRecord) then
      ChangeRecord := TMIEChangeRecordCancellation.create;
    ChangeRecord.ChangeRecord(ReportDateCal.GetDate, ProductList.GetItemsValue(ProductList.GetItemIndex), EditVolume.ReadText,
        EditNumberOfDoses.ReadText, EditNumberOfPackets.ReadText, StringGrid.GetValue(0, StringGrid.CurrentRow));
    GetStringGrid(CurrentForm);
    ShowMessage('Запись успешно изменена!');
    end
    else
    begin
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      EditNumberOfPackets.WriteText('0');
      ProductList.WriteItemIndex(-1);
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end;
    EditVolume.WriteText('0');
    EditNumberOfDoses.WriteText('0');
    EditNumberOfPackets.WriteText('0');
    ProductList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
  end;
  if ButtonEdit.GetCaption='Изменить' then ButtonEdit.ChangeCaption('Сохранить изменения') else ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок

function TVIECCancellation.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TVIECCancellation.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TVIECCancellation.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TVIECCancellation.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TVIECCancellation.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal:=TDTPickerTag5.Create;
  result:=ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-7, NameForm);
end;

//Edit

function TVIECCancellation.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TEditTag5.create;
  Result:=EditVolume.GetEdit(400, 160, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);
end;

function TVIECCancellation.GetEditNumberOfDoses(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses) then
    EditNumberOfDoses := TEditTag5.create;
  Result:=EditNumberOfDoses.GetEdit(400, 200, 185, 12, False, NameForm);
  EditNumberOfDoses.NumberOnly(True);
end;

function TVIECCancellation.GetEditNumberOfPackets(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfPackets) then
    EditNumberOfPackets := TEditTag5.create;
  Result:=EditNumberOfPackets.GetEdit(400, 240, 185, 12, False, NameForm);
  EditNumberOfPackets.NumberOnly(True);
end;

//Label

function TVIECCancellation.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(25, 'Списание трансфузионных сред в экспедиции', NameForm);
end;

function TVIECCancellation.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TTempLabelTag5.create;
  result := LabelReportDate.GetTempLabel(50, 80, 16, 'Отчетная неделя: ', NameForm);
end;

function TVIECCancellation.GetLabelTheNameOfTheEnvironment(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTheNameOfTheEnvironment) then
    LabelTheNameOfTheEnvironment := TTempLabelTag5.create;
  result := LabelTheNameOfTheEnvironment.GetTempLabel(50, 120, 14, 'Наименование продукции: ', NameForm);
end;

function TVIECCancellation.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(50, 160, 14, 'Объем продукции: ', NameForm);
end;

function TVIECCancellation.GetLabelNumberOfDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDoses) then
    LabelNumberOfDoses := TTempLabelTag5.create;
  result := LabelNumberOfDoses.GetTempLabel(50, 200, 14, 'Количество доз: ', NameForm);
end;

function TVIECCancellation.GetLabelNumberOfPackets(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfPackets) then
    LabelNumberOfPackets := TTempLabelTag5.create;
  result := LabelNumberOfPackets.GetTempLabel(50, 240, 14, 'Количество пакетов тромбоконцентрата: ', NameForm);
end;

//ComboBox

function TVIECCancellation.GetProductList(NameForm: TForm): TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TComboboxTag5.create;
  result := ProductList.GetComboBox('ProductList', 285, 120, 300, 14, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts ' +
  'WHERE (NameProducts.ForExped=True);';
  ProductList.TheContentOfTheList(SQL);
end;

// StringGrid

function TVIECCancellation.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i:=0; j:=0;
  Try
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  Result:=StringGrid.GetStringGrid(40, 330, 820, 190, 6, 2, 12, NameForm);
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 2, DT_LEFT, 3, DT_RIGHT, 4, DT_RIGHT, 5, DT_RIGHT);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0,40);
  StringGrid.ColWidth(1,90);
  StringGrid.ColWidth(2,250);
  StringGrid.ColWidth(3,90);
  StringGrid.ColWidth(4,90);
  StringGrid.ColWidth(5,90);
  StringGrid.Visible(true);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Наименование продукции');
  StringGrid.WriteCells(3, 0, 'Объем, мл');
  StringGrid.WriteCells(4, 0, 'Дозы, шт');
  StringGrid.WriteCells(5, 0, 'Пакеты, шт');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TMIECCancellation.create;
  ContentForStringGrid.GetContent;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetReportDate(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetTheNameOfTheEnvironment(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetVolume(j));
        StringGrid.WriteCells(4, i+1, ContentForStringGrid.GetNumberOfDoses(j));
        StringGrid.WriteCells(5, i+1, ContentForStringGrid.GetNumberOfPackets(j));
        j:=j+1;
      end;
  Except
    ShowMessage('Ошибка при формировании таблицы!');
  End;
end;

end.
