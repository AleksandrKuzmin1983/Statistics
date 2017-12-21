unit VIOFFlowRateOfWholeBlood;

interface

uses
  WinProcs, SysUtils, StdCtrls, Buttons, Vcl.Grids,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants, Data.DB,
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
  MIOFFlowRateOfWholeBlood;

type
  IVIOFFlowRateOfWholeBlood = interface
  end;

  TVIOFFlowRateOfWholeBlood = class(TInterfacedObject, IVIOFFlowRateOfWholeBlood)
  private
    LabelCancellationDate: ITempLabelTag5;
    LabelVolume: ITempLabelTag5;
    LabelNumberOfDoses: ITempLabelTag5;
    LabelReasonConsumption: ITempLabelTag5;
    Title: ITitleLabelTag5;
    SQL: String;

    StringGrid: IStringGridTag5;
    ContentForStringGrid: IMIOFFlowRateOfWholeBlood;

    EditVolume: IEditTag5;
    EditNumberOfDoses: IEditTag5;

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
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberOfDoses(NameForm: TForm): TLabel;
    function GetLabelReasonConsumption(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetEditVolume(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;

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

constructor TVIOFFlowRateOfWholeBlood.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelReportDate(form);
  GetLabelVolume(form);
  GetLabelNumberOfDoses(form);
  GetLabelReasonConsumption(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);
  GetEditNumberOfDoses(form);

  GetReasonConsumption(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

//Button

// Добавление новой записи

procedure TVIOFFlowRateOfWholeBlood.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
  EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses.ReadText));
  if (EditVolume.ReadText='0') or (EditNumberOfDoses.ReadText='0') or (ReasonConsumption.GetItemIndex=-1) then
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
        AddSQL('INSERT INTO [Брак компонентов и другой расход] (ДАТАЗАГ, ДАТАБР, БЦКО, БЦКД, БКЦП) VALUES (' +
        '#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(CancellationDateCal.GetDate)) + '#, ' +
        '#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(CancellationDateCal.GetDate)) + '#, ' +
        EditVolume.ReadText + ', ' + EditNumberOfDoses.ReadText + ', ''' +
        ReasonConsumption.GetItemsValue(ReasonConsumption.GetItemIndex) + ''' )');
        ExecSQL;
      end;
    ShowMessage('Запись успешно добавлена!');
    GetStringGrid(CurrentForm);
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
    EditVolume.WriteText('0');
    EditNumberOfDoses.WriteText('0');
    ReasonConsumption.WriteItemIndex(-1);
    CancellationDateCal.WriteDateTime(StartOfTheWeek(Date)-3);
end;

// Разблокировка кнопок

procedure TVIOFFlowRateOfWholeBlood.ButtonBlocked(Sender: TObject);
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

procedure TVIOFFlowRateOfWholeBlood.ButtonDeleted(Sender: TObject);
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
    GetStringGrid(CurrentForm);
  except
    On e : EDatabaseError do
      messageDlg(e.message, mtError, [mbOK],0);
  end;
    EditVolume.WriteText('0');
    EditNumberOfDoses.WriteText('0');
    ReasonConsumption.WriteItemIndex(-1);
    CancellationDateCal.WriteDateTime(StartOfTheWeek(Date)-3);
end;

// Внесение изменений

procedure TVIOFFlowRateOfWholeBlood.ButtonEdited(Sender: TObject);
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
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow)));
    EditNumberOfDoses.WriteText(VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow)));
    for i:=0 to ReasonConsumption.GetItemsCount-1 do
      if VarToStr(StringGrid.GetValue(4, StringGrid.CurrentRow))=ReasonConsumption.GetItemsValue(i) then  ReasonConsumption.WriteItemIndex(i);
    if ReasonConsumption.GetItemIndex=-1 then ShowMessage('Причина расхода у изменяемой записи задана не верно!' + chr(13) + 'Обратитесь к администратору!');
  end;
  if ButtonEdit.GetCaption='Сохранить изменения' then
  begin
    EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
    EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses.ReadText));
    if (EditVolume.ReadText='0') or (EditNumberOfDoses.ReadText='0') or (ReasonConsumption.GetItemIndex=-1) then
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
        '[Брак компонентов и другой расход].БЦКО=' + EditVolume.ReadText + ', ' +
        '[Брак компонентов и другой расход].БЦКД=' + EditNumberOfDoses.ReadText + ', ' +
        '[Брак компонентов и другой расход].БКЦП=''' + ReasonConsumption.GetItemsValue(ReasonConsumption.GetItemIndex) + ''' ' +
        'WHERE [Брак компонентов и другой расход].Код=' + StringGrid.GetValue(0, StringGrid.CurrentRow));
        ExecSQL;
      end;
    ShowMessage('Запись успешно изменена!');
    end
    else
    begin
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      ReasonConsumption.WriteItemIndex(-1);
      CancellationDateCal.WriteDateTime(StartOfTheWeek(Date)-3);
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end;
    GetStringGrid(CurrentForm);
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      ReasonConsumption.WriteItemIndex(-1);
      CancellationDateCal.WriteDateTime(StartOfTheWeek(Date)-3);
  end;
  if ButtonEdit.GetCaption='Изменить' then ButtonEdit.ChangeCaption('Сохранить изменения') else ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок

function TVIOFFlowRateOfWholeBlood.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TVIOFFlowRateOfWholeBlood.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TVIOFFlowRateOfWholeBlood.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TVIOFFlowRateOfWholeBlood.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TVIOFFlowRateOfWholeBlood.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(CancellationDateCal) then
    CancellationDateCal:=TDTPickerTag5.Create;
  result:=CancellationDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-3, NameForm);
end;

//Edit

function TVIOFFlowRateOfWholeBlood.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TEditTag5.create;
  Result:=EditVolume.GetEdit(400, 120, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);
end;

function TVIOFFlowRateOfWholeBlood.GetEditNumberOfDoses(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses) then
    EditNumberOfDoses := TEditTag5.create;
  Result:=EditNumberOfDoses.GetEdit(400, 160, 185, 12, False, NameForm);
  EditNumberOfDoses.NumberOnly(True);
end;

//Label

function TVIOFFlowRateOfWholeBlood.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(25, 'Расход цельной консервированнай крови', NameForm);
end;

function TVIOFFlowRateOfWholeBlood.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelCancellationDate) then
    LabelCancellationDate := TTempLabelTag5.create;
  result := LabelCancellationDate.GetTempLabel(50, 80, 16, 'Дата расхода: ', NameForm);
end;

function TVIOFFlowRateOfWholeBlood.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(50, 120, 14, 'Объем продукции: ', NameForm);
end;

function TVIOFFlowRateOfWholeBlood.GetLabelNumberOfDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDoses) then
    LabelNumberOfDoses := TTempLabelTag5.create;
  result := LabelNumberOfDoses.GetTempLabel(50, 160, 14, 'Количество доз: ', NameForm);
end;

function TVIOFFlowRateOfWholeBlood.GetLabelReasonConsumption(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReasonConsumption) then
    LabelReasonConsumption := TTempLabelTag5.create;
  result := LabelReasonConsumption.GetTempLabel(50, 200, 14, 'Причина списания: ', NameForm);
end;

//ComboBox

function TVIOFFlowRateOfWholeBlood.GetReasonConsumption(NameForm: TForm): TComboBox;
begin
  if not Assigned(ReasonConsumption) then
    ReasonConsumption := TComboboxTag5.create;
  result := ReasonConsumption.GetComboBox(285, 200, 300, 14, NameForm);
  Try
    SQL:='SELECT TypeOfDefects.TypeDef ' +
    'FROM TypeOfDefects ' +
    'WHERE (((TypeOfDefects.Other)=True)) ' +
    'ORDER BY TypeOfDefects.TypeDef;';
    ReasonConsumption.TheContentOfTheList(SQL);
  Except
    On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

// StringGrid

function TVIOFFlowRateOfWholeBlood.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  j:=0;
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 2, DT_RIGHT, 3, DT_CENTER, 4, DT_LEFT, 7, DT_RIGHT);
  Result:=StringGrid.GetStringGrid(40, 330, 820, 190, 5, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0,50);
  StringGrid.ColWidth(1,90);
  StringGrid.ColWidth(2,90);
  StringGrid.ColWidth(3,80);
  StringGrid.ColWidth(4,170);
  StringGrid.Visible(true);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Объем, мл');
  StringGrid.WriteCells(3, 0, 'Дозы, шт');
  StringGrid.WriteCells(4, 0, 'Причина расхода');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TMIOFFlowRateOfWholeBlood.create;
  ContentForStringGrid.GetContent;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetCancellationDate(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetVolume(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetNumberOfDoses(j));
        StringGrid.WriteCells(4, i+1, ContentForStringGrid.GetReasonConsumption(j));
        j:=j+1;
      end;
end;
end.
