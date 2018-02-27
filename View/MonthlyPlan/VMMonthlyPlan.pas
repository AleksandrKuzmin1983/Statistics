unit VMMonthlyPlan;

interface

uses
  Vcl.ExtCtrls, WinProcs, SysUtils, StdCtrls, Buttons, Vcl.Grids, Data.DB,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,

  UMSCheckFillStringFields,
  UMSBlockMainMenu,
  UVFLabel,
  UVFTitleLabel,
  UVFEdit,
  UVFListBox,
  UVFBitBtnAdd,
  UVFBitBtnDelete,
  UVFBitBtnEdit,
  UVFBitBtnBlock,
  UVFStringGrid,
  UVFComboBox,
  UVFPanel,
  MMListOfDate,
  MMMonthlyPlan,
  MMAddRecoedMonthlyPlan,
  MMDeleteRecordMonthlyPlan,
//  MHAChangeRecordAutomaticApheresis,
  UMSCheckForExistenceOfRecord,
  UMSValueChecksOnTheAdequacy,
  UMSGlobalVariant;

type
  TVMMonthlyPlan = class(TGlobalVariant)
  private
    LabelDate: TTempLabelTag5;
    LabelVolumeWholeBlood: TTempLabelTag5;
    LabelVolumeStoredBlood: TTempLabelTag5;
    LabelVolumePlasmaTotal: TTempLabelTag5;
    LabelProceduresBlood: TTempLabelTag5;
    LabelProceduresPlasmaAPA: TTempLabelTag5;
    LabelProceduresTrombo: TTempLabelTag5;
    LabelVolumePlasmaAPA: TTempLabelTag5;
    LabelVolumeErSusp: TTempLabelTag5;
    LabelVolumeTrombo: TTempLabelTag5;
    LabelNumberWorkDays: TTempLabelTag5;
    LabelWorkDays: TTempLabelTag5;

    Title: TTitleLabelTag5;
    SQL: String;

    PanelVert: TTempPanelTag5;
    PanelGor1: TTempPanelTag5;
    PanelGor2: TTempPanelTag5;
    PanelGor3: TTempPanelTag5;
    PanelGor4: TTempPanelTag5;
    PanelGor5: TTempPanelTag5;
    PanelGor6: TTempPanelTag5;

    EditVolumeWholeBlood: TEditTag5;
    EditVolumeStoredBlood: TEditTag5;
    EditVolumePlasmaTotal: TEditTag5;
    EditProceduresBlood: TEditTag5;
    EditProceduresPlasmaAPA: TEditTag5;
    EditProceduresTrombo: TEditTag5;
    EditVolumePlasmaAPA: TEditTag5;
    EditVolumeErSusp: TEditTag5;
    EditVolumeTrombo: TEditTag5;
    EditNumberWorkDays: TEditTag5;

    CBoxMonth: TComboboxTag5;
    CBoxYear: TComboboxTag5;
    Period: TDate;
    LBoxCalendar: TListBoxTag5;

    StringGrid: TStringGridTag5;
    ContentForStringGrid: IMMMonthlyPlan;
    ListOfDate: IMMListOfDate;

    AddRecord: IMMAddRecoedMonthlyPlan;
    DeleteRecord: IMMDeleteRecordMonthlyPlan;
//    ChangeRecord: IMHAChangeRecordAutomaticApheresis;

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

constructor TVMMonthlyPlan.create(form: TForm);
begin
  CurrentForm:=Form;

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
  inherited;
end;

destructor TVMMonthlyPlan.destroy;
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
  inherited;
end;

//Button

procedure TVMMonthlyPlan.AfterSaving_Cancelling;
var
  i: integer;
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
end;

// Добавление новой записи

procedure TVMMonthlyPlan.ButtonAdded(Sender: TObject);
var
  i: integer;
begin
  GetPeriod;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(CheckForExistenceOfRecord) then
      CheckForExistenceOfRecord := TUMSCheckForExistenceOfRecord.create;
    SQL:='SELECT Plans.ДатаПлан ' +
      'FROM Plans ' +
      'WHERE Plans.ДатаПлан=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Period)) + '# ';
    if CheckForExistenceOfRecord.CheckForExistenceOfRecord(SQL) then exit;
    if CheckingBeforeSaving then exit;
    if not Assigned(AddRecord) then
      AddRecord := TMMAddRecoedMonthlyPlan.create;
    AddRecord.AddRecordPlasma(Period, EditVolumeWholeBlood.ReadText, EditVolumeStoredBlood.ReadText,
      EditVolumePlasmaTotal.ReadText, EditProceduresBlood.ReadText, EditProceduresPlasmaAPA.ReadText,
      EditProceduresTrombo.ReadText, EditVolumePlasmaAPA.ReadText, EditVolumeErSusp.ReadText,
      EditVolumeTrombo.ReadText, EditNumberWorkDays.ReadText);
    for i:=0 to LBoxCalendar.GetItemsCount-1 do
      if LBoxCalendar.CheckSelected(i) then
        AddRecord.AddRecordDays(StrToDate(LBoxCalendar.GetItemsValue(i)));
    GetStringGrid(CurrentForm);
    AfterSaving_Cancelling;
  end;
end;

// Разблокировка кнопок

procedure TVMMonthlyPlan.ButtonBlocked(Sender: TObject);
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

procedure TVMMonthlyPlan.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись от ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + ' числа?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TMMDeleteRecordMonthlyPlan.create;
    DeleteRecord.DeleteRecord(StringGrid.GetValue(0, StringGrid.CurrentRow));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount-1);
    ShowMessage('Запись успешно удалена!');
  end;
  AfterSaving_Cancelling;
end;

// Внесение изменений
procedure TVMMonthlyPlan.ButtonEdited(Sender: TObject);
var
 i, j: integer;
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
    CBoxMonth.Enabled(False);
    CBoxYear.Enabled(False);
    ButtonDelete.ChangeEnabled(False);

    StringGrid.Enabled(False);

    CBoxMonth.WriteItemIndex(MonthOf(StrToDate(StringGrid.GetValue(0, StringGrid.CurrentRow)))-1);
    CBoxYear.WriteItemIndex(YearOf(StrToDate(StringGrid.GetValue(0, StringGrid.CurrentRow)))-YearOf(Date())+2);
    OnChangeCbox(CBoxMonth);

    EditVolumeWholeBlood.WriteText(StringGrid.GetValue(1 , StringGrid.CurrentRow));
    EditVolumeStoredBlood.WriteText(StringGrid.GetValue(2 , StringGrid.CurrentRow));
    EditVolumePlasmaTotal.WriteText(StringGrid.GetValue(3 , StringGrid.CurrentRow));
    EditProceduresBlood.WriteText(StringGrid.GetValue(4 , StringGrid.CurrentRow));
    EditProceduresPlasmaAPA.WriteText(StringGrid.GetValue(5 , StringGrid.CurrentRow));
    EditProceduresTrombo.WriteText(StringGrid.GetValue(6 , StringGrid.CurrentRow));
    EditVolumePlasmaAPA.WriteText(StringGrid.GetValue(7 , StringGrid.CurrentRow));
    EditVolumeErSusp.WriteText(StringGrid.GetValue(8 , StringGrid.CurrentRow));
    EditVolumeTrombo.WriteText(StringGrid.GetValue(9 , StringGrid.CurrentRow));
    EditNumberWorkDays.WriteText(StringGrid.GetValue(10 , StringGrid.CurrentRow));

    if not Assigned(ListOfDate) then
      ListOfDate := TMMListOfDate.create;
    ListOfDate.GetContent(MonthOf(StrToDate(StringGrid.GetValue(0, StringGrid.CurrentRow))), YearOf(StrToDate(StringGrid.GetValue(0, StringGrid.CurrentRow))));
    for i:=0 to ListOfDate.GetRowCount-1 do
      for j:=0 to LBoxCalendar.GetItemsCount-1 do
        if ListOfDate.GetList(i)=LBoxCalendar.GetItemsValue(j) then
        begin
          LBoxCalendar.SetSelected(j, true);
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
      CBoxMonth.Enabled(True);
      CBoxYear.Enabled(True);
      StringGrid.Enabled(True);
      if CheckingBeforeSaving then exit;
      if not Assigned(AddRecord) then
        AddRecord := TMMAddRecoedMonthlyPlan.create;
      if not Assigned(DeleteRecord) then
        DeleteRecord := TMMDeleteRecordMonthlyPlan.create;  
      GetPeriod;          
      DeleteRecord.DeleteRecord(StringGrid.GetValue(0, StringGrid.CurrentRow));
      AddRecord.AddRecordPlasma(Period, EditVolumeWholeBlood.ReadText, EditVolumeStoredBlood.ReadText,
        EditVolumePlasmaTotal.ReadText, EditProceduresBlood.ReadText, EditProceduresPlasmaAPA.ReadText,
        EditProceduresTrombo.ReadText, EditVolumePlasmaAPA.ReadText, EditVolumeErSusp.ReadText,
        EditVolumeTrombo.ReadText, EditNumberWorkDays.ReadText);
      for i:=0 to LBoxCalendar.GetItemsCount-1 do
        if LBoxCalendar.CheckSelected(i) then
          AddRecord.AddRecordDays(StrToDate(LBoxCalendar.GetItemsValue(i)));
      GetStringGrid(CurrentForm);
      AfterSaving_Cancelling;
      GetStringGrid(CurrentForm);
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
      CBoxMonth.Enabled(True);
      CBoxYear.Enabled(True);
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
function TVMMonthlyPlan.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
 if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(670, 0, ButtonAdded, NameForm);
end;

function TVMMonthlyPlan.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(670, 0, ButtonBlocked, NameForm);
end;

function TVMMonthlyPlan.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
 if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(670, 0, ButtonDeleted, NameForm);
end;

function TVMMonthlyPlan.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(670, 0, ButtonEdited, NameForm);
end;

function TVMMonthlyPlan.CheckingBeforeSaving: boolean;
var
  value1, value2: integer;
begin
  result:=true;
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  EditVolumeWholeBlood.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeWholeBlood.ReadText));
  EditVolumeStoredBlood.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeStoredBlood.ReadText));
  EditVolumePlasmaTotal.WriteText(CheckFillStrFields.CheckStringFields(EditVolumePlasmaTotal.ReadText));
  EditProceduresBlood.WriteText(CheckFillStrFields.CheckStringFields(EditProceduresBlood.ReadText));
  EditProceduresPlasmaAPA.WriteText(CheckFillStrFields.CheckStringFields(EditProceduresPlasmaAPA.ReadText));
  EditProceduresTrombo.WriteText(CheckFillStrFields.CheckStringFields(EditProceduresTrombo.ReadText));
  EditVolumePlasmaAPA.WriteText(CheckFillStrFields.CheckStringFields(EditVolumePlasmaAPA.ReadText));
  EditVolumeErSusp.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeErSusp.ReadText));
  EditVolumeTrombo.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeTrombo.ReadText));
  EditNumberWorkDays.WriteText(CheckFillStrFields.CheckStringFields(EditNumberWorkDays.ReadText));

  if not Assigned(ValueChecksOnTheAdequacy) then
    ValueChecksOnTheAdequacy := TUMSValueChecksOnTheAdequacy.create;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumeWholeBlood.ReadText, 'План по объему заготавливаемой цельной крови не может равняться нулю!') then exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumeStoredBlood.ReadText, 'План по объему заготавливаемой консервированной крови не может равняться нулю!') then exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumePlasmaTotal.ReadText, 'План по объему заготавливаемой плазмы (всего) не может равняться нулю!') then exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditProceduresBlood.ReadText, 'План по количеству процедур цельной крови не может равняться нулю!') then exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditProceduresPlasmaAPA.ReadText, 'План по количеству процедур плазмы АПА не может равняться нулю!') then exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumePlasmaAPA.ReadText, 'План по объему заготавливаемой плазмы АПА не может равняться нулю!') then exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditVolumeErSusp.ReadText, 'План по объему заготавливаемых эр. сред не может равняться нулю!') then exit;
  if ValueChecksOnTheAdequacy.CheckZeroValues(EditNumberWorkDays.ReadText, 'Количество рабочих дней в плановом периоде не может равняться нулю!') then exit;
  if LBoxCalendar.GetNumberSelectedString<>StrToInt(EditNumberWorkDays.ReadText) then
  begin
    ShowMessage('Количество рабочих дней не соответствует количеству выделенных дней в календаре!');
    exit;
  end;
  result:=false;
end;

function TVMMonthlyPlan.GetLabelDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDate) then
    LabelDate := TTempLabelTag5.create;
  result := LabelDate.GetTempLabel(30, 60, 14, 'Плановый период: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelVolumeWholeBlood(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumeWholeBlood) then
    LabelVolumeWholeBlood := TTempLabelTag5.create;
  result := LabelVolumeWholeBlood.GetTempLabel(30, 140, 14, 'Объем цельной крови, мл: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelVolumeStoredBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumeStoredBlood) then
    LabelVolumeStoredBlood := TTempLabelTag5.create;
  result := LabelVolumeStoredBlood.GetTempLabel(30, 170, 14, 'Объем консервированной крови, мл: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelVolumePlasmaTotal(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumePlasmaTotal) then
    LabelVolumePlasmaTotal := TTempLabelTag5.create;
  result := LabelVolumePlasmaTotal.GetTempLabel(30, 200, 14, 'Объем плазмы (всего), мл: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelProceduresBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProceduresBlood) then
    LabelProceduresBlood := TTempLabelTag5.create;
  result := LabelProceduresBlood.GetTempLabel(30, 240, 14, 'Количество процедур крови: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelProceduresPlasmaAPA(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProceduresPlasmaAPA) then
    LabelProceduresPlasmaAPA := TTempLabelTag5.create;
  result := LabelProceduresPlasmaAPA.GetTempLabel(30, 270, 14, 'Количество процедур плазмафереза: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelProceduresTrombo(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProceduresTrombo) then
    LabelProceduresTrombo := TTempLabelTag5.create;
  result := LabelProceduresTrombo.GetTempLabel(30, 300, 14, 'Количество процедур цитофереза: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelVolumePlasmaAPA(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumePlasmaAPA) then
    LabelVolumePlasmaAPA := TTempLabelTag5.create;
  result := LabelVolumePlasmaAPA.GetTempLabel(30, 340, 14, 'Объем плазмы АПА, мл: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelVolumeErSusp(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumeErSusp) then
    LabelVolumeErSusp := TTempLabelTag5.create;
  result := LabelVolumeErSusp.GetTempLabel(30, 370, 14, 'Объем эр. сред, мл: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelVolumeTrombo(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumeTrombo) then
    LabelVolumeTrombo := TTempLabelTag5.create;
  result := LabelVolumeTrombo.GetTempLabel(30, 400, 14, 'Количество ед. доз тромбоконцентрата: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelNumberWorkDays(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberWorkDays) then
    LabelNumberWorkDays := TTempLabelTag5.create;
  result := LabelNumberWorkDays.GetTempLabel(30, 440, 14, 'Количество рабочих дней: ', NameForm);
end;

function TVMMonthlyPlan.GetLabelWorkDays(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelWorkDays) then
    LabelWorkDays := TTempLabelTag5.create;
  result := LabelWorkDays.GetTempLabel(670, 280, 14, 'Выбери рабочие дни в отчетном периоде (Нажми Ctrl+...). ', NameForm);
  LabelWorkDays.Width(200);
  LabelWorkDays.WordWrap(true);
end;

procedure TVMMonthlyPlan.OnChangeCbox(Sender: TObject);
begin
  LBoxCalendar.ContentListBox(StrToInt(CBoxYear.GetItemsValue(CBoxYear.GetItemIndex)), CBoxMonth.GetItemIndex+1);
end;

procedure TVMMonthlyPlan.Show;
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
end;

function TVMMonthlyPlan.GetPanelVert(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert) then
    PanelVert := TTempPanelTag5.create;
  Result:=PanelVert.GetTempPanel(360, 140, 323, 1, 0, NameForm);
end;

procedure TVMMonthlyPlan.GetPeriod;
begin
  Period:=EncodeDate(StrToInt(CBoxYear.GetItemsValue(CBoxYear.GetItemIndex)),CBoxMonth.GetItemIndex + 1,1);
end;

function TVMMonthlyPlan.GetPanelGor1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor1) then
    PanelGor1 := TTempPanelTag5.create;
  Result:=PanelGor1.GetTempPanel(150, 165, 1, 320, 0, NameForm);
end;

function TVMMonthlyPlan.GetPanelGor2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor2) then
    PanelGor2 := TTempPanelTag5.create;
  Result:=PanelGor2.GetTempPanel(150, 195, 1, 320, 0, NameForm);
end;

function TVMMonthlyPlan.GetPanelGor3(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor3) then
    PanelGor3 := TTempPanelTag5.create;
  Result:=PanelGor3.GetTempPanel(150, 265, 1, 320, 0, NameForm);
end;

function TVMMonthlyPlan.GetPanelGor4(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor4) then
    PanelGor4 := TTempPanelTag5.create;
  Result:=PanelGor4.GetTempPanel(150, 295, 1, 320, 0, NameForm);
end;

function TVMMonthlyPlan.GetPanelGor5(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor5) then
    PanelGor5 := TTempPanelTag5.create;
  Result:=PanelGor5.GetTempPanel(150, 365, 1, 320, 0, NameForm);
end;

function TVMMonthlyPlan.GetPanelGor6(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor6) then
    PanelGor6 := TTempPanelTag5.create;
  Result:=PanelGor6.GetTempPanel(150, 395, 1, 320, 0, NameForm);
end;

function TVMMonthlyPlan.GetEditVolumeWholeBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeWholeBlood) then
    EditVolumeWholeBlood := TEditTag5.create;
  Result:=EditVolumeWholeBlood.GetEdit(370, 140, 100, 10, False, NameForm);
  EditVolumeWholeBlood.NumberOnly(True);
end;

function TVMMonthlyPlan.GetEditVolumeStoredBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeStoredBlood) then
    EditVolumeStoredBlood := TEditTag5.create;
  Result:=EditVolumeStoredBlood.GetEdit(370, 170, 100, 10, False, NameForm);
  EditVolumeStoredBlood.NumberOnly(True);
end;

function TVMMonthlyPlan.GetEditVolumePlasmaTotal(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumePlasmaTotal) then
    EditVolumePlasmaTotal := TEditTag5.create;
  Result:=EditVolumePlasmaTotal.GetEdit(370, 200, 100, 10, False, NameForm);
  EditVolumePlasmaTotal.NumberOnly(True);
end;

function TVMMonthlyPlan.GetEditProceduresBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditProceduresBlood) then
    EditProceduresBlood := TEditTag5.create;
  Result:=EditProceduresBlood.GetEdit(370, 240, 100, 10, False, NameForm);
  EditProceduresBlood.NumberOnly(True);
end;

function TVMMonthlyPlan.GetEditProceduresPlasmaAPA(NameForm: TForm): TEdit;
begin
  if not Assigned(EditProceduresPlasmaAPA) then
    EditProceduresPlasmaAPA := TEditTag5.create;
  Result:=EditProceduresPlasmaAPA.GetEdit(370, 270, 100, 10, False, NameForm);
  EditProceduresPlasmaAPA.NumberOnly(True);
end;

function TVMMonthlyPlan.GetEditProceduresTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditProceduresTrombo) then
    EditProceduresTrombo := TEditTag5.create;
  Result:=EditProceduresTrombo.GetEdit(370, 300, 100, 10, False, NameForm);
  EditProceduresTrombo.NumberOnly(True);
end;

function TVMMonthlyPlan.GetEditVolumePlasmaAPA(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumePlasmaAPA) then
    EditVolumePlasmaAPA := TEditTag5.create;
  Result:=EditVolumePlasmaAPA.GetEdit(370, 340, 100, 10, False, NameForm);
  EditVolumePlasmaAPA.NumberOnly(True);
end;

function TVMMonthlyPlan.GetEditVolumeErSusp(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeErSusp) then
    EditVolumeErSusp := TEditTag5.create;
  Result:=EditVolumeErSusp.GetEdit(370, 370, 100, 10, False, NameForm);
  EditVolumeErSusp.NumberOnly(True);
end;

function TVMMonthlyPlan.GetEditVolumeTrombo(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeTrombo) then
    EditVolumeTrombo := TEditTag5.create;
  Result:=EditVolumeTrombo.GetEdit(370, 400, 100, 10, False, NameForm);
  EditVolumeTrombo.NumberOnly(True);
end;


function TVMMonthlyPlan.GetEditNumberWorkDays(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberWorkDays) then
    EditNumberWorkDays := TEditTag5.create;
  Result:=EditNumberWorkDays.GetEdit(370, 440, 100, 10, False, NameForm);
  EditNumberWorkDays.NumberOnly(True);
end;

function TVMMonthlyPlan.GetCBoxMonth(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxMonth) then
    CBoxMonth := TComboboxTag5.create;
  result := CBoxMonth.GetComboBox('CBoxMonth', 30, 90, 100, 14, NameForm);
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
end;

function TVMMonthlyPlan.GetCBoxYear(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxYear) then
    CBoxYear := TComboboxTag5.create;
  result := CBoxYear.GetComboBox('CBoxYear', 150, 90, 70, 14, NameForm);
  CBoxYear.AddItem(IntToStr(YearOF(Date())-2));
  CBoxYear.AddItem(IntToStr(YearOF(Date())-1));
  CBoxYear.AddItem(IntToStr(YearOF(Date())));
  CBoxYear.AddItem(IntToStr(YearOF(Date())+1));
  CBoxYear.AddItem(IntToStr(YearOF(Date())+2));
  CBoxYear.WriteItemIndex(2);
  CBoxYear.GetOnChange(OnChangeCbox);
end;

function TVMMonthlyPlan.GetLBoxCalendar(NameForm: TForm): TListBox;
begin
  if not Assigned(LBoxCalendar) then
    LBoxCalendar := TListBoxTag5.create;
  result := LBoxCalendar.GetListBox(520, 140, 110, 325, 12, NameForm);
  LBoxCalendar.ContentListBox(StrToInt(CBoxYear.GetItemsValue(CBoxYear.GetItemIndex)), CBoxMonth.GetItemIndex+1);
end;

//Label
function TVMMonthlyPlan.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(25, 'Ввод плановых показателей', NameForm);
end;




// StringGrid
function TVMMonthlyPlan.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i:=0; j:=0;
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 1, DT_CENTER, 11, DT_CENTER, 11, DT_CENTER, 11, DT_CENTER, 11, DT_CENTER);
  Result:=StringGrid.GetStringGrid(30, 490, 840, 150, 11, 2, 9, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.Visible(true);
  StringGrid.ColWidth(0,60);
  StringGrid.ColWidth(1,60);
  StringGrid.ColWidth(2,65);
  StringGrid.ColWidth(3,65);
  StringGrid.ColWidth(4,75);
  StringGrid.ColWidth(5,75);
  StringGrid.ColWidth(6,75);
  StringGrid.ColWidth(7,60);
  StringGrid.ColWidth(8,70);
  StringGrid.ColWidth(9,100);
  StringGrid.ColWidth(10,95);
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
    ContentForStringGrid := TMMMonthlyPlan.create;
  ContentForStringGrid.GetContent;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetDate(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetVolumeWholeBlood(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetVolumeStoredBlood(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetVolumePlasmaTotal(j));
        StringGrid.WriteCells(4, i+1, ContentForStringGrid.GetProceduresBlood(j));
        StringGrid.WriteCells(5, i+1, ContentForStringGrid.GetProceduresPlasmaAPA(j));
        StringGrid.WriteCells(6, i+1, ContentForStringGrid.GetProceduresTrombo(j));
        StringGrid.WriteCells(7, i+1, ContentForStringGrid.GetVolumePlasmaAPA(j));
        StringGrid.WriteCells(8, i+1, ContentForStringGrid.GetVolumeErSusp(j));
        StringGrid.WriteCells(9, i+1, ContentForStringGrid.GetVolumeTrombo(j));
        StringGrid.WriteCells(10, i+1, ContentForStringGrid.GetNumberWorkDays(j));
        j:=j+1;
      end;
end;
end.
