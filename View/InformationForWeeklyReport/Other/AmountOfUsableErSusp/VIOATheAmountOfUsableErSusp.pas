unit VIOATheAmountOfUsableErSusp;

interface

uses
  WinProcs, SysUtils, StdCtrls, Buttons, Vcl.Grids, Data.DB,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,
  UMSCheckFillStringFields,
  UMSBlockMainMenu,
  UVFComboBox,
  UVFLabel,
  UVFTitleLabel,
  UVFEdit,
  UVFDateTimePicker,
  UVFBitBtnAdd,
  UVFBitBtnDelete,
  UVFBitBtnEdit,
  UVFBitBtnBlock,
  UVFStringGrid,
  MIOATheAmountOfUsableErSusp;

type
  ITheAmountOfUsableErSusp = interface
  end;

  TTheAmountOfUsableErSusp = class(TInterfacedObject, ITheAmountOfUsableErSusp)
  private
    LabelReportDate: ITempLabelTag5;
    LabelProductList: ITempLabelTag5;
    LabelVolume: ITempLabelTag5;
    Title: ITitleLabelTag5;
    SQL: String;

    StringGrid: IStringGridTag5;
    ContentForStringGrid: IAmountOfUsableErSusp;

    EditVolume: IEditTag5;
    ProductList: IComboboxTag5;

    ReportDateCal: IDTPickerTag5;
    CheckStrFields: ICheckFillStringFields;
    BlockMainMenu: IBlockMainMenu;

    ButtonAdd: IBitBtnAddTag5;
    ButtonDelete: IBitBtnDeleteTag5;
    ButtonEdit: IBitBtnEditTag5;
    ButtonBlock: IBitBtnBlockTag5;
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
  public
    constructor create(form: TForm);
  end;

implementation

{ TBloodProduct }

constructor TTheAmountOfUsableErSusp.create(form: TForm);
begin
  CurrentForm:=Form;

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
end;

//Button

// Добавление новой записи

procedure TTheAmountOfUsableErSusp.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckStrFields) then
    CheckStrFields := TCheckFillStringFields.create;
  EditVolume.WriteText(CheckStrFields.CheckStringFields(EditVolume.ReadText));
  if (EditVolume.ReadText='0') then
    begin
      Showmessage('Поле "Произведено годной продукции, мл" должно быть заполнено!');
      exit;
    End;
    if ProductList.GetItemIndex=-1 then
    begin
      ShowMessage('Вид продукции не задан!');
      exit;
    end;
  try
    if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('INSERT INTO Exped (ДАТАЛЗ, НС, ПГЭС) VALUES (#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(ReportDateCal.GetDate)) +
               '#, ''' + ProductList.GetItemsValue(ProductList.GetItemIndex) + ''', ' + EditVolume.ReadText + ')');
        ExecSQL;
     {  OpenConnect;
        Insert;
        WriteValue(1, dateOf(ReportDateCal.GetDate));
        WriteValue(2, ProductList.GetItemsValue(ProductList.GetItemIndex));
        WriteValue(3, StrToInt(EditVolume.ReadText));
        Post;
        CloseConnect; }
      end;
    ShowMessage('Запись успешно добавлена!');
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
    EditVolume.WriteText('0');
    ProductList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Разблокировка кнопок

procedure TTheAmountOfUsableErSusp.ButtonBlocked(Sender: TObject);
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

procedure TTheAmountOfUsableErSusp.ButtonDeleted(Sender: TObject);
begin
  try
    if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('DELETE FROM Exped WHERE Exped.Код=' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)));
        ExecSQL;
      end;
      ShowMessage('Запись успешно удалена!');
    end;
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
    EditVolume.WriteText('0');
    ProductList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Внесение изменений

procedure TTheAmountOfUsableErSusp.ButtonEdited(Sender: TObject);
var
 i: integer;
begin
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
    if ProductList.GetItemIndex=-1 then ShowMessage('Название продукции для данной записи задано не верно!');
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetCaption='Сохранить изменения' then
  begin
    if not Assigned(CheckStrFields) then
      CheckStrFields := TCheckFillStringFields.create;
    EditVolume.WriteText(CheckStrFields.CheckStringFields(EditVolume.ReadText));
    if (EditVolume.ReadText='0') then
    begin
      Showmessage('Поле "Произведено годной продукции, мл" должно быть заполнено!' + char(13) + 'Если значение необходимо удалить, то отмените изменения и воспользуйтесь кнопкой "Удалить запись"!');
      exit;
    End;
    BlockMainMenu.BlockMainMenu(True, CurrentForm);
    ButtonBlock.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    StringGrid.Enabled(True);
  try
    if MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('UPDATE Exped SET Exped.ДАТАЛЗ = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(ReportDateCal.GetDate)) +
               '#, Exped.НС =''' + ProductList.GetItemsValue(ProductList.GetItemIndex) + ''', ' +
               'Exped.ПГЭС=' + EditVolume.ReadText + ' WHERE Exped.Код=' + StringGrid.GetValue(0, StringGrid.CurrentRow));
        ExecSQL;
      end;
    ShowMessage('Запись успешно изменена!');
    end
    else
    begin
      EditVolume.WriteText('0');
      ProductList.WriteItemIndex(-1);
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end;
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
    EditVolume.WriteText('0');
    ProductList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
  end;
  if ButtonEdit.GetCaption='Изменить' then ButtonEdit.ChangeCaption('Сохранить изменения') else ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок

function TTheAmountOfUsableErSusp.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TTheAmountOfUsableErSusp.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TTheAmountOfUsableErSusp.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TTheAmountOfUsableErSusp.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TTheAmountOfUsableErSusp.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal:=TDTPickerTag5.Create;
  result:=ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-7, NameForm);
end;

//Edit

function TTheAmountOfUsableErSusp.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TEditTag5.create;
  Result:=EditVolume.GetEdit(400, 180, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);
end;

//Label

function TTheAmountOfUsableErSusp.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TTempLabelTag5.create;
  result := LabelReportDate.GetTempLabel(50, 80, 16, 'Отчетная неделя: ', NameForm);
end;

function TTheAmountOfUsableErSusp.GetLabelProductList(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProductList) then
    LabelProductList := TTempLabelTag5.create;
  result := LabelProductList.GetTempLabel(50, 130, 16, 'Название продукци: ', NameForm);
end;

function TTheAmountOfUsableErSusp.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(50, 180, 16, 'Произведено годной продукции, мл: ', NameForm);
end;

function TTheAmountOfUsableErSusp.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(18, 'Объем годных эритроцитарных сред заготовленных за отчетную неделю', NameForm);
end;

//ComboBox

function TTheAmountOfUsableErSusp.GetProductList(NameForm: TForm): TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TComboboxTag5.create;
  result := ProductList.GetComboBox(270, 130, 315, 14, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id FROM NameProducts ' +
  'WHERE (((NameProducts.TypeProduct)="Эр взвесь") And NameProducts.Production=True);';
  ProductList.TheContentOfTheList(SQL);
end;


function TTheAmountOfUsableErSusp.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 1, DT_LEFT, 2, DT_LEFT, 3, DT_RIGHT, 4, DT_Center);
  Result:=StringGrid.GetStringGrid(50, 280, 800, 240, 4, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0,60);
  StringGrid.ColWidth(1,100);
  StringGrid.ColWidth(2,300);
  StringGrid.ColWidth(3,100);
  StringGrid.Visible(true);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Наименование продукции, шт');
  StringGrid.WriteCells(3, 0, 'Объем, мл');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TAmountOfUsableErSusp.create;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetDate(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetName(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetVolume(j));
        j:=j+1;
      end;
end;

end.
