unit VHSSitoferez;

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
  MHSSitoferez,
  MHSAddRecordSitoferez,
  MHSDeleteRecordSitoferez,
  MHSChangeRecordSitoferez,
  UMSCheckForExistenceOfRecord,
  UMSValueChecksOnTheAdequacy,

  MIOAddRecord,
  MIODeleteRecord,
  MIOChangeRecord,
  UMSGlobalVariant;

type
  IVHSSitoferez = interface
  end;

  TVHSSitoferez = class(TGlobalVariant)
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
    LabelNumberOfPacets: TTempLabelTag5;
    LabelNumberDoses: TTempLabelTag5;
    LabelType: TTempLabelTag5;
    LabelTrombo: TTempLabelTag5;
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
    PanelVert4Components1: TTempPanelTag5;

    //шапка
    DateCal: TDTPickerTag5;
    EditNumberOfDonors: TEditTag5;
    //таблица "кровь"
    EditSentToPreserving: TEditTag5;
    EditForLaboratoryResearch: TEditTag5;
    EditAllWholeBlood: TEditTag5;
    EditAllStoredBlood: TEditTag5;
    //таблица "компоненты"
    EditVolumeTrombo: TEditTag5;
    EditVolumeDefect: TEditTag5;
    EditNumberOfPacketsTrombo: TEditTag5;
    EditNumberOfPacketsDefect: TEditTag5;
    EditNumberDosesTrombo: TEditTag5;
    EditNumberDosesDefect: TEditTag5;

    CBoxTypeDefect: TComboboxTag5;
    CBoxTypeTrombo: TComboboxTag5;


    StringGrid: TStringGridTag5;
    ContentForStringGrid: IMHSSitoferez;
    AddRecord: IMHSAddRecordSitoferez;
    DeleteRecord: IMHSDeleteRecordSitoferez;
    ChangeRecord: IMHSChangeRecordSitoferez;

    ValueChecksOnTheAdequacy: IUMSValueChecksOnTheAdequacy;
    CheckFillStrFields: ICheckFillStringFields;
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
    function GetLabelNumberOfPacets(NameForm: TForm): TLabel;
    function GetLabelNumberDoses(NameForm: TForm): TLabel;
    function GetLabelType(NameForm: TForm): TLabel;
    function GetLabelTrombo(NameForm: TForm): TLabel;
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
    function GetPanelVert4Components1(NameForm: TForm): TPanel;

    function GetEditNumberOfDonors(NameForm: TForm): TEdit;
    function GetEditSentToPreserving(NameForm: TForm): TEdit;
    function GetEditForLaboratoryResearch(NameForm: TForm): TEdit;
    function GetEditAllWholeBlood(NameForm: TForm): TEdit;
    function GetEditAllStoredBlood(NameForm: TForm): TEdit;
    function GetEditVolumeTrombo(NameForm: TForm): TEdit;
    function GetEditVolumeDefect(NameForm: TForm): TEdit;
    function GetEditNumberOfPacetsTrombo(NameForm: TForm): TEdit;
    function GetEditNumberOfPacetsDefect(NameForm: TForm): TEdit;
    function GetEditNumberDosesTrombo(NameForm: TForm): TEdit;
    function GetEditNumberDosesDefect(NameForm: TForm): TEdit;

    function GetCBoxTypeDefect(NameForm: TForm): TComboBox;
    function GetCBoxTypeTrombo(NameForm: TForm): TComboBox;

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

constructor TVHSSitoferez.create(form: TForm);
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
  GetLabelNumberOfPacets(form);
  GetLabelNumberDoses(form);
  GetLabelType(form);
  GetLabelTrombo(form);
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
  GetPanelVert4Components1(form);
  GetPanelGor1Components1(form);
  GetPanelGor2Components1(form);

  GetEditNumberOfDonors(form);
  GetEditSentToPreserving(form);
  GetEditForLaboratoryResearch(form);
  GetEditAllWholeBlood(form);
  GetEditAllStoredBlood(form);
  GetEditVolumeTrombo(form);
  GetEditVolumeDefect(form);
  GetEditNumberOfPacetsTrombo(form);
  GetEditNumberOfPacetsDefect(form);
  GetEditNumberDosesTrombo(form);
  GetEditNumberDosesDefect(form);

  GetStringGrid(form);
  GetCalendarDateCal(form);

  GetCBoxTypeDefect(form);
  GetCBoxTypeTrombo(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  inherited;
end;

destructor TVHSSitoferez.destroy;
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
  LabelNumberOfPacets.destroy;
  LabelNumberDoses.destroy;
  LabelType.destroy;
  LabelTrombo.destroy;
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
  PanelVert4Components1.destroy;
  //шапка
  EditNumberOfDonors.destroy;

  //таблица "кровь"
  EditSentToPreserving.destroy;
  EditForLaboratoryResearch.destroy;
  EditAllWholeBlood.destroy;
  EditAllStoredBlood.destroy;
  //таблица "компоненты 1"
  EditVolumeTrombo.destroy;
  EditVolumeDefect.destroy;
  EditNumberOfPacketsTrombo.destroy;
  EditNumberOfPacketsDefect.destroy;
  EditNumberDosesTrombo.destroy;
  EditNumberDosesDefect.destroy;

  CBoxTypeDefect.destroy;
  CBoxTypeTrombo.destroy;

  StringGrid.destroy;

  DateCal.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;
  inherited;
end;

//Button

procedure TVHSSitoferez.AfterSaving_Cancelling;
var
  i: integer;
begin
  DateCal.WriteDateTime(date());
  EditNumberOfDonors.WriteText('0');
  EditSentToPreserving.WriteText('0');
  EditForLaboratoryResearch.WriteText('0');
  EditAllWholeBlood.WriteText('0');
  EditAllStoredBlood.WriteText('0');
  EditVolumeTrombo.WriteText('0');
  EditNumberOfPacketsTrombo.WriteText('0');
  EditNumberDosesTrombo.WriteText('0');
  EditVolumeDefect.WriteText('0');
  EditNumberOfPacketsDefect.WriteText('0');
  EditNumberDosesDefect.WriteText('0');
  CBoxTypeTrombo.WriteItemIndex(0);
  CBoxTypeDefect.WriteItemIndex(-1);
end;

// Добавление новой записи

procedure TVHSSitoferez.ButtonAdded(Sender: TObject);
begin
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(CheckForExistenceOfRecord) then
      CheckForExistenceOfRecord := TUMSCheckForExistenceOfRecord.create;
    SQL:='SELECT ДатаТ ' +
      'FROM Tromb ' +
      'WHERE Tromb.ДатаТ=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(DateCal.GetDate)) + '# ';
    if CheckForExistenceOfRecord.CheckForExistenceOfRecord(SQL) then exit;
    if CheckingBeforeSaving then exit;
    if not Assigned(AddRecord) then
      AddRecord := TMHSAddRecordSitoferez.create;
    AddRecord.AddRecordTrombo(DateCal.GetDate, EditNumberOfDonors.ReadText,
      EditSentToPreserving.ReadText, EditForLaboratoryResearch.ReadText,
      EditAllWholeBlood.ReadText, EditAllStoredBlood.ReadText);
    AddRecord.AddRecordTromboDoza(DateCal.GetDate, EditNumberOfDonors.ReadText);
    AddRecord.AddRecordTromboComponents(EditVolumeTrombo.ReadText, EditNumberOfPacketsTrombo.ReadText, EditNumberDosesTrombo.ReadText, CBoxTypeTrombo.GetItemsValue(CBoxTypeTrombo.GetItemIndex));
    AddRecord.AddRecordTromboDefect(EditVolumeDefect.ReadText, EditNumberOfPacketsDefect.ReadText, EditNumberDosesDefect.ReadText, CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
    GetStringGrid(CurrentForm);
    ShowMessage('Записи успешно добавлена!');
    AfterSaving_Cancelling;
  end;
end;

// Разблокировка кнопок

procedure TVHSSitoferez.ButtonBlocked(Sender: TObject);
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

procedure TVHSSitoferez.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись от ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + ' числа?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TMHSDeleteRecordSitoferez.create;
    DeleteRecord.DeleteRecord(StringGrid.GetValue(0, StringGrid.CurrentRow));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount-1);
    ShowMessage('Запись успешно удалена!');
  end;
  AfterSaving_Cancelling;
end;

// Внесение изменений
procedure TVHSSitoferez.ButtonEdited(Sender: TObject);
var
 i: integer;
begin
  if not Assigned(ChangeRecord) then
    ChangeRecord := TMHSChangeRecordSitoferez.create;
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
    EditVolumeTrombo.WriteText(StringGrid.GetValue(6 , StringGrid.CurrentRow));
    EditNumberOfPacketsTrombo.WriteText(StringGrid.GetValue(7 , StringGrid.CurrentRow));
    EditNumberDosesTrombo.WriteText(StringGrid.GetValue(8 , StringGrid.CurrentRow));
    for i:=0 to CBoxTypeTrombo.GetItemsCount do
      if CBoxTypeTrombo.GetItemsValue(i)=StringGrid.GetValue(9 , StringGrid.CurrentRow) then
      begin
        CBoxTypeTrombo.WriteItemIndex(i);
        break;
      end;
    EditVolumeDefect.WriteText(StringGrid.GetValue(10 , StringGrid.CurrentRow));
    EditNumberOfPacketsDefect.WriteText(StringGrid.GetValue(11 , StringGrid.CurrentRow));
    EditNumberDosesDefect.WriteText(StringGrid.GetValue(12 , StringGrid.CurrentRow));
    for i:=0 to CBoxTypeDefect.GetItemsCount do
      if CBoxTypeDefect.GetItemsValue(i)=StringGrid.GetValue(13, StringGrid.CurrentRow) then
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
      ChangeRecord.ChangeRecordTrombo(DateCal.GetDate, EditNumberOfDonors.ReadText,
      EditSentToPreserving.ReadText, EditForLaboratoryResearch.ReadText,
      EditAllWholeBlood.ReadText, EditAllStoredBlood.ReadText);
      ChangeRecord.ChangeRecordTromboDoza(DateCal.GetDate, EditNumberOfDonors.ReadText);
      ChangeRecord.ChangeRecordTromboComponents(EditVolumeTrombo.ReadText, EditNumberOfPacketsTrombo.ReadText, EditNumberDosesTrombo.ReadText, CBoxTypeTrombo.GetItemsValue(CBoxTypeTrombo.GetItemIndex));
      ChangeRecord.ChangeRecordTromboDefect(EditVolumeDefect.ReadText,EditNumberOfPacketsDefect.ReadText, EditNumberDosesDefect.ReadText, CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
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
function TVHSSitoferez.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(670, 0, ButtonAdded, NameForm);
end;

function TVHSSitoferez.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(670, 0, ButtonBlocked, NameForm);
end;

function TVHSSitoferez.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(670, 0, ButtonDeleted, NameForm);
end;

function TVHSSitoferez.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(670, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker
function TVHSSitoferez.GetCalendarDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(DateCal) then
    DateCal:=TDTPickerTag5.Create;
  result:=DateCal.GetDTPicker(220, 70, Date(), NameForm);
  DateCal.Width(100);
  DateCal.FontSize(10);
end;

function TVHSSitoferez.CheckingBeforeSaving: boolean;
var
  value1: integer;
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  EditNumberOfDonors.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDonors.ReadText));
  EditSentToPreserving.WriteText(CheckFillStrFields.CheckStringFields(EditSentToPreserving.ReadText));
  EditForLaboratoryResearch.WriteText(CheckFillStrFields.CheckStringFields(EditForLaboratoryResearch.ReadText));
  EditAllWholeBlood.WriteText(CheckFillStrFields.CheckStringFields(EditAllWholeBlood.ReadText));
  EditAllStoredBlood.WriteText(CheckFillStrFields.CheckStringFields(EditAllStoredBlood.ReadText));
  EditVolumeTrombo.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeTrombo.ReadText));
  EditNumberOfPacketsTrombo.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesTrombo.ReadText));
  EditNumberDosesTrombo.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesTrombo.ReadText));
  EditVolumeDefect.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeDefect.ReadText));
  EditNumberOfPacketsDefect.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesTrombo.ReadText));
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
function TVHSSitoferez.GetLabelDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDate) then
    LabelDate := TTempLabelTag5.create;
  result := LabelDate.GetTempLabel(30, 70, 14, 'Дата заготовки: ', NameForm);
end;

function TVHSSitoferez.GetLabelNumberOfDonors(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDonors) then
    LabelNumberOfDonors := TTempLabelTag5.create;
  result := LabelNumberOfDonors.GetTempLabel(30, 105, 14, 'Количество доноров: ', NameForm);
end;

function TVHSSitoferez.GetEditNumberOfDonors(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDonors) then
    EditNumberOfDonors := TEditTag5.create;
  Result:=EditNumberOfDonors.GetEdit(220, 105, 100, 12, False, NameForm);
  EditNumberOfDonors.NumberOnly(True);
end;

//таблица "кровь"
function TVHSSitoferez.GetLabelSentToPreserving(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelSentToPreserving) then
    LabelSentToPreserving := TTempLabelTag5.create;
  result := LabelSentToPreserving.GetTempLabel(100, 190, 12, 'Отправлено на консервирование, мл: ', NameForm);
  LabelSentToPreserving.WordWrap(true);
  LabelSentToPreserving.Width(150);
  LabelSentToPreserving.Height(40);
end;

function TVHSSitoferez.GetLabelForLaboratoryResearch(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelForLaboratoryResearch) then
    LabelForLaboratoryResearch := TTempLabelTag5.create;
  result := LabelForLaboratoryResearch.GetTempLabel(265, 190, 12, 'На лабораторные иследования, мл: ', NameForm);
  LabelForLaboratoryResearch.WordWrap(true);
  LabelForLaboratoryResearch.Width(120);
  LabelForLaboratoryResearch.Height(40);
end;

function TVHSSitoferez.GetLabelAllWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllWholeBlood) then
    LabelAllWholeBlood := TTempLabelTag5.create;
  result := LabelAllWholeBlood.GetTempLabel(400, 190, 12, 'Всего цельной крови, мл: ', NameForm);
  LabelAllWholeBlood.WordWrap(true);
  LabelAllWholeBlood.Width(100);
  LabelAllWholeBlood.Height(40);
end;

function TVHSSitoferez.GetLabelAllStoredBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllStoredBlood) then
    LabelAllStoredBlood := TTempLabelTag5.create;
  result := LabelAllStoredBlood.GetTempLabel(515, 190, 12, 'Всего конс-ной крови, мл: ', NameForm);
  LabelAllStoredBlood.WordWrap(true);
  LabelAllStoredBlood.Width(120);
  LabelAllStoredBlood.Height(40);
end;

function TVHSSitoferez.GetLabelBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelBlood) then
    LabelBlood := TTempLabelTag5.create;
  result := LabelBlood.GetTempLabel(30, 240, 12, 'Кровь: ', NameForm);
  LabelBlood.Width(120);
end;

function TVHSSitoferez.GetEditSentToPreserving(NameForm: TForm): TEdit;
begin
  if not Assigned(EditSentToPreserving) then
    EditSentToPreserving := TEditTag5.create;
  Result:=EditSentToPreserving.GetEdit(100, 240, 155, 10, False, NameForm);
  EditSentToPreserving.NumberOnly(True);
end;

function TVHSSitoferez.GetEditForLaboratoryResearch(
  NameForm: TForm): TEdit;
begin
  if not Assigned(EditForLaboratoryResearch) then
    EditForLaboratoryResearch := TEditTag5.create;
  Result:=EditForLaboratoryResearch.GetEdit(265, 240, 125, 10, False, NameForm);
  EditForLaboratoryResearch.NumberOnly(True);
end;

function TVHSSitoferez.GetEditAllWholeBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllWholeBlood) then
    EditAllWholeBlood := TEditTag5.create;
  Result:=EditAllWholeBlood.GetEdit(400, 240, 105, 10, False, NameForm);
  EditAllWholeBlood.NumberOnly(True);
end;

function TVHSSitoferez.GetEditAllStoredBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllStoredBlood) then
    EditAllStoredBlood := TEditTag5.create;
  Result:=EditAllStoredBlood.GetEdit(515, 240, 105, 10, False, NameForm);
  EditAllStoredBlood.NumberOnly(True);
end;

function TVHSSitoferez.GetPanelGorBlood(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGorBlood) then
    PanelGorBlood := TTempPanelTag5.create;
  Result:=PanelGorBlood.GetTempPanel(30, 232, 1, 590, 0, NameForm);
end;

function TVHSSitoferez.GetPanelVertBlood1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood1) then
    PanelVertBlood1 := TTempPanelTag5.create;
  Result:=PanelVertBlood1.GetTempPanel(95, 190, 75, 1, 0, NameForm);
end;

function TVHSSitoferez.GetPanelVertBlood2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood2) then
    PanelVertBlood2 := TTempPanelTag5.create;
  Result:=PanelVertBlood2.GetTempPanel(260, 190, 75, 1, 0, NameForm);
end;

function TVHSSitoferez.GetPanelVertBlood3(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood3) then
    PanelVertBlood3 := TTempPanelTag5.create;
  Result:=PanelVertBlood3.GetTempPanel(395, 190, 75, 1, 0, NameForm);
end;

function TVHSSitoferez.GetPanelVertBlood4(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood4) then
    PanelVertBlood4 := TTempPanelTag5.create;
  Result:=PanelVertBlood4.GetTempPanel(510, 190, 75, 1, 0, NameForm);
end;

//таблица компонентов
function TVHSSitoferez.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(210, 293, 12, 'Объем, мл: ', NameForm);
  LabelVolume.WordWrap(true);
  LabelVolume.Width(80);
end;

function TVHSSitoferez.GetLabelNumberOfPacets(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfPacets) then
    LabelNumberOfPacets := TTempLabelTag5.create;
  result := LabelNumberOfPacets.GetTempLabel(310, 293, 12, 'Кол-во пакетов, шт: ', NameForm);
end;

function TVHSSitoferez.GetLabelNumberDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberDoses) then
    LabelNumberDoses := TTempLabelTag5.create;
  result := LabelNumberDoses.GetTempLabel(470, 293, 12, 'Кол-во доз, шт: ', NameForm);
end;

function TVHSSitoferez.GetLabelType(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelType) then
    LabelType := TTempLabelTag5.create;
  result := LabelType.GetTempLabel(600, 293, 12, 'Вид продукци: ', NameForm);
end;

function TVHSSitoferez.GetLabelTrombo(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTrombo) then
    LabelTrombo := TTempLabelTag5.create;
  result := LabelTrombo.GetTempLabel(30, 328, 14, 'Тромбоконцентрат: ', NameForm);
end;

function TVHSSitoferez.GetLabelDefectWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDefectWholeBlood) then
    LabelDefectWholeBlood := TTempLabelTag5.create;
  result := LabelDefectWholeBlood.GetTempLabel(30, 365, 14, 'Брак цельной крови: ', NameForm);
end;

function TVHSSitoferez.GetPanelGor1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor1Components1) then
    PanelGor1Components1 := TTempPanelTag5.create;
  Result:=PanelGor1Components1.GetTempPanel(30, 320, 1, 730, 0, NameForm);
end;

function TVHSSitoferez.GetPanelGor2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor2Components1) then
    PanelGor2Components1 := TTempPanelTag5.create;
  Result:=PanelGor2Components1.GetTempPanel(30, 358, 1, 730, 0, NameForm);
end;

function TVHSSitoferez.GetPanelVert1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert1Components1) then
    PanelVert1Components1 := TTempPanelTag5.create;
  Result:=PanelVert1Components1.GetTempPanel(205, 293, 110, 1, 0, NameForm);
end;

function TVHSSitoferez.GetPanelVert2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert2Components1) then
    PanelVert2Components1 := TTempPanelTag5.create;
  Result:=PanelVert2Components1.GetTempPanel(305, 293, 110, 1, 0, NameForm);
end;

function TVHSSitoferez.GetPanelVert3Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert3Components1) then
    PanelVert3Components1 := TTempPanelTag5.create;
  Result:=PanelVert3Components1.GetTempPanel(465, 293, 110, 1, 0, NameForm);
end;

function TVHSSitoferez.GetPanelVert4Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert4Components1) then
    PanelVert4Components1 := TTempPanelTag5.create;
  Result:=PanelVert4Components1.GetTempPanel(595, 293, 110, 1, 0, NameForm);
end;

function TVHSSitoferez.GetEditVolumeTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeTrombo) then
    EditVolumeTrombo := TEditTag5.create;
  Result:=EditVolumeTrombo.GetEdit(210, 325, 90, 12, False, NameForm);
  EditVolumeTrombo.NumberOnly(True);
end;

function TVHSSitoferez.GetEditVolumeDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeDefect) then
    EditVolumeDefect := TEditTag5.create;
  Result:=EditVolumeDefect.GetEdit(210, 363, 90, 12, False, NameForm);
  EditVolumeDefect.NumberOnly(True);
end;

function TVHSSitoferez.GetEditNumberOfPacetsTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfPacketsTrombo) then
    EditNumberOfPacketsTrombo := TEditTag5.create;
  Result:=EditNumberOfPacketsTrombo.GetEdit(310, 325, 150, 12, False, NameForm);
  EditNumberOfPacketsTrombo.NumberOnly(True);
end;

function TVHSSitoferez.GetEditNumberOfPacetsDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfPacketsDefect) then
    EditNumberOfPacketsDefect := TEditTag5.create;
  Result:=EditNumberOfPacketsDefect.GetEdit(310, 363, 150, 12, False, NameForm);
  EditNumberOfPacketsDefect.NumberOnly(True);
end;

function TVHSSitoferez.GetEditNumberDosesTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesTrombo) then
    EditNumberDosesTrombo := TEditTag5.create;
  Result:=EditNumberDosesTrombo.GetEdit(470, 325, 120, 12, False, NameForm);
  EditNumberDosesTrombo.NumberOnly(True);
end;

function TVHSSitoferez.GetEditNumberDosesDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesDefect) then
    EditNumberDosesDefect := TEditTag5.create;
  Result:=EditNumberDosesDefect.GetEdit(470, 363, 120, 12, False, NameForm);
  EditNumberDosesDefect.NumberOnly(True);
end;

function TVHSSitoferez.GetCBoxTypeTrombo(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeTrombo) then
    CBoxTypeTrombo := TComboboxTag5.create;
  result := CBoxTypeTrombo.GetComboBox('', 600, 325, 160, 12, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts ' +
  'WHERE (((NameProducts.Visible)=True) AND ((NameProducts.TypeProduct)="Тромбоциты") and ((NameProducts.Production)=true))';
  CBoxTypeTrombo.TheContentOfTheList(SQL);
  CBoxTypeTrombo.WriteItemIndex(0);
end;

function TVHSSitoferez.GetCBoxTypeDefect(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeDefect) then
    CBoxTypeDefect := TComboboxTag5.create;
  result := CBoxTypeDefect.GetComboBox('', 600, 363, 160, 12, NameForm);
  SQL:='SELECT TypeOfDefects.TypeDef ' +
  'FROM TypeOfDefects ' +
  'WHERE (TypeOfDefects.Other=True)';
  CBoxTypeDefect.TheContentOfTheList(SQL);
  CBoxTypeDefect.WriteItemIndex(-1);
end;

//Label
function TVHSSitoferez.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(22, 'Ввод ежедневных данных по заготовке тромбоконцентрата', NameForm);
end;

// StringGrid
function TVHSSitoferez.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i:=0; j:=0;
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 1, DT_CENTER, 15, DT_CENTER, 9, DT_CENTER, 10, DT_CENTER, 16, DT_CENTER);
  Result:=StringGrid.GetStringGrid(30, 480, 840, 160, 14, 2, 9, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.Visible(true);
  StringGrid.ColWidth(0,60);
  StringGrid.ColWidth(1,70);
  StringGrid.ColWidth(2,65);
  StringGrid.ColWidth(3,70);
  StringGrid.ColWidth(4,80);
  StringGrid.ColWidth(5,80);
  StringGrid.ColWidth(6,70);
  StringGrid.ColWidth(7,80);
  StringGrid.ColWidth(8,70);
  StringGrid.ColWidth(9,110);
  StringGrid.ColWidth(10,90);
  StringGrid.ColWidth(11,90);
  StringGrid.ColWidth(12,85);
  StringGrid.ColWidth(13,80);
  StringGrid.WriteCells(0, 0, 'Дата');
  StringGrid.WriteCells(1, 0, 'Кол-во дон.');
  StringGrid.WriteCells(2, 0, 'На консерв.');
  StringGrid.WriteCells(3, 0, 'На лабор-е');
  StringGrid.WriteCells(4, 0, 'Всего цел. кр.');
  StringGrid.WriteCells(5, 0, 'Консерв-я кр.');
  StringGrid.WriteCells(6, 0, 'V тромбо-та');
  StringGrid.WriteCells(7, 0, 'Кол-во пакетов');
  StringGrid.WriteCells(8, 0, 'Кол-во доз');
  StringGrid.WriteCells(9, 0, 'Вид продукции');
  StringGrid.WriteCells(10, 0, 'V брака цел. кр.');
  StringGrid.WriteCells(11, 0, 'Кол-во пакетов');
  StringGrid.WriteCells(12, 0, 'Кол-во доз');
  StringGrid.WriteCells(13, 0, 'Вид брака');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TMHSSitoferez.create;
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
        StringGrid.WriteCells(6, i+1, ContentForStringGrid.GetVolomeTrombo(j));
        StringGrid.WriteCells(7, i+1, ContentForStringGrid.GetNumberOfPacketsTrombo(j));
        StringGrid.WriteCells(8, i+1, ContentForStringGrid.GetNumberOfDosesTrombo(j));
        StringGrid.WriteCells(9, i+1, ContentForStringGrid.GetTypeTrombo(j));
        StringGrid.WriteCells(10, i+1, ContentForStringGrid.GetVolomeDefect(j));
        StringGrid.WriteCells(11, i+1, ContentForStringGrid.GetNumberOfPacketsDefect(j));
        StringGrid.WriteCells(12, i+1, ContentForStringGrid.GetNumberOfDosesDefect(j));
        StringGrid.WriteCells(13, i+1, ContentForStringGrid.GetTypeDefect(j));
        j:=j+1;
      end;
end;
end.
