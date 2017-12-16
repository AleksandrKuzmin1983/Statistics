unit VIOCConsumptionOfPlazma;

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
  MIOCConsumptionOfPlazma;

type
  IVIOCConsumptionOfPlazma = interface
  end;

  TVIOCConsumptionOfPlazma = class(TInterfacedObject, IVIOCConsumptionOfPlazma)
  private
    LabelCancellationDate: ITempLabelTag5;
    LabelTheNameOfPlazma: ITempLabelTag5;
    LabelVolume: ITempLabelTag5;
    LabelNumberOfDoses: ITempLabelTag5;
    LabelReasonConsumption: ITempLabelTag5;
    Title: ITitleLabelTag5;
    SQL: String;

    StringGrid: IStringGridTag5;
    ContentForStringGrid: IMIOCConsumptionOfPlazma;

    EditVolume: IEditTag5;
    EditNumberOfDoses: IEditTag5;

    ProductList: IComboboxTag5;
    ReasonConsumption: IComboboxTag5;

    CancellationDateCal: IDTPickerTag5;
    CheckFillStrFields: ICheckFillStringFields;
    BlockMainMenu: IBlockMainMenu;

    ButtonAdd: IBitBtnAddTag5;
    ButtonDelete: IBitBtnDeleteTag5;
    ButtonEdit: IBitBtnEditTag5;
    ButtonBlock: IBitBtnBlockTag5;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelTheNameOfPlazma(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberOfDoses(NameForm: TForm): TLabel;
    function GetLabelReasonConsumption(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetEditVolume(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;

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
  public
    constructor create(form: TForm);
  end;

implementation

{ TBloodProduct }

constructor TVIOCConsumptionOfPlazma.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelReportDate(form);
  GetLabelTheNameOfPlazma(form);
  GetLabelVolume(form);
  GetLabelNumberOfDoses(form);
  GetLabelReasonConsumption(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);
  GetEditNumberOfDoses(form);

  GetProductList(form);
  GetReasonConsumption(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

//Button

// Добавление новой записи

procedure TVIOCConsumptionOfPlazma.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
  EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses.ReadText));
  if (EditVolume.ReadText='0') or (EditNumberOfDoses.ReadText='0')
    or (ProductList.GetItemIndex=-1) or (ReasonConsumption.GetItemIndex=-1) then
    begin
      Showmessage('Все поля должны быть заполнены!');
      exit;
    End;
  try
    if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('INSERT INTO [Брак компонентов и другой расход] (ДАТАЗАГ, ДАТАБР, БПВ, БПО, БПД, БПП) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(CancellationDateCal.GetDate)) + '#, ' +
        '#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(CancellationDateCal.GetDate)) + '#, ''' +
        ProductList.GetItemsValue(ProductList.GetItemIndex) + ''', ' +
        EditVolume.ReadText + ', ' + EditNumberOfDoses.ReadText + ', ''' +
        ReasonConsumption.GetItemsValue(ReasonConsumption.GetItemIndex) + ''')');
        ExecSQL;
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
    EditNumberOfDoses.WriteText('0');
    ReasonConsumption.WriteItemIndex(-1);
    ProductList.WriteItemIndex(-1);
    CancellationDateCal.WriteDateTime(StartOfTheWeek(Date)-3);
end;

// Разблокировка кнопок

procedure TVIOCConsumptionOfPlazma.ButtonBlocked(Sender: TObject);
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

procedure TVIOCConsumptionOfPlazma.ButtonDeleted(Sender: TObject);
begin
  try
    if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('DELETE FROM [Брак компонентов и другой расход] WHERE [Брак компонентов и другой расход].Код=' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)));
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
    EditNumberOfDoses.WriteText('0');
    ProductList.WriteItemIndex(-1);
    ReasonConsumption.WriteItemIndex(-1);
    CancellationDateCal.WriteDateTime(StartOfTheWeek(Date)-3);
end;

// Внесение изменений

procedure TVIOCConsumptionOfPlazma.ButtonEdited(Sender: TObject);
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

    CancellationDateCal.WriteDateTime(StrToDate(StringGrid.GetValue(1, StringGrid.CurrentRow)));
    for i:=0 to ProductList.GetItemsCount-1 do
      if VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow))=ProductList.GetItemsValue(i) then  ProductList.WriteItemIndex(i);
    if ProductList.GetItemIndex=-1 then ShowMessage('Название изменяемой продукции для данной записи задано не верно!' + chr(13) + 'Обратитесь к администратору!');
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow)));
    EditNumberOfDoses.WriteText(VarToStr(StringGrid.GetValue(4, StringGrid.CurrentRow)));
    for i:=0 to ReasonConsumption.GetItemsCount-1 do
      if VarToStr(StringGrid.GetValue(5, StringGrid.CurrentRow))=ReasonConsumption.GetItemsValue(i) then  ReasonConsumption.WriteItemIndex(i);
    if ReasonConsumption.GetItemIndex=-1 then ShowMessage('Причина списания у изменяемой записи задана не верно!' + chr(13) + 'Обратитесь к администратору!');

  end;
  if ButtonEdit.GetCaption='Сохранить изменения' then
  begin
    EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
    EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses.ReadText));
    if (EditVolume.ReadText='0') or (EditNumberOfDoses.ReadText='0')
      or (ProductList.GetItemIndex=-1) or (ReasonConsumption.GetItemIndex=-1) then
    begin
      Showmessage('Все поля должны быть заполнены!');
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
        AddSQL('UPDATE [Брак компонентов и другой расход] SET ' +
        '[Брак компонентов и другой расход].ДАТАЗАГ = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(CancellationDateCal.GetDate)) + '#, ' +
        '[Брак компонентов и другой расход].ДАТАБР = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(CancellationDateCal.GetDate)) + '#, ' +
        '[Брак компонентов и другой расход].БПВ=''' + ProductList.GetItemsValue(ProductList.GetItemIndex) + ''', ' +
        '[Брак компонентов и другой расход].БПО=' + EditVolume.ReadText + ', ' +
        '[Брак компонентов и другой расход].БПД=' + EditNumberOfDoses.ReadText + ', ' +
        '[Брак компонентов и другой расход].БПП=''' + ReasonConsumption.GetItemsValue(ReasonConsumption.GetItemIndex) + ''' ' +
        'WHERE [Брак компонентов и другой расход].Код=' + StringGrid.GetValue(0, StringGrid.CurrentRow));
        ExecSQL;
      end;
    ShowMessage('Запись успешно изменена!');
    end
    else
    begin
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      ProductList.WriteItemIndex(-1);
      ReasonConsumption.WriteItemIndex(-1);
      CancellationDateCal.WriteDateTime(StartOfTheWeek(Date)-3);
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
      EditNumberOfDoses.WriteText('0');
      ProductList.WriteItemIndex(-1);
      ReasonConsumption.WriteItemIndex(-1);
      CancellationDateCal.WriteDateTime(StartOfTheWeek(Date)-3);
  end;
  if ButtonEdit.GetCaption='Изменить' then ButtonEdit.ChangeCaption('Сохранить изменения') else ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок

function TVIOCConsumptionOfPlazma.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TVIOCConsumptionOfPlazma.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TVIOCConsumptionOfPlazma.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TVIOCConsumptionOfPlazma.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TVIOCConsumptionOfPlazma.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(CancellationDateCal) then
    CancellationDateCal:=TDTPickerTag5.Create;
  result:=CancellationDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-3, NameForm);
end;

//Edit

function TVIOCConsumptionOfPlazma.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TEditTag5.create;
  Result:=EditVolume.GetEdit(400, 160, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);
end;

function TVIOCConsumptionOfPlazma.GetEditNumberOfDoses(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses) then
    EditNumberOfDoses := TEditTag5.create;
  Result:=EditNumberOfDoses.GetEdit(400, 200, 185, 12, False, NameForm);
  EditNumberOfDoses.NumberOnly(True);
end;

//Label

function TVIOCConsumptionOfPlazma.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(25, 'Расход плазмы', NameForm);
end;

function TVIOCConsumptionOfPlazma.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelCancellationDate) then
    LabelCancellationDate := TTempLabelTag5.create;
  result := LabelCancellationDate.GetTempLabel(50, 80, 16, 'Дата расхода: ', NameForm);
end;

function TVIOCConsumptionOfPlazma.GetLabelTheNameOfPlazma(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTheNameOfPlazma) then
    LabelTheNameOfPlazma := TTempLabelTag5.create;
  result := LabelTheNameOfPlazma.GetTempLabel(50, 120, 14, 'Наименование продукции: ', NameForm);
end;

function TVIOCConsumptionOfPlazma.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(50, 160, 14, 'Объем продукции: ', NameForm);
end;

function TVIOCConsumptionOfPlazma.GetLabelNumberOfDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDoses) then
    LabelNumberOfDoses := TTempLabelTag5.create;
  result := LabelNumberOfDoses.GetTempLabel(50, 200, 14, 'Количество доз: ', NameForm);
end;

function TVIOCConsumptionOfPlazma.GetLabelReasonConsumption(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReasonConsumption) then
    LabelReasonConsumption := TTempLabelTag5.create;
  result := LabelReasonConsumption.GetTempLabel(50, 240, 14, 'Причина списания: ', NameForm);
end;

//ComboBox


function TVIOCConsumptionOfPlazma.GetProductList(NameForm: TForm): TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TComboboxTag5.create;
  result := ProductList.GetComboBox(285, 120, 300, 14, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts ' +
  'WHERE (((NameProducts.TypeProduct)="Плазма") AND ((NameProducts.Visible)=True));';
  ProductList.TheContentOfTheList(SQL);
end;

function TVIOCConsumptionOfPlazma.GetReasonConsumption(NameForm: TForm): TComboBox;
begin
  if not Assigned(ReasonConsumption) then
    ReasonConsumption := TComboboxTag5.create;
  result := ReasonConsumption.GetComboBox(285, 240, 300, 14, NameForm);
  SQL:='SELECT TypeOfDefects.TypeDef ' +
  'FROM TypeOfDefects ' +
  'WHERE (((TypeOfDefects.Plasma)=True)) ' +
  'ORDER BY TypeOfDefects.TypeDef;';
  ReasonConsumption.TheContentOfTheList(SQL);
end;

// StringGrid

function TVIOCConsumptionOfPlazma.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 3, DT_RIGHT, 4, DT_CENTER, 5, DT_LEFT, 7, DT_RIGHT);
  Result:=StringGrid.GetStringGrid(40, 330, 820, 190, 6, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0,50);
  StringGrid.ColWidth(1,90);
  StringGrid.ColWidth(2,250);
  StringGrid.ColWidth(3,100);
  StringGrid.ColWidth(4,80);
  StringGrid.ColWidth(5,170);
  StringGrid.Visible(true);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Наименование продукции');
  StringGrid.WriteCells(3, 0, 'Объем, мл');
  StringGrid.WriteCells(4, 0, 'Дозы, шт');
  StringGrid.WriteCells(5, 0, 'Причина расхода');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TMIOCConsumptionOfPlazma.create;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetCancellationDate(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetTheNameOfTheEnvironment(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetVolume(j));
        StringGrid.WriteCells(4, i+1, ContentForStringGrid.GetNumberOfDoses(j));
        StringGrid.WriteCells(5, i+1, ContentForStringGrid.GetReasonConsumption(j));
        j:=j+1;
      end;
end;
end.
