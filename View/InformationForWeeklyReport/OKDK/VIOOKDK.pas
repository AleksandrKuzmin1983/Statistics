unit VIOOKDK;

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
  MIOCurrentType,
  MIOTypeOfSelectRow,
  MIONameTypeOfSelectRow,
  MIOAddRecord,
  MIODeleteRecord,
  MIOChangeRecord,
  MIOOKDK;

type
  IVIOOKDK = interface
  end;

  TVIOOKDK = class(TInterfacedObject, IVIOOKDK)
  private
    CurrentTypeOfTap: IMIOCurrentType;
    CurrentTypeOfSelectRow: IMIOTypeOfSelectRow;
    CurrentNameTypeOfSelectRow: IMIONameTypeOfSelectRow;

    LabelReportDate: ITempLabelTag5;
    LabelTypeOfTap: ITempLabelTag5;
    LabelNameTap: ITempLabelTag5;
    LabelVolume: ITempLabelTag5;
    Title: ITitleLabelTag5;
    SQL: String;

    StringGrid: IStringGridTag5;
    ContentForStringGrid: IMIOOKDK;
    AddRecord: IMIOAddRecord;
    DeleteRecord: IMIODeleteRecord;
    ChangeRecord: IMIOChangeRecord;

    EditVolume: IEditTag5;

    TypeOfTapList: IComboboxTag5;
    NameTapsList: IComboboxTag5;

    ReportDateCal: IDTPickerTag5;
    CheckFillStrFields: TCheckFillStringFields;
    BlockMainMenu: IBlockMainMenu;

    ButtonAdd: IBitBtnAddTag5;
    ButtonDelete: IBitBtnDeleteTag5;
    ButtonEdit: IBitBtnEditTag5;
    ButtonBlock: IBitBtnBlockTag5;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelTypeOfTap(NameForm: TForm): TLabel;
    function GetLabelNameTap(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;

    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetEditVolume(NameForm: TForm): TEdit;

    function GetTypeOfTapList(NameForm: TForm): TComboBox;
    function GetNameTapsList(NameForm: TForm): TComboBox;

    function GetCalendarReportDateCal(NameForm: TForm): TDateTimePicker;

    function GetButtonEdit(NameForm: TForm): TBitBtn;
    procedure ButtonEdited(Sender: TObject);
    function GetButtonAdd(NameForm: TForm): TBitBtn;
    procedure ButtonAdded(Sender: TObject);
    function GetButtonDelete(NameForm: TForm): TBitBtn;
    procedure ButtonDeleted(Sender: TObject);
    function GetButtonBlock(NameForm: TForm): TBitBtn;
    procedure ButtonBlocked(Sender: TObject);

    procedure OnChangeListOfType(Sender: TObject);
  public
    constructor create(form: TForm);
  end;

implementation

{ TBloodProduct }

constructor TVIOOKDK.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelReportDate(form);
  GetLabelTypeOfTap(form);
  GetLabelNameTap(form);
  GetLabelVolume(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);

  GetTypeOfTapList(form);
  GetNameTapsList(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

//Button

// Добавление новой записи

procedure TVIOOKDK.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
  if EditVolume.ReadText='0' then
    begin
      Showmessage('Необходимо указать количество!');
      exit;
    End;
  if  NameTapsList.GetItemIndex=-1 then
    begin
      Showmessage('Необходимо указать наименование!');
      exit;
    End;
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      if not Assigned(AddRecord) then
        AddRecord := TMIOAddRecord.create;
      AddRecord.AddRecord(ReportDateCal.GetDate, NameTapsList.GetItemsValue(NameTapsList.GetItemIndex), EditVolume.ReadText);
      ShowMessage('Запись успешно добавлена!');
      GetStringGrid(CurrentForm);
      ShowMessage('(добавление) наполнение прошло!');
    end;
  EditVolume.WriteText('0');
  TypeOfTapList.WriteItemIndex(-1);
  NameTapsList.Clear;
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Разблокировка кнопок

procedure TVIOOKDK.ButtonBlocked(Sender: TObject);
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

procedure TVIOOKDK.ButtonDeleted(Sender: TObject);
begin
  if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TMIODeleteRecord.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)));
    ShowMessage('Запись успешно удалена!');
  end;
  GetStringGrid(CurrentForm);
  EditVolume.WriteText('0');
  TypeOfTapList.WriteItemIndex(-1);
  NameTapsList.Clear;
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Внесение изменений

procedure TVIOOKDK.ButtonEdited(Sender: TObject);
var
  TempVar: String;
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

    ReportDateCal.WriteDateTime(StrToDate(StringGrid.GetValue(1, StringGrid.CurrentRow)));

    if Assigned(CurrentTypeOfSelectRow) then
      CurrentTypeOfSelectRow:=nil;
    if not Assigned(CurrentTypeOfSelectRow) then
      CurrentTypeOfSelectRow := TMIOTypeOfSelectRow.create;
    TempVAR:=CurrentTypeOfSelectRow.GetCurrentTypeOfSelectRow(VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow)));
    if Assigned(CurrentTypeOfSelectRow) then
      CurrentTypeOfSelectRow:=nil;
    if not Assigned(CurrentNameTypeOfSelectRow) then
      CurrentNameTypeOfSelectRow := TMIONameTypeOfSelectRow.create;
    TempVAR:=CurrentNameTypeOfSelectRow.GetCurrentNameTypeOfSelectRow(TempVAR);
    for i:=0 to TypeOfTapList.GetItemsCount-1 do
      if TempVAR=TypeOfTapList.GetItemsValue(i) then
      begin
        TypeOfTapList.WriteItemIndex(i);
        OnChangeListOfType(nil);
      end;
    if TypeOfTapList.GetItemIndex=-1 then ShowMessage('Тип данной записи задан не верно!' + chr(13) + 'Обратитесь к администратору!');

    for i:=0 to NameTapsList.GetItemsCount-1 do
      if VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow))=NameTapsList.GetItemsValue(i) then  NameTapsList.WriteItemIndex(i);
    if NameTapsList.GetItemIndex=-1 then ShowMessage('Наименование данной записи задано не верно!' + chr(13) + 'Обратитесь к администратору!');

    EditVolume.WriteText(VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow)));
  end;

  if ButtonEdit.GetCaption='Сохранить изменения' then
  begin
    EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
    if EditVolume.ReadText='0' then
      begin
        Showmessage('Необходимо указать количество!');
        exit;
      End;
    if  NameTapsList.GetItemIndex=-1 then
      begin
        Showmessage('Необходимо указать наименование!');
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
      if not Assigned(ChangeRecord) then
        ChangeRecord := TMIOChangeRecord.create;
      ChangeRecord.ChangeRecord(ReportDateCal.GetDate, NameTapsList.GetItemsValue(NameTapsList.GetItemIndex), EditVolume.ReadText, StringGrid.GetValue(0, StringGrid.CurrentRow));
      ShowMessage('Запись успешно изменена!');
    end
    else
    begin
      EditVolume.WriteText('0');
      TypeOfTapList.WriteItemIndex(-1);
      NameTapsList.Clear;
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end;
      GetStringGrid(CurrentForm);
      ShowMessage('Запись успешно изменена!');
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  end;
      EditVolume.WriteText('0');
      TypeOfTapList.WriteItemIndex(-1);
      NameTapsList.Clear;
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
  end;
  if ButtonEdit.GetCaption='Изменить' then ButtonEdit.ChangeCaption('Сохранить изменения') else ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок

function TVIOOKDK.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TVIOOKDK.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TVIOOKDK.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TVIOOKDK.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TVIOOKDK.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal:=TDTPickerTag5.Create;
  result:=ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-7, NameForm);
end;

//Edit

function TVIOOKDK.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TEditTag5.create;
  Result:=EditVolume.GetEdit(400, 185, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);
end;

//Label

function TVIOOKDK.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(25, 'Информация с ОКДК', NameForm);
end;

function TVIOOKDK.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TTempLabelTag5.create;
  result := LabelReportDate.GetTempLabel(50, 80, 16, 'Отчетная неделя: ', NameForm);
end;

function TVIOOKDK.GetLabelTypeOfTap(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTypeOfTap) then
    LabelTypeOfTap := TTempLabelTag5.create;
  result := LabelTypeOfTap.GetTempLabel(50, 115, 14, 'Тип: ', NameForm);
end;

function TVIOOKDK.GetLabelNameTap(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNameTap) then
    LabelNameTap := TTempLabelTag5.create;
  result := LabelNameTap.GetTempLabel(50, 150, 14, 'Наименование: ', NameForm);
end;

function TVIOOKDK.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(50, 185, 14, 'Количество: ', NameForm);
end;

//ComboBox

function TVIOOKDK.GetTypeOfTapList(NameForm: TForm): TComboBox;
begin
  if not Assigned(TypeOfTapList) then
    TypeOfTapList := TComboboxTag5.create;
  result := TypeOfTapList.GetComboBox(245, 115, 340, 14, NameForm);
  SQL:='SELECT TypesOfTaps.Type ' +
  'FROM TypesOfTaps ' +
  'ORDER BY TypesOfTaps.Type DESC;';
  TypeOfTapList.TheContentOfTheList(SQL);
  TypeOfTapList.GetOnChange(OnChangeListOfType);
end;

procedure TVIOOKDK.OnChangeListOfType(Sender: TObject);
Var
  TempVAR: String;
begin
//  TypeOfTapList.Enabled(False);
  if Assigned(CurrentTypeOfTap) then
    CurrentTypeOfTap:=nil;
//  TypeOfTapList.Enabled(False);
  if not Assigned(CurrentTypeOfTap) then
    CurrentTypeOfTap := TMIOCurrentType.create;
  TypeOfTapList.Enabled(False);
  TempVAR:=CurrentTypeOfTap.GetCurrentType(TypeOfTapList.GetItemsValue(TypeOfTapList.GetItemIndex));
  NameTapsList.Clear;
  SQL:='SELECT Taps.NameTap ' +
  'FROM TypesOfTaps INNER JOIN Taps ON TypesOfTaps.Id = Taps.TypeOfTap ' +
  'WHERE ((TypesOfTaps.Id)=' + TempVAR + ');';
  NameTapsList.TheContentOfTheList(SQL);
  case StrToInt(TempVAR) of
    3: NameTapsList.WriteItemIndex(0);
    4: NameTapsList.WriteItemIndex(0);
    5: NameTapsList.WriteItemIndex(0);
  end;
  TypeOfTapList.Enabled(True);
end;

function TVIOOKDK.GetNameTapsList(NameForm: TForm): TComboBox;
begin
  if not Assigned(NameTapsList) then
    NameTapsList := TComboboxTag5.create;
  result := NameTapsList.GetComboBox(400, 150, 185, 14, NameForm);
  NameTapsList.GetDROPPEDWIDTH(220);
end;

// StringGrid

function TVIOOKDK.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i:=0; j:=0;
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 3, DT_CENTER, 5, DT_RIGHT, 6, DT_RIGHT, 7, DT_RIGHT);
  Result:=StringGrid.GetStringGrid(40, 330, 820, 190, 4, 2, 11, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.Visible(true);
  StringGrid.ColWidth(0,40);
  StringGrid.ColWidth(1,90);
  StringGrid.ColWidth(2,180);
  StringGrid.ColWidth(3,90);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Наименование');
  StringGrid.WriteCells(3, 0, 'Количество');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TMIOOKDK.create;
  ContentForStringGrid.GetContent;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetReportDate(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetTheNameOfTap(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetVolume(j));
        j:=j+1;
      end;
end;

end.
