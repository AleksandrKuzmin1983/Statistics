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
  UVFCheckBox,
  UVFPanel,
  MHMManualHarvesting,
  MHMAddRecordManualHarvesting,
  MHMDeleteRecordManualHarvesting,

  MIOCurrentType,
  MIOTypeOfSelectRow,
  MIONameTypeOfSelectRow,
  MIOAddRecord,
  MIODeleteRecord,
  MIOChangeRecord;

type
  IVHMManualHarvesting = interface
  end;

  TVHMManualHarvesting = class(TInterfacedObject, IVHMManualHarvesting)
  private
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
    //компоненты 2
    LabelVolume2: ITempLabelTag5;
    LabelNumberDoses2: ITempLabelTag5;
    LabelType2: ITempLabelTag5;
    LabelErSusp2: ITempLabelTag5;
    LabelPlazma2: ITempLabelTag5;
    LabelFiltrat2: ITempLabelTag5;
    LabelDefectWholeBlood2: ITempLabelTag5;

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
    //таблица "компоненты 2"
    PanelGor1Components2: ITempPanelTag5;
    PanelGor2Components2: ITempPanelTag5;
    PanelGor3Components2: ITempPanelTag5;
    PanelGor4Components2: ITempPanelTag5;
    PanelVert1Components2: ITempPanelTag5;
    PanelVert2Components2: ITempPanelTag5;
    PanelVert3Components2: ITempPanelTag5;

    //шапка
    EditNumberOfDonors: IEditTag5;
    EditNumberOfDoses: IEditTag5;
    EditNumberOfDoses2: IEditTag5;
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
    //таблица "компоненты 2"
    EditVolumeErSusp2: IEditTag5;
    EditVolumePlazma2: IEditTag5;
    EditVolumeFiltrat2: IEditTag5;
    EditVolumeDefect2: IEditTag5;
    EditNumberDosesErSusp2: IEditTag5;
    EditNumberDosesPlazma2: IEditTag5;
    EditNumberDosesFiltrat2: IEditTag5;
    EditNumberDosesDefect2: IEditTag5;

    CBoxVolumeOfDonation: IComboboxTag5;
    CBoxVolumeOfDonation2: IComboboxTag5;
    CBoxTypeErSusp: IComboboxTag5;
    CBoxTypeDefect: IComboboxTag5;
    CBoxTypePlazma: IComboboxTag5;
    CBoxTypeErSusp2: IComboboxTag5;
    CBoxTypeDefect2: IComboboxTag5;
    CBoxTypePlazma2: IComboboxTag5;

    StringGrid: IStringGridTag5;
    ContentForStringGrid: IMHMManualHarvesting;
    AddRecord: IMHMAddRecordManualHarvesting;
    DeleteRecord: IMHMDeleteRecordManualHarvesting;
//    ChangeRecord: IMIOChangeRecord;

    DateCal: IDTPickerTag5;
    CheckFillStrFields: TCheckFillStringFields;
    BlockMainMenu: IBlockMainMenu;
    CheckBox: ICheckBoxTag5;
    CheckBoxOuting: ICheckBoxTag5;

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
    function GetLabelVolume2(NameForm: TForm): TLabel;
    function GetLabelNumberDoses2(NameForm: TForm): TLabel;
    function GetLabelType2(NameForm: TForm): TLabel;
    function GetLabelErSusp2(NameForm: TForm): TLabel;
    function GetLabelPlazma2(NameForm: TForm): TLabel;
    function GetLabelFiltrat2(NameForm: TForm): TLabel;
    function GetLabelDefectWholeBlood2(NameForm: TForm): TLabel;

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
    function GetPanelGor1Components2(NameForm: TForm): TPanel;
    function GetPanelGor2Components2(NameForm: TForm): TPanel;
    function GetPanelGor3Components2(NameForm: TForm): TPanel;
    function GetPanelGor4Components2(NameForm: TForm): TPanel;
    function GetPanelVert1Components2(NameForm: TForm): TPanel;
    function GetPanelVert2Components2(NameForm: TForm): TPanel;
    function GetPanelVert3Components2(NameForm: TForm): TPanel;

    function GetEditNumberOfDonors(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses2(NameForm: TForm): TEdit;
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
    function GetEditVolumeErSusp2(NameForm: TForm): TEdit;
    function GetEditVolumePlazma2(NameForm: TForm): TEdit;
    function GetEditVolumeFiltrat2(NameForm: TForm): TEdit;
    function GetEditVolumeDefect2(NameForm: TForm): TEdit;
    function GetEditNumberDosesErSusp2(NameForm: TForm): TEdit;
    function GetEditNumberDosesPlazma2(NameForm: TForm): TEdit;
    function GetEditNumberDosesFiltrat2(NameForm: TForm): TEdit;
    function GetEditNumberDosesDefect2(NameForm: TForm): TEdit;

    function GetCBoxVolumeOfDonation(NameForm: TForm): TComboBox;
    function GetCBoxVolumeOfDonation2(NameForm: TForm): TComboBox;
    function GetCBoxTypeErSusp(NameForm: TForm): TComboBox;
    function GetCBoxTypeDefect(NameForm: TForm): TComboBox;
    function GetCBoxTypePlazma(NameForm: TForm): TComboBox;
    function GetCBoxTypeErSusp2(NameForm: TForm): TComboBox;
    function GetCBoxTypeDefect2(NameForm: TForm): TComboBox;
    function GetCBoxTypePlazma2(NameForm: TForm): TComboBox;

    function GetStringGrid(NameForm: TForm): TStringGrid;
    function GetCalendarDateCal(NameForm: TForm): TDateTimePicker;
    function GetCheckBox(NameForm: TForm): TCheckBox;
    function GetCheckBoxOuting(NameForm: TForm): TCheckBox;

    function GetButtonEdit(NameForm: TForm): TBitBtn;
    procedure ButtonEdited(Sender: TObject);
    function GetButtonAdd(NameForm: TForm): TBitBtn;
    procedure ButtonAdded(Sender: TObject);
    function GetButtonDelete(NameForm: TForm): TBitBtn;
    procedure ButtonDeleted(Sender: TObject);
    function GetButtonBlock(NameForm: TForm): TBitBtn;
    procedure ButtonBlocked(Sender: TObject);
    procedure CheckBoxOnClick(Sender: TObject);
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
  GetLabelVolume2(form);
  GetLabelNumberDoses2(form);
  GetLabelType2(form);
  GetLabelErSusp2(form);
  GetLabelPlazma2(form);
  GetLabelFiltrat2(form);
  GetLabelDefectWholeBlood2(form);

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
  GetPanelVert1Components2(form);
  GetPanelVert2Components2(form);
  GetPanelVert3Components2(form);
  GetPanelGor1Components2(form);
  GetPanelGor2Components2(form);
  GetPanelGor3Components2(form);
  GetPanelGor4Components2(form);

  GetEditNumberOfDonors(form);
  GetEditNumberOfDoses(form);
  GetEditNumberOfDoses2(form);
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
  GetEditVolumeErSusp2(form);
  GetEditVolumePlazma2(form);
  GetEditVolumeFiltrat2(form);
  GetEditVolumeDefect2(form);
  GetEditNumberDosesErSusp2(form);
  GetEditNumberDosesPlazma2(form);
  GetEditNumberDosesFiltrat2(form);
  GetEditNumberDosesDefect2(form);

  GetStringGrid(form);
  GetCalendarDateCal(form);
  GetCheckBox(form);
  GetCheckBoxOuting(form);

  GetCBoxVolumeOfDonation(form);
  GetCBoxVolumeOfDonation2(form);
  GetCBoxTypeErSusp(form);
  GetCBoxTypeDefect(form);
  GetCBoxTypePlazma(form);
  GetCBoxTypeErSusp2(form);
  GetCBoxTypeDefect2(form);
  GetCBoxTypePlazma2(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

//Button

// Добавление новой записи

procedure TVHMManualHarvesting.ButtonAdded(Sender: TObject);
var
  Doza350: string;
  Doza450: string;
begin
 { if not Assigned(CheckFillStrFields) then
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
    End; }
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      if not Assigned(AddRecord) then
        AddRecord := TMHMAddRecordManualHarvesting.create;
      AddRecord.AddRecordBlood(DateCal.GetDate, EditNumberOfDonors.ReadText,
        EditSentToPreserving.ReadText, EditForLaboratoryResearch.ReadText,
        EditAllWholeBlood.ReadText, EditAllStoredBlood.ReadText, CheckBoxOuting.CheckedString);
      // Вынести в отдельный класс в виде массива
      if CBoxVolumeOfDonation.GetItemsValue(CBoxVolumeOfDonation.GetItemIndex)='350' then Doza350:=EditNumberOfDoses.ReadText else Doza350:='0';
      if CBoxVolumeOfDonation.GetItemsValue(CBoxVolumeOfDonation.GetItemIndex)='450' then Doza450:=EditNumberOfDoses.ReadText else Doza450:='0';
      //*
      AddRecord.AddRecordBloodDoze(DateCal.GetDate, '0', Doza350, '0', Doza450, '0');
      AddRecord.AddRecordBloodErSusp(EditVolumeErSusp.ReadText, EditNumberDosesErSusp.ReadText, CBoxTypeErSusp.GetItemsValue(CBoxTypeErSusp.GetItemIndex));
      AddRecord.AddRecordBloodPlazma(EditVolumePlazma.ReadText, EditNumberDosesPlazma.ReadText, CBoxTypePlazma.GetItemsValue(CBoxTypePlazma.GetItemIndex));
      AddRecord.AddRecordBloodFiltrat(EditVolumeFiltrat.ReadText, EditNumberDosesFiltrat.ReadText);
      AddRecord.AddRecordBloodDefect(EditVolumeDefect.ReadText, EditNumberDosesDefect.ReadText, CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
      ShowMessage('Запись успешно добавлена!');
      GetStringGrid(CurrentForm);
    end;
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
  if MessageDlg('Удалить запись от ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + ' числа?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(DeleteRecord) then
      DeleteRecord := TMHMDeleteRecordManualHarvesting.create;
    DeleteRecord.DeleteRecord(StringGrid.GetValue(0, StringGrid.CurrentRow));
    GetStringGrid(CurrentForm);
    StringGrid.DeleteLastRow(StringGrid.GetRowCount-1);
    ShowMessage('Запись успешно удалена!');
  end;
{  EditVolume.WriteText('0');
  TypeOfTapList.WriteItemIndex(-1);
  NameTapsList.Clear;
  ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7); }
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

function TVHMManualHarvesting.GetCheckBoxOuting(NameForm: TForm): TCheckBox;
begin
  if not Assigned(CheckBoxOuting) then
    CheckBoxOuting := TCheckBoxTag5.create;
  result := CheckBoxOuting.GetCheckBox(450, 120, 200, 40, 14, False, 'ВЫЕЗД!', NameForm);
end;

function TVHMManualHarvesting.GetCheckBox(NameForm: TForm): TCheckBox;
begin
  if not Assigned(CheckBox) then
    CheckBox := TCheckBoxTag5.create;
  result := CheckBox.GetCheckBox(450, 75, 200, 40, 12, False, 'Заготовка происходила в разных гемаконах', NameForm);
  CheckBox.OnClick(CheckBoxOnClick);
end;

procedure TVHMManualHarvesting.CheckBoxOnClick(Sender: TObject);
begin
  if CheckBox.Checked then
  begin
    LabelVolume2.Visible(True);
    LabelNumberDoses2.Visible(True);
    LabelType2.Visible(True);
    LabelErSusp2.Visible(True);
    LabelPlazma2.Visible(True);
    LabelFiltrat2.Visible(True);
    LabelDefectWholeBlood2.Visible(True);
    PanelGor1Components2.Visible(True);
    PanelGor2Components2.Visible(True);
    PanelGor3Components2.Visible(True);
    PanelGor4Components2.Visible(True);
    PanelVert1Components2.Visible(True);
    PanelVert2Components2.Visible(True);
    PanelVert3Components2.Visible(True);
    EditVolumeErSusp2.Visible(True);
    EditVolumePlazma2.Visible(True);
    EditVolumeFiltrat2.Visible(True);
    EditVolumeDefect2.Visible(True);
    EditNumberDosesErSusp2.Visible(True);
    EditNumberDosesPlazma2.Visible(True);
    EditNumberDosesFiltrat2.Visible(True);
    EditNumberDosesDefect2.Visible(True);
    EditNumberOfDoses2.Visible(True);   //
    CBoxTypeErSusp2.Visible(True);
    CBoxTypePlazma2.Visible(True);
    CBoxTypeDefect2.Visible(True);
    CBoxVolumeOfDonation2.Visible(True);
  end
  else
  begin
    LabelVolume2.Visible(False);
    LabelNumberDoses2.Visible(False);
    LabelType2.Visible(False);
    LabelErSusp2.Visible(False);
    LabelPlazma2.Visible(False);
    LabelFiltrat2.Visible(False);
    LabelDefectWholeBlood2.Visible(False);
    PanelGor1Components2.Visible(False);
    PanelGor2Components2.Visible(False);
    PanelGor3Components2.Visible(False);
    PanelGor4Components2.Visible(False);
    PanelVert1Components2.Visible(False);
    PanelVert2Components2.Visible(False);
    PanelVert3Components2.Visible(False);
    EditVolumeErSusp2.Visible(False);
    EditVolumePlazma2.Visible(False);
    EditVolumeFiltrat2.Visible(False);
    EditVolumeDefect2.Visible(False);
    EditNumberDosesErSusp2.Visible(False);
    EditNumberDosesPlazma2.Visible(False);
    EditNumberDosesFiltrat2.Visible(False);
    EditNumberDosesDefect2.Visible(False);
    EditNumberOfDoses2.Visible(False);
    CBoxTypeErSusp2.Visible(False);
    CBoxTypePlazma2.Visible(False);
    CBoxTypeDefect2.Visible(False);
    CBoxVolumeOfDonation2.Visible(False);
  end;
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

function TVHMManualHarvesting.GetEditNumberOfDoses2(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses2) then
    EditNumberOfDoses2 := TEditTag5.create;
  Result:=EditNumberOfDoses2.GetEdit(320, 145, 100, 10, False, NameForm);
  EditNumberOfDoses2.NumberOnly(True);
  EditNumberOfDoses2.Visible(False);
end;

function TVHMManualHarvesting.GetCBoxVolumeOfDonation(NameForm: TForm): TComboBox;
var
  i: integer;
begin
  if not Assigned(CBoxVolumeOfDonation) then
    CBoxVolumeOfDonation := TComboboxTag5.create;
  result := CBoxVolumeOfDonation.GetComboBox(200, 120, 100, 10, NameForm);
  SQL:='SELECT top 1 * ' +
  'FROM BloodDoza';
  CBoxVolumeOfDonation.GetListOfTheNameColumns(SQL);
  for i := CBoxVolumeOfDonation.GetItemsCount downto 0 do
    if (CBoxVolumeOfDonation.GetItemsValue(i)<>'350') and (CBoxVolumeOfDonation.GetItemsValue(i)<>'450') then CBoxVolumeOfDonation.DeleteRecord(i);
  for i := CBoxVolumeOfDonation.GetItemsCount downto 0 do
    if CBoxVolumeOfDonation.GetItemsValue(i)='450' then CBoxVolumeOfDonation.WriteItemIndex(i);
end;

function TVHMManualHarvesting.GetCBoxVolumeOfDonation2(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxVolumeOfDonation2) then
    CBoxVolumeOfDonation2 := TComboboxTag5.create;
  result := CBoxVolumeOfDonation2.GetComboBox(320, 120, 100, 10, NameForm);
  SQL:='SELECT top 1 * ' +
  'FROM BloodDoza';
  CBoxVolumeOfDonation2.GetListOfTheNameColumns(SQL);
  CBoxVolumeOfDonation2.WriteItemIndex(1);
  CBoxVolumeOfDonation2.Visible(False);
end;

//таблица "кровь"
function TVHMManualHarvesting.GetLabelSentToPreserving(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelSentToPreserving) then
    LabelSentToPreserving := TTempLabelTag5.create;
  result := LabelSentToPreserving.GetTempLabel(100, 190, 12, 'Отправлено на консервирование, мл: ', NameForm);
  LabelSentToPreserving.WordWrap(true);
  LabelSentToPreserving.Width(150);
  LabelSentToPreserving.Height(40);
end;

function TVHMManualHarvesting.GetLabelForLaboratoryResearch(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelForLaboratoryResearch) then
    LabelForLaboratoryResearch := TTempLabelTag5.create;
  result := LabelForLaboratoryResearch.GetTempLabel(265, 190, 12, 'На лабораторные иследования, мл: ', NameForm);
  LabelForLaboratoryResearch.WordWrap(true);
  LabelForLaboratoryResearch.Width(120);
  LabelForLaboratoryResearch.Height(40);
end;

function TVHMManualHarvesting.GetLabelAllWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllWholeBlood) then
    LabelAllWholeBlood := TTempLabelTag5.create;
  result := LabelAllWholeBlood.GetTempLabel(400, 190, 12, 'Всего цельной крови, мл: ', NameForm);
  LabelAllWholeBlood.WordWrap(true);
  LabelAllWholeBlood.Width(100);
  LabelAllWholeBlood.Height(40);
end;

function TVHMManualHarvesting.GetLabelAllStoredBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelAllStoredBlood) then
    LabelAllStoredBlood := TTempLabelTag5.create;
  result := LabelAllStoredBlood.GetTempLabel(515, 190, 12, 'Всего конс-ной крови, мл: ', NameForm);
  LabelAllStoredBlood.WordWrap(true);
  LabelAllStoredBlood.Width(120);
  LabelAllStoredBlood.Height(40);
end;

function TVHMManualHarvesting.GetLabelBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelBlood) then
    LabelBlood := TTempLabelTag5.create;
  result := LabelBlood.GetTempLabel(30, 240, 12, 'Кровь: ', NameForm);
  LabelBlood.Width(120);
end;

function TVHMManualHarvesting.GetEditSentToPreserving(NameForm: TForm): TEdit;
begin
  if not Assigned(EditSentToPreserving) then
    EditSentToPreserving := TEditTag5.create;
  Result:=EditSentToPreserving.GetEdit(100, 240, 155, 10, False, NameForm);
  EditSentToPreserving.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditForLaboratoryResearch(
  NameForm: TForm): TEdit;
begin
  if not Assigned(EditForLaboratoryResearch) then
    EditForLaboratoryResearch := TEditTag5.create;
  Result:=EditForLaboratoryResearch.GetEdit(265, 240, 125, 10, False, NameForm);
  EditForLaboratoryResearch.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditAllWholeBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllWholeBlood) then
    EditAllWholeBlood := TEditTag5.create;
  Result:=EditAllWholeBlood.GetEdit(400, 240, 105, 10, False, NameForm);
  EditAllWholeBlood.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditAllStoredBlood(NameForm: TForm): TEdit;
begin
  if not Assigned(EditAllStoredBlood) then
    EditAllStoredBlood := TEditTag5.create;
  Result:=EditAllStoredBlood.GetEdit(515, 240, 105, 10, False, NameForm);
  EditAllStoredBlood.NumberOnly(True);
end;

function TVHMManualHarvesting.GetPanelGorBlood(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGorBlood) then
    PanelGorBlood := TTempPanelTag5.create;
  Result:=PanelGorBlood.GetTempPanel(30, 232, 1, 590, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVertBlood1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood1) then
    PanelVertBlood1 := TTempPanelTag5.create;
  Result:=PanelVertBlood1.GetTempPanel(95, 190, 75, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVertBlood2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood2) then
    PanelVertBlood2 := TTempPanelTag5.create;
  Result:=PanelVertBlood2.GetTempPanel(260, 190, 75, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVertBlood3(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood3) then
    PanelVertBlood3 := TTempPanelTag5.create;
  Result:=PanelVertBlood3.GetTempPanel(395, 190, 75, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVertBlood4(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVertBlood4) then
    PanelVertBlood4 := TTempPanelTag5.create;
  Result:=PanelVertBlood4.GetTempPanel(510, 190, 75, 1, 0, NameForm);
end;

//таблица "компоненты 1"
function TVHMManualHarvesting.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(140, 290, 12, 'Объем, мл: ', NameForm);
  LabelVolume.WordWrap(true);
  LabelVolume.Width(80);
end;

function TVHMManualHarvesting.GetLabelNumberDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberDoses) then
    LabelNumberDoses := TTempLabelTag5.create;
  result := LabelNumberDoses.GetTempLabel(240, 290, 12, 'Количество доз, шт: ', NameForm);
  LabelNumberDoses.WordWrap(true);
  LabelNumberDoses.Width(80);
  LabelNumberDoses.Height(40);
end;

function TVHMManualHarvesting.GetLabelType(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelType) then
    LabelType := TTempLabelTag5.create;
  result := LabelType.GetTempLabel(340, 290, 12, 'Вид продукци: ', NameForm);
  LabelType.WordWrap(true);
  LabelType.Width(80);
  LabelType.Height(40);
end;

function TVHMManualHarvesting.GetLabelErSusp(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelErSusp) then
    LabelErSusp := TTempLabelTag5.create;
  result := LabelErSusp.GetTempLabel(30, 330, 12, 'Эр. взвесь: ', NameForm);
  LabelErSusp.WordWrap(true);
  LabelErSusp.Width(100);
  LabelErSusp.Height(40);
end;

function TVHMManualHarvesting.GetLabelPlazma(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelPlazma) then
    LabelPlazma := TTempLabelTag5.create;
  result := LabelPlazma.GetTempLabel(30, 360, 12, 'Плазма: ', NameForm);
  LabelPlazma.WordWrap(true);
  LabelPlazma.Width(100);
  LabelPlazma.Height(40);
end;

function TVHMManualHarvesting.GetLabelFiltrat(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelFiltrat) then
    LabelFiltrat := TTempLabelTag5.create;
  result := LabelFiltrat.GetTempLabel(30, 388, 12, 'Фильтрат: ', NameForm);
  LabelFiltrat.WordWrap(true);
  LabelFiltrat.Width(100);
  LabelFiltrat.Height(40);
end;

function TVHMManualHarvesting.GetLabelDefectWholeBlood(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDefectWholeBlood) then
    LabelDefectWholeBlood := TTempLabelTag5.create;
  result := LabelDefectWholeBlood.GetTempLabel(30, 416, 12, 'Брак цельной крови: ', NameForm);
  LabelDefectWholeBlood.WordWrap(true);
  LabelDefectWholeBlood.Width(100);
  LabelDefectWholeBlood.Height(40);
end;

function TVHMManualHarvesting.GetPanelGor1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor1Components1) then
    PanelGor1Components1 := TTempPanelTag5.create;
  Result:=PanelGor1Components1.GetTempPanel(30, 328, 1, 400, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelGor2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor2Components1) then
    PanelGor2Components1 := TTempPanelTag5.create;
  Result:=PanelGor2Components1.GetTempPanel(30, 355, 1, 400, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelGor3Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor3Components1) then
    PanelGor3Components1 := TTempPanelTag5.create;
  Result:=PanelGor3Components1.GetTempPanel(30, 383, 1, 400, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelGor4Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor4Components1) then
    PanelGor4Components1 := TTempPanelTag5.create;
  Result:=PanelGor4Components1.GetTempPanel(30, 411, 1, 400, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVert1Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert1Components1) then
    PanelVert1Components1 := TTempPanelTag5.create;
  Result:=PanelVert1Components1.GetTempPanel(135, 293, 157, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVert2Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert2Components1) then
    PanelVert2Components1 := TTempPanelTag5.create;
  Result:=PanelVert2Components1.GetTempPanel(235, 293, 157, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetPanelVert3Components1(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert3Components1) then
    PanelVert3Components1 := TTempPanelTag5.create;
  Result:=PanelVert3Components1.GetTempPanel(335, 293, 157, 1, 0, NameForm);
end;

function TVHMManualHarvesting.GetEditVolumeErSusp(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeErSusp) then
    EditVolumeErSusp := TEditTag5.create;
  Result:=EditVolumeErSusp.GetEdit(140, 330, 90, 10, False, NameForm);
  EditVolumeErSusp.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditVolumePlazma(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumePlazma) then
    EditVolumePlazma := TEditTag5.create;
  Result:=EditVolumePlazma.GetEdit(140, 358, 90, 10, False, NameForm);
  EditVolumePlazma.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditVolumeFiltrat(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeFiltrat) then
    EditVolumeFiltrat := TEditTag5.create;
  Result:=EditVolumeFiltrat.GetEdit(140, 386, 90, 10, False, NameForm);
  EditVolumeFiltrat.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditVolumeDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeDefect) then
    EditVolumeDefect := TEditTag5.create;
  Result:=EditVolumeDefect.GetEdit(140, 414, 90, 10, False, NameForm);
  EditVolumeDefect.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditNumberDosesErSusp(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesErSusp) then
    EditNumberDosesErSusp := TEditTag5.create;
  Result:=EditNumberDosesErSusp.GetEdit(240, 330, 90, 10, False, NameForm);
  EditNumberDosesErSusp.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditNumberDosesPlazma(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesPlazma) then
    EditNumberDosesPlazma := TEditTag5.create;
  Result:=EditNumberDosesPlazma.GetEdit(240, 358, 90, 10, False, NameForm);
  EditNumberDosesPlazma.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditNumberDosesFiltrat(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesFiltrat) then
    EditNumberDosesFiltrat := TEditTag5.create;
  Result:=EditNumberDosesFiltrat.GetEdit(240, 386, 90, 10, False, NameForm);
  EditNumberDosesFiltrat.NumberOnly(True);
end;

function TVHMManualHarvesting.GetEditNumberDosesDefect(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesDefect) then
    EditNumberDosesDefect := TEditTag5.create;
  Result:=EditNumberDosesDefect.GetEdit(240, 414, 90, 10, False, NameForm);
  EditNumberDosesDefect.NumberOnly(True);
end;

function TVHMManualHarvesting.GetCBoxTypeErSusp(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeErSusp) then
    CBoxTypeErSusp := TComboboxTag5.create;
  result := CBoxTypeErSusp.GetComboBox(340, 330, 90, 10, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts ' +
  'WHERE (((NameProducts.Visible)=True) AND ((NameProducts.TypeProduct)="Эр взвесь")); ';
  CBoxTypeErSusp.TheContentOfTheList(SQL);
  CBoxTypeErSusp.WriteItemIndex(2);
  CBoxTypeErSusp.GetDROPPEDWIDTH(200);
end;

function TVHMManualHarvesting.GetCBoxTypePlazma(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypePlazma) then
    CBoxTypePlazma := TComboboxTag5.create;
  result := CBoxTypePlazma.GetComboBox(340, 357, 90, 10, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts ' +
  'WHERE (((NameProducts.Visible)=True) AND ((NameProducts.TypeProduct)="Плазма") and ((NameProducts.AUTO)=false))';
  CBoxTypePlazma.TheContentOfTheList(SQL);
  CBoxTypePlazma.WriteItemIndex(1);
  CBoxTypePlazma.GetDROPPEDWIDTH(200);
end;

function TVHMManualHarvesting.GetCBoxTypeDefect(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeDefect) then
    CBoxTypeDefect := TComboboxTag5.create;
  result := CBoxTypeDefect.GetComboBox(340, 413, 90, 10, NameForm);
  SQL:='SELECT TypeOfDefects.TypeDef ' +
  'FROM TypeOfDefects ' +
  'WHERE (TypeOfDefects.Other=True) or (TypeOfDefects.Null=True)';
  CBoxTypeDefect.TheContentOfTheList(SQL);
  CBoxTypeDefect.WriteItemIndex(-1);
  CBoxTypeDefect.GetDROPPEDWIDTH(200);
end;

//таблица "компоненты 2"
function TVHMManualHarvesting.GetLabelVolume2(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume2) then
    LabelVolume2 := TTempLabelTag5.create;
  result := LabelVolume2.GetTempLabel(580, 290, 12, 'Объем, мл: ', NameForm);
  LabelVolume2.WordWrap(true);
  LabelVolume2.Width(80);
  LabelVolume2.Visible(False);
end;

function TVHMManualHarvesting.GetLabelNumberDoses2(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberDoses2) then
    LabelNumberDoses2 := TTempLabelTag5.create;
  result := LabelNumberDoses2.GetTempLabel(680, 290, 12, 'Количество доз, шт: ', NameForm);
  LabelNumberDoses2.WordWrap(true);
  LabelNumberDoses2.Width(80);
  LabelNumberDoses2.Height(40);
  LabelNumberDoses2.Visible(False);
end;

function TVHMManualHarvesting.GetLabelType2(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelType2) then
    LabelType2 := TTempLabelTag5.create;
  result := LabelType2.GetTempLabel(780, 290, 12, 'Вид продукци: ', NameForm);
  LabelType2.WordWrap(true);
  LabelType2.Width(80);
  LabelType2.Height(40);
  LabelType2.Visible(False);
end;

function TVHMManualHarvesting.GetLabelErSusp2(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelErSusp2) then
    LabelErSusp2 := TTempLabelTag5.create;
  result := LabelErSusp2.GetTempLabel(470, 330, 12, 'Эр. взвесь: ', NameForm);
  LabelErSusp2.WordWrap(true);
  LabelErSusp2.Width(100);
  LabelErSusp2.Height(40);
  LabelErSusp2.Visible(False);
end;

function TVHMManualHarvesting.GetLabelPlazma2(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelPlazma2) then
    LabelPlazma2 := TTempLabelTag5.create;
  result := LabelPlazma2.GetTempLabel(470, 360, 12, 'Плазма: ', NameForm);
  LabelPlazma2.WordWrap(true);
  LabelPlazma2.Width(100);
  LabelPlazma2.Height(40);
  LabelPlazma2.Visible(False);
end;

function TVHMManualHarvesting.GetLabelFiltrat2(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelFiltrat2) then
    LabelFiltrat2 := TTempLabelTag5.create;
  result := LabelFiltrat2.GetTempLabel(470, 388, 12, 'Фильтрат: ', NameForm);
  LabelFiltrat2.WordWrap(true);
  LabelFiltrat2.Width(100);
  LabelFiltrat2.Height(40);
  LabelFiltrat2.Visible(False);
end;

function TVHMManualHarvesting.GetLabelDefectWholeBlood2(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelDefectWholeBlood2) then
    LabelDefectWholeBlood2 := TTempLabelTag5.create;
  result := LabelDefectWholeBlood2.GetTempLabel(470, 416, 12, 'Брак цельной крови: ', NameForm);
  LabelDefectWholeBlood2.WordWrap(true);
  LabelDefectWholeBlood2.Width(100);
  LabelDefectWholeBlood2.Height(40);
  LabelDefectWholeBlood2.Visible(False);
end;

function TVHMManualHarvesting.GetPanelGor1Components2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor1Components2) then
    PanelGor1Components2 := TTempPanelTag5.create;
  Result:=PanelGor1Components2.GetTempPanel(470, 328, 1, 400, 0, NameForm);
  PanelGor1Components2.Visible(False);
end;

function TVHMManualHarvesting.GetPanelGor2Components2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor2Components2) then
    PanelGor2Components2 := TTempPanelTag5.create;
  Result:=PanelGor2Components2.GetTempPanel(470, 355, 1, 400, 0, NameForm);
  PanelGor2Components2.Visible(False);
end;

function TVHMManualHarvesting.GetPanelGor3Components2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor3Components2) then
    PanelGor3Components2 := TTempPanelTag5.create;
  Result:=PanelGor3Components2.GetTempPanel(470, 383, 1, 400, 0, NameForm);
  PanelGor3Components2.Visible(False);
end;

function TVHMManualHarvesting.GetPanelGor4Components2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelGor4Components2) then
    PanelGor4Components2 := TTempPanelTag5.create;
  Result:=PanelGor4Components2.GetTempPanel(470, 411, 1, 400, 0, NameForm);
  PanelGor4Components2.Visible(False);
end;

function TVHMManualHarvesting.GetPanelVert1Components2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert1Components2) then
    PanelVert1Components2 := TTempPanelTag5.create;
  Result:=PanelVert1Components2.GetTempPanel(575, 293, 157, 1, 0, NameForm);
  PanelVert1Components2.Visible(False);
end;

function TVHMManualHarvesting.GetPanelVert2Components2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert2Components2) then
    PanelVert2Components2 := TTempPanelTag5.create;
  Result:=PanelVert2Components2.GetTempPanel(675, 293, 157, 1, 0, NameForm);
  PanelVert2Components2.Visible(False);
end;

function TVHMManualHarvesting.GetPanelVert3Components2(NameForm: TForm): TPanel;
begin
  if not Assigned(PanelVert3Components2) then
    PanelVert3Components2 := TTempPanelTag5.create;
  Result:=PanelVert3Components2.GetTempPanel(775, 293, 157, 1, 0, NameForm);
  PanelVert3Components2.Visible(False);
end;

function TVHMManualHarvesting.GetEditVolumeErSusp2(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeErSusp2) then
    EditVolumeErSusp2 := TEditTag5.create;
  Result:=EditVolumeErSusp2.GetEdit(580, 330, 90, 10, False, NameForm);
  EditVolumeErSusp2.NumberOnly(True);
  EditVolumeErSusp2.Visible(False);
end;

function TVHMManualHarvesting.GetEditVolumePlazma2(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumePlazma2) then
    EditVolumePlazma2 := TEditTag5.create;
  Result:=EditVolumePlazma2.GetEdit(580, 358, 90, 10, False, NameForm);
  EditVolumePlazma2.NumberOnly(True);
  EditVolumePlazma2.Visible(False);
end;

function TVHMManualHarvesting.GetEditVolumeFiltrat2(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeFiltrat2) then
    EditVolumeFiltrat2 := TEditTag5.create;
  Result:=EditVolumeFiltrat2.GetEdit(580, 386, 90, 10, False, NameForm);
  EditVolumeFiltrat2.NumberOnly(True);
  EditVolumeFiltrat2.Visible(False);
end;

function TVHMManualHarvesting.GetEditVolumeDefect2(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolumeDefect2) then
    EditVolumeDefect2 := TEditTag5.create;
  Result:=EditVolumeDefect2.GetEdit(580, 414, 90, 10, False, NameForm);
  EditVolumeDefect2.NumberOnly(True);
  EditVolumeDefect2.Visible(False);
end;

function TVHMManualHarvesting.GetEditNumberDosesErSusp2(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesErSusp2) then
    EditNumberDosesErSusp2 := TEditTag5.create;
  Result:=EditNumberDosesErSusp2.GetEdit(680, 330, 90, 10, False, NameForm);
  EditNumberDosesErSusp2.NumberOnly(True);
  EditNumberDosesErSusp2.Visible(False);
end;

function TVHMManualHarvesting.GetEditNumberDosesPlazma2(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesPlazma2) then
    EditNumberDosesPlazma2 := TEditTag5.create;
  Result:=EditNumberDosesPlazma2.GetEdit(680, 358, 90, 10, False, NameForm);
  EditNumberDosesPlazma2.NumberOnly(True);
  EditNumberDosesPlazma2.Visible(False);
end;

function TVHMManualHarvesting.GetEditNumberDosesFiltrat2(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesFiltrat2) then
    EditNumberDosesFiltrat2 := TEditTag5.create;
  Result:=EditNumberDosesFiltrat2.GetEdit(680, 386, 90, 10, False, NameForm);
  EditNumberDosesFiltrat2.NumberOnly(True);
  EditNumberDosesFiltrat2.Visible(False);
end;

function TVHMManualHarvesting.GetEditNumberDosesDefect2(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberDosesDefect2) then
    EditNumberDosesDefect2 := TEditTag5.create;
  Result:=EditNumberDosesDefect2.GetEdit(680, 414, 90, 10, False, NameForm);
  EditNumberDosesDefect2.NumberOnly(True);
  EditNumberDosesDefect2.Visible(False);
end;

function TVHMManualHarvesting.GetCBoxTypeErSusp2(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeErSusp2) then
    CBoxTypeErSusp2 := TComboboxTag5.create;
  result := CBoxTypeErSusp2.GetComboBox(780, 330, 90, 10, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts ' +
  'WHERE (((NameProducts.Visible)=True) AND ((NameProducts.TypeProduct)="Эр взвесь")); ';
  CBoxTypeErSusp2.TheContentOfTheList(SQL);
  CBoxTypeErSusp2.WriteItemIndex(1);
  CBoxTypeErSusp2.GetDROPPEDWIDTH(200);
  CBoxTypeErSusp2.Visible(False);
end;

function TVHMManualHarvesting.GetCBoxTypePlazma2(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypePlazma2) then
    CBoxTypePlazma2 := TComboboxTag5.create;
  result := CBoxTypePlazma2.GetComboBox(780, 357, 90, 10, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts ' +
  'WHERE (((NameProducts.Visible)=True) AND ((NameProducts.TypeProduct)="Плазма") and ((NameProducts.AUTO)=false))';
  CBoxTypePlazma2.TheContentOfTheList(SQL);
  CBoxTypePlazma2.WriteItemIndex(0);
  CBoxTypePlazma2.GetDROPPEDWIDTH(200);
  CBoxTypePlazma2.Visible(False);
end;

function TVHMManualHarvesting.GetCBoxTypeDefect2(NameForm: TForm): TComboBox;
begin
  if not Assigned(CBoxTypeDefect2) then
    CBoxTypeDefect2 := TComboboxTag5.create;
  result := CBoxTypeDefect2.GetComboBox(780, 413, 90, 10, NameForm);
  SQL:='SELECT TypeOfDefects.TypeDef ' +
  'FROM TypeOfDefects ' +
  'WHERE (TypeOfDefects.Other=True) or (TypeOfDefects.Null=True)';
  CBoxTypeDefect2.TheContentOfTheList(SQL);
  CBoxTypeDefect2.WriteItemIndex(-1);
  CBoxTypeDefect2.GetDROPPEDWIDTH(200);
  CBoxTypeDefect2.Visible(False);
end;

//Label
function TVHMManualHarvesting.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(20, 'Ввод ежедневных данных по заготовке крови "ручным" способом', NameForm);
end;

// StringGrid
function TVHMManualHarvesting.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  i:=0; j:=0;
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 1, DT_CENTER, 11, DT_CENTER, 14, DT_CENTER, 25, DT_CENTER, 36, DT_CENTER);
  Result:=StringGrid.GetStringGrid(30, 480, 840, 160, 19, 2, 9, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.Visible(true);
  StringGrid.ColWidth(0,60);
  StringGrid.ColWidth(1,60);
  StringGrid.ColWidth(2,55);
  StringGrid.ColWidth(3,55);
  StringGrid.ColWidth(4,70);
  StringGrid.ColWidth(5,60);
  StringGrid.ColWidth(6,80);
  StringGrid.ColWidth(7,80);
  StringGrid.ColWidth(8,70);
  StringGrid.ColWidth(9,80);
  StringGrid.ColWidth(10,180);
  StringGrid.ColWidth(11,60);
  StringGrid.ColWidth(12,80);
  StringGrid.ColWidth(13,160);
  StringGrid.ColWidth(14,70);
  StringGrid.ColWidth(15,85);
  StringGrid.ColWidth(16,70);
  StringGrid.ColWidth(17,90);
  StringGrid.ColWidth(18,60);
  StringGrid.WriteCells(0, 0, 'Дата');
  StringGrid.WriteCells(1, 0, 'Кол-во дон.');
  StringGrid.WriteCells(2, 0, 'Дозы 450');
  StringGrid.WriteCells(3, 0, 'Дозы 350');
  StringGrid.WriteCells(4, 0, 'На консерв.');
  StringGrid.WriteCells(5, 0, 'На лабор-е');
  StringGrid.WriteCells(6, 0, 'Всего цел. кр.');
  StringGrid.WriteCells(7, 0, 'Консерв-я кр.');
  StringGrid.WriteCells(8, 0, 'V эр. взвеси');
  StringGrid.WriteCells(9, 0, 'Кол-во доз э.в. ');
  StringGrid.WriteCells(10, 0, 'Вид эр. взвеси');
  StringGrid.WriteCells(11, 0, 'V плазмы');
  StringGrid.WriteCells(12, 0, 'Кол-во доз пл.');
  StringGrid.WriteCells(13, 0, 'Вид плазмы');
  StringGrid.WriteCells(14, 0, 'V фильтрата');
  StringGrid.WriteCells(15, 0, 'Кол-во доз фил.');
  StringGrid.WriteCells(16, 0, 'V брака цел. кр.');
  StringGrid.WriteCells(17, 0, 'Кол-во доз брака');
  StringGrid.WriteCells(18, 0, 'Вид брака');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TMHMManualHarvesting.create;
  ContentForStringGrid.GetContent;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetDate(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetNumberOfDonors(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetNumberOfDosesVolume450(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetNumberOfDosesVolume350(j));
        StringGrid.WriteCells(4, i+1, ContentForStringGrid.GetSentToPreserving(j));
        StringGrid.WriteCells(5, i+1, ContentForStringGrid.GetForLaboratoryResearch(j));
        StringGrid.WriteCells(6, i+1, ContentForStringGrid.GetAllWholeBlood(j));
        StringGrid.WriteCells(7, i+1, ContentForStringGrid.GetAllStoredBlood(j));
        StringGrid.WriteCells(8, i+1, ContentForStringGrid.GetVolomeErSusp(j));
        StringGrid.WriteCells(9, i+1, ContentForStringGrid.GetNumberOfDosesErSusp(j));
        StringGrid.WriteCells(10, i+1, ContentForStringGrid.GetTypeErSusp(j));
        StringGrid.WriteCells(11, i+1, ContentForStringGrid.GetVolomePlazma(j));
        StringGrid.WriteCells(12, i+1, ContentForStringGrid.GetNumberOfDosesPlazma(j));
        StringGrid.WriteCells(13, i+1, ContentForStringGrid.GetTypePlazma(j));
        StringGrid.WriteCells(14, i+1, ContentForStringGrid.GetVolomeFiltrat(j));
        StringGrid.WriteCells(15, i+1, ContentForStringGrid.GetNumberOfDosesPlazma(j));
        StringGrid.WriteCells(16, i+1, ContentForStringGrid.GetVolomeDefect(j));
        StringGrid.WriteCells(17, i+1, ContentForStringGrid.GetNumberOfDosesDefect(j));
        StringGrid.WriteCells(18, i+1, ContentForStringGrid.GetTypeDefect(j));
        j:=j+1;
      end;
end;
end.
