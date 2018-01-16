unit VIOCCheckLPU;

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
  MIOCAddRecordResultsCheckLPU,
  MIOCDeleteRecordResultsCheckLPU,
  MIOCChangeRecordResultsCheckLPU,
  MIOCCheckLPU,
  UMSGlobalVariant;

type
  IVIOCCheckLPU = interface
  end;

  TVIOCCheckLPU = class(TGlobalVariant)
  private
    LabelReportDate: TTempLabelTag5;
    LabelCheckLPU: TTempLabelTag5;
    Title: TTitleLabelTag5;
    SQL: String;

    StringGrid: TStringGridTag5;
    ContentForStringGrid: IMIOCCheckLPU;
    AddRecord: IMIOCAddRecordResultsCheckLPU;
    DeleteRecord: IMIOCDeleteRecordResultsCheckLPU;
    ChangeRecord: IMIOCChangeRecordResultsCheckLPU;

    EditCheckLPU: TEditTag5;

    ReportDateCal: TDTPickerTag5;
    CheckFillStrFields: ICheckFillStringFields;
    BlockMainMenu: IBlockMainMenu;

    ButtonAdd: TBitBtnAddTag5;
    ButtonDelete: TBitBtnDeleteTag5;
    ButtonEdit: TBitBtnEditTag5;
    ButtonBlock: TBitBtnBlockTag5;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelCheckLPU(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;
    function GetEditCheckLPU(NameForm: TForm): TEdit;
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
    constructor create(form: TForm); override;
    destructor destroy; override;
  end;

implementation

{ TBloodProduct }

constructor TVIOCCheckLPU.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelReportDate(form);
  GetLabelCheckLPU(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditCheckLPU(form);


  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
  inherited;
end;

destructor TVIOCCheckLPU.destroy;
begin
    LabelReportDate.destroy;
    LabelCheckLPU.destroy;
    Title.destroy;

    StringGrid.destroy;

    EditCheckLPU.destroy;

    ReportDateCal.destroy;

    ButtonAdd.destroy;
    ButtonDelete.destroy;
    ButtonEdit.destroy;
    ButtonBlock.destroy;
  inherited;
end;

//Button

// Добавление новой записи

procedure TVIOCCheckLPU.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  EditCheckLPU.WriteText(CheckFillStrFields.CheckStringFields(EditCheckLPU.ReadText));
  if (EditCheckLPU.ReadText='0') then
    begin
      Showmessage('Поле "Количество проверок ЛПУ" должно быть заполнено!');
      exit;
    End;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(AddRecord) then
      AddRecord := TMIOCAddRecordResultsCheckLPU.create;
    AddRecord.AddRecord(ReportDateCal.GetDate, EditCheckLPU.ReadText);
    GetStringGrid(CurrentForm);
    ShowMessage('Запись успешно добавлена!');
  end;
  EditCheckLPU.WriteText('0');
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Разблокировка кнопок

procedure TVIOCCheckLPU.ButtonBlocked(Sender: TObject);
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

procedure TVIOCCheckLPU.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TMIOCDeleteRecordResultsCheckLPU.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount-1);
    ShowMessage('Запись успешно удалена!');
  end;
  EditCheckLPU.WriteText('0');
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Внесение изменений

procedure TVIOCCheckLPU.ButtonEdited(Sender: TObject);
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
    EditCheckLPU.WriteText(VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetCaption='Сохранить изменения' then
  begin
    EditCheckLPU.WriteText(CheckFillStrFields.CheckStringFields(EditCheckLPU.ReadText));
    if (EditCheckLPU.ReadText='0') then
    begin
      Showmessage('Поле "Количество проверок ЛПУ" должно быть заполнено!' + char(13) + 'Если запись необходимо удалить, то отмените изменения и воспользуйтесь кнопкой "Удалить запись"!');
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
      ChangeRecord := TMIOCChangeRecordResultsCheckLPU.create;
    ChangeRecord.ChangeRecord(ReportDateCal.GetDate, EditCheckLPU.ReadText,
      StringGrid.GetValue(0, StringGrid.CurrentRow));
    GetStringGrid(CurrentForm);
    ShowMessage('Запись успешно изменена!');
  end
  else
    begin
      EditCheckLPU.WriteText('0');
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end;
    EditCheckLPU.WriteText('0');
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
  end;
  if ButtonEdit.GetCaption='Изменить' then ButtonEdit.ChangeCaption('Сохранить изменения') else ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок

function TVIOCCheckLPU.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TVIOCCheckLPU.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TVIOCCheckLPU.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TVIOCCheckLPU.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TVIOCCheckLPU.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal:=TDTPickerTag5.Create;
  result:=ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-7, NameForm);
end;

//Edit

function TVIOCCheckLPU.GetEditCheckLPU(NameForm: TForm): TEdit;
begin
  if not Assigned(EditCheckLPU) then
    EditCheckLPU := TEditTag5.create;
  Result:=EditCheckLPU.GetEdit(450, 130, 135, 12, False, NameForm);
  EditCheckLPU.NumberOnly(True);
end;

//Label

function TVIOCCheckLPU.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TTempLabelTag5.create;
  result := LabelReportDate.GetTempLabel(50, 80, 16, 'Отчетная неделя: ', NameForm);
end;

function TVIOCCheckLPU.GetLabelCheckLPU(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelCheckLPU) then
    LabelCheckLPU := TTempLabelTag5.create;
  result := LabelCheckLPU.GetTempLabel(50, 130, 14, 'Количество консультаций трансфузиологом: ', NameForm);
end;

function TVIOCCheckLPU.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(25, 'Количество проведенных проверок ЛПУ', NameForm);
end;

//StringGrid

function TVIOCCheckLPU.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 1, DT_LEFT, 2, DT_Center, 3, DT_Center, 4, DT_Center);
  Result:=StringGrid.GetStringGrid(50, 280, 800, 240, 3, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0,60);
  StringGrid.ColWidth(1,100);
  StringGrid.ColWidth(2,160);
  StringGrid.Visible(true);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Количество проверок');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TMIOCCheckLPU.create;
  ContentForStringGrid.GetContent;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetDate(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetCheckLPU(j));
        j:=j+1;
      end;
end;
end.
