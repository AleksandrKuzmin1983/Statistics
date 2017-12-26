unit VHMManualHarvesting;

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
  MIOCurrentType,
  MIOTypeOfSelectRow,
  MIONameTypeOfSelectRow,
  MIOAddRecord,
  MIODeleteRecord,
  MIOChangeRecord,
  MIOOKDK;

type
  IVHMManualHarvesting = interface
  end;

  TVHMManualHarvesting = class(TInterfacedObject, IVHMManualHarvesting)
  private
//    CurrentTypeOfTap: IMIOCurrentType;
//    CurrentTypeOfSelectRow: IMIOTypeOfSelectRow;
//    CurrentNameTypeOfSelectRow: IMIONameTypeOfSelectRow;
    //шапка
    LabelDate: ITempLabelTag5;
    LabelNumberOfDonors: ITempLabelTag5;
    LabelVolumeOfDonation: ITempLabelTag5;
    LabelNumberOfDoses: ITempLabelTag5;
    //кровь
    LabelSentToPreserving: ITempLabelTag5;
    LabelForLaboratoryResearch: ITempLabelTag5;
    LabelAllWholeBlood: ITempLabelTag5;
    LabelAllStoredBlood: ITempLabelTag5;
    LabelBlood: ITempLabelTag5;
    //компоненты 1
    LabelVolume: ITempLabelTag5;
    LabelNumberDoses: ITempLabelTag5;
    LabelType: ITempLabelTag5;
    LabelErSusp: ITempLabelTag5;
    LabelPlazma: ITempLabelTag5;
    LabelFiltrat: ITempLabelTag5;
    LabelDefectWholeBlood: ITempLabelTag5;

    Title: ITitleLabelTag5;
    SQL: String;

    //таблица "кровь"
    PanelGorBlood: ITempPanelTag5;
    PanelVertBlood1: ITempPanelTag5;
    PanelVertBlood2: ITempPanelTag5;
    PanelVertBlood3: ITempPanelTag5;
    PanelVertBlood4: ITempPanelTag5;
    //таблица "компоненты 1"
    PanelGor1Components1: ITempPanelTag5;
    PanelGor2Components1: ITempPanelTag5;
    PanelGor3Components1: ITempPanelTag5;
    PanelGor4Components1: ITempPanelTag5;
    PanelVert1Components1: ITempPanelTag5;
    PanelVert2Components1: ITempPanelTag5;
    PanelVert3Components1: ITempPanelTag5;

    //шапка
    EditNumberOfDonors: IEditTag5;
    EditNumberOfDoses: IEditTag5;
    //таблица "кровь"
    EditSentToPreserving: IEditTag5;
    EditForLaboratoryResearch: IEditTag5;
    EditAllWholeBlood: IEditTag5;
    EditAllStoredBlood: IEditTag5;
    //таблица "компоненты 1"
    EditVolumeErSusp: IEditTag5;
    EditVolumePlazma: IEditTag5;
    EditVolumeFiltrat: IEditTag5;
    EditVolumeDefect: IEditTag5;
    EditNumberDosesErSusp: IEditTag5;
    EditNumberDosesPlazma: IEditTag5;
    EditNumberDosesFiltrat: IEditTag5;
    EditNumberDosesDefect: IEditTag5;

    CBoxVolumeOfDonation: IComboboxTag5;
    CBoxTypeErSusp: IComboboxTag5;
//    NameTapsList: IComboboxTag5;


//    StringGrid: IStringGridTag5;
//    ContentForStringGrid: IMIOOKDK;
//    AddRecord: IMIOAddRecord;
  //  DeleteRecord: IMIODeleteRecord;
//    ChangeRecord: IMIOChangeRecord;

    DateCal: IDTPickerTag5;
    CheckFillStrFields: TCheckFillStringFields;
  //  BlockMainMenu: IBlockMainMenu;

    ButtonAdd: IBitBtnAddTag5;
    ButtonDelete: IBitBtnDeleteTag5;
    ButtonEdit: IBitBtnEditTag5;
    ButtonBlock: IBitBtnBlockTag5;
    CurrentForm: TForm;
    function GetLabelDate(NameForm: TForm): TLabel;
    function GetLabelNumberOfDonors(NameForm: TForm): TLabel;
    function GetLabelVolumeOfDonation(NameForm: TForm): TLabel;
    function GetLabelNumberOfDoses(NameForm: TForm): TLabel;
    function GetLabelSentToPreserving(NameForm: TForm): TLabel;
    function GetLabelForLaboratoryResearch(NameForm: TForm): TLabel;
    function GetLabelAllWholeBlood(NameForm: TForm): TLabel;
    function GetLabelAllStoredBlood(NameForm: TForm): TLabel;
    function GetLabelBlood(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberDoses(NameForm: TForm): TLabel;
    function GetLabelType(NameForm: TForm): TLabel;
    function GetLabelErSusp(NameForm: TForm): TLabel;
    function GetLabelPlazma(NameForm: TForm): TLabel;
    function GetLabelFiltrat(NameForm: TForm): TLabel;
    function GetLabelDefectWholeBlood(NameForm: TForm): TLabel;

    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetPanelGorBlood(NameForm: TForm): TPanel;
    function GetPanelVertBlood1(NameForm: TForm): TPanel;
    function GetPanelVertBlood2(NameForm: TForm): TPanel;
    function GetPanelVertBlood3(NameForm: TForm): TPanel;
    function GetPanelVertBlood4(NameForm: TForm): TPanel;
    function GetPanelGor1Components1(NameForm: TForm): TPanel;
    function GetPanelGor2Components1(NameForm: TForm): TPanel;
    function GetPanelGor3Components1(NameForm: TForm): TPanel;
    function GetPanelGor4Components1(NameForm: TForm): TPanel;
    function GetPanelVert1Components1(NameForm: TForm): TPanel;
    function GetPanelVert2Components1(NameForm: TForm): TPanel;
    function GetPanelVert3Components1(NameForm: TForm): TPanel;

    function GetEditNumberOfDonors(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;
    function GetEditSentToPreserving(NameForm: TForm): TEdit;
    function GetEditForLaboratoryResearch(NameForm: TForm): TEdit;
    function GetEditAllWholeBlood(NameForm: TForm): TEdit;
    function GetEditAllStoredBlood(NameForm: TForm): TEdit;
    function GetEditVolumeErSusp(NameForm: TForm): TEdit;
    function GetEditVolumePlazma(NameForm: TForm): TEdit;
    function GetEditVolumeFiltrat(NameForm: TForm): TEdit;
    function GetEditVolumeDefect(NameForm: TForm): TEdit;
    function GetEditNumberDosesErSusp(NameForm: TForm): TEdit;
    function GetEditNumberDosesPlazma(NameForm: TForm): TEdit;
    function GetEditNumberDosesFiltrat(NameForm: TForm): TEdit;
    function GetEditNumberDosesDefect(NameForm: TForm): TEdit;




    function GetCBoxVolumeOfDonation(NameForm: TForm): TComboBox;
    function GetCBoxTypeErSusp(NameForm: TForm): TComboBox;
  //  function GetNameTapsList(NameForm: TForm): TComboBox;


    //    function GetStringGrid(NameForm: TForm): TStringGrid;





    function GetCalendarDateCal(NameForm: TForm): TDateTimePicker;

    function GetButtonEdit(NameForm: TForm): TBitBtn;
    procedure ButtonEdited(Sender: TObject);
    function GetButtonAdd(NameForm: TForm): TBitBtn;
    procedure ButtonAdded(Sender: TObject);
    function GetButtonDelete(NameForm: TForm): TBitBtn;
    procedure ButtonDeleted(Sender: TObject);
    function GetButtonBlock(NameForm: TForm): TBitBtn;
    procedure ButtonBlocked(Sender: TObject);

//    procedure OnChangeListOfType(Sender: TObject);
  public
    constructor create(form: TForm);
  end;

implementation

{ TBloodProduct }

constructor TVHMManualHarvesting.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelDate(form);
  GetLabelNumberOfDonors(form);
  GetLabelVolumeOfDonation(form);
  GetLabelNumberOfDoses(form);
  GetLabelSentToPreserving(form);
  GetLabelForLaboratoryResearch(form);
  GetLabelAllWholeBlood(form);
  GetLabelAllStoredBlood(form);
  GetLabelBlood(form);
  GetLabelVolume(form);
  GetLabelNumberDoses(form);
  GetLabelType(form);
  GetLabelErSusp(form);
  GetLabelPlazma(form);
  GetLabelFiltrat(form);
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
  GetPanelGor3Components1(form);
  GetPanelGor4Components1(form);

  GetEditNumberOfDonors(form);
  GetEditNumberOfDoses(form);
  GetEditSentToPreserving(form);
  GetEditForLaboratoryResearch(form);
  GetEditAllWholeBlood(form);
  GetEditAllStoredBlood(form);
  GetEditVolumeErSusp(form);
  GetEditVolumePlazma(form);
  GetEditVolumeFiltrat(form);
  GetEditVolumeDefect(form);
  GetEditNumberDosesErSusp(form);
  GetEditNumberDosesPlazma(form);
  GetEditNumberDosesFiltrat(form);
  GetEditNumberDosesDefect(form);



 { GetStringGrid(form);  }

  GetCalendarDateCal(form);

  GetCBoxVolumeOfDonation(form);
  GetCBoxTypeErSusp(form);
 { GetEditVolume(form);


  GetNameTapsList(form);  }

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

//Button

// Добавление новой записи

procedure TVHMManualHarvesting.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
 { EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
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
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);    }
end;

// Разблокировка кнопок

procedure TVHMManualHarvesting.ButtonBlocked(Sender: TObject);
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

procedure TVHMManualHarvesting.ButtonDeleted(Sender: TObject);
begin
{  if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TMIODeleteRecord.create;
    DeleteRecord.DeleteRecord(VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount-1);
    ShowMessage('Запись успешно удалена!');
  end;
  EditVolume.WriteText('0');
  TypeOfTapList.WriteItemIndex(-1);
  NameTapsList.Clear;
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);   }
end;

// Внесение изменений
procedure TVHMManualHarvesting.ButtonEdited(Sender: TObject);
var
  TempVar: String;
  i: integer;
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
 { if not Assigned(BlockMainMenu) then
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
  if ButtonEdit.GetCaption='Изменить' then ButtonEdit.ChangeCaption('Сохранить изменения') else ButtonEdit.ChangeCaption('Изменить');}
end;

// Создание кнопок
function TVHMManualHarvesting.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(670, 0, ButtonAdded, NameForm);
end;

function TVHMManualHarvesting.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(670, 0, ButtonBlocked, NameForm);
end;

function TVHMManualHarvesting.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(670, 0, ButtonDeleted, NameForm);
end;

function TVHMManualHarvesting.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(670, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker
function TVHMManualHarvesting.GetCalendarDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(DateCal) then
    DateCal:=TDTPickerTag5.Create;
  result:=DateCal.GetDTPicker(200, 70, Date(), NameForm);
  DateCal.Width(100);
  DateCal.FontSize(8);
end;

//шапка
function TVHMManualHarvesting.GetLabelDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDate) then
    LabelDate := TTempLabelTag5.create;
  result := LabelDate.GetTempLabel(30, 70, 12, 'Дата заготовки: ', NameForm);
end;

function TVHMManualHarvesting.GetLabelNumberOfDonors(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDonors) then
    LabelNumberOfDonors := TTempLabelTag5.create;
  result := LabelNumberOfDonors.GetTempLabel(30, 95, 12, 'Количество доноров: ', NameForm);
end;

function TVHMManualHarvesting.GetLabelVolumeOfDonation(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolumeOfDonation) then
    LabelVolumeOfDonation := TTempLabelTag5.create;
  result := LabelVolumeOfDonation.GetTempLabel(30, 120, 12, 'Объем донаций: ', NameForm);
end;

function TVHMManualHarvesting.GetLabelNumberOfDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDoses) then
    LabelNumberOfDoses := TTempLabelTag5.create;
  result := LabelNumberOfDoses.GetTempLabel(30, 145, 12, 'Количество доз: ', NameForm);
end;

function TVHMManualHarvesting.GetEditNumberOfDonors(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDonors) then
    EditNumberOfDonors := TEditTag5.create;
  Result:=EditNumberOfDonors.GetEdit(200, 95, 100, 10, False, NameForm);
  EditNumberOfDonors.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditNumberOfDoses(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses) then
    EditNumberOfDoses := TEditTag5.create;
  Result:=EditNumberOfDoses.GetEdit(200, 145, 100, 10, False, NameForm);
  EditNumberOfDoses.NumberOnly(True);
end;



function TVHMManualHarvesting.GetCBoxVolumeOfDonation(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxVolumeOfDonation) then
    CBoxVolumeOfDonation := TComboboxTag5.create;
  result := CBoxVolumeOfDonation.GetComboBox(200, 120, 100, 10, NameForm);
  SQL:='SELECT top 1 * ' +
  'FROM BloodDoza';
  CBoxVolumeOfDonation.GetListOfTheNameColumns(SQL);
  CBoxVolumeOfDonation.WriteItemIndex(3);
//  CBoxVolumeOfDonation.GetOnChange(OnChangeListOfType);
end;

//таблица "кровь"
function TVHMManualHarvesting.GetLabelSentToPreserving(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelSentToPreserving) then
    LabelSentToPreserving := TTempLabelTag5.create;
  result := LabelSentToPreserving.GetTempLabel(100, 185, 12, 'Отправлено на консервирование, мл: ', NameForm);
  LabelSentToPreserving.WordWrap(true);
  LabelSentToPreserving.Width(150);
  LabelSentToPreserving.Height(40);
end;

function TVHMManualHarvesting.GetLabelForLaboratoryResearch(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelForLaboratoryResearch) then
    LabelForLaboratoryResearch := TTempLabelTag5.create;
  result := LabelForLaboratoryResearch.GetTempLabel(265, 185, 12, 'На лабораторные иследования, мл: ', NameForm);
  LabelForLaboratoryResearch.WordWrap(true);
  LabelForLaboratoryResearch.Width(120);
  LabelForLaboratoryResearch.Height(40);
end;

function TVHMManualHarvesting.GetLabelAllWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllWholeBlood) then
    LabelAllWholeBlood := TTempLabelTag5.create;
  result := LabelAllWholeBlood.GetTempLabel(400, 185, 12, 'Всего цельной крови, мл: ', NameForm);
  LabelAllWholeBlood.WordWrap(true);
  LabelAllWholeBlood.Width(100);
  LabelAllWholeBlood.Height(40);
end;

function TVHMManualHarvesting.GetLabelAllStoredBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllStoredBlood) then
    LabelAllStoredBlood := TTempLabelTag5.create;
  result := LabelAllStoredBlood.GetTempLabel(515, 185, 12, 'Всего конс-ной крови, мл: ', NameForm);
  LabelAllStoredBlood.WordWrap(true);
  LabelAllStoredBlood.Width(120);
  LabelAllStoredBlood.Height(40);
end;

function TVHMManualHarvesting.GetLabelBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelBlood) then
    LabelBlood := TTempLabelTag5.create;
  result := LabelBlood.GetTempLabel(30, 235, 12, 'Кровь: ', NameForm);
  LabelBlood.Width(120);
end;

function TVHMManualHarvesting.GetEditSentToPreserving(NameForm: TForm): TEdit;
begin
  if not Assigned(EditSentToPreserving) then
    EditSentToPreserving := TEditTag5.create;
  Result:=EditSentToPreserving.GetEdit(100, 235, 155, 10, False, NameForm);
  EditSentToPreserving.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditForLaboratoryResearch(
  NameForm: TForm): TEdit;
begin
  if not Assigned(EditForLaboratoryResearch) then
    EditForLaboratoryResearch := TEditTag5.create;
  Result:=EditForLaboratoryResearch.GetEdit(265, 235, 125, 10, False, NameForm);
  EditForLaboratoryResearch.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditAllWholeBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllWholeBlood) then
    EditAllWholeBlood := TEditTag5.create;
  Result:=EditAllWholeBlood.GetEdit(400, 235, 105, 10, False, NameForm);
  EditAllWholeBlood.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditAllStoredBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllStoredBlood) then
    EditAllStoredBlood := TEditTag5.create;
  Result:=EditAllStoredBlood.GetEdit(515, 235, 105, 10, False, NameForm);
  EditAllStoredBlood.NumberOnly(True);
end;

function TVHMManualHarvesting.GetPanelGorBlood(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGorBlood) then
    PanelGorBlood := TTempPanelTag5.create;
  Result:=PanelGorBlood.GetTempPanel(30, 227, 1, 590, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVertBlood1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood1) then
    PanelVertBlood1 := TTempPanelTag5.create;
  Result:=PanelVertBlood1.GetTempPanel(95, 185, 75, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVertBlood2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood2) then
    PanelVertBlood2 := TTempPanelTag5.create;
  Result:=PanelVertBlood2.GetTempPanel(260, 185, 75, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVertBlood3(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood3) then
    PanelVertBlood3 := TTempPanelTag5.create;
  Result:=PanelVertBlood3.GetTempPanel(395, 185, 75, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVertBlood4(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood4) then
    PanelVertBlood4 := TTempPanelTag5.create;
  Result:=PanelVertBlood4.GetTempPanel(510, 185, 75, 1, 0, NameForm);
end;

//таблица "компоненты 1"
function TVHMManualHarvesting.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(140, 270, 12, 'Объем, мл: ', NameForm);
  LabelVolume.WordWrap(true);
  LabelVolume.Width(80);
end;

function TVHMManualHarvesting.GetLabelNumberDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberDoses) then
    LabelNumberDoses := TTempLabelTag5.create;
  result := LabelNumberDoses.GetTempLabel(240, 270, 12, 'Количество доз, шт: ', NameForm);
  LabelNumberDoses.WordWrap(true);
  LabelNumberDoses.Width(80);
  LabelNumberDoses.Height(40);
end;

function TVHMManualHarvesting.GetLabelType(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelType) then
    LabelType := TTempLabelTag5.create;
  result := LabelType.GetTempLabel(340, 270, 12, 'Вид продукци: ', NameForm);
  LabelType.WordWrap(true);
  LabelType.Width(80);
  LabelType.Height(40);
end;

function TVHMManualHarvesting.GetLabelErSusp(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelErSusp) then
    LabelErSusp := TTempLabelTag5.create;
  result := LabelErSusp.GetTempLabel(30, 310, 12, 'Эр. взвесь: ', NameForm);
  LabelErSusp.WordWrap(true);
  LabelErSusp.Width(100);
  LabelErSusp.Height(40);
end;

function TVHMManualHarvesting.GetLabelPlazma(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelPlazma) then
    LabelPlazma := TTempLabelTag5.create;
  result := LabelPlazma.GetTempLabel(30, 340, 12, 'Плазма: ', NameForm);
  LabelPlazma.WordWrap(true);
  LabelPlazma.Width(100);
  LabelPlazma.Height(40);
end;

function TVHMManualHarvesting.GetLabelFiltrat(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelFiltrat) then
    LabelFiltrat := TTempLabelTag5.create;
  result := LabelFiltrat.GetTempLabel(30, 368, 12, 'Фильтрат: ', NameForm);
  LabelFiltrat.WordWrap(true);
  LabelFiltrat.Width(100);
  LabelFiltrat.Height(40);
end;

function TVHMManualHarvesting.GetLabelDefectWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDefectWholeBlood) then
    LabelDefectWholeBlood := TTempLabelTag5.create;
  result := LabelDefectWholeBlood.GetTempLabel(30, 396, 12, 'Брак цельной крови: ', NameForm);
  LabelDefectWholeBlood.WordWrap(true);
  LabelDefectWholeBlood.Width(100);
  LabelDefectWholeBlood.Height(40);
end;

function TVHMManualHarvesting.GetPanelGor1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor1Components1) then
    PanelGor1Components1 := TTempPanelTag5.create;
  Result:=PanelGor1Components1.GetTempPanel(30, 308, 1, 400, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelGor2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor2Components1) then
    PanelGor2Components1 := TTempPanelTag5.create;
  Result:=PanelGor2Components1.GetTempPanel(30, 335, 1, 400, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelGor3Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor3Components1) then
    PanelGor3Components1 := TTempPanelTag5.create;
  Result:=PanelGor3Components1.GetTempPanel(30, 363, 1, 400, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelGor4Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor4Components1) then
    PanelGor4Components1 := TTempPanelTag5.create;
  Result:=PanelGor4Components1.GetTempPanel(30, 391, 1, 400, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVert1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert1Components1) then
    PanelVert1Components1 := TTempPanelTag5.create;
  Result:=PanelVert1Components1.GetTempPanel(135, 273, 157, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVert2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert2Components1) then
    PanelVert2Components1 := TTempPanelTag5.create;
  Result:=PanelVert2Components1.GetTempPanel(235, 273, 157, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVert3Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert3Components1) then
    PanelVert3Components1 := TTempPanelTag5.create;
  Result:=PanelVert3Components1.GetTempPanel(335, 273, 157, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetEditVolumeErSusp(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeErSusp) then
    EditVolumeErSusp := TEditTag5.create;
  Result:=EditVolumeErSusp.GetEdit(140, 310, 90, 10, False, NameForm);
  EditVolumeErSusp.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditVolumePlazma(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumePlazma) then
    EditVolumePlazma := TEditTag5.create;
  Result:=EditVolumePlazma.GetEdit(140, 338, 90, 10, False, NameForm);
  EditVolumePlazma.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditVolumeFiltrat(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeFiltrat) then
    EditVolumeFiltrat := TEditTag5.create;
  Result:=EditVolumeFiltrat.GetEdit(140, 366, 90, 10, False, NameForm);
  EditVolumeFiltrat.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditVolumeDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeDefect) then
    EditVolumeDefect := TEditTag5.create;
  Result:=EditVolumeDefect.GetEdit(140, 394, 90, 10, False, NameForm);
  EditVolumeDefect.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditNumberDosesErSusp(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesErSusp) then
    EditNumberDosesErSusp := TEditTag5.create;
  Result:=EditNumberDosesErSusp.GetEdit(240, 310, 90, 10, False, NameForm);
  EditNumberDosesErSusp.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditNumberDosesPlazma(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesPlazma) then
    EditNumberDosesPlazma := TEditTag5.create;
  Result:=EditNumberDosesPlazma.GetEdit(240, 338, 90, 10, False, NameForm);
  EditNumberDosesPlazma.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditNumberDosesFiltrat(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesFiltrat) then
    EditNumberDosesFiltrat := TEditTag5.create;
  Result:=EditNumberDosesFiltrat.GetEdit(240, 366, 90, 10, False, NameForm);
  EditNumberDosesFiltrat.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditNumberDosesDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesDefect) then
    EditNumberDosesDefect := TEditTag5.create;
  Result:=EditNumberDosesDefect.GetEdit(240, 394, 90, 10, False, NameForm);
  EditNumberDosesDefect.NumberOnly(True);
end;

function TVHMManualHarvesting.GetCBoxTypeErSusp(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeErSusp) then
    CBoxTypeErSusp := TComboboxTag5.create;
  result := CBoxTypeErSusp.GetComboBox(340, 310, 90, 10, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts WHERE (((NameProducts.Visible)=True) AND ((NameProducts.TypeProduct)="Эр взвесь")); ';
  CBoxTypeErSusp.TheContentOfTheList(SQL);
  CBoxTypeErSusp.WriteItemIndex(2);
  CBoxTypeErSusp.GetDROPPEDWIDTH(200);
//  CBoxVolumeOfDonation.GetOnChange(OnChangeListOfType);
end;


//таблица "компоненты 2"



//Label
function TVHMManualHarvesting.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(20, 'Ввод ежедневных данных по заготовке крови "ручным" способом', NameForm);
end;

{
procedure TVHMManualHarvesting.OnChangeListOfType(Sender: TObject);
Var
  TempVAR: String;
begin
  if Assigned(CurrentTypeOfTap) then
    CurrentTypeOfTap:=nil;
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

function TVHMManualHarvesting.GetNameTapsList(NameForm: TForm): TComboBox;
begin
  if not Assigned(NameTapsList) then
    NameTapsList := TComboboxTag5.create;
  result := NameTapsList.GetComboBox(400, 150, 185, 14, NameForm);
  NameTapsList.GetDROPPEDWIDTH(220);
end;
    }
// StringGrid

{function TVHMManualHarvesting.GetStringGrid(
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
end;  }

end.
