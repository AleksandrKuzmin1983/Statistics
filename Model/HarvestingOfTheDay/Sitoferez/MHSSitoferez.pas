unit MHSSitoferez;

interface

uses
  Vcl.ExtCtrls, WinProcs, SysUtils, CodeSiteLogging, StdCtrls, Buttons, Vcl.Grids, Data.DB,
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
  MFPanel,
  BHSSitoferez,
  BHSAddRecordSitoferez,
  BHSDeleteRecordSitoferez,
  BHSChangeRecordSitoferez,
  USCheckForExistenceOfRecord,
  USValueChecksOnTheAdequacy,

  BIOAddRecord,
  BIODeleteRecord,
  BIOChangeRecord,
  USGlobalVariant;

type

  TMHSSitoferez = class(TUSGlobalVariant)
  private
    // шапка
    LabelDate: TMFLabel;
    LabelNumberOfDonors: TMFLabel;
    // кровь
    LabelSentToPreserving: TMFLabel;
    LabelForLaboratoryResearch: TMFLabel;
    LabelAllWholeBlood: TMFLabel;
    LabelAllStoredBlood: TMFLabel;
    LabelBlood: TMFLabel;

    LabelVolume: TMFLabel;
    LabelNumberOfPacets: TMFLabel;
    LabelNumberDoses: TMFLabel;
    LabelType: TMFLabel;
    LabelTrombo: TMFLabel;
    LabelDefectWholeBlood: TMFLabel;

    Title: TMFTitleLabel;
    SQL: String;

    // таблица "кровь"
    PanelGorBlood: TMFPanel;
    PanelVertBlood1: TMFPanel;
    PanelVertBlood2: TMFPanel;
    PanelVertBlood3: TMFPanel;
    PanelVertBlood4: TMFPanel;
    // таблица "компоненты"
    PanelGor1Components1: TMFPanel;
    PanelGor2Components1: TMFPanel;
    PanelVert1Components1: TMFPanel;
    PanelVert2Components1: TMFPanel;
    PanelVert3Components1: TMFPanel;
    PanelVert4Components1: TMFPanel;

    // шапка
    DateCal: TMFDateTimePicker;
    EditNumberOfDonors: TMFEdit;
    // таблица "кровь"
    EditSentToPreserving: TMFEdit;
    EditForLaboratoryResearch: TMFEdit;
    EditAllWholeBlood: TMFEdit;
    EditAllStoredBlood: TMFEdit;
    // таблица "компоненты"
    EditVolumeTrombo: TMFEdit;
    EditVolumeDefect: TMFEdit;
    EditNumberOfPacketsTrombo: TMFEdit;
    EditNumberOfPacketsDefect: TMFEdit;
    EditNumberDosesTrombo: TMFEdit;
    EditNumberDosesDefect: TMFEdit;

    CBoxTypeDefect: TMFComboBox;
    CBoxTypeTrombo: TMFComboBox;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBHSSitoferez;
    AddRecord: IBHSAddRecordSitoferez;
    DeleteRecord: IBHSDeleteRecordSitoferez;
    ChangeRecord: IBHSChangeRecordSitoferez;

    ValueChecksOnTheAdequacy: IUSValueChecksOnTheAdequacy;
    CheckFillStrFields: IUSCheckFillStringFields;
    BlockMainMenu: IUSBlockMainMenu;

    ButtonAdd: TMFBitBtnAdd;
    ButtonDelete: TMFBitBtnDelete;
    ButtonEdit: TMFBitBtnEdit;
    ButtonBlock: TMFBitBtnBlock;

    CheckForExistenceOfRecord: IUSCheckForExistenceOfRecord;
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
    procedure Show;
  public
    constructor create(form: TForm); override;
    destructor destroy; override;
  end;

implementation

{ TBloodProduct }

constructor TMHSSitoferez.create(form: TForm);
begin
  CurrentForm := form;

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
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
  inherited;
end;

destructor TMHSSitoferez.destroy;
begin
  LabelDate.destroy;
  LabelNumberOfDonors.destroy;
  // кровь
  LabelSentToPreserving.destroy;
  LabelForLaboratoryResearch.destroy;
  LabelAllWholeBlood.destroy;
  LabelAllStoredBlood.destroy;
  LabelBlood.destroy;
  // компоненты 1
  LabelVolume.destroy;
  LabelNumberOfPacets.destroy;
  LabelNumberDoses.destroy;
  LabelType.destroy;
  LabelTrombo.destroy;
  LabelDefectWholeBlood.destroy;

  Title.destroy;

  // таблица "кровь"
  PanelGorBlood.destroy;
  PanelVertBlood1.destroy;
  PanelVertBlood2.destroy;
  PanelVertBlood3.destroy;
  PanelVertBlood4.destroy;
  // таблица "компоненты 1"
  PanelGor1Components1.destroy;
  PanelGor2Components1.destroy;
  PanelVert1Components1.destroy;
  PanelVert2Components1.destroy;
  PanelVert3Components1.destroy;
  PanelVert4Components1.destroy;
  // шапка
  EditNumberOfDonors.destroy;

  // таблица "кровь"
  EditSentToPreserving.destroy;
  EditForLaboratoryResearch.destroy;
  EditAllWholeBlood.destroy;
  EditAllStoredBlood.destroy;
  // таблица "компоненты 1"
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
  inherited;
end;

// Button

procedure TMHSSitoferez.AfterSaving_Cancelling;
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// Добавление новой записи

procedure TMHSSitoferez.ButtonAdded(Sender: TObject);
begin
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(CheckForExistenceOfRecord) then
      CheckForExistenceOfRecord := TUSCheckForExistenceOfRecord.create;
    SQL := 'SELECT ДатаТ ' + 'FROM Tromb ' + 'WHERE Tromb.ДатаТ=#' +
      FormatDateTime('mm''/''dd''/''yyyy', dateOf(DateCal.GetDate)) + '# ';
    if CheckForExistenceOfRecord.CheckForExistenceOfRecord(SQL) then
      exit;
    if CheckingBeforeSaving then
      exit;
    if not Assigned(AddRecord) then
      AddRecord := TBHSAddRecordSitoferez.create;
    AddRecord.AddRecordTrombo(DateCal.GetDate, EditNumberOfDonors.ReadText,
      EditSentToPreserving.ReadText, EditForLaboratoryResearch.ReadText,
      EditAllWholeBlood.ReadText, EditAllStoredBlood.ReadText);
    AddRecord.AddRecordTromboDoza(DateCal.GetDate, EditNumberOfDonors.ReadText);
    AddRecord.AddRecordTromboComponents(EditVolumeTrombo.ReadText,
      EditNumberOfPacketsTrombo.ReadText, EditNumberDosesTrombo.ReadText,
      CBoxTypeTrombo.GetItemsValue(CBoxTypeTrombo.GetItemIndex));
    AddRecord.AddRecordTromboDefect(EditVolumeDefect.ReadText,
      EditNumberOfPacketsDefect.ReadText, EditNumberDosesDefect.ReadText,
      CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    ShowMessage('Записи успешно добавлена!');
    AfterSaving_Cancelling;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// Разблокировка кнопок

procedure TMHSSitoferez.ButtonBlocked(Sender: TObject);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// Кнопка удаления

procedure TMHSSitoferez.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись от ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + ' числа?', mtConfirmation, [mbYes, mbNo], 0) = 6
  then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBHSDeleteRecordSitoferez.create;
    DeleteRecord.DeleteRecord(StringGrid.GetValue(0, StringGrid.CurrentRow));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    StringGrid.Visible(True);
    ShowMessage('Запись успешно удалена!');
  end;
  AfterSaving_Cancelling;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// Внесение изменений
procedure TMHSSitoferez.ButtonEdited(Sender: TObject);
var
  i: integer;
begin
  if not Assigned(ChangeRecord) then
    ChangeRecord := TBHSChangeRecordSitoferez.create;
  ChangeRecord.GetTempId(FormatDateTime('mm''/''dd''/''yyyy',
    StrToDateTime(StringGrid.GetValue(0, StringGrid.CurrentRow))));

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
    DateCal.WriteDateTime(StrToDate(StringGrid.GetValue(0,
      StringGrid.CurrentRow)));
    DateCal.Enabled(False);
    EditNumberOfDonors.WriteText(StringGrid.GetValue(1, StringGrid.CurrentRow));
    EditSentToPreserving.WriteText(StringGrid.GetValue(2,
      StringGrid.CurrentRow));
    EditForLaboratoryResearch.WriteText(StringGrid.GetValue(3,
      StringGrid.CurrentRow));
    EditAllWholeBlood.WriteText(StringGrid.GetValue(4, StringGrid.CurrentRow));
    EditAllStoredBlood.WriteText(StringGrid.GetValue(5, StringGrid.CurrentRow));
    EditVolumeTrombo.WriteText(StringGrid.GetValue(6, StringGrid.CurrentRow));
    EditNumberOfPacketsTrombo.WriteText(StringGrid.GetValue(7,
      StringGrid.CurrentRow));
    EditNumberDosesTrombo.WriteText(StringGrid.GetValue(8,
      StringGrid.CurrentRow));
    for i := 0 to CBoxTypeTrombo.GetItemsCount do
      if CBoxTypeTrombo.GetItemsValue(i) = StringGrid.GetValue(9,
        StringGrid.CurrentRow) then
      begin
        CBoxTypeTrombo.WriteItemIndex(i);
        break;
      end;
    EditVolumeDefect.WriteText(StringGrid.GetValue(10, StringGrid.CurrentRow));
    EditNumberOfPacketsDefect.WriteText(StringGrid.GetValue(11,
      StringGrid.CurrentRow));
    EditNumberDosesDefect.WriteText(StringGrid.GetValue(12,
      StringGrid.CurrentRow));
    for i := 0 to CBoxTypeDefect.GetItemsCount do
      if CBoxTypeDefect.GetItemsValue(i) = StringGrid.GetValue(13,
        StringGrid.CurrentRow) then
      begin
        CBoxTypeDefect.WriteItemIndex(i);
        break;
      end;
  end;

  if ButtonEdit.GetCaption = 'Сохранить изменения' then
  begin
    try
      if MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0) = 6
      then
      begin
        BlockMainMenu.BlockMainMenu(True, CurrentForm);
        ButtonBlock.ChangeEnabled(True);
        ButtonAdd.ChangeEnabled(True);
        ButtonDelete.ChangeEnabled(True);
        DateCal.Enabled(True);
        StringGrid.Enabled(True);
        if CheckingBeforeSaving then
          exit;
        ChangeRecord.ChangeRecordTrombo(DateCal.GetDate,
          EditNumberOfDonors.ReadText, EditSentToPreserving.ReadText,
          EditForLaboratoryResearch.ReadText, EditAllWholeBlood.ReadText,
          EditAllStoredBlood.ReadText);
        ChangeRecord.ChangeRecordTromboDoza(DateCal.GetDate,
          EditNumberOfDonors.ReadText);
        ChangeRecord.ChangeRecordTromboComponents(EditVolumeTrombo.ReadText,
          EditNumberOfPacketsTrombo.ReadText, EditNumberDosesTrombo.ReadText,
          CBoxTypeTrombo.GetItemsValue(CBoxTypeTrombo.GetItemIndex));
        ChangeRecord.ChangeRecordTromboDefect(EditVolumeDefect.ReadText,
          EditNumberOfPacketsDefect.ReadText, EditNumberDosesDefect.ReadText,
          CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
        AfterSaving_Cancelling;
        GetStringGrid(CurrentForm);
        StringGrid.Visible(True);
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
        DateCal.Enabled(True);
        StringGrid.Enabled(True);
        AfterSaving_Cancelling;
        exit;
      end;
    except
      On e: EDatabaseError do
        MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  if ButtonEdit.GetCaption = 'Изменить' then
    ButtonEdit.ChangeCaption('Сохранить изменения')
  else
    ButtonEdit.ChangeCaption('Изменить');

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// Создание кнопок
function TMHSSitoferez.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(670, 0, ButtonAdded, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(670, 0, ButtonBlocked, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(670, 0, ButtonDeleted, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(670, 0, ButtonEdited, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// TDateTimePicker
function TMHSSitoferez.GetCalendarDateCal(NameForm: TForm): TDateTimePicker;
begin
  if not Assigned(DateCal) then
    DateCal := TMFDateTimePicker.create;
  Result := DateCal.GetDTPicker(220, 70, date(), NameForm);
  DateCal.Width(100);
  DateCal.FontSize(10);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.CheckingBeforeSaving: boolean;
var
  value1: integer;
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  EditNumberOfDonors.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberOfDonors.ReadText));
  EditSentToPreserving.WriteText(CheckFillStrFields.CheckStringFields
    (EditSentToPreserving.ReadText));
  EditForLaboratoryResearch.WriteText(CheckFillStrFields.CheckStringFields
    (EditForLaboratoryResearch.ReadText));
  EditAllWholeBlood.WriteText(CheckFillStrFields.CheckStringFields
    (EditAllWholeBlood.ReadText));
  EditAllStoredBlood.WriteText(CheckFillStrFields.CheckStringFields
    (EditAllStoredBlood.ReadText));
  EditVolumeTrombo.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumeTrombo.ReadText));
  EditNumberOfPacketsTrombo.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberDosesTrombo.ReadText));
  EditNumberDosesTrombo.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberDosesTrombo.ReadText));
  EditVolumeDefect.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumeDefect.ReadText));
  EditNumberOfPacketsDefect.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberDosesTrombo.ReadText));
  EditNumberDosesDefect.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberDosesDefect.ReadText));
  if not Assigned(ValueChecksOnTheAdequacy) then
    ValueChecksOnTheAdequacy := TUSValueChecksOnTheAdequacy.create;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditNumberOfDonors.ReadText,
    'Количество доноров не может равняться нулю!') then
  begin
    Result := True;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditSentToPreserving.ReadText,
    'Количество отправленной крови на консервирование не может равняться нулю!')
  then
  begin
    Result := True;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckZeroValues
    (EditForLaboratoryResearch.ReadText,
    'Количество крови отправленной на лабораторные исследования не может равняться нулю!')
  then
  begin
    Result := True;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditAllWholeBlood.ReadText,
    'Количество цельной крови не может равняться нулю!') then
  begin
    Result := True;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditAllStoredBlood.ReadText,
    'Количество консервированной крови не может равняться нулю!') then
  begin
    Result := True;
    exit;
  end;
  if ValueChecksOnTheAdequacy.CheckingEqualities
    (StrToInt(EditForLaboratoryResearch.ReadText),
    20 * StrToInt(EditNumberOfDonors.ReadText),
    'Количество крови на лабораторные исследования не соответствует количеству доноров!')
  then
  begin
    Result := True;
    exit;
  end;
  value1 := StrToInt(EditSentToPreserving.ReadText) +
    StrToInt(EditForLaboratoryResearch.ReadText);
  if ValueChecksOnTheAdequacy.CheckingEqualities(value1,
    StrToInt(EditAllWholeBlood.ReadText),
    'Количество цельной крови не совпадает с суммой "Отправлено на консервирование" и "На лабораторные иследования"!')
  then
  begin
    Result := True;
    exit;
  end;
  Result := False;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// шапка
function TMHSSitoferez.GetLabelDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDate) then
    LabelDate := TMFLabel.create;
  Result := LabelDate.GetTempLabel(30, 70, 14, 'Дата заготовки: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelNumberOfDonors(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDonors) then
    LabelNumberOfDonors := TMFLabel.create;
  Result := LabelNumberOfDonors.GetTempLabel(30, 105, 14,
    'Количество доноров: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditNumberOfDonors(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDonors) then
    EditNumberOfDonors := TMFEdit.create;
  Result := EditNumberOfDonors.GetEdit(220, 105, 100, 12, False, NameForm);
  EditNumberOfDonors.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// таблица "кровь"
function TMHSSitoferez.GetLabelSentToPreserving(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelSentToPreserving) then
    LabelSentToPreserving := TMFLabel.create;
  Result := LabelSentToPreserving.GetTempLabel(100, 190, 12,
    'Отправлено на консервирование, мл: ', NameForm);
  LabelSentToPreserving.WordWrap(True);
  LabelSentToPreserving.Width(150);
  LabelSentToPreserving.Height(40);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelForLaboratoryResearch(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelForLaboratoryResearch) then
    LabelForLaboratoryResearch := TMFLabel.create;
  Result := LabelForLaboratoryResearch.GetTempLabel(265, 190, 12,
    'На лабораторные иследования, мл: ', NameForm);
  LabelForLaboratoryResearch.WordWrap(True);
  LabelForLaboratoryResearch.Width(120);
  LabelForLaboratoryResearch.Height(40);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelAllWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllWholeBlood) then
    LabelAllWholeBlood := TMFLabel.create;
  Result := LabelAllWholeBlood.GetTempLabel(400, 190, 12,
    'Всего цельной крови, мл: ', NameForm);
  LabelAllWholeBlood.WordWrap(True);
  LabelAllWholeBlood.Width(100);
  LabelAllWholeBlood.Height(40);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelAllStoredBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllStoredBlood) then
    LabelAllStoredBlood := TMFLabel.create;
  Result := LabelAllStoredBlood.GetTempLabel(515, 190, 12,
    'Всего конс-ной крови, мл: ', NameForm);
  LabelAllStoredBlood.WordWrap(True);
  LabelAllStoredBlood.Width(120);
  LabelAllStoredBlood.Height(40);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelBlood) then
    LabelBlood := TMFLabel.create;
  Result := LabelBlood.GetTempLabel(30, 240, 12, 'Кровь: ', NameForm);
  LabelBlood.Width(120);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditSentToPreserving(NameForm: TForm): TEdit;
begin
  if not Assigned(EditSentToPreserving) then
    EditSentToPreserving := TMFEdit.create;
  Result := EditSentToPreserving.GetEdit(100, 240, 155, 10, False, NameForm);
  EditSentToPreserving.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditForLaboratoryResearch(NameForm: TForm): TEdit;
begin
  if not Assigned(EditForLaboratoryResearch) then
    EditForLaboratoryResearch := TMFEdit.create;
  Result := EditForLaboratoryResearch.GetEdit(265, 240, 125, 10, False,
    NameForm);
  EditForLaboratoryResearch.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditAllWholeBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllWholeBlood) then
    EditAllWholeBlood := TMFEdit.create;
  Result := EditAllWholeBlood.GetEdit(400, 240, 105, 10, False, NameForm);
  EditAllWholeBlood.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditAllStoredBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllStoredBlood) then
    EditAllStoredBlood := TMFEdit.create;
  Result := EditAllStoredBlood.GetEdit(515, 240, 105, 10, False, NameForm);
  EditAllStoredBlood.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelGorBlood(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGorBlood) then
    PanelGorBlood := TMFPanel.create;
  Result := PanelGorBlood.GetTempPanel(30, 232, 1, 590, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelVertBlood1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood1) then
    PanelVertBlood1 := TMFPanel.create;
  Result := PanelVertBlood1.GetTempPanel(95, 190, 75, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelVertBlood2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood2) then
    PanelVertBlood2 := TMFPanel.create;
  Result := PanelVertBlood2.GetTempPanel(260, 190, 75, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelVertBlood3(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood3) then
    PanelVertBlood3 := TMFPanel.create;
  Result := PanelVertBlood3.GetTempPanel(395, 190, 75, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelVertBlood4(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood4) then
    PanelVertBlood4 := TMFPanel.create;
  Result := PanelVertBlood4.GetTempPanel(510, 190, 75, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// таблица компонентов
function TMHSSitoferez.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TMFLabel.create;
  Result := LabelVolume.GetTempLabel(210, 293, 12, 'Объем, мл: ', NameForm);
  LabelVolume.WordWrap(True);
  LabelVolume.Width(80);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelNumberOfPacets(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfPacets) then
    LabelNumberOfPacets := TMFLabel.create;
  Result := LabelNumberOfPacets.GetTempLabel(310, 293, 12,
    'Кол-во пакетов, шт: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelNumberDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberDoses) then
    LabelNumberDoses := TMFLabel.create;
  Result := LabelNumberDoses.GetTempLabel(470, 293, 12, 'Кол-во доз, шт: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelType(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelType) then
    LabelType := TMFLabel.create;
  Result := LabelType.GetTempLabel(600, 293, 12, 'Вид продукци: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelTrombo(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTrombo) then
    LabelTrombo := TMFLabel.create;
  Result := LabelTrombo.GetTempLabel(30, 328, 14, 'Тромбоконцентрат: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetLabelDefectWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDefectWholeBlood) then
    LabelDefectWholeBlood := TMFLabel.create;
  Result := LabelDefectWholeBlood.GetTempLabel(30, 365, 14,
    'Брак цельной крови: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelGor1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor1Components1) then
    PanelGor1Components1 := TMFPanel.create;
  Result := PanelGor1Components1.GetTempPanel(30, 320, 1, 730, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelGor2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor2Components1) then
    PanelGor2Components1 := TMFPanel.create;
  Result := PanelGor2Components1.GetTempPanel(30, 358, 1, 730, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelVert1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert1Components1) then
    PanelVert1Components1 := TMFPanel.create;
  Result := PanelVert1Components1.GetTempPanel(205, 293, 110, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelVert2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert2Components1) then
    PanelVert2Components1 := TMFPanel.create;
  Result := PanelVert2Components1.GetTempPanel(305, 293, 110, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelVert3Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert3Components1) then
    PanelVert3Components1 := TMFPanel.create;
  Result := PanelVert3Components1.GetTempPanel(465, 293, 110, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetPanelVert4Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert4Components1) then
    PanelVert4Components1 := TMFPanel.create;
  Result := PanelVert4Components1.GetTempPanel(595, 293, 110, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditVolumeTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeTrombo) then
    EditVolumeTrombo := TMFEdit.create;
  Result := EditVolumeTrombo.GetEdit(210, 325, 90, 12, False, NameForm);
  EditVolumeTrombo.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditVolumeDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeDefect) then
    EditVolumeDefect := TMFEdit.create;
  Result := EditVolumeDefect.GetEdit(210, 363, 90, 12, False, NameForm);
  EditVolumeDefect.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditNumberOfPacetsTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfPacketsTrombo) then
    EditNumberOfPacketsTrombo := TMFEdit.create;
  Result := EditNumberOfPacketsTrombo.GetEdit(310, 325, 150, 12, False,
    NameForm);
  EditNumberOfPacketsTrombo.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditNumberOfPacetsDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfPacketsDefect) then
    EditNumberOfPacketsDefect := TMFEdit.create;
  Result := EditNumberOfPacketsDefect.GetEdit(310, 363, 150, 12, False,
    NameForm);
  EditNumberOfPacketsDefect.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditNumberDosesTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesTrombo) then
    EditNumberDosesTrombo := TMFEdit.create;
  Result := EditNumberDosesTrombo.GetEdit(470, 325, 120, 12, False, NameForm);
  EditNumberDosesTrombo.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetEditNumberDosesDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesDefect) then
    EditNumberDosesDefect := TMFEdit.create;
  Result := EditNumberDosesDefect.GetEdit(470, 363, 120, 12, False, NameForm);
  EditNumberDosesDefect.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetCBoxTypeTrombo(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeTrombo) then
    CBoxTypeTrombo := TMFComboBox.create;
  Result := CBoxTypeTrombo.GetComboBox('', 600, 325, 160, 12, NameForm);
  SQL := 'SELECT NameProducts.ShortName, NameProducts.id ' +
    'FROM NameProducts ' +
    'WHERE (((NameProducts.Visible)=True) AND ((NameProducts.TypeProduct)="Тромбоциты") and ((NameProducts.Production)=true))';
  CBoxTypeTrombo.TheContentOfTheList(SQL);
  CBoxTypeTrombo.WriteItemIndex(0);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

function TMHSSitoferez.GetCBoxTypeDefect(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeDefect) then
    CBoxTypeDefect := TMFComboBox.create;
  Result := CBoxTypeDefect.GetComboBox('', 600, 363, 160, 12, NameForm);
  SQL := 'SELECT TypeOfDefects.TypeDef ' + 'FROM TypeOfDefects ' +
    'WHERE (TypeOfDefects.Other=True)';
  CBoxTypeDefect.TheContentOfTheList(SQL);
  CBoxTypeDefect.WriteItemIndex(-1);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// Label
function TMHSSitoferez.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(22,
    'Ввод ежедневных данных по заготовке тромбоконцентрата', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

// StringGrid
function TMHSSitoferez.GetStringGrid(NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i := 0;
  j := 0;
  if not Assigned(StringGrid) then
    StringGrid := TMFStringGrid.create;
  StringGrid.ResultFormat(DT_CENTER, 1, DT_CENTER, 15, DT_CENTER, 9, DT_CENTER,
    10, DT_CENTER, 16, DT_CENTER);
  Result := StringGrid.GetStringGrid(30, 480, 840, 160, 14, 2, 9, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0, 60);
  StringGrid.ColWidth(1, 70);
  StringGrid.ColWidth(2, 65);
  StringGrid.ColWidth(3, 70);
  StringGrid.ColWidth(4, 80);
  StringGrid.ColWidth(5, 80);
  StringGrid.ColWidth(6, 70);
  StringGrid.ColWidth(7, 80);
  StringGrid.ColWidth(8, 70);
  StringGrid.ColWidth(9, 110);
  StringGrid.ColWidth(10, 90);
  StringGrid.ColWidth(11, 90);
  StringGrid.ColWidth(12, 85);
  StringGrid.ColWidth(13, 80);
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
    ContentForStringGrid := TBHSSitoferez.create;
  ContentForStringGrid.GetContent;
  if ContentForStringGrid.GetRowCount > 0 then
    for i := 0 to ContentForStringGrid.GetRowCount - 1 do
    begin
      if StringGrid.GetValue(0, 1) <> '' then
        StringGrid.AddRowCount;
      StringGrid.WriteCells(0, i + 1, ContentForStringGrid.GetDate(j));
      StringGrid.WriteCells(1, i + 1,
        ContentForStringGrid.GetNumberOfDonors(j));
      StringGrid.WriteCells(2, i + 1,
        ContentForStringGrid.GetSentToPreserving(j));
      StringGrid.WriteCells(3, i + 1,
        ContentForStringGrid.GetForLaboratoryResearch(j));
      StringGrid.WriteCells(4, i + 1, ContentForStringGrid.GetAllWholeBlood(j));
      StringGrid.WriteCells(5, i + 1,
        ContentForStringGrid.GetAllStoredBlood(j));
      StringGrid.WriteCells(6, i + 1, ContentForStringGrid.GetVolomeTrombo(j));
      StringGrid.WriteCells(7, i + 1,
        ContentForStringGrid.GetNumberOfPacketsTrombo(j));
      StringGrid.WriteCells(8, i + 1,
        ContentForStringGrid.GetNumberOfDosesTrombo(j));
      StringGrid.WriteCells(9, i + 1, ContentForStringGrid.GetTypeTrombo(j));
      StringGrid.WriteCells(10, i + 1, ContentForStringGrid.GetVolomeDefect(j));
      StringGrid.WriteCells(11, i + 1,
        ContentForStringGrid.GetNumberOfPacketsDefect(j));
      StringGrid.WriteCells(12, i + 1,
        ContentForStringGrid.GetNumberOfDosesDefect(j));
      StringGrid.WriteCells(13, i + 1, ContentForStringGrid.GetTypeDefect(j));
      j := j + 1;
    end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

procedure TMHSSitoferez.Show;
begin
  LabelDate.Visible(True);
  LabelNumberOfDonors.Visible(True);
  LabelSentToPreserving.Visible(True);
  LabelForLaboratoryResearch.Visible(True);
  LabelAllWholeBlood.Visible(True);
  LabelAllStoredBlood.Visible(True);
  LabelBlood.Visible(True);
  LabelVolume.Visible(True);
  LabelNumberOfPacets.Visible(True);
  LabelNumberDoses.Visible(True);
  LabelType.Visible(True);
  LabelTrombo.Visible(True);
  LabelDefectWholeBlood.Visible(True);

  PanelGorBlood.Visible(True);
  PanelVertBlood1.Visible(True);
  PanelVertBlood2.Visible(True);
  PanelVertBlood3.Visible(True);
  PanelVertBlood4.Visible(True);
  PanelVert1Components1.Visible(True);
  PanelVert2Components1.Visible(True);
  PanelVert3Components1.Visible(True);
  PanelVert4Components1.Visible(True);
  PanelGor1Components1.Visible(True);
  PanelGor2Components1.Visible(True);

  EditNumberOfDonors.Visible(True);
  EditSentToPreserving.Visible(True);
  EditForLaboratoryResearch.Visible(True);
  EditAllWholeBlood.Visible(True);
  EditAllStoredBlood.Visible(True);
  EditVolumeTrombo.Visible(True);
  EditVolumeDefect.Visible(True);
  EditNumberOfPacketsTrombo.Visible(True);
  EditNumberOfPacketsDefect.Visible(True);
  EditNumberDosesTrombo.Visible(True);
  EditNumberDosesDefect.Visible(True);

  StringGrid.Visible(True);
  DateCal.Visible(True);

  CBoxTypeDefect.Visible(True);
  CBoxTypeTrombo.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHMManualHarvesting.Show выполнена');
end;

end.
