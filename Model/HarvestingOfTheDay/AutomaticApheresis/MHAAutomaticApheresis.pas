unit MHAAutomaticApheresis;

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
  BHAAutomaticApheresis,
  BHAAddRecordAutomaticApheresis,
  BHADeleteRecordAutomaticApheresis,
  BHAChangeRecordAutomaticApheresis,
  USCheckForExistenceOfRecord,
  USValueChecksOnTheAdequacy,

  USGlobalVariant;

type

  TMHAAutomaticApheresis = class(TUSGlobalVariant)
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
    LabelNumberDoses: TMFLabel;
    LabelType: TMFLabel;
    LabelPlazma: TMFLabel;
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

    // шапка
    DateCal: TMFDateTimePicker;
    EditNumberOfDonors: TMFEdit;
    // таблица "кровь"
    EditSentToPreserving: TMFEdit;
    EditForLaboratoryResearch: TMFEdit;
    EditAllWholeBlood: TMFEdit;
    EditAllStoredBlood: TMFEdit;
    // таблица "компоненты"
    EditVolumePlazma: TMFEdit;
    EditVolumeDefect: TMFEdit;
    EditNumberDosesPlazma: TMFEdit;
    EditNumberDosesDefect: TMFEdit;

    CBoxTypeDefect: TMFComboBox;
    CBoxTypePlazma: TMFComboBox;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBHAAutomaticApheresis;
    AddRecord: IBHAAddRecordAutomaticApheresis;
    DeleteRecord: IBHADeleteRecordAutomaticApheresis;
    ChangeRecord: IBHAChangeRecordAutomaticApheresis;

    ValueChecksOnTheAdequacy: IUSValueChecksOnTheAdequacy;
    CheckFillStrFields: TUSCheckFillStringFields;
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
    procedure Show;
  public
    constructor create(form: TForm); override;
    destructor destroy; override;
  end;

implementation

{ TBloodProduct }

constructor TMHAAutomaticApheresis.create(form: TForm);
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
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.create выполнена');
  inherited;
end;

destructor TMHAAutomaticApheresis.destroy;
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
  LabelNumberDoses.destroy;
  LabelType.destroy;
  LabelPlazma.destroy;
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

  // шапка
  EditNumberOfDonors.destroy;

  // таблица "кровь"
  EditSentToPreserving.destroy;
  EditForLaboratoryResearch.destroy;
  EditAllWholeBlood.destroy;
  EditAllStoredBlood.destroy;
  // таблица "компоненты 1"
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.destroy выполнена');
  inherited;
end;

// Button

procedure TMHAAutomaticApheresis.AfterSaving_Cancelling;
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.AfterSaving_Cancelling выполнена');
end;

// Добавление новой записи

procedure TMHAAutomaticApheresis.ButtonAdded(Sender: TObject);
begin
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(CheckForExistenceOfRecord) then
      CheckForExistenceOfRecord := TUSCheckForExistenceOfRecord.create;
    SQL := 'SELECT ДатаП ' + 'FROM Plasma ' + 'WHERE Plasma.ДатаП=#' +
      FormatDateTime('mm''/''dd''/''yyyy', dateOf(DateCal.GetDate)) + '# ';
    if CheckForExistenceOfRecord.CheckForExistenceOfRecord(SQL) then
      exit;
    if CheckingBeforeSaving then
      exit;
    if not Assigned(AddRecord) then
      AddRecord := TBHAAddRecordAutomaticApheresis.create;
    AddRecord.AddRecordPlasma(DateCal.GetDate, EditNumberOfDonors.ReadText,
      EditSentToPreserving.ReadText, EditForLaboratoryResearch.ReadText,
      EditAllWholeBlood.ReadText, EditAllStoredBlood.ReadText);
    AddRecord.AddRecordPlasmaDoza(DateCal.GetDate, EditNumberOfDonors.ReadText);
    AddRecord.AddRecordPlasmaComponents(EditVolumePlazma.ReadText,
      EditNumberDosesPlazma.ReadText,
      CBoxTypePlazma.GetItemsValue(CBoxTypePlazma.GetItemIndex));
    AddRecord.AddRecordPlasmaDefect(EditVolumeDefect.ReadText,
      EditNumberDosesDefect.ReadText,
      CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    ShowMessage('Объем реинфузии - ' +
      IntToStr(StrToInt(EditAllStoredBlood.ReadText) -
      StrToInt(EditVolumePlazma.ReadText) - StrToInt(EditVolumeDefect.ReadText))
      + chr(13) + 'Количество консерванта - ' +
      IntToStr(StrToInt(EditAllStoredBlood.ReadText) -
      StrToInt(EditSentToPreserving.ReadText)));
    AfterSaving_Cancelling;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.ButtonAdded выполнена');
end;

// Разблокировка кнопок

procedure TMHAAutomaticApheresis.ButtonBlocked(Sender: TObject);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.ButtonBlocked выполнена');
end;

// Кнопка удаления

procedure TMHAAutomaticApheresis.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись от ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + ' числа?', mtConfirmation, [mbYes, mbNo], 0) = 6
  then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBHADeleteRecordAutomaticApheresis.create;
    DeleteRecord.DeleteRecord(StringGrid.GetValue(0, StringGrid.CurrentRow));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    StringGrid.Visible(True);
    ShowMessage('Запись успешно удалена!');
  end;
  AfterSaving_Cancelling;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.ButtonDeleted выполнена');
end;

// Внесение изменений
procedure TMHAAutomaticApheresis.ButtonEdited(Sender: TObject);
var
  i: integer;
begin
  if not Assigned(ChangeRecord) then
    ChangeRecord := TBHAChangeRecordAutomaticApheresis.create;
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
    EditVolumePlazma.WriteText(StringGrid.GetValue(6, StringGrid.CurrentRow));
    EditNumberDosesPlazma.WriteText(StringGrid.GetValue(7,
      StringGrid.CurrentRow));
    for i := 0 to CBoxTypePlazma.GetItemsCount do
      if CBoxTypePlazma.GetItemsValue(i) = StringGrid.GetValue(8,
        StringGrid.CurrentRow) then
      begin
        CBoxTypePlazma.WriteItemIndex(i);
        break;
      end;
    EditVolumeDefect.WriteText(StringGrid.GetValue(9, StringGrid.CurrentRow));
    EditNumberDosesDefect.WriteText(StringGrid.GetValue(10,
      StringGrid.CurrentRow));
    for i := 0 to CBoxTypeDefect.GetItemsCount do
      if CBoxTypeDefect.GetItemsValue(i) = StringGrid.GetValue(11,
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
        ChangeRecord.ChangeRecordPlasma(DateCal.GetDate,
          EditNumberOfDonors.ReadText, EditSentToPreserving.ReadText,
          EditForLaboratoryResearch.ReadText, EditAllWholeBlood.ReadText,
          EditAllStoredBlood.ReadText);
        ChangeRecord.ChangeRecordPlasmaDoza(DateCal.GetDate,
          EditNumberOfDonors.ReadText);
        ChangeRecord.ChangeRecordPlasmaComponents(EditVolumePlazma.ReadText,
          EditNumberDosesPlazma.ReadText,
          CBoxTypePlazma.GetItemsValue(CBoxTypePlazma.GetItemIndex));
        ChangeRecord.ChangeRecordPlasmaDefect(EditVolumeDefect.ReadText,
          EditNumberDosesDefect.ReadText,
          CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
        ShowMessage('Объем реинфузии - ' +
          IntToStr(StrToInt(EditAllStoredBlood.ReadText) -
          StrToInt(EditVolumePlazma.ReadText) -
          StrToInt(EditVolumeDefect.ReadText)) + chr(13) +
          'Количество консерванта - ' +
          IntToStr(StrToInt(EditAllStoredBlood.ReadText) -
          StrToInt(EditSentToPreserving.ReadText)));
        AfterSaving_Cancelling;
        GetStringGrid(CurrentForm);
        StringGrid.Visible(True);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.ButtonEdited выполнена');
end;

// Создание кнопок
function TMHAAutomaticApheresis.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(670, 0, ButtonAdded, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetButtonAdd выполнена');
end;

function TMHAAutomaticApheresis.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(670, 0, ButtonBlocked, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetButtonBlock выполнена');
end;

function TMHAAutomaticApheresis.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(670, 0, ButtonDeleted, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetButtonDelete выполнена');
end;

function TMHAAutomaticApheresis.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(670, 0, ButtonEdited, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetButtonEdit выполнена');
end;

// TDateTimePicker
function TMHAAutomaticApheresis.GetCalendarDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(DateCal) then
    DateCal := TMFDateTimePicker.create;
  Result := DateCal.GetDTPicker(220, 70, date(), NameForm);
  DateCal.Width(100);
  DateCal.FontSize(10);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetCalendarDateCal выполнена');
end;

function TMHAAutomaticApheresis.CheckingBeforeSaving: boolean;
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
  EditVolumePlazma.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumePlazma.ReadText));
  EditNumberDosesPlazma.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberDosesPlazma.ReadText));
  EditVolumeDefect.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumeDefect.ReadText));
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.CheckingBeforeSaving выполнена');
end;

// шапка
function TMHAAutomaticApheresis.GetLabelDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDate) then
    LabelDate := TMFLabel.create;
  Result := LabelDate.GetTempLabel(30, 70, 14, 'Дата заготовки: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelDate выполнена');
end;

function TMHAAutomaticApheresis.GetLabelNumberOfDonors(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDonors) then
    LabelNumberOfDonors := TMFLabel.create;
  Result := LabelNumberOfDonors.GetTempLabel(30, 105, 14,
    'Количество доноров: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelNumberOfDonors выполнена');
end;

function TMHAAutomaticApheresis.GetEditNumberOfDonors(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDonors) then
    EditNumberOfDonors := TMFEdit.create;
  Result := EditNumberOfDonors.GetEdit(220, 105, 100, 12, False, NameForm);
  EditNumberOfDonors.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetEditNumberOfDonors выполнена');
end;

// таблица "кровь"
function TMHAAutomaticApheresis.GetLabelSentToPreserving
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelSentToPreserving) then
    LabelSentToPreserving := TMFLabel.create;
  Result := LabelSentToPreserving.GetTempLabel(100, 190, 12,
    'Отправлено на консервирование, мл: ', NameForm);
  LabelSentToPreserving.WordWrap(True);
  LabelSentToPreserving.Width(150);
  LabelSentToPreserving.Height(40);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelSentToPreserving выполнена');
end;

function TMHAAutomaticApheresis.GetLabelForLaboratoryResearch
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelForLaboratoryResearch) then
    LabelForLaboratoryResearch := TMFLabel.create;
  Result := LabelForLaboratoryResearch.GetTempLabel(265, 190, 12,
    'На лабораторные иследования, мл: ', NameForm);
  LabelForLaboratoryResearch.WordWrap(True);
  LabelForLaboratoryResearch.Width(120);
  LabelForLaboratoryResearch.Height(40);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelForLaboratoryResearch выполнена');
end;

function TMHAAutomaticApheresis.GetLabelAllWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllWholeBlood) then
    LabelAllWholeBlood := TMFLabel.create;
  Result := LabelAllWholeBlood.GetTempLabel(400, 190, 12,
    'Всего цельной крови, мл: ', NameForm);
  LabelAllWholeBlood.WordWrap(True);
  LabelAllWholeBlood.Width(100);
  LabelAllWholeBlood.Height(40);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelAllWholeBlood выполнена');
end;

function TMHAAutomaticApheresis.GetLabelAllStoredBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllStoredBlood) then
    LabelAllStoredBlood := TMFLabel.create;
  Result := LabelAllStoredBlood.GetTempLabel(515, 190, 12,
    'Всего конс-ной крови, мл: ', NameForm);
  LabelAllStoredBlood.WordWrap(True);
  LabelAllStoredBlood.Width(120);
  LabelAllStoredBlood.Height(40);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelAllStoredBlood выполнена');
end;

function TMHAAutomaticApheresis.GetLabelBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelBlood) then
    LabelBlood := TMFLabel.create;
  Result := LabelBlood.GetTempLabel(30, 240, 12, 'Кровь: ', NameForm);
  LabelBlood.Width(120);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelBlood выполнена');
end;

function TMHAAutomaticApheresis.GetEditSentToPreserving(NameForm: TForm): TEdit;
begin
  if not Assigned(EditSentToPreserving) then
    EditSentToPreserving := TMFEdit.create;
  Result := EditSentToPreserving.GetEdit(100, 240, 155, 10, False, NameForm);
  EditSentToPreserving.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetEditSentToPreserving выполнена');
end;

function TMHAAutomaticApheresis.GetEditForLaboratoryResearch
  (NameForm: TForm): TEdit;
begin
  if not Assigned(EditForLaboratoryResearch) then
    EditForLaboratoryResearch := TMFEdit.create;
  Result := EditForLaboratoryResearch.GetEdit(265, 240, 125, 10, False,
    NameForm);
  EditForLaboratoryResearch.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetEditForLaboratoryResearch выполнена');
end;

function TMHAAutomaticApheresis.GetEditAllWholeBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllWholeBlood) then
    EditAllWholeBlood := TMFEdit.create;
  Result := EditAllWholeBlood.GetEdit(400, 240, 105, 10, False, NameForm);
  EditAllWholeBlood.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetEditAllWholeBlood выполнена');
end;

function TMHAAutomaticApheresis.GetEditAllStoredBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllStoredBlood) then
    EditAllStoredBlood := TMFEdit.create;
  Result := EditAllStoredBlood.GetEdit(515, 240, 105, 10, False, NameForm);
  EditAllStoredBlood.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetEditAllStoredBlood выполнена');
end;

function TMHAAutomaticApheresis.GetPanelGorBlood(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGorBlood) then
    PanelGorBlood := TMFPanel.create;
  Result := PanelGorBlood.GetTempPanel(30, 232, 1, 590, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelGorBlood выполнена');
end;

function TMHAAutomaticApheresis.GetPanelVertBlood1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood1) then
    PanelVertBlood1 := TMFPanel.create;
  Result := PanelVertBlood1.GetTempPanel(95, 190, 75, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelVertBlood1 выполнена');
end;

function TMHAAutomaticApheresis.GetPanelVertBlood2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood2) then
    PanelVertBlood2 := TMFPanel.create;
  Result := PanelVertBlood2.GetTempPanel(260, 190, 75, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelVertBlood2 выполнена');
end;

function TMHAAutomaticApheresis.GetPanelVertBlood3(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood3) then
    PanelVertBlood3 := TMFPanel.create;
  Result := PanelVertBlood3.GetTempPanel(395, 190, 75, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelVertBlood3 выполнена');
end;

function TMHAAutomaticApheresis.GetPanelVertBlood4(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood4) then
    PanelVertBlood4 := TMFPanel.create;
  Result := PanelVertBlood4.GetTempPanel(510, 190, 75, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelVertBlood4 выполнена');
end;

// таблица компонентов
function TMHAAutomaticApheresis.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TMFLabel.create;
  Result := LabelVolume.GetTempLabel(210, 293, 12, 'Объем, мл: ', NameForm);
  LabelVolume.WordWrap(True);
  LabelVolume.Width(80);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelVolume выполнена');
end;

function TMHAAutomaticApheresis.GetLabelNumberDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberDoses) then
    LabelNumberDoses := TMFLabel.create;
  Result := LabelNumberDoses.GetTempLabel(310, 293, 12, 'Количество доз, шт: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelNumberDoses выполнена');
end;

function TMHAAutomaticApheresis.GetLabelType(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelType) then
    LabelType := TMFLabel.create;
  Result := LabelType.GetTempLabel(470, 293, 12, 'Вид продукци: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelType выполнена');
end;

function TMHAAutomaticApheresis.GetLabelPlazma(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelPlazma) then
    LabelPlazma := TMFLabel.create;
  Result := LabelPlazma.GetTempLabel(30, 328, 14, 'Плазма: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelPlazma выполнена');
end;

function TMHAAutomaticApheresis.GetLabelDefectWholeBlood
  (NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDefectWholeBlood) then
    LabelDefectWholeBlood := TMFLabel.create;
  Result := LabelDefectWholeBlood.GetTempLabel(30, 365, 14,
    'Брак цельной крови: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelDefectWholeBlood выполнена');
end;

function TMHAAutomaticApheresis.GetPanelGor1Components1
  (NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor1Components1) then
    PanelGor1Components1 := TMFPanel.create;
  Result := PanelGor1Components1.GetTempPanel(30, 320, 1, 550, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelGor1Components1 выполнена');
end;

function TMHAAutomaticApheresis.GetPanelGor2Components1
  (NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor2Components1) then
    PanelGor2Components1 := TMFPanel.create;
  Result := PanelGor2Components1.GetTempPanel(30, 358, 1, 550, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelGor2Components1 выполнена');
end;

function TMHAAutomaticApheresis.GetPanelVert1Components1
  (NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert1Components1) then
    PanelVert1Components1 := TMFPanel.create;
  Result := PanelVert1Components1.GetTempPanel(205, 293, 110, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelVert1Components1 выполнена');
end;

function TMHAAutomaticApheresis.GetPanelVert2Components1
  (NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert2Components1) then
    PanelVert2Components1 := TMFPanel.create;
  Result := PanelVert2Components1.GetTempPanel(305, 293, 110, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelVert2Components1 выполнена');
end;

function TMHAAutomaticApheresis.GetPanelVert3Components1
  (NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert3Components1) then
    PanelVert3Components1 := TMFPanel.create;
  Result := PanelVert3Components1.GetTempPanel(465, 293, 110, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetPanelVert3Components1 выполнена');
end;

function TMHAAutomaticApheresis.GetEditVolumePlazma(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumePlazma) then
    EditVolumePlazma := TMFEdit.create;
  Result := EditVolumePlazma.GetEdit(210, 325, 90, 12, False, NameForm);
  EditVolumePlazma.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetEditVolumePlazma выполнена');
end;

function TMHAAutomaticApheresis.GetEditVolumeDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeDefect) then
    EditVolumeDefect := TMFEdit.create;
  Result := EditVolumeDefect.GetEdit(210, 363, 90, 12, False, NameForm);
  EditVolumeDefect.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetEditVolumeDefect выполнена');
end;

function TMHAAutomaticApheresis.GetEditNumberDosesPlazma
  (NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesPlazma) then
    EditNumberDosesPlazma := TMFEdit.create;
  Result := EditNumberDosesPlazma.GetEdit(310, 325, 150, 12, False, NameForm);
  EditNumberDosesPlazma.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetEditNumberDosesPlazma выполнена');
end;

function TMHAAutomaticApheresis.GetEditNumberDosesDefect
  (NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesDefect) then
    EditNumberDosesDefect := TMFEdit.create;
  Result := EditNumberDosesDefect.GetEdit(310, 363, 150, 12, False, NameForm);
  EditNumberDosesDefect.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetEditNumberDosesDefect выполнена');
end;

function TMHAAutomaticApheresis.GetCBoxTypePlazma(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypePlazma) then
    CBoxTypePlazma := TMFComboBox.create;
  Result := CBoxTypePlazma.GetComboBox('CBoxTypePlazma', 470, 325, 110, 12,
    NameForm);
  SQL := 'SELECT NameProducts.ShortName, NameProducts.id ' +
    'FROM NameProducts ' +
    'WHERE (((NameProducts.Visible)=True) AND ((NameProducts.TypeProduct)="Плазма") and ((NameProducts.AUTO)=true))';
  CBoxTypePlazma.TheContentOfTheList(SQL);
  CBoxTypePlazma.WriteItemIndex(0);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetCBoxTypePlazma выполнена');
end;

function TMHAAutomaticApheresis.GetCBoxTypeDefect(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeDefect) then
    CBoxTypeDefect := TMFComboBox.create;
  Result := CBoxTypeDefect.GetComboBox('CBoxTypeDefect', 470, 363, 110, 12,
    NameForm);
  SQL := 'SELECT TypeOfDefects.TypeDef ' + 'FROM TypeOfDefects ' +
    'WHERE (TypeOfDefects.Other=True)';
  CBoxTypeDefect.TheContentOfTheList(SQL);
  CBoxTypeDefect.WriteItemIndex(-1);
  CBoxTypeDefect.GetDROPPEDWIDTH(200);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetCBoxTypeDefect выполнена');
end;

// Label
function TMHAAutomaticApheresis.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(19,
    'Ввод ежедневных данных по заготовке плазмы автоматическим аферезом',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetLabelTitle выполнена');
end;

// StringGrid
function TMHAAutomaticApheresis.GetStringGrid(NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i := 0;
  j := 0;
  if not Assigned(StringGrid) then
    StringGrid := TMFStringGrid.create;
  StringGrid.ResultFormat(DT_CENTER, 1, DT_CENTER, 7, DT_CENTER, 9, DT_CENTER,
    10, DT_CENTER, 11, DT_CENTER);
  Result := StringGrid.GetStringGrid(30, 480, 840, 160, 12, 2, 9, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0, 60);
  StringGrid.ColWidth(1, 70);
  StringGrid.ColWidth(2, 60);
  StringGrid.ColWidth(3, 70);
  StringGrid.ColWidth(4, 80);
  StringGrid.ColWidth(5, 80);
  StringGrid.ColWidth(6, 65);
  StringGrid.ColWidth(7, 80);
  StringGrid.ColWidth(8, 90);
  StringGrid.ColWidth(9, 90);
  StringGrid.ColWidth(10, 95);
  StringGrid.ColWidth(11, 90);
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
    ContentForStringGrid := TBHAAutomaticApheresis.create;
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
      StringGrid.WriteCells(6, i + 1, ContentForStringGrid.GetVolomePlazma(j));
      StringGrid.WriteCells(7, i + 1,
        ContentForStringGrid.GetNumberOfDosesPlazma(j));
      StringGrid.WriteCells(8, i + 1, ContentForStringGrid.GetTypePlazma(j));
      StringGrid.WriteCells(9, i + 1, ContentForStringGrid.GetVolomeDefect(j));
      StringGrid.WriteCells(10, i + 1,
        ContentForStringGrid.GetNumberOfDosesDefect(j));
      StringGrid.WriteCells(11, i + 1, ContentForStringGrid.GetTypeDefect(j));
      j := j + 1;
    end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.GetStringGrid выполнена');
end;

procedure TMHAAutomaticApheresis.Show;
begin
  LabelDate.Visible(True);
  LabelNumberOfDonors.Visible(True);
  LabelSentToPreserving.Visible(True);
  LabelForLaboratoryResearch.Visible(True);
  LabelAllWholeBlood.Visible(True);
  LabelAllStoredBlood.Visible(True);
  LabelBlood.Visible(True);
  LabelVolume.Visible(True);
  LabelNumberDoses.Visible(True);
  LabelType.Visible(True);
  LabelPlazma.Visible(True);
  LabelDefectWholeBlood.Visible(True);

  PanelGorBlood.Visible(True);
  PanelVertBlood1.Visible(True);
  PanelVertBlood2.Visible(True);
  PanelVertBlood3.Visible(True);
  PanelVertBlood4.Visible(True);
  PanelVert1Components1.Visible(True);
  PanelVert2Components1.Visible(True);
  PanelVert3Components1.Visible(True);
  PanelGor1Components1.Visible(True);
  PanelGor2Components1.Visible(True);

  EditNumberOfDonors.Visible(True);
  EditSentToPreserving.Visible(True);
  EditForLaboratoryResearch.Visible(True);
  EditAllWholeBlood.Visible(True);
  EditAllStoredBlood.Visible(True);
  EditVolumePlazma.Visible(True);
  EditVolumeDefect.Visible(True);
  EditNumberDosesPlazma.Visible(True);
  EditNumberDosesDefect.Visible(True);

  StringGrid.Visible(True);
  DateCal.Visible(True);

  CBoxTypeDefect.Visible(True);
  CBoxTypePlazma.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMHAAutomaticApheresis.Show выполнена');
end;

end.
