unit MMMonthlyPlan;

interface

uses
  Vcl.ExtCtrls, WinProcs, SysUtils, StdCtrls, CodeSiteLogging, Buttons, Vcl.Grids, Data.DB,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,

  USCheckFillStringFields,
  USBlockMainMenu,
  MFLabel,
  MFTitleLabel,
  MFEdit,
  MFListBox,
  MFBitBtnAdd,
  MFBitBtnDelete,
  MFBitBtnEdit,
  MFBitBtnBlock,
  MFStringGrid,
  MFComboBox,
  MFPanel,
  BMListOfDate,
  BMMonthlyPlan,
  BMAddRecoedMonthlyPlan,
  BMDeleteRecordMonthlyPlan,
  BMChangeRecordMonthlyPlan,
  USCheckForExistenceOfRecord,
  USValueChecksOnTheAdequacy,
  USGlobalVariant;

type

  TMMMonthlyPlan = class(TUSGlobalVariant)
  private
    LabelDate: TMFLabel;
    LabelVolumeWholeBlood: TMFLabel;
    LabelVolumeStoredBlood: TMFLabel;
    LabelVolumePlasmaTotal: TMFLabel;
    LabelProceduresBlood: TMFLabel;
    LabelProceduresPlasmaAPA: TMFLabel;
    LabelProceduresTrombo: TMFLabel;
    LabelVolumePlasmaAPA: TMFLabel;
    LabelVolumeErSusp: TMFLabel;
    LabelVolumeTrombo: TMFLabel;
    LabelNumberWorkDays: TMFLabel;
    LabelWorkDays: TMFLabel;

    Title: TMFTitleLabel;
    SQL: String;

    PanelVert: TMFPanel;
    PanelGor1: TMFPanel;
    PanelGor2: TMFPanel;
    PanelGor3: TMFPanel;
    PanelGor4: TMFPanel;
    PanelGor5: TMFPanel;
    PanelGor6: TMFPanel;

    EditVolumeWholeBlood: TMFEdit;
    EditVolumeStoredBlood: TMFEdit;
    EditVolumePlasmaTotal: TMFEdit;
    EditProceduresBlood: TMFEdit;
    EditProceduresPlasmaAPA: TMFEdit;
    EditProceduresTrombo: TMFEdit;
    EditVolumePlasmaAPA: TMFEdit;
    EditVolumeErSusp: TMFEdit;
    EditVolumeTrombo: TMFEdit;
    EditNumberWorkDays: TMFEdit;

    CBoxMonth: TMFComboBox;
    CBoxYear: TMFComboBox;
    Period: TDate;
    LBoxCalendar: TMFListBox;

    StringGrid: TMFStringGrid;
    ContentForStringGrid: IBMMonthlyPlan;
    ListOfDate: IBMListOfDate;

    AddRecord: IBMAddRecoedMonthlyPlan;
    DeleteRecord: IBMDeleteRecordMonthlyPlan;
    ChangeDaysOfRecord: IBMChangeRecordMonthlyPlan;

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
    function GetLabelVolumeWholeBlood(NameForm: TForm): TLabel;
    function GetLabelVolumeStoredBlood(NameForm: TForm): TLabel;
    function GetLabelVolumePlasmaTotal(NameForm: TForm): TLabel;
    function GetLabelProceduresBlood(NameForm: TForm): TLabel;
    function GetLabelProceduresPlasmaAPA(NameForm: TForm): TLabel;
    function GetLabelProceduresTrombo(NameForm: TForm): TLabel;
    function GetLabelVolumePlasmaAPA(NameForm: TForm): TLabel;
    function GetLabelVolumeErSusp(NameForm: TForm): TLabel;
    function GetLabelVolumeTrombo(NameForm: TForm): TLabel;
    function GetLabelNumberWorkDays(NameForm: TForm): TLabel;
    function GetLabelWorkDays(NameForm: TForm): TLabel;

    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetPanelVert(NameForm: TForm): TPanel;
    function GetPanelGor1(NameForm: TForm): TPanel;
    function GetPanelGor2(NameForm: TForm): TPanel;
    function GetPanelGor3(NameForm: TForm): TPanel;
    function GetPanelGor4(NameForm: TForm): TPanel;
    function GetPanelGor5(NameForm: TForm): TPanel;
    function GetPanelGor6(NameForm: TForm): TPanel;

    function GetEditVolumeWholeBlood(NameForm: TForm): TEdit;
    function GetEditVolumeStoredBlood(NameForm: TForm): TEdit;
    function GetEditVolumePlasmaTotal(NameForm: TForm): TEdit;
    function GetEditProceduresBlood(NameForm: TForm): TEdit;
    function GetEditProceduresPlasmaAPA(NameForm: TForm): TEdit;
    function GetEditProceduresTrombo(NameForm: TForm): TEdit;
    function GetEditVolumePlasmaAPA(NameForm: TForm): TEdit;
    function GetEditVolumeErSusp(NameForm: TForm): TEdit;
    function GetEditVolumeTrombo(NameForm: TForm): TEdit;
    function GetEditNumberWorkDays(NameForm: TForm): TEdit;

    function GetCBoxMonth(NameForm: TForm): TComboBox;
    function GetCBoxYear(NameForm: TForm): TComboBox;
    procedure OnChangeCbox(Sender: TObject);
    function GetLBoxCalendar(NameForm: TForm): TListBox;
    Procedure GetPeriod;

    function GetStringGrid(NameForm: TForm): TStringGrid;

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

constructor TMMMonthlyPlan.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelDate(form);
  GetLabelVolumeWholeBlood(form);
  GetLabelVolumeStoredBlood(form);
  GetLabelVolumePlasmaTotal(form);
  GetLabelProceduresBlood(form);
  GetLabelProceduresPlasmaAPA(form);
  GetLabelProceduresTrombo(form);
  GetLabelVolumePlasmaAPA(form);
  GetLabelVolumeErSusp(form);
  GetLabelVolumeTrombo(form);
  GetLabelNumberWorkDays(form);
  GetLabelWorkDays(form);

  GetLabelTitle(form);

  GetPanelVert(form);
  GetPanelGor1(form);
  GetPanelGor2(form);
  GetPanelGor3(form);
  GetPanelGor4(form);
  GetPanelGor5(form);
  GetPanelGor6(form);

  GetEditVolumeWholeBlood(form);
  GetEditVolumeStoredBlood(form);
  GetEditVolumePlasmaTotal(form);
  GetEditProceduresBlood(form);
  GetEditProceduresPlasmaAPA(form);
  GetEditProceduresTrombo(form);
  GetEditVolumePlasmaAPA(form);
  GetEditVolumeErSusp(form);
  GetEditVolumeTrombo(form);
  GetEditNumberWorkDays(form);

  GetCBoxMonth(form);
  GetCBoxYear(form);
  GetLBoxCalendar(form);

  GetStringGrid(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  Show;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.create выполнена');
  inherited;
end;

destructor TMMMonthlyPlan.destroy;
begin
  LabelDate.destroy;

  LabelVolumeWholeBlood.destroy;
  LabelVolumeStoredBlood.destroy;
  LabelVolumePlasmaTotal.destroy;
  LabelProceduresBlood.destroy;
  LabelProceduresPlasmaAPA.destroy;
  LabelProceduresTrombo.destroy;
  LabelVolumePlasmaAPA.destroy;
  LabelVolumeErSusp.destroy;
  LabelVolumeTrombo.destroy;
  LabelNumberWorkDays.destroy;
  LabelWorkDays.destroy;

  Title.destroy;

  PanelVert.destroy;
  PanelGor1.destroy;
  PanelGor2.destroy;
  PanelGor3.destroy;
  PanelGor4.destroy;
  PanelGor5.destroy;
  PanelGor6.destroy;

  EditVolumeWholeBlood.destroy;
  EditVolumeStoredBlood.destroy;
  EditVolumePlasmaTotal.destroy;
  EditProceduresBlood.destroy;
  EditProceduresPlasmaAPA.destroy;
  EditProceduresTrombo.destroy;
  EditVolumePlasmaAPA.destroy;
  EditVolumeErSusp.destroy;
  EditVolumeTrombo.destroy;
  EditNumberWorkDays.destroy;

  CBoxMonth.destroy;
  CBoxYear.destroy;
  LBoxCalendar.destroy;

  StringGrid.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.destroy выполнена');
  inherited;
end;

// Button

procedure TMMMonthlyPlan.AfterSaving_Cancelling;
begin
  EditVolumeWholeBlood.WriteText('0');
  EditVolumeStoredBlood.WriteText('0');
  EditVolumePlasmaTotal.WriteText('0');
  EditProceduresBlood.WriteText('0');
  EditProceduresPlasmaAPA.WriteText('0');
  EditProceduresTrombo.WriteText('0');
  EditVolumePlasmaAPA.WriteText('0');
  EditVolumeErSusp.WriteText('0');
  EditVolumeTrombo.WriteText('0');
  EditNumberWorkDays.WriteText('0');

  CBoxMonth.WriteItemIndex(MonthOf(Date()));
  CBoxYear.WriteItemIndex(2);
  OnChangeCbox(CBoxMonth);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.AfterSaving_Cancelling выполнена');
end;

// Добавление новой записи

procedure TMMMonthlyPlan.ButtonAdded(Sender: TObject);
var
  i: integer;
begin
  GetPeriod;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0) = 6 then
  begin
    if not Assigned(CheckForExistenceOfRecord) then
      CheckForExistenceOfRecord := TUSCheckForExistenceOfRecord.create;
    SQL := 'SELECT Plans.ДатаПлан ' + 'FROM Plans ' + 'WHERE Plans.ДатаПлан=#' +
      FormatDateTime('mm''/''dd''/''yyyy', dateOf(Period)) + '# ';
    if CheckForExistenceOfRecord.CheckForExistenceOfRecord(SQL) then
      exit;
    if CheckingBeforeSaving then
      exit;
    if not Assigned(AddRecord) then
      AddRecord := TBMAddRecoedMonthlyPlan.create;
    AddRecord.AddRecordPlasma(Period, EditVolumeWholeBlood.ReadText,
      EditVolumeStoredBlood.ReadText, EditVolumePlasmaTotal.ReadText,
      EditProceduresBlood.ReadText, EditProceduresPlasmaAPA.ReadText,
      EditProceduresTrombo.ReadText, EditVolumePlasmaAPA.ReadText,
      EditVolumeErSusp.ReadText, EditVolumeTrombo.ReadText,
      EditNumberWorkDays.ReadText);
    for i := 0 to LBoxCalendar.GetItemsCount - 1 do
      if LBoxCalendar.CheckSelected(i) then
        AddRecord.AddRecordDays(StrToDate(LBoxCalendar.GetItemsValue(i)));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    AfterSaving_Cancelling;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.ButtonAdded выполнена');
end;

// Разблокировка кнопок

procedure TMMMonthlyPlan.ButtonBlocked(Sender: TObject);
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.ButtonBlocked выполнена');
end;

// Кнопка удаления

procedure TMMMonthlyPlan.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись от ' + VarToStr(StringGrid.GetValue(0,
    StringGrid.CurrentRow)) + ' числа?', mtConfirmation, [mbYes, mbNo], 0) = 6
  then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TBMDeleteRecordMonthlyPlan.create;
    DeleteRecord.DeleteRecord(StringGrid.GetValue(0, StringGrid.CurrentRow));
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount - 1);
    ShowMessage('Запись успешно удалена!');
  end;
  AfterSaving_Cancelling;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.ButtonDeleted выполнена');
end;

// Внесение изменений
procedure TMMMonthlyPlan.ButtonEdited(Sender: TObject);
var
  i, j: integer;
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
    CBoxMonth.Enabled(False);
    CBoxYear.Enabled(False);
    ButtonDelete.ChangeEnabled(False);

    StringGrid.Enabled(False);

    CBoxMonth.WriteItemIndex
      (MonthOf(StrToDate(StringGrid.GetValue(0, StringGrid.CurrentRow))) - 1);
    CBoxYear.WriteItemIndex
      (YearOf(StrToDate(StringGrid.GetValue(0, StringGrid.CurrentRow))) -
      YearOf(Date()) + 2);
    OnChangeCbox(CBoxMonth);

    EditVolumeWholeBlood.WriteText(StringGrid.GetValue(1,
      StringGrid.CurrentRow));
    EditVolumeStoredBlood.WriteText(StringGrid.GetValue(2,
      StringGrid.CurrentRow));
    EditVolumePlasmaTotal.WriteText(StringGrid.GetValue(3,
      StringGrid.CurrentRow));
    EditProceduresBlood.WriteText(StringGrid.GetValue(4,
      StringGrid.CurrentRow));
    EditProceduresPlasmaAPA.WriteText(StringGrid.GetValue(5,
      StringGrid.CurrentRow));
    EditProceduresTrombo.WriteText(StringGrid.GetValue(6,
      StringGrid.CurrentRow));
    EditVolumePlasmaAPA.WriteText(StringGrid.GetValue(7,
      StringGrid.CurrentRow));
    EditVolumeErSusp.WriteText(StringGrid.GetValue(8, StringGrid.CurrentRow));
    EditVolumeTrombo.WriteText(StringGrid.GetValue(9, StringGrid.CurrentRow));
    EditNumberWorkDays.WriteText(StringGrid.GetValue(10,
      StringGrid.CurrentRow));

    if not Assigned(ChangeDaysOfRecord) then
      ChangeDaysOfRecord := TBMChangeRecordMonthlyPlan.create;
    if not Assigned(ListOfDate) then
      ListOfDate := TBMListOfDate.create;
    ListOfDate.GetContent(MonthOf(StrToDate(StringGrid.GetValue(0,
      StringGrid.CurrentRow))),
      YearOf(StrToDate(StringGrid.GetValue(0, StringGrid.CurrentRow))));
    for i := 0 to ListOfDate.GetRowCount - 1 do
      for j := 0 to LBoxCalendar.GetItemsCount - 1 do
        if ListOfDate.GetList(i) = LBoxCalendar.GetItemsValue(j) then
        begin
          LBoxCalendar.SetSelected(j, True);
          break;
        end;
  end;

  if ButtonEdit.GetTag = 2 then
  begin
    try
      if MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0) = 6
      then
      begin
        BlockMainMenu.BlockMainMenu(True, CurrentForm);
        ButtonBlock.ChangeEnabled(True);
        ButtonAdd.ChangeEnabled(True);
        ButtonDelete.ChangeEnabled(True);
        CBoxMonth.Enabled(True);
        CBoxYear.Enabled(True);
        StringGrid.Enabled(True);
        if CheckingBeforeSaving then
          exit;
        if not Assigned(AddRecord) then
          AddRecord := TBMAddRecoedMonthlyPlan.create;
        if not Assigned(DeleteRecord) then
          DeleteRecord := TBMDeleteRecordMonthlyPlan.create;
        GetPeriod;
        DeleteRecord.DeleteRecord(StringGrid.GetValue(0,
          StringGrid.CurrentRow));
        AddRecord.AddRecordPlasma(Period, EditVolumeWholeBlood.ReadText,
          EditVolumeStoredBlood.ReadText, EditVolumePlasmaTotal.ReadText,
          EditProceduresBlood.ReadText, EditProceduresPlasmaAPA.ReadText,
          EditProceduresTrombo.ReadText, EditVolumePlasmaAPA.ReadText,
          EditVolumeErSusp.ReadText, EditVolumeTrombo.ReadText,
          EditNumberWorkDays.ReadText);
        for i := 0 to LBoxCalendar.GetItemsCount - 1 do
          if LBoxCalendar.CheckSelected(i) then
            ChangeDaysOfRecord.AddRecordDays(Period,
              StrToDate(LBoxCalendar.GetItemsValue(i)));
        AfterSaving_Cancelling;
        GetStringGrid(CurrentForm);
        StringGrid.Visible(True);
        ButtonEdit.ChangeTag(1);
        ButtonEdit.ChangeGlyph;
        exit;
      end
      else
      begin
        ButtonEdit.ChangeTag(1);
        ButtonEdit.ChangeGlyph;
        BlockMainMenu.BlockMainMenu(True, CurrentForm);
        ButtonBlock.ChangeEnabled(True);
        ButtonAdd.ChangeEnabled(True);
        ButtonDelete.ChangeEnabled(True);
        CBoxMonth.Enabled(True);
        CBoxYear.Enabled(True);
        StringGrid.Enabled(True);
        AfterSaving_Cancelling;
        exit;
      end;
    except
      On e: EDatabaseError do
        MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  if ButtonEdit.GetTag = 1 then
  begin
    ButtonEdit.ChangeTag(2);
    ButtonEdit.ChangeGlyph;
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.ButtonEdited выполнена');
end;

// Создание кнопок
function TMMMonthlyPlan.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TMFBitBtnAdd.create;
  Result := ButtonAdd.GetBitBtnAdd(670, 0, ButtonAdded, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetButtonAdd выполнена');
end;

function TMMMonthlyPlan.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TMFBitBtnBlock.create;
  Result := ButtonBlock.GetBitBtnBlock(670, 0, ButtonBlocked, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetButtonBlock выполнена');
end;

function TMMMonthlyPlan.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TMFBitBtnDelete.create;
  Result := ButtonDelete.GetBitBtnDelete(670, 0, ButtonDeleted, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetButtonDelete выполнена');
end;

function TMMMonthlyPlan.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TMFBitBtnEdit.create;
  Result := ButtonEdit.GetBitBtnEdit(670, 0, ButtonEdited, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetButtonEdit выполнена');
end;

function TMMMonthlyPlan.CheckingBeforeSaving: boolean;
begin
  Result := True;
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  EditVolumeWholeBlood.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumeWholeBlood.ReadText));
  EditVolumeStoredBlood.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumeStoredBlood.ReadText));
  EditVolumePlasmaTotal.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumePlasmaTotal.ReadText));
  EditProceduresBlood.WriteText(CheckFillStrFields.CheckStringFields
    (EditProceduresBlood.ReadText));
  EditProceduresPlasmaAPA.WriteText(CheckFillStrFields.CheckStringFields
    (EditProceduresPlasmaAPA.ReadText));
  EditProceduresTrombo.WriteText(CheckFillStrFields.CheckStringFields
    (EditProceduresTrombo.ReadText));
  EditVolumePlasmaAPA.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumePlasmaAPA.ReadText));
  EditVolumeErSusp.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumeErSusp.ReadText));
  EditVolumeTrombo.WriteText(CheckFillStrFields.CheckStringFields
    (EditVolumeTrombo.ReadText));
  EditNumberWorkDays.WriteText(CheckFillStrFields.CheckStringFields
    (EditNumberWorkDays.ReadText));

  if not Assigned(ValueChecksOnTheAdequacy) then
    ValueChecksOnTheAdequacy := TUSValueChecksOnTheAdequacy.create;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumeWholeBlood.ReadText,
    'План по объему заготавливаемой цельной крови не может равняться нулю!')
  then
    exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumeStoredBlood.ReadText,
    'План по объему заготавливаемой консервированной крови не может равняться нулю!')
  then
    exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumePlasmaTotal.ReadText,
    'План по объему заготавливаемой плазмы (всего) не может равняться нулю!')
  then
    exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditProceduresBlood.ReadText,
    'План по количеству процедур цельной крови не может равняться нулю!') then
    exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditProceduresPlasmaAPA.ReadText,
    'План по количеству процедур плазмы АПА не может равняться нулю!') then
    exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumePlasmaAPA.ReadText,
    'План по объему заготавливаемой плазмы АПА не может равняться нулю!') then
    exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumeErSusp.ReadText,
    'План по объему заготавливаемых эр. сред не может равняться нулю!') then
    exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditNumberWorkDays.ReadText,
    'Количество рабочих дней в плановом периоде не может равняться нулю!') then
    exit;
  if LBoxCalendar.GetNumberSelectedString <>
    StrToInt(EditNumberWorkDays.ReadText) then
  begin
    ShowMessage
      ('Количество рабочих дней не соответствует количеству выделенных дней в календаре!');
    exit;
  end;
  Result := False;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.CheckingBeforeSaving выполнена');
end;

function TMMMonthlyPlan.GetLabelDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDate) then
    LabelDate := TMFLabel.create;
  Result := LabelDate.GetTempLabel(30, 60, 14, 'Плановый период: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.creaGetLabelDatete выполнена');
end;

function TMMMonthlyPlan.GetLabelVolumeWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumeWholeBlood) then
    LabelVolumeWholeBlood := TMFLabel.create;
  Result := LabelVolumeWholeBlood.GetTempLabel(30, 140, 14,
    'Объем цельной крови, мл: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelVolumeWholeBlood выполнена');
end;

function TMMMonthlyPlan.GetLabelVolumeStoredBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumeStoredBlood) then
    LabelVolumeStoredBlood := TMFLabel.create;
  Result := LabelVolumeStoredBlood.GetTempLabel(30, 170, 14,
    'Объем консервированной крови, мл: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelVolumeStoredBlood выполнена');
end;

function TMMMonthlyPlan.GetLabelVolumePlasmaTotal(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumePlasmaTotal) then
    LabelVolumePlasmaTotal := TMFLabel.create;
  Result := LabelVolumePlasmaTotal.GetTempLabel(30, 200, 14,
    'Объем плазмы (всего), мл: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelVolumePlasmaTotal выполнена');
end;

function TMMMonthlyPlan.GetLabelProceduresBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProceduresBlood) then
    LabelProceduresBlood := TMFLabel.create;
  Result := LabelProceduresBlood.GetTempLabel(30, 240, 14,
    'Количество процедур крови: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelProceduresBlood выполнена');
end;

function TMMMonthlyPlan.GetLabelProceduresPlasmaAPA(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProceduresPlasmaAPA) then
    LabelProceduresPlasmaAPA := TMFLabel.create;
  Result := LabelProceduresPlasmaAPA.GetTempLabel(30, 270, 14,
    'Количество процедур плазмафереза: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelProceduresPlasmaAPA выполнена');
end;

function TMMMonthlyPlan.GetLabelProceduresTrombo(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProceduresTrombo) then
    LabelProceduresTrombo := TMFLabel.create;
  Result := LabelProceduresTrombo.GetTempLabel(30, 300, 14,
    'Количество процедур цитофереза: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelProceduresTrombo выполнена');
end;

function TMMMonthlyPlan.GetLabelVolumePlasmaAPA(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumePlasmaAPA) then
    LabelVolumePlasmaAPA := TMFLabel.create;
  Result := LabelVolumePlasmaAPA.GetTempLabel(30, 340, 14,
    'Объем плазмы АПА, мл: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelVolumePlasmaAPA выполнена');
end;

function TMMMonthlyPlan.GetLabelVolumeErSusp(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumeErSusp) then
    LabelVolumeErSusp := TMFLabel.create;
  Result := LabelVolumeErSusp.GetTempLabel(30, 370, 14, 'Объем эр. сред, мл: ',
    NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelVolumeErSusp выполнена');
end;

function TMMMonthlyPlan.GetLabelVolumeTrombo(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumeTrombo) then
    LabelVolumeTrombo := TMFLabel.create;
  Result := LabelVolumeTrombo.GetTempLabel(30, 400, 14,
    'Количество ед. доз тромбоконцентрата: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelVolumeTrombo выполнена');
end;

function TMMMonthlyPlan.GetLabelNumberWorkDays(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberWorkDays) then
    LabelNumberWorkDays := TMFLabel.create;
  Result := LabelNumberWorkDays.GetTempLabel(30, 440, 14,
    'Количество рабочих дней: ', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelNumberWorkDays выполнена');
end;

function TMMMonthlyPlan.GetLabelWorkDays(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelWorkDays) then
    LabelWorkDays := TMFLabel.create;
  Result := LabelWorkDays.GetTempLabel(670, 280, 14,
    'Выбери рабочие дни в отчетном периоде (Нажми Ctrl+...). ', NameForm);
  LabelWorkDays.Width(200);
  LabelWorkDays.WordWrap(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelWorkDays выполнена');
end;

procedure TMMMonthlyPlan.OnChangeCbox(Sender: TObject);
begin
  LBoxCalendar.ContentListBox
    (StrToInt(CBoxYear.GetItemsValue(CBoxYear.GetItemIndex)),
    CBoxMonth.GetItemIndex + 1);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.OnChangeCbox выполнена');
end;

procedure TMMMonthlyPlan.Show;
begin
  LabelDate.Visible(True);
  LabelVolumeWholeBlood.Visible(True);
  LabelVolumeStoredBlood.Visible(True);
  LabelVolumePlasmaTotal.Visible(True);
  LabelProceduresBlood.Visible(True);
  LabelProceduresPlasmaAPA.Visible(True);
  LabelProceduresTrombo.Visible(True);
  LabelVolumePlasmaAPA.Visible(True);
  LabelVolumeErSusp.Visible(True);
  LabelVolumeTrombo.Visible(True);
  LabelNumberWorkDays.Visible(True);
  LabelWorkDays.Visible(True);

  PanelVert.Visible(True);
  PanelGor1.Visible(True);
  PanelGor2.Visible(True);
  PanelGor3.Visible(True);
  PanelGor4.Visible(True);
  PanelGor5.Visible(True);
  PanelGor6.Visible(True);

  EditVolumeWholeBlood.Visible(True);
  EditVolumeStoredBlood.Visible(True);
  EditVolumePlasmaTotal.Visible(True);
  EditProceduresBlood.Visible(True);
  EditProceduresPlasmaAPA.Visible(True);
  EditProceduresTrombo.Visible(True);
  EditVolumePlasmaAPA.Visible(True);
  EditVolumeErSusp.Visible(True);
  EditVolumeTrombo.Visible(True);
  EditNumberWorkDays.Visible(True);

  CBoxMonth.Visible(True);
  CBoxYear.Visible(True);
  LBoxCalendar.Visible(True);

  StringGrid.Visible(True);

  ButtonEdit.Visible(True);
  ButtonAdd.Visible(True);
  ButtonDelete.Visible(True);
  ButtonBlock.Visible(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.Show выполнена');
end;

function TMMMonthlyPlan.GetPanelVert(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert) then
    PanelVert := TMFPanel.create;
  Result := PanelVert.GetTempPanel(360, 140, 323, 1, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetPanelVert выполнена');
end;

procedure TMMMonthlyPlan.GetPeriod;
begin
  Period := EncodeDate(StrToInt(CBoxYear.GetItemsValue(CBoxYear.GetItemIndex)),
    CBoxMonth.GetItemIndex + 1, 1);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetPeriod выполнена');
end;

function TMMMonthlyPlan.GetPanelGor1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor1) then
    PanelGor1 := TMFPanel.create;
  Result := PanelGor1.GetTempPanel(150, 165, 1, 320, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetPanelGor1 выполнена');
end;

function TMMMonthlyPlan.GetPanelGor2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor2) then
    PanelGor2 := TMFPanel.create;
  Result := PanelGor2.GetTempPanel(150, 195, 1, 320, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetPanelGor2 выполнена');
end;

function TMMMonthlyPlan.GetPanelGor3(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor3) then
    PanelGor3 := TMFPanel.create;
  Result := PanelGor3.GetTempPanel(150, 265, 1, 320, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetPanelGor3 выполнена');
end;

function TMMMonthlyPlan.GetPanelGor4(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor4) then
    PanelGor4 := TMFPanel.create;
  Result := PanelGor4.GetTempPanel(150, 295, 1, 320, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetPanelGor4 выполнена');
end;

function TMMMonthlyPlan.GetPanelGor5(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor5) then
    PanelGor5 := TMFPanel.create;
  Result := PanelGor5.GetTempPanel(150, 365, 1, 320, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetPanelGor5 выполнена');
end;

function TMMMonthlyPlan.GetPanelGor6(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor6) then
    PanelGor6 := TMFPanel.create;
  Result := PanelGor6.GetTempPanel(150, 395, 1, 320, 0, NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetPanelGor6 выполнена');
end;

function TMMMonthlyPlan.GetEditVolumeWholeBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeWholeBlood) then
    EditVolumeWholeBlood := TMFEdit.create;
  Result := EditVolumeWholeBlood.GetEdit(370, 140, 100, 10, False, NameForm);
  EditVolumeWholeBlood.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditVolumeWholeBlood выполнена');
end;

function TMMMonthlyPlan.GetEditVolumeStoredBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeStoredBlood) then
    EditVolumeStoredBlood := TMFEdit.create;
  Result := EditVolumeStoredBlood.GetEdit(370, 170, 100, 10, False, NameForm);
  EditVolumeStoredBlood.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditVolumeStoredBlood выполнена');
end;

function TMMMonthlyPlan.GetEditVolumePlasmaTotal(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumePlasmaTotal) then
    EditVolumePlasmaTotal := TMFEdit.create;
  Result := EditVolumePlasmaTotal.GetEdit(370, 200, 100, 10, False, NameForm);
  EditVolumePlasmaTotal.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditVolumePlasmaTotal выполнена');
end;

function TMMMonthlyPlan.GetEditProceduresBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditProceduresBlood) then
    EditProceduresBlood := TMFEdit.create;
  Result := EditProceduresBlood.GetEdit(370, 240, 100, 10, False, NameForm);
  EditProceduresBlood.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditProceduresBlood выполнена');
end;

function TMMMonthlyPlan.GetEditProceduresPlasmaAPA(NameForm: TForm): TEdit;
begin
  if not Assigned(EditProceduresPlasmaAPA) then
    EditProceduresPlasmaAPA := TMFEdit.create;
  Result := EditProceduresPlasmaAPA.GetEdit(370, 270, 100, 10, False, NameForm);
  EditProceduresPlasmaAPA.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditProceduresPlasmaAPA выполнена');
end;

function TMMMonthlyPlan.GetEditProceduresTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditProceduresTrombo) then
    EditProceduresTrombo := TMFEdit.create;
  Result := EditProceduresTrombo.GetEdit(370, 300, 100, 10, False, NameForm);
  EditProceduresTrombo.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditProceduresTrombo выполнена');
end;

function TMMMonthlyPlan.GetEditVolumePlasmaAPA(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumePlasmaAPA) then
    EditVolumePlasmaAPA := TMFEdit.create;
  Result := EditVolumePlasmaAPA.GetEdit(370, 340, 100, 10, False, NameForm);
  EditVolumePlasmaAPA.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditVolumePlasmaAPA выполнена');
end;

function TMMMonthlyPlan.GetEditVolumeErSusp(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeErSusp) then
    EditVolumeErSusp := TMFEdit.create;
  Result := EditVolumeErSusp.GetEdit(370, 370, 100, 10, False, NameForm);
  EditVolumeErSusp.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditVolumeErSusp выполнена');
end;

function TMMMonthlyPlan.GetEditVolumeTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeTrombo) then
    EditVolumeTrombo := TMFEdit.create;
  Result := EditVolumeTrombo.GetEdit(370, 400, 100, 10, False, NameForm);
  EditVolumeTrombo.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditVolumeTrombo выполнена');
end;

function TMMMonthlyPlan.GetEditNumberWorkDays(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberWorkDays) then
    EditNumberWorkDays := TMFEdit.create;
  Result := EditNumberWorkDays.GetEdit(370, 440, 100, 10, False, NameForm);
  EditNumberWorkDays.NumberOnly(True);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetEditNumberWorkDays выполнена');
end;

function TMMMonthlyPlan.GetCBoxMonth(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxMonth) then
    CBoxMonth := TMFComboBox.create;
  Result := CBoxMonth.GetComboBox('CBoxMonth', 30, 90, 100, 14, NameForm);
  CBoxMonth.AddItem('Январь');
  CBoxMonth.AddItem('Февраль');
  CBoxMonth.AddItem('Март');
  CBoxMonth.AddItem('Апрель');
  CBoxMonth.AddItem('Май');
  CBoxMonth.AddItem('Июнь');
  CBoxMonth.AddItem('Июль');
  CBoxMonth.AddItem('Август');
  CBoxMonth.AddItem('Сентябрь');
  CBoxMonth.AddItem('Октябрь');
  CBoxMonth.AddItem('Ноябрь');
  CBoxMonth.AddItem('Декабрь');
  CBoxMonth.WriteItemIndex(MonthOf(Date()));
  CBoxMonth.GetOnChange(OnChangeCbox);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetCBoxMonth выполнена');
end;

function TMMMonthlyPlan.GetCBoxYear(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxYear) then
    CBoxYear := TMFComboBox.create;
  Result := CBoxYear.GetComboBox('CBoxYear', 150, 90, 70, 14, NameForm);
  CBoxYear.AddItem(IntToStr(YearOf(Date()) - 2));
  CBoxYear.AddItem(IntToStr(YearOf(Date()) - 1));
  CBoxYear.AddItem(IntToStr(YearOf(Date())));
  CBoxYear.AddItem(IntToStr(YearOf(Date()) + 1));
  CBoxYear.AddItem(IntToStr(YearOf(Date()) + 2));
  CBoxYear.WriteItemIndex(2);
  CBoxYear.GetOnChange(OnChangeCbox);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetCBoxYear выполнена');
end;

function TMMMonthlyPlan.GetLBoxCalendar(NameForm: TForm): TListBox;
begin
  if not Assigned(LBoxCalendar) then
    LBoxCalendar := TMFListBox.create;
  Result := LBoxCalendar.GetListBox(520, 140, 110, 325, 12, NameForm);
  LBoxCalendar.ContentListBox
    (StrToInt(CBoxYear.GetItemsValue(CBoxYear.GetItemIndex)),
    CBoxMonth.GetItemIndex + 1);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLBoxCalendar выполнена');
end;

// Label
function TMMMonthlyPlan.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TMFTitleLabel.create;
  Result := Title.GetTitleLabel(25, 'Ввод плановых показателей', NameForm);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetLabelTitle выполнена');
end;

// StringGrid
function TMMMonthlyPlan.GetStringGrid(NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i := 0;
  j := 0;
  if not Assigned(StringGrid) then
    StringGrid := TMFStringGrid.create;
  StringGrid.ResultFormat(DT_CENTER, 1, DT_CENTER, 11, DT_CENTER, 11, DT_CENTER,
    11, DT_CENTER, 11, DT_CENTER);
  Result := StringGrid.GetStringGrid(30, 490, 840, 150, 11, 2, 9, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.Visible(True);
  StringGrid.ColWidth(0, 60);
  StringGrid.ColWidth(1, 60);
  StringGrid.ColWidth(2, 65);
  StringGrid.ColWidth(3, 65);
  StringGrid.ColWidth(4, 75);
  StringGrid.ColWidth(5, 75);
  StringGrid.ColWidth(6, 75);
  StringGrid.ColWidth(7, 60);
  StringGrid.ColWidth(8, 70);
  StringGrid.ColWidth(9, 100);
  StringGrid.ColWidth(10, 95);
  StringGrid.WriteCells(0, 0, 'Дата');
  StringGrid.WriteCells(1, 0, 'Цел кр, л');
  StringGrid.WriteCells(2, 0, 'Конс кр, л');
  StringGrid.WriteCells(3, 0, 'Всего пл, л');
  StringGrid.WriteCells(4, 0, 'Проц-ры кр');
  StringGrid.WriteCells(5, 0, 'Проц-ры пл');
  StringGrid.WriteCells(6, 0, 'Проц-ры тр');
  StringGrid.WriteCells(7, 0, 'V АПА, л');
  StringGrid.WriteCells(8, 0, 'V эр сред, л');
  StringGrid.WriteCells(9, 0, 'Кол-во тромбо, д');
  StringGrid.WriteCells(10, 0, 'Кол-во раб дней');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TBMMonthlyPlan.create;
  ContentForStringGrid.GetContent;
  if ContentForStringGrid.GetRowCount > 0 then
    for i := 0 to ContentForStringGrid.GetRowCount - 1 do
    begin
      if StringGrid.GetValue(0, 1) <> '' then
        StringGrid.AddRowCount;
      StringGrid.WriteCells(0, i + 1, ContentForStringGrid.GetDate(j));
      StringGrid.WriteCells(1, i + 1,
        ContentForStringGrid.GetVolumeWholeBlood(j));
      StringGrid.WriteCells(2, i + 1,
        ContentForStringGrid.GetVolumeStoredBlood(j));
      StringGrid.WriteCells(3, i + 1,
        ContentForStringGrid.GetVolumePlasmaTotal(j));
      StringGrid.WriteCells(4, i + 1,
        ContentForStringGrid.GetProceduresBlood(j));
      StringGrid.WriteCells(5, i + 1,
        ContentForStringGrid.GetProceduresPlasmaAPA(j));
      StringGrid.WriteCells(6, i + 1,
        ContentForStringGrid.GetProceduresTrombo(j));
      StringGrid.WriteCells(7, i + 1,
        ContentForStringGrid.GetVolumePlasmaAPA(j));
      StringGrid.WriteCells(8, i + 1, ContentForStringGrid.GetVolumeErSusp(j));
      StringGrid.WriteCells(9, i + 1, ContentForStringGrid.GetVolumeTrombo(j));
      StringGrid.WriteCells(10, i + 1,
        ContentForStringGrid.GetNumberWorkDays(j));
      j := j + 1;
    end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMMMonthlyPlan.GetStringGrid выполнена');
end;
end.
