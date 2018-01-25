unit VHAAutomaticApheresis;

interface

uses
  Vcl.ExtCtrls, WinProcs, SysUtils, StdCtrls, Buttons, Vcl.Grids, Data.DB,
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
  UVFPanel,
  MHAAutomaticApheresis,
  MHAAddRecordAutomaticApheresis,
  MHADeleteRecordAutomaticApheresis,
  MHAChangeRecordAutomaticApheresis,
  UMSCheckForExistenceOfRecord,
  UMSValueChecksOnTheAdequacy,

  MIOCurrentType,
  MIOTypeOfSelectRow,
  MIONameTypeOfSelectRow,
  MIOAddRecord,
  MIODeleteRecord,
  MIOChangeRecord,
  UMSGlobalVariant;

type
  IVHAAutomaticApheresis = interface
  end;

  TVHAAutomaticApheresis = class(TGlobalVariant)
  private
    //шапка
    LabelDate: TTempLabelTag5;
    LabelNumberOfDonors: TTempLabelTag5;
    //кровь
    LabelSentToPreserving: TTempLabelTag5;
    LabelForLaboratoryResearch: TTempLabelTag5;
    LabelAllWholeBlood: TTempLabelTag5;
    LabelAllStoredBlood: TTempLabelTag5;
    LabelBlood: TTempLabelTag5;

    LabelVolume: TTempLabelTag5;
    LabelNumberDoses: TTempLabelTag5;
    LabelType: TTempLabelTag5;
    LabelPlazma: TTempLabelTag5;
    LabelDefectWholeBlood: TTempLabelTag5;

    Title: TTitleLabelTag5;
    SQL: String;

    //таблица "кровь"
    PanelGorBlood: TTempPanelTag5;
    PanelVertBlood1: TTempPanelTag5;
    PanelVertBlood2: TTempPanelTag5;
    PanelVertBlood3: TTempPanelTag5;
    PanelVertBlood4: TTempPanelTag5;
    //таблица "компоненты"
    PanelGor1Components1: TTempPanelTag5;
    PanelGor2Components1: TTempPanelTag5;
    PanelVert1Components1: TTempPanelTag5;
    PanelVert2Components1: TTempPanelTag5;
    PanelVert3Components1: TTempPanelTag5;

    //шапка
    DateCal: TDTPickerTag5;
    EditNumberOfDonors: TEditTag5;
    //таблица "кровь"
    EditSentToPreserving: TEditTag5;
    EditForLaboratoryResearch: TEditTag5;
    EditAllWholeBlood: TEditTag5;
    EditAllStoredBlood: TEditTag5;
    //таблица "компоненты"
    EditVolumePlazma: TEditTag5;
    EditVolumeDefect: TEditTag5;
    EditNumberDosesPlazma: TEditTag5;
    EditNumberDosesDefect: TEditTag5;

    CBoxTypeDefect: TComboboxTag5;
    CBoxTypePlazma: TComboboxTag5;


    StringGrid: TStringGridTag5;
    ContentForStringGrid: IMHAAutomaticApheresis;
    AddRecord: IMHAAddRecordAutomaticApheresis;
    DeleteRecord: IMHADeleteRecordAutomaticApheresis;
    ChangeRecord: IMHAChangeRecordAutomaticApheresis;

    ValueChecksOnTheAdequacy: IUMSValueChecksOnTheAdequacy;
    CheckFillStrFields: TCheckFillStringFields;
    BlockMainMenu: IBlockMainMenu;

    ButtonAdd: TBitBtnAddTag5;
    ButtonDelete: TBitBtnDeleteTag5;
    ButtonEdit: TBitBtnEditTag5;
    ButtonBlock: TBitBtnBlockTag5;

    CheckForExistenceOfRecord: IUMSCheckForExistenceOfRecord;
    CurrentForm: TForm;

    function CheckingBeforeSaving: boolean;
    procedure AfterSaving_Cancelling;

    function GetLabelDate(NameForm: TForm): TLabel;
    function GetLabelNumberOfDonors(NameForm: TForm): TLabel;
    function GetLabelSentToPreserving(NameForm: TForm): TLabel;
    function GetLabelForLaboratoryResearch(NameForm: TForm): TLabel;
    function GetLabelAllWholeBlood(NameForm: TForm): TLabel;
    function GetLabelAllStoredBlood(NameForm: TForm): TLabel;
    function GetLabelBlood(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberDoses(NameForm: TForm): TLabel;
    function GetLabelType(NameForm: TForm): TLabel;
    function GetLabelPlazma(NameForm: TForm): TLabel;
    function GetLabelDefectWholeBlood(NameForm: TForm): TLabel;

    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetPanelGorBlood(NameForm: TForm): TPanel;
    function GetPanelVertBlood1(NameForm: TForm): TPanel;
    function GetPanelVertBlood2(NameForm: TForm): TPanel;
    function GetPanelVertBlood3(NameForm: TForm): TPanel;
    function GetPanelVertBlood4(NameForm: TForm): TPanel;
    function GetPanelGor1Components1(NameForm: TForm): TPanel;
    function GetPanelGor2Components1(NameForm: TForm): TPanel;
    function GetPanelVert1Components1(NameForm: TForm): TPanel;
    function GetPanelVert2Components1(NameForm: TForm): TPanel;
    function GetPanelVert3Components1(NameForm: TForm): TPanel;

    function GetEditNumberOfDonors(NameForm: TForm): TEdit;
    function GetEditSentToPreserving(NameForm: TForm): TEdit;
    function GetEditForLaboratoryResearch(NameForm: TForm): TEdit;
    function GetEditAllWholeBlood(NameForm: TForm): TEdit;
    function GetEditAllStoredBlood(NameForm: TForm): TEdit;
    function GetEditVolumePlazma(NameForm: TForm): TEdit;
    function GetEditVolumeDefect(NameForm: TForm): TEdit;
    function GetEditNumberDosesPlazma(NameForm: TForm): TEdit;
    function GetEditNumberDosesDefect(NameForm: TForm): TEdit;

    function GetCBoxTypeDefect(NameForm: TForm): TComboBox;
    function GetCBoxTypePlazma(NameForm: TForm): TComboBox;

    function GetStringGrid(NameForm: TForm): TStringGrid;
    function GetCalendarDateCal(NameForm: TForm): TDateTimePicker;

    function GetButtonEdit(NameForm: TForm): TBitBtn;
    procedure ButtonEdited(Sender: TObject);
    function GetButtonAdd(NameForm: TForm): TBitBtn;
    procedure ButtonAdded(Sender: TObject);
    function GetButtonDelete(NameForm: TForm): TBitBtn;
    procedure ButtonDeleted(Sender: TObject);
    function GetButtonBlock(NameForm: TForm): TBitBtn;
    procedure ButtonBlocked(Sender: TObject);
  public
    constructor create(form: TForm); override;
    destructor destroy; override;
  end;

implementation

{ TBloodProduct }

constructor TVHAAutomaticApheresis.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelDate(form);
  GetLabelNumberOfDonors(form);
  GetLabelSentToPreserving(form);
  GetLabelForLaboratoryResearch(form);
  GetLabelAllWholeBlood(form);
  GetLabelAllStoredBlood(form);
  GetLabelBlood(form);
  GetLabelVolume(form);
  GetLabelNumberDoses(form);
  GetLabelType(form);
  GetLabelPlazma(form);
  GetLabelDefectWholeBlood(form);

  GetLabelTitle(form);

  GetPanelGorBlood(form);
  GetPanelVertBlood1(form);
  GetPanelVertBlood2(form);
  GetPanelVertBlood3(form);
  GetPanelVertBlood4(form);
  GetPanelVert1Components1(form);
  GetPanelVert2Components1(form);
  GetPanelVert3Components1(form);
  GetPanelGor1Components1(form);
  GetPanelGor2Components1(form);

  GetEditNumberOfDonors(form);
  GetEditSentToPreserving(form);
  GetEditForLaboratoryResearch(form);
  GetEditAllWholeBlood(form);
  GetEditAllStoredBlood(form);
  GetEditVolumePlazma(form);
  GetEditVolumeDefect(form);
  GetEditNumberDosesPlazma(form);
  GetEditNumberDosesDefect(form);

  GetStringGrid(form);
  GetCalendarDateCal(form);

  GetCBoxTypeDefect(form);
  GetCBoxTypePlazma(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  inherited;
end;

destructor TVHAAutomaticApheresis.destroy;
begin
  LabelDate.destroy;
  LabelNumberOfDonors.destroy;
  //кровь
  LabelSentToPreserving.destroy;
  LabelForLaboratoryResearch.destroy;
  LabelAllWholeBlood.destroy;
  LabelAllStoredBlood.destroy;
  LabelBlood.destroy;
  //компоненты 1
  LabelVolume.destroy;
  LabelNumberDoses.destroy;
  LabelType.destroy;
  LabelPlazma.destroy;
  LabelDefectWholeBlood.destroy;

  Title.destroy;

  //таблица "кровь"
  PanelGorBlood.destroy;
  PanelVertBlood1.destroy;
  PanelVertBlood2.destroy;
  PanelVertBlood3.destroy;
  PanelVertBlood4.destroy;
  //таблица "компоненты 1"
  PanelGor1Components1.destroy;
  PanelGor2Components1.destroy;
  PanelVert1Components1.destroy;
  PanelVert2Components1.destroy;
  PanelVert3Components1.destroy;

  //шапка
  EditNumberOfDonors.destroy;

  //таблица "кровь"
  EditSentToPreserving.destroy;
  EditForLaboratoryResearch.destroy;
  EditAllWholeBlood.destroy;
  EditAllStoredBlood.destroy;
  //таблица "компоненты 1"
  EditVolumePlazma.destroy;
  EditVolumeDefect.destroy;
  EditNumberDosesPlazma.destroy;
  EditNumberDosesDefect.destroy;

  CBoxTypePlazma.destroy;
  CBoxTypeDefect.destroy;


  StringGrid.destroy;

  DateCal.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;
  inherited;
end;

//Button

procedure TVHAAutomaticApheresis.AfterSaving_Cancelling;
var
  i: integer;
begin
  DateCal.WriteDateTime(date());
  EditNumberOfDonors.WriteText('0');
  EditSentToPreserving.WriteText('0');
  EditForLaboratoryResearch.WriteText('0');
  EditAllWholeBlood.WriteText('0');
  EditAllStoredBlood.WriteText('0');
  EditVolumePlazma.WriteText('0');
  EditNumberDosesPlazma.WriteText('0');
  EditVolumeDefect.WriteText('0');
  EditNumberDosesDefect.WriteText('0');
  CBoxTypePlazma.WriteItemIndex(1);
  CBoxTypeDefect.WriteItemIndex(-1);
end;

// Добавление новой записи

procedure TVHAAutomaticApheresis.ButtonAdded(Sender: TObject);
begin
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(CheckForExistenceOfRecord) then
      CheckForExistenceOfRecord := TUMSCheckForExistenceOfRecord.create;
    SQL:='SELECT ДатаП ' +
      'FROM Plasma ' +
      'WHERE Plasma.ДатаП=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(DateCal.GetDate)) + '# ';
    if CheckForExistenceOfRecord.CheckForExistenceOfRecord(SQL) then exit;
    if CheckingBeforeSaving then exit;
    if not Assigned(AddRecord) then
      AddRecord := TMHAAddRecordAutomaticApheresis.create;
    AddRecord.AddRecordPlasma(DateCal.GetDate, EditNumberOfDonors.ReadText,
      EditSentToPreserving.ReadText, EditForLaboratoryResearch.ReadText,
      EditAllWholeBlood.ReadText, EditAllStoredBlood.ReadText);
    AddRecord.AddRecordPlasmaDoza(DateCal.GetDate, EditNumberOfDonors.ReadText);
    AddRecord.AddRecordPlasmaComponents(EditVolumePlazma.ReadText, EditNumberDosesPlazma.ReadText, CBoxTypePlazma.GetItemsValue(CBoxTypePlazma.GetItemIndex));
    AddRecord.AddRecordPlasmaDefect(EditVolumeDefect.ReadText, EditNumberDosesDefect.ReadText, CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
    GetStringGrid(CurrentForm);
    ShowMessage('Записи успешно добавлена!');
    AfterSaving_Cancelling;
  end;
end;

// Разблокировка кнопок

procedure TVHAAutomaticApheresis.ButtonBlocked(Sender: TObject);
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

procedure TVHAAutomaticApheresis.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись от ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + ' числа?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TMHADeleteRecordAutomaticApheresis.create;
    DeleteRecord.DeleteRecord(StringGrid.GetValue(0, StringGrid.CurrentRow));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount-1);
    ShowMessage('Запись успешно удалена!');
  end;
  AfterSaving_Cancelling;
end;

// Внесение изменений
procedure TVHAAutomaticApheresis.ButtonEdited(Sender: TObject);
var
 i: integer;
begin
  if not Assigned(ChangeRecord) then
    ChangeRecord := TMHAChangeRecordAutomaticApheresis.create;
  ChangeRecord.GetTempId(FormatDateTime('mm''/''dd''/''yyyy', StrToDateTime(StringGrid.GetValue(0 , StringGrid.CurrentRow))));

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
    DateCal.WriteDateTime(StrToDate(StringGrid.GetValue(0, StringGrid.CurrentRow)));
    DateCal.Enabled(false);
    EditNumberOfDonors.WriteText(StringGrid.GetValue(1, StringGrid.CurrentRow));

    EditSentToPreserving.WriteText(StringGrid.GetValue(2 , StringGrid.CurrentRow));
    EditForLaboratoryResearch.WriteText(StringGrid.GetValue(3 , StringGrid.CurrentRow));
    EditAllWholeBlood.WriteText(StringGrid.GetValue(4 , StringGrid.CurrentRow));
    EditAllStoredBlood.WriteText(StringGrid.GetValue(5 , StringGrid.CurrentRow));
    EditVolumePlazma.WriteText(StringGrid.GetValue(6 , StringGrid.CurrentRow));
    EditNumberDosesPlazma.WriteText(StringGrid.GetValue(7 , StringGrid.CurrentRow));
    for i:=0 to CBoxTypePlazma.GetItemsCount do
      if CBoxTypePlazma.GetItemsValue(i)=StringGrid.GetValue(8 , StringGrid.CurrentRow) then
      begin
        CBoxTypePlazma.WriteItemIndex(i);
        break;
      end;
    EditVolumeDefect.WriteText(StringGrid.GetValue(9 , StringGrid.CurrentRow));
    EditNumberDosesDefect.WriteText(StringGrid.GetValue(10 , StringGrid.CurrentRow));
    for i:=0 to CBoxTypeDefect.GetItemsCount do
      if CBoxTypeDefect.GetItemsValue(i)=StringGrid.GetValue(11, StringGrid.CurrentRow) then
      begin
        CBoxTypeDefect.WriteItemIndex(i);
        break;
      end;
  end;

  if ButtonEdit.GetCaption='Сохранить изменения' then
  begin
    try
    if MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      BlockMainMenu.BlockMainMenu(True, CurrentForm);
      ButtonBlock.ChangeEnabled(True);
      ButtonAdd.ChangeEnabled(True);
      ButtonDelete.ChangeEnabled(True);
      DateCal.Enabled(true);
      StringGrid.Enabled(True);
      if CheckingBeforeSaving then exit;
      ChangeRecord.ChangeRecordPlasma(DateCal.GetDate, EditNumberOfDonors.ReadText,
      EditSentToPreserving.ReadText, EditForLaboratoryResearch.ReadText,
      EditAllWholeBlood.ReadText, EditAllStoredBlood.ReadText);
      ChangeRecord.ChangeRecordPlasmaDoza(DateCal.GetDate, EditNumberOfDonors.ReadText);
      ChangeRecord.ChangeRecordPlasmaComponents(EditVolumePlazma.ReadText, EditNumberDosesPlazma.ReadText, CBoxTypePlazma.GetItemsValue(CBoxTypePlazma.GetItemIndex));
      ChangeRecord.ChangeRecordPlasmaDefect(EditVolumeDefect.ReadText, EditNumberDosesDefect.ReadText, CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
      AfterSaving_Cancelling;
      GetStringGrid(CurrentForm);
      ShowMessage('Запись успешно изменена!');
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end
    else
    begin
      ButtonEdit.ChangeCaption('Изменить');
      BlockMainMenu.BlockMainMenu(True, CurrentForm);
      ButtonBlock.ChangeEnabled(True);
      ButtonAdd.ChangeEnabled(True);
      ButtonDelete.ChangeEnabled(True);
      DateCal.Enabled(true);
      StringGrid.Enabled(True);
      AfterSaving_Cancelling;
      exit;
    end;
    except
    On e : EDatabaseError do
      messageDlg(e.message, mtError, [mbOK],0);
    end;
  end;
  if ButtonEdit.GetCaption='Изменить' then ButtonEdit.ChangeCaption('Сохранить изменения') else ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок
function TVHAAutomaticApheresis.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(670, 0, ButtonAdded, NameForm);
end;

function TVHAAutomaticApheresis.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(670, 0, ButtonBlocked, NameForm);
end;

function TVHAAutomaticApheresis.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(670, 0, ButtonDeleted, NameForm);
end;

function TVHAAutomaticApheresis.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(670, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker
function TVHAAutomaticApheresis.GetCalendarDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(DateCal) then
    DateCal:=TDTPickerTag5.Create;
  result:=DateCal.GetDTPicker(220, 70, Date(), NameForm);
  DateCal.Width(100);
  DateCal.FontSize(10);
end;

function TVHAAutomaticApheresis.CheckingBeforeSaving: boolean;
var
  value1, value2: integer;
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  EditNumberOfDonors.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDonors.ReadText));
  EditSentToPreserving.WriteText(CheckFillStrFields.CheckStringFields(EditSentToPreserving.ReadText));
  EditForLaboratoryResearch.WriteText(CheckFillStrFields.CheckStringFields(EditForLaboratoryResearch.ReadText));
  EditAllWholeBlood.WriteText(CheckFillStrFields.CheckStringFields(EditAllWholeBlood.ReadText));
  EditAllStoredBlood.WriteText(CheckFillStrFields.CheckStringFields(EditAllStoredBlood.ReadText));
  EditVolumePlazma.WriteText(CheckFillStrFields.CheckStringFields(EditVolumePlazma.ReadText));
  EditNumberDosesPlazma.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesPlazma.ReadText));
  EditVolumeDefect.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeDefect.ReadText));
  EditNumberDosesDefect.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesDefect.ReadText));
  if not Assigned(ValueChecksOnTheAdequacy) then
    ValueChecksOnTheAdequacy := TUMSValueChecksOnTheAdequacy.create;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditNumberOfDonors.ReadText, 'Количество доноров не может равняться нулю!') then
  begin
    result:=true;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditSentToPreserving.ReadText, 'Количество отправленной крови на консервирование не может равняться нулю!') then
  begin
    result:=true;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditForLaboratoryResearch.ReadText, 'Количество крови отправленной на лабораторные исследования не может равняться нулю!') then
  begin
    result:=true;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditAllWholeBlood.ReadText, 'Количество цельной крови не может равняться нулю!') then
  begin
    result:=true;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditAllStoredBlood.ReadText, 'Количество консервированной крови не может равняться нулю!') then
  begin
    result:=true;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckingEqualities(StrToInt(EditForLaboratoryResearch.ReadText), 20*StrToInt(EditNumberOfDonors.ReadText),
    'Количество крови на лабораторные исследования не соответствует количеству доноров!') then
  begin
    result:=true;
    exit;
  end;
  value1:=StrToInt(EditSentToPreserving.ReadText)+StrToInt(EditForLaboratoryResearch.ReadText);
  if ValueChecksOnTheAdequacy.CheckingEqualities(Value1, StrToInt(EditAllWholeBlood.ReadText),
    'Количество цельной крови не совпадает с суммой "Отправлено на консервирование" и "На лабораторные иследования"!') then
  begin
    result:=true;
    exit;
  end;
  result:=false;
end;

//шапка
function TVHAAutomaticApheresis.GetLabelDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDate) then
    LabelDate := TTempLabelTag5.create;
  result := LabelDate.GetTempLabel(30, 70, 14, 'Дата заготовки: ', NameForm);
end;

function TVHAAutomaticApheresis.GetLabelNumberOfDonors(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDonors) then
    LabelNumberOfDonors := TTempLabelTag5.create;
  result := LabelNumberOfDonors.GetTempLabel(30, 105, 14, 'Количество доноров: ', NameForm);
end;

function TVHAAutomaticApheresis.GetEditNumberOfDonors(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDonors) then
    EditNumberOfDonors := TEditTag5.create;
  Result:=EditNumberOfDonors.GetEdit(220, 105, 100, 12, False, NameForm);
  EditNumberOfDonors.NumberOnly(True);
end;

//таблица "кровь"
function TVHAAutomaticApheresis.GetLabelSentToPreserving(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelSentToPreserving) then
    LabelSentToPreserving := TTempLabelTag5.create;
  result := LabelSentToPreserving.GetTempLabel(100, 190, 12, 'Отправлено на консервирование, мл: ', NameForm);
  LabelSentToPreserving.WordWrap(true);
  LabelSentToPreserving.Width(150);
  LabelSentToPreserving.Height(40);
end;

function TVHAAutomaticApheresis.GetLabelForLaboratoryResearch(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelForLaboratoryResearch) then
    LabelForLaboratoryResearch := TTempLabelTag5.create;
  result := LabelForLaboratoryResearch.GetTempLabel(265, 190, 12, 'На лабораторные иследования, мл: ', NameForm);
  LabelForLaboratoryResearch.WordWrap(true);
  LabelForLaboratoryResearch.Width(120);
  LabelForLaboratoryResearch.Height(40);
end;

function TVHAAutomaticApheresis.GetLabelAllWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllWholeBlood) then
    LabelAllWholeBlood := TTempLabelTag5.create;
  result := LabelAllWholeBlood.GetTempLabel(400, 190, 12, 'Всего цельной крови, мл: ', NameForm);
  LabelAllWholeBlood.WordWrap(true);
  LabelAllWholeBlood.Width(100);
  LabelAllWholeBlood.Height(40);
end;

function TVHAAutomaticApheresis.GetLabelAllStoredBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllStoredBlood) then
    LabelAllStoredBlood := TTempLabelTag5.create;
  result := LabelAllStoredBlood.GetTempLabel(515, 190, 12, 'Всего конс-ной крови, мл: ', NameForm);
  LabelAllStoredBlood.WordWrap(true);
  LabelAllStoredBlood.Width(120);
  LabelAllStoredBlood.Height(40);
end;

function TVHAAutomaticApheresis.GetLabelBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelBlood) then
    LabelBlood := TTempLabelTag5.create;
  result := LabelBlood.GetTempLabel(30, 240, 12, 'Кровь: ', NameForm);
  LabelBlood.Width(120);
end;

function TVHAAutomaticApheresis.GetEditSentToPreserving(NameForm: TForm): TEdit;
begin
  if not Assigned(EditSentToPreserving) then
    EditSentToPreserving := TEditTag5.create;
  Result:=EditSentToPreserving.GetEdit(100, 240, 155, 10, False, NameForm);
  EditSentToPreserving.NumberOnly(True);
end;

function TVHAAutomaticApheresis.GetEditForLaboratoryResearch(
  NameForm: TForm): TEdit;
begin
  if not Assigned(EditForLaboratoryResearch) then
    EditForLaboratoryResearch := TEditTag5.create;
  Result:=EditForLaboratoryResearch.GetEdit(265, 240, 125, 10, False, NameForm);
  EditForLaboratoryResearch.NumberOnly(True);
end;

function TVHAAutomaticApheresis.GetEditAllWholeBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllWholeBlood) then
    EditAllWholeBlood := TEditTag5.create;
  Result:=EditAllWholeBlood.GetEdit(400, 240, 105, 10, False, NameForm);
  EditAllWholeBlood.NumberOnly(True);
end;

function TVHAAutomaticApheresis.GetEditAllStoredBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllStoredBlood) then
    EditAllStoredBlood := TEditTag5.create;
  Result:=EditAllStoredBlood.GetEdit(515, 240, 105, 10, False, NameForm);
  EditAllStoredBlood.NumberOnly(True);
end;

function TVHAAutomaticApheresis.GetPanelGorBlood(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGorBlood) then
    PanelGorBlood := TTempPanelTag5.create;
  Result:=PanelGorBlood.GetTempPanel(30, 232, 1, 590, 0, NameForm);
end;

function TVHAAutomaticApheresis.GetPanelVertBlood1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood1) then
    PanelVertBlood1 := TTempPanelTag5.create;
  Result:=PanelVertBlood1.GetTempPanel(95, 190, 75, 1, 0, NameForm);
end;

function TVHAAutomaticApheresis.GetPanelVertBlood2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood2) then
    PanelVertBlood2 := TTempPanelTag5.create;
  Result:=PanelVertBlood2.GetTempPanel(260, 190, 75, 1, 0, NameForm);
end;

function TVHAAutomaticApheresis.GetPanelVertBlood3(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood3) then
    PanelVertBlood3 := TTempPanelTag5.create;
  Result:=PanelVertBlood3.GetTempPanel(395, 190, 75, 1, 0, NameForm);
end;

function TVHAAutomaticApheresis.GetPanelVertBlood4(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood4) then
    PanelVertBlood4 := TTempPanelTag5.create;
  Result:=PanelVertBlood4.GetTempPanel(510, 190, 75, 1, 0, NameForm);
end;

//таблица компонентов
function TVHAAutomaticApheresis.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(210, 293, 12, 'Объем, мл: ', NameForm);
  LabelVolume.WordWrap(true);
  LabelVolume.Width(80);
end;

function TVHAAutomaticApheresis.GetLabelNumberDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberDoses) then
    LabelNumberDoses := TTempLabelTag5.create;
  result := LabelNumberDoses.GetTempLabel(310, 293, 12, 'Количество доз, шт: ', NameForm);
end;

function TVHAAutomaticApheresis.GetLabelType(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelType) then
    LabelType := TTempLabelTag5.create;
  result := LabelType.GetTempLabel(470, 293, 12, 'Вид продукци: ', NameForm);
end;

function TVHAAutomaticApheresis.GetLabelPlazma(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelPlazma) then
    LabelPlazma := TTempLabelTag5.create;
  result := LabelPlazma.GetTempLabel(30, 328, 14, 'Плазма: ', NameForm);
end;

function TVHAAutomaticApheresis.GetLabelDefectWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDefectWholeBlood) then
    LabelDefectWholeBlood := TTempLabelTag5.create;
  result := LabelDefectWholeBlood.GetTempLabel(30, 365, 14, 'Брак цельной крови: ', NameForm);
end;

function TVHAAutomaticApheresis.GetPanelGor1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor1Components1) then
    PanelGor1Components1 := TTempPanelTag5.create;
  Result:=PanelGor1Components1.GetTempPanel(30, 320, 1, 550, 0, NameForm);
end;

function TVHAAutomaticApheresis.GetPanelGor2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor2Components1) then
    PanelGor2Components1 := TTempPanelTag5.create;
  Result:=PanelGor2Components1.GetTempPanel(30, 358, 1, 550, 0, NameForm);
end;

function TVHAAutomaticApheresis.GetPanelVert1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert1Components1) then
    PanelVert1Components1 := TTempPanelTag5.create;
  Result:=PanelVert1Components1.GetTempPanel(205, 293, 110, 1, 0, NameForm);
end;

function TVHAAutomaticApheresis.GetPanelVert2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert2Components1) then
    PanelVert2Components1 := TTempPanelTag5.create;
  Result:=PanelVert2Components1.GetTempPanel(305, 293, 110, 1, 0, NameForm);
end;

function TVHAAutomaticApheresis.GetPanelVert3Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert3Components1) then
    PanelVert3Components1 := TTempPanelTag5.create;
  Result:=PanelVert3Components1.GetTempPanel(465, 293, 110, 1, 0, NameForm);
end;

function TVHAAutomaticApheresis.GetEditVolumePlazma(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumePlazma) then
    EditVolumePlazma := TEditTag5.create;
  Result:=EditVolumePlazma.GetEdit(210, 325, 90, 12, False, NameForm);
  EditVolumePlazma.NumberOnly(True);
end;

function TVHAAutomaticApheresis.GetEditVolumeDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeDefect) then
    EditVolumeDefect := TEditTag5.create;
  Result:=EditVolumeDefect.GetEdit(210, 363, 90, 12, False, NameForm);
  EditVolumeDefect.NumberOnly(True);
end;

function TVHAAutomaticApheresis.GetEditNumberDosesPlazma(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesPlazma) then
    EditNumberDosesPlazma := TEditTag5.create;
  Result:=EditNumberDosesPlazma.GetEdit(310, 325, 150, 12, False, NameForm);
  EditNumberDosesPlazma.NumberOnly(True);
end;

function TVHAAutomaticApheresis.GetEditNumberDosesDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesDefect) then
    EditNumberDosesDefect := TEditTag5.create;
  Result:=EditNumberDosesDefect.GetEdit(310, 363, 150, 12, False, NameForm);
  EditNumberDosesDefect.NumberOnly(True);
end;

function TVHAAutomaticApheresis.GetCBoxTypePlazma(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypePlazma) then
    CBoxTypePlazma := TComboboxTag5.create;
  result := CBoxTypePlazma.GetComboBox('CBoxTypePlazma', 470, 325, 110, 12, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts ' +
  'WHERE (((NameProducts.Visible)=True) AND ((NameProducts.TypeProduct)="Плазма") and ((NameProducts.AUTO)=true))';
  CBoxTypePlazma.TheContentOfTheList(SQL);
  CBoxTypePlazma.WriteItemIndex(0);
end;

function TVHAAutomaticApheresis.GetCBoxTypeDefect(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeDefect) then
    CBoxTypeDefect := TComboboxTag5.create;
  result := CBoxTypeDefect.GetComboBox('CBoxTypeDefect', 470, 363, 110, 12, NameForm);
  SQL:='SELECT TypeOfDefects.TypeDef ' +
  'FROM TypeOfDefects ' +
  'WHERE (TypeOfDefects.Other=True) or (TypeOfDefects.Null=True)';
  CBoxTypeDefect.TheContentOfTheList(SQL);
  CBoxTypeDefect.WriteItemIndex(-1);
  CBoxTypeDefect.GetDROPPEDWIDTH(200);
end;

//Label
function TVHAAutomaticApheresis.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(19, 'Ввод ежедневных данных по заготовке плазмы автоматическим аферезом', NameForm);
end;

// StringGrid
function TVHAAutomaticApheresis.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i:=0; j:=0;
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 1, DT_CENTER, 7, DT_CENTER, 9, DT_CENTER, 10, DT_CENTER, 11, DT_CENTER);
  Result:=StringGrid.GetStringGrid(30, 480, 840, 160, 12, 2, 9, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.Visible(true);
  StringGrid.ColWidth(0,60);
  StringGrid.ColWidth(1,70);
  StringGrid.ColWidth(2,60);
  StringGrid.ColWidth(3,70);
  StringGrid.ColWidth(4,80);
  StringGrid.ColWidth(5,80);
  StringGrid.ColWidth(6,65);
  StringGrid.ColWidth(7,80);
  StringGrid.ColWidth(8,90);
  StringGrid.ColWidth(9,90);
  StringGrid.ColWidth(10,95);
  StringGrid.ColWidth(11,90);
  StringGrid.WriteCells(0, 0, 'Дата');
  StringGrid.WriteCells(1, 0, 'Кол-во дон.');
  StringGrid.WriteCells(2, 0, 'На консерв.');
  StringGrid.WriteCells(3, 0, 'На лабор-е');
  StringGrid.WriteCells(4, 0, 'Всего цел. кр.');
  StringGrid.WriteCells(5, 0, 'Консерв-я кр.');
  StringGrid.WriteCells(6, 0, 'V плазмы');
  StringGrid.WriteCells(7, 0, 'Кол-во доз пл.');
  StringGrid.WriteCells(8, 0, 'Вид плазмы');
  StringGrid.WriteCells(9, 0, 'V брака цел. кр.');
  StringGrid.WriteCells(10, 0, 'Кол-во доз брака');
  StringGrid.WriteCells(11, 0, 'Вид брака');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TMHAAutomaticApheresis.create;
  ContentForStringGrid.GetContent;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetDate(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetNumberOfDonors(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetSentToPreserving(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetForLaboratoryResearch(j));
        StringGrid.WriteCells(4, i+1, ContentForStringGrid.GetAllWholeBlood(j));
        StringGrid.WriteCells(5, i+1, ContentForStringGrid.GetAllStoredBlood(j));
        StringGrid.WriteCells(6, i+1, ContentForStringGrid.GetVolomePlazma(j));
        StringGrid.WriteCells(7, i+1, ContentForStringGrid.GetNumberOfDosesPlazma(j));
        StringGrid.WriteCells(8, i+1, ContentForStringGrid.GetTypePlazma(j));
        StringGrid.WriteCells(9, i+1, ContentForStringGrid.GetVolomeDefect(j));
        StringGrid.WriteCells(10, i+1, ContentForStringGrid.GetNumberOfDosesDefect(j));
        StringGrid.WriteCells(11, i+1, ContentForStringGrid.GetTypeDefect(j));
        j:=j+1;
      end;
end;
end.
