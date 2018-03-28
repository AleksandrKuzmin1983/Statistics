unit MHMManualHarvesting;

interface

uses
  Vcl.ExtCtrls, WinProcs, SysUtils, StdCtrls, Buttons, Vcl.Grids, Data.DB,
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
  MFCheckBox,
  MFPanel,
  BHMManualHarvesting,
  BHMAddRecordManualHarvesting,
  BHMDeleteRecordManualHarvesting,
  BHMChangeRecordManualHarvesting,
  USValueChecksOnTheAdequacy,
  USCheckForExistenceOfRecord,
  USGlobalVariant;

type
  IVHMManualHarvesting = interface
  end;

  TVHMManualHarvesting = class(TGlobalVariant)
  private
    //шапка
    LabelDate: TTempLabelTag5;
    LabelNumberOfDonors: TTempLabelTag5;
    LabelVolumeOfDonation: TTempLabelTag5;
    LabelNumberOfDoses: TTempLabelTag5;
    //кровь
    LabelSentToPreserving: TTempLabelTag5;
    LabelForLaboratoryResearch: TTempLabelTag5;
    LabelAllWholeBlood: TTempLabelTag5;
    LabelAllStoredBlood: TTempLabelTag5;
    LabelBlood: TTempLabelTag5;
    //компоненты 1
    LabelVolume: TTempLabelTag5;
    LabelNumberDoses: TTempLabelTag5;
    LabelType: TTempLabelTag5;
    LabelErSusp: TTempLabelTag5;
    LabelPlazma: TTempLabelTag5;
    LabelFiltrat: TTempLabelTag5;
    LabelDefectWholeBlood: TTempLabelTag5;
    //компоненты 2
    LabelVolume2: TTempLabelTag5;
    LabelNumberDoses2: TTempLabelTag5;
    LabelType2: TTempLabelTag5;
    LabelErSusp2: TTempLabelTag5;
    LabelPlazma2: TTempLabelTag5;
    LabelFiltrat2: TTempLabelTag5;
    LabelDefectWholeBlood2: TTempLabelTag5;

    Title: TTitleLabelTag5;
    SQL: String;

    //таблица "кровь"
    PanelGorBlood: TTempPanelTag5;
    PanelVertBlood1: TTempPanelTag5;
    PanelVertBlood2: TTempPanelTag5;
    PanelVertBlood3: TTempPanelTag5;
    PanelVertBlood4: TTempPanelTag5;
    //таблица "компоненты 1"
    PanelGor1Components1: TTempPanelTag5;
    PanelGor2Components1: TTempPanelTag5;
    PanelGor3Components1: TTempPanelTag5;
    PanelGor4Components1: TTempPanelTag5;
    PanelVert1Components1: TTempPanelTag5;
    PanelVert2Components1: TTempPanelTag5;
    PanelVert3Components1: TTempPanelTag5;
    //таблица "компоненты 2"
    PanelGor1Components2: TTempPanelTag5;
    PanelGor2Components2: TTempPanelTag5;
    PanelGor3Components2: TTempPanelTag5;
    PanelGor4Components2: TTempPanelTag5;
    PanelVert1Components2: TTempPanelTag5;
    PanelVert2Components2: TTempPanelTag5;
    PanelVert3Components2: TTempPanelTag5;

    //шапка
    DateCal: TDTPickerTag5;
    EditNumberOfDonors: TEditTag5;
    EditNumberOfDoses: TEditTag5;
    EditNumberOfDoses2: TEditTag5;
    //таблица "кровь"
    EditSentToPreserving: TEditTag5;
    EditForLaboratoryResearch: TEditTag5;
    EditAllWholeBlood: TEditTag5;
    EditAllStoredBlood: TEditTag5;
    //таблица "компоненты 1"
    EditVolumeErSusp: TEditTag5;
    EditVolumePlazma: TEditTag5;
    EditVolumeFiltrat: TEditTag5;
    EditVolumeDefect: TEditTag5;
    EditNumberDosesErSusp: TEditTag5;
    EditNumberDosesPlazma: TEditTag5;
    EditNumberDosesFiltrat: TEditTag5;
    EditNumberDosesDefect: TEditTag5;
    //таблица "компоненты 2"
    EditVolumeErSusp2: TEditTag5;
    EditVolumePlazma2: TEditTag5;
    EditVolumeFiltrat2: TEditTag5;
    EditVolumeDefect2: TEditTag5;
    EditNumberDosesErSusp2: TEditTag5;
    EditNumberDosesPlazma2: TEditTag5;
    EditNumberDosesFiltrat2: TEditTag5;
    EditNumberDosesDefect2: TEditTag5;

    CBoxVolumeOfDonation: TComboboxTag5;
    CBoxVolumeOfDonation2: TComboboxTag5;
    CBoxTypeErSusp: TComboboxTag5;
    CBoxTypeDefect: TComboboxTag5;
    CBoxTypePlazma: TComboboxTag5;
    CBoxTypeErSusp2: TComboboxTag5;
    CBoxTypeDefect2: TComboboxTag5;
    CBoxTypePlazma2: TComboboxTag5;

    StringGrid: TStringGridTag5;
    ContentForStringGrid: IMHMManualHarvesting;
    AddRecord: IMHMAddRecordManualHarvesting;
    DeleteRecord: IMHMDeleteRecordManualHarvesting;
    ChangeRecord: IMHMChangeRecordManualHarvesting;

    ValueChecksOnTheAdequacy: IUMSValueChecksOnTheAdequacy;
    CheckFillStrFields: ICheckFillStringFields;
    BlockMainMenu: IBlockMainMenu;
    CheckBox: TCheckBoxTag5;
    CheckBoxOuting: TCheckBoxTag5;

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
    procedure Show;
  public
    constructor create(form: TForm); override;
    destructor destroy; override;
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
  Show;
end;

destructor TVHMManualHarvesting.destroy;
begin
  LabelDate.destroy;
  LabelNumberOfDonors.destroy;
  LabelVolumeOfDonation.destroy;
  LabelNumberOfDoses.destroy;
  //кровь
  LabelSentToPreserving.destroy;
  LabelForLaboratoryResearch.destroy;
  LabelAllWholeBlood.destroy;
  LabelAllStoredBlood.destroy;
  LabelBlood.destroy;
  //компоненты 1
  LabelVolume.destroy;
  LabelNumberDoses.destroy;
  LabelType.destroy;
  LabelErSusp.destroy;
  LabelPlazma.destroy;
  LabelFiltrat.destroy;
  LabelDefectWholeBlood.destroy;
  //компоненты 2
  LabelVolume2.destroy;
  LabelNumberDoses2.destroy;
  LabelType2.destroy;
  LabelErSusp2.destroy;
  LabelPlazma2.destroy;
  LabelFiltrat2.destroy;
  LabelDefectWholeBlood2.destroy;

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
  PanelGor3Components1.destroy;
  PanelGor4Components1.destroy;
  PanelVert1Components1.destroy;
  PanelVert2Components1.destroy;
  PanelVert3Components1.destroy;
  //таблица "компоненты 2"
  PanelGor1Components2.destroy;
  PanelGor2Components2.destroy;
  PanelGor3Components2.destroy;
  PanelGor4Components2.destroy;
  PanelVert1Components2.destroy;
  PanelVert2Components2.destroy;
  PanelVert3Components2.destroy;

  //шапка
  EditNumberOfDonors.destroy;
  EditNumberOfDoses.destroy;
  EditNumberOfDoses2.destroy;
  //таблица "кровь"
  EditSentToPreserving.destroy;
  EditForLaboratoryResearch.destroy;
  EditAllWholeBlood.destroy;
  EditAllStoredBlood.destroy;
  //таблица "компоненты 1"
  EditVolumeErSusp.destroy;
  EditVolumePlazma.destroy;
  EditVolumeFiltrat.destroy;
  EditVolumeDefect.destroy;
  EditNumberDosesErSusp.destroy;
  EditNumberDosesPlazma.destroy;
  EditNumberDosesFiltrat.destroy;
  EditNumberDosesDefect.destroy;
  //таблица "компоненты 2"
  EditVolumeErSusp2.destroy;
  EditVolumePlazma2.destroy;
  EditVolumeFiltrat2.destroy;
  EditVolumeDefect2.destroy;
  EditNumberDosesErSusp2.destroy;
  EditNumberDosesPlazma2.destroy;
  EditNumberDosesFiltrat2.destroy;
  EditNumberDosesDefect2.destroy;

  CBoxVolumeOfDonation.destroy;
  CBoxVolumeOfDonation2.destroy;
  CBoxTypeErSusp.destroy;
  CBoxTypeDefect.destroy;
  CBoxTypePlazma.destroy;
  CBoxTypeErSusp2.destroy;
  CBoxTypeDefect2.destroy;
  CBoxTypePlazma2.destroy;

  StringGrid.destroy;

  DateCal.destroy;

  CheckBox.destroy;
  CheckBoxOuting.destroy;

  ButtonAdd.destroy;
  ButtonDelete.destroy;
  ButtonEdit.destroy;
  ButtonBlock.destroy;
  inherited;
end;

//Button

procedure TVHMManualHarvesting.AfterSaving_Cancelling;
var
  i: integer;
begin
  CheckBox.WriteChecked(false);
  CheckBoxOuting.WriteChecked(false);
  DateCal.WriteDateTime(date());
  for i := CBoxVolumeOfDonation.GetItemsCount downto 0 do
    if CBoxVolumeOfDonation.GetItemsValue(i)='450' then CBoxVolumeOfDonation.WriteItemIndex(i);
  for i := CBoxVolumeOfDonation2.GetItemsCount downto 0 do
    if CBoxVolumeOfDonation2.GetItemsValue(i)='350' then CBoxVolumeOfDonation2.WriteItemIndex(i);
  EditNumberOfDonors.WriteText('0');
  EditNumberOfDoses.WriteText('0');
  EditNumberOfDoses2.WriteText('0');
  EditSentToPreserving.WriteText('0');
  EditForLaboratoryResearch.WriteText('0');
  EditAllWholeBlood.WriteText('0');
  EditAllStoredBlood.WriteText('0');
  EditVolumeErSusp.WriteText('0');
  EditVolumeErSusp2.WriteText('0');
  EditNumberDosesErSusp.WriteText('0');
  EditNumberDosesErSusp2.WriteText('0');
  EditVolumePlazma.WriteText('0');
  EditVolumePlazma2.WriteText('0');
  EditNumberDosesPlazma.WriteText('0');
  EditNumberDosesPlazma2.WriteText('0');
  EditVolumeFiltrat.WriteText('0');
  EditVolumeFiltrat2.WriteText('0');
  EditNumberDosesFiltrat.WriteText('0');
  EditNumberDosesFiltrat2.WriteText('0');
  EditNumberDosesPlazma.WriteText('0');
  EditNumberDosesPlazma2.WriteText('0');
  EditVolumeDefect.WriteText('0');
  EditVolumeDefect2.WriteText('0');
  EditNumberDosesDefect.WriteText('0');
  EditNumberDosesDefect2.WriteText('0');
  CBoxTypeErSusp.WriteItemIndex(2);
  CBoxTypePlazma.WriteItemIndex(1);
  CBoxTypeDefect.WriteItemIndex(-1);
  CBoxTypeErSusp2.WriteItemIndex(1);
  CBoxTypePlazma2.WriteItemIndex(0);
  CBoxTypeDefect2.WriteItemIndex(-1);
end;

// Добавление новой записи

procedure TVHMManualHarvesting.ButtonAdded(Sender: TObject);
var
  Doza350: string;
  Doza450: string;
begin
  if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
  begin
    if not Assigned(CheckForExistenceOfRecord) then
      CheckForExistenceOfRecord := TUMSCheckForExistenceOfRecord.create;
    SQL:='SELECT ДатаК ' +
      'FROM Blood ' +
      'WHERE Blood.ДатаК=#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(DateCal.GetDate)) + '# ';
    if CheckForExistenceOfRecord.CheckForExistenceOfRecord(SQL) then exit;
    if CheckingBeforeSaving then exit;
    if not Assigned(AddRecord) then
      AddRecord := TMHMAddRecordManualHarvesting.create;
    AddRecord.AddRecordBlood(DateCal.GetDate, EditNumberOfDonors.ReadText,
      EditSentToPreserving.ReadText, EditForLaboratoryResearch.ReadText,
      EditAllWholeBlood.ReadText, EditAllStoredBlood.ReadText, CheckBoxOuting.CheckedString);
    case CheckBox.GetChecked of
      False:
      begin
        if CBoxVolumeOfDonation.GetItemsValue(CBoxVolumeOfDonation.GetItemIndex)='350' then Doza350:=EditNumberOfDoses.ReadText else Doza350:='0';
        if CBoxVolumeOfDonation.GetItemsValue(CBoxVolumeOfDonation.GetItemIndex)='450' then Doza450:=EditNumberOfDoses.ReadText else Doza450:='0';
        AddRecord.AddRecordBloodDoze(DateCal.GetDate, '0', Doza350, '0', Doza450, '0');
        AddRecord.AddRecordBloodErSusp(EditVolumeErSusp.ReadText, EditNumberDosesErSusp.ReadText, CBoxTypeErSusp.GetItemsValue(CBoxTypeErSusp.GetItemIndex));
        AddRecord.AddRecordBloodPlazma(EditVolumePlazma.ReadText, EditNumberDosesPlazma.ReadText, CBoxTypePlazma.GetItemsValue(CBoxTypePlazma.GetItemIndex));
        AddRecord.AddRecordBloodFiltrat(EditVolumeFiltrat.ReadText, EditNumberDosesFiltrat.ReadText);
        AddRecord.AddRecordBloodDefect(EditVolumeDefect.ReadText, EditNumberDosesDefect.ReadText, CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
      end;
      True:
      begin
        if CBoxVolumeOfDonation.GetItemsValue(CBoxVolumeOfDonation.GetItemIndex)='350' then Doza350:=EditNumberOfDoses.ReadText else Doza350:='0';
        if CBoxVolumeOfDonation.GetItemsValue(CBoxVolumeOfDonation.GetItemIndex)='450' then Doza450:=EditNumberOfDoses.ReadText else Doza450:='0';
        AddRecord.AddRecordBloodDoze(DateCal.GetDate, '0', Doza350, '0', Doza450, '0');
        AddRecord.AddRecordBloodErSusp(EditVolumeErSusp.ReadText, EditNumberDosesErSusp.ReadText, CBoxTypeErSusp.GetItemsValue(CBoxTypeErSusp.GetItemIndex));
        AddRecord.AddRecordBloodPlazma(EditVolumePlazma.ReadText, EditNumberDosesPlazma.ReadText, CBoxTypePlazma.GetItemsValue(CBoxTypePlazma.GetItemIndex));
        AddRecord.AddRecordBloodFiltrat(EditVolumeFiltrat.ReadText, EditNumberDosesFiltrat.ReadText);
        AddRecord.AddRecordBloodDefect(EditVolumeDefect.ReadText, EditNumberDosesDefect.ReadText, CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));

        if CBoxVolumeOfDonation2.GetItemsValue(CBoxVolumeOfDonation2.GetItemIndex)='350' then Doza350:=EditNumberOfDoses2.ReadText else Doza350:='0';
        if CBoxVolumeOfDonation2.GetItemsValue(CBoxVolumeOfDonation2.GetItemIndex)='450' then Doza450:=EditNumberOfDoses2.ReadText else Doza450:='0';
        AddRecord.AddRecordBloodDoze(DateCal.GetDate, '0', Doza350, '0', Doza450, '0');
        AddRecord.AddRecordBloodErSusp(EditVolumeErSusp2.ReadText, EditNumberDosesErSusp2.ReadText, CBoxTypeErSusp2.GetItemsValue(CBoxTypeErSusp2.GetItemIndex));
        AddRecord.AddRecordBloodPlazma(EditVolumePlazma2.ReadText, EditNumberDosesPlazma2.ReadText, CBoxTypePlazma2.GetItemsValue(CBoxTypePlazma2.GetItemIndex));
        AddRecord.AddRecordBloodFiltrat(EditVolumeFiltrat2.ReadText, EditNumberDosesFiltrat2.ReadText);
        AddRecord.AddRecordBloodDefect(EditVolumeDefect2.ReadText, EditNumberDosesDefect2.ReadText, CBoxTypeDefect2.GetItemsValue(CBoxTypeDefect2.GetItemIndex));
      end;
    end;
    GetStringGrid(CurrentForm);
    StringGrid.Visible(True);
    ShowMessage('Записи успешно добавлена!');
    AfterSaving_Cancelling;
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
    StringGrid.Visible(True);
    ShowMessage('Запись успешно удалена!');
  end;
  AfterSaving_Cancelling;
end;

// Внесение изменений
procedure TVHMManualHarvesting.ButtonEdited(Sender: TObject);
var
 i: integer;
 Doza350, Doza450: string;
begin
  if not Assigned(ChangeRecord) then
    ChangeRecord := TMHMChangeRecordManualHarvesting.create;
  ChangeRecord.GetTempId(StringGrid.GetValue(8 , StringGrid.CurrentRow),
    StringGrid.GetValue(9 , StringGrid.CurrentRow), StringGrid.GetValue(10 , StringGrid.CurrentRow),
    FormatDateTime('mm''/''dd''/''yyyy', StrToDateTime(StringGrid.GetValue(0 , StringGrid.CurrentRow))));

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
    CheckBox.Enabled(False);
    StringGrid.Enabled(False);
    DateCal.WriteDateTime(StrToDate(StringGrid.GetValue(0, StringGrid.CurrentRow)));
    DateCal.Enabled(false);
    EditNumberOfDonors.WriteText(StringGrid.GetValue(1, StringGrid.CurrentRow));
    if StringGrid.GetValue(2, StringGrid.CurrentRow)<>'0' then
      for i:=0 to CBoxVolumeOfDonation.GetItemsCount do
        if CBoxVolumeOfDonation.GetItemsValue(i)='450' then
        begin
          CBoxVolumeOfDonation.WriteItemIndex(i);
          EditNumberOfDoses.WriteText(StringGrid.GetValue(2, StringGrid.CurrentRow));
          break;
        end;
    if StringGrid.GetValue(3, StringGrid.CurrentRow)<>'0' then
      for i:=0 to CBoxVolumeOfDonation.GetItemsCount do
        if CBoxVolumeOfDonation.GetItemsValue(i)='350' then
        begin
          CBoxVolumeOfDonation.WriteItemIndex(i);
          EditNumberOfDoses.WriteText(StringGrid.GetValue(3, StringGrid.CurrentRow));
          break;
        end;
    EditSentToPreserving.WriteText(StringGrid.GetValue(4 , StringGrid.CurrentRow));
    EditForLaboratoryResearch.WriteText(StringGrid.GetValue(5 , StringGrid.CurrentRow));
    EditAllWholeBlood.WriteText(StringGrid.GetValue(6 , StringGrid.CurrentRow));
    EditAllStoredBlood.WriteText(StringGrid.GetValue(7 , StringGrid.CurrentRow));
    EditVolumeErSusp.WriteText(StringGrid.GetValue(8 , StringGrid.CurrentRow));
    EditNumberDosesErSusp.WriteText(StringGrid.GetValue(9 , StringGrid.CurrentRow));
    for i:=0 to CBoxTypeErSusp.GetItemsCount do
      if CBoxTypeErSusp.GetItemsValue(i)=StringGrid.GetValue(10 , StringGrid.CurrentRow) then
      begin
        CBoxTypeErSusp.WriteItemIndex(i);
        break;
      end;
    EditVolumePlazma.WriteText(StringGrid.GetValue(11 , StringGrid.CurrentRow));
    EditNumberDosesPlazma.WriteText(StringGrid.GetValue(12 , StringGrid.CurrentRow));
    for i:=0 to CBoxTypePlazma.GetItemsCount do
      if CBoxTypePlazma.GetItemsValue(i)=StringGrid.GetValue(13 , StringGrid.CurrentRow) then
      begin
        CBoxTypePlazma.WriteItemIndex(i);
        break;
      end;
    EditVolumeFiltrat.WriteText(StringGrid.GetValue(14 , StringGrid.CurrentRow));
    EditNumberDosesFiltrat.WriteText(StringGrid.GetValue(15 , StringGrid.CurrentRow));
    EditVolumeDefect.WriteText(StringGrid.GetValue(16 , StringGrid.CurrentRow));
    EditNumberDosesDefect.WriteText(StringGrid.GetValue(17 , StringGrid.CurrentRow));
    for i:=0 to CBoxTypeDefect.GetItemsCount do
      if CBoxTypeDefect.GetItemsValue(i)=StringGrid.GetValue(18, StringGrid.CurrentRow) then
      begin
        CBoxTypeDefect.WriteItemIndex(i);
        break;
      end;
    if StringGrid.GetValue(19, StringGrid.CurrentRow)='Да' then CheckBoxOuting.WriteChecked(true) else CheckBoxOuting.WriteChecked(false);
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
      CheckBox.Enabled(true);
      DateCal.Enabled(true);
      StringGrid.Enabled(True);
      if CheckingBeforeSaving then exit;
      if CBoxVolumeOfDonation.GetItemsValue(CBoxVolumeOfDonation.GetItemIndex)='350' then Doza350:=EditNumberOfDoses.ReadText else Doza350:='0';
      if CBoxVolumeOfDonation.GetItemsValue(CBoxVolumeOfDonation.GetItemIndex)='450' then Doza450:=EditNumberOfDoses.ReadText else Doza450:='0';
      ChangeRecord.ChangeRecordBlood(DateCal.GetDate, EditNumberOfDonors.ReadText,
      EditSentToPreserving.ReadText, EditForLaboratoryResearch.ReadText,
      EditAllWholeBlood.ReadText, EditAllStoredBlood.ReadText,
      CheckBoxOuting.CheckedString);
      ChangeRecord.ChangeRecordBloodDoze(DateCal.GetDate, '0', Doza350, '0', Doza450, '0');
      ChangeRecord.ChangeRecordBloodErSusp(EditVolumeErSusp.ReadText, EditNumberDosesErSusp.ReadText, CBoxTypeErSusp.GetItemsValue(CBoxTypeErSusp.GetItemIndex));
      ChangeRecord.ChangeRecordBloodPlazma(EditVolumePlazma.ReadText, EditNumberDosesPlazma.ReadText, CBoxTypePlazma.GetItemsValue(CBoxTypePlazma.GetItemIndex));
      ChangeRecord.ChangeRecordBloodFiltrat(EditVolumeFiltrat.ReadText, EditNumberDosesFiltrat.ReadText);
      ChangeRecord.ChangeRecordBloodDefect(EditVolumeDefect.ReadText, EditNumberDosesDefect.ReadText, CBoxTypeDefect.GetItemsValue(CBoxTypeDefect.GetItemIndex));
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
      CheckBox.Enabled(true);
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
  if CheckBox.GetChecked then
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

function TVHMManualHarvesting.CheckingBeforeSaving: boolean;
var
  value1, value2: integer;
begin
    if not Assigned(CheckFillStrFields) then
      CheckFillStrFields := TCheckFillStringFields.create;
    EditNumberOfDonors.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDonors.ReadText));
    EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses.ReadText));
    EditSentToPreserving.WriteText(CheckFillStrFields.CheckStringFields(EditSentToPreserving.ReadText));
    EditForLaboratoryResearch.WriteText(CheckFillStrFields.CheckStringFields(EditForLaboratoryResearch.ReadText));
    EditAllWholeBlood.WriteText(CheckFillStrFields.CheckStringFields(EditAllWholeBlood.ReadText));
    EditAllStoredBlood.WriteText(CheckFillStrFields.CheckStringFields(EditAllStoredBlood.ReadText));
    EditVolumeErSusp.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeErSusp.ReadText));
    EditNumberDosesErSusp.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesErSusp.ReadText));
    EditVolumePlazma.WriteText(CheckFillStrFields.CheckStringFields(EditVolumePlazma.ReadText));
    EditNumberDosesPlazma.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesPlazma.ReadText));
    EditVolumeFiltrat.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeFiltrat.ReadText));
    EditNumberDosesFiltrat.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesPlazma.ReadText));
    EditVolumeDefect.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeDefect.ReadText));
    EditNumberDosesDefect.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesDefect.ReadText));

    if not Assigned(ValueChecksOnTheAdequacy) then
      ValueChecksOnTheAdequacy := TUMSValueChecksOnTheAdequacy.create;
    if ValueChecksOnTheAdequacy.CheckZeroValues(EditNumberOfDonors.ReadText, 'Количество доноров не может равняться нулю!') then
    begin
      result:=true;
      exit;
    end;
    if ValueChecksOnTheAdequacy.CheckZeroValues(EditNumberOfDoses.ReadText, 'Количество доз не может равняться нулю!') then
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
    case CheckBox.GetChecked of
      False:
      begin
        if ValueChecksOnTheAdequacy.CheckingEqualities(StrToInt(EditNumberOfDonors.ReadText), StrToInt(EditNumberOfDoses.ReadText),
          'Количество доз не совпадает с количеством доноров!') then
        begin
          result:=true;
          exit;
        end;
        value1:=StrToInt(EditVolumeErSusp.ReadText)-100*StrToInt(EditNumberDosesErSusp.ReadText)+StrToInt(EditVolumeFiltrat.ReadText)
          +StrToInt(EditVolumePlazma.ReadText)+StrToInt(EditVolumeDefect.ReadText);
        if ValueChecksOnTheAdequacy.CheckingEqualities(Value1, StrToInt(EditAllStoredBlood.ReadText),
          'Количество консервированной крови не совпадает с суммой ее компонентов (скорее всего неправильно введен фильтрат или брак цельной крови)!') then
        begin
          result:=true;
          exit;
        end;
        value1:=StrToInt(EditNumberDosesErSusp.ReadText)+StrToInt(EditNumberDosesDefect.ReadText);
        if ValueChecksOnTheAdequacy.CheckingEqualities(value1, StrToInt(EditNumberOfDonors.ReadText),
          'Количество донаций эр. взвеси не совпадает с количеством доноров!') then
        begin
          result:=true;
          exit;
        end;
        value1:=StrToInt(EditNumberDosesPlazma.ReadText)+StrToInt(EditNumberDosesDefect.ReadText);
        if ValueChecksOnTheAdequacy.CheckingEqualities(value1, StrToInt(EditNumberOfDonors.ReadText),
          'Количество донаций плазмы не совпадает с количеством доноров!') then
        begin
          result:=true;
          exit;
        end;
        value1:=StrToInt(EditNumberDosesPlazma.ReadText)+StrToInt(EditNumberDosesDefect.ReadText);
        if ValueChecksOnTheAdequacy.CheckingEqualities(value1, StrToInt(EditNumberOfDonors.ReadText),
          'Количество донаций плазмы не совпадает с количеством доноров!') then
        begin
          result:=true;
          exit;
        end;
        if StrToInt(EditVolumeErSusp.ReadText)<StrToInt(EditVolumePlazma.ReadText) then
          if MessageDlg('Объем плазмы больше объема эр. взвеси!' + chr(13) + 'Все равно сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)<>6 then
          begin
            result:=true;
            exit;
          end;
        if (StrToInt(EditVolumeErSusp.ReadText)<StrToInt(EditVolumeFiltrat.ReadText)) or (StrToInt(EditVolumePlazma.ReadText)<StrToInt(EditVolumeFiltrat.ReadText)) then
        begin
          ShowMessage('Объем фильтрата почему-то больше объема эр. взвеси или плазмы!');
          result:=true;
          exit;
        end;
      end;
      True:
      begin
        EditNumberOfDoses2.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses2.ReadText));
        EditVolumeErSusp2.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeErSusp2.ReadText));
        EditNumberDosesErSusp2.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesErSusp2.ReadText));
        EditVolumePlazma2.WriteText(CheckFillStrFields.CheckStringFields(EditVolumePlazma2.ReadText));
        EditNumberDosesPlazma2.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesPlazma2.ReadText));
        EditVolumeFiltrat2.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeFiltrat2.ReadText));
        EditNumberDosesFiltrat2.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesPlazma2.ReadText));
        EditVolumeDefect2.WriteText(CheckFillStrFields.CheckStringFields(EditVolumeDefect2.ReadText));
        EditNumberDosesDefect2.WriteText(CheckFillStrFields.CheckStringFields(EditNumberDosesDefect2.ReadText));

        if ValueChecksOnTheAdequacy.CheckZeroValues(EditNumberOfDoses2.ReadText, 'Количество доз второго вида гемаконов почему-то равна нулю!' + chr(13) + 'Если все донации происходили с использованием одного вида гемаконов, то уберите галочку "Заготовка происходила в разных гемаконах"') then
        begin
          result:=true;
          exit;
        end;
        value1:=StrToInt(EditNumberOfDoses.ReadText)+StrToInt(EditNumberOfDoses2.ReadText);
        if ValueChecksOnTheAdequacy.CheckingEqualities(value1, StrToInt(EditNumberOfDonors.ReadText),
          'Сумма доз не совпадает с количеством доноров!') then
        begin
          result:=true;
          exit;
        end;
        value1:=StrToInt(EditVolumeErSusp.ReadText)+StrToInt(EditVolumeErSusp2.ReadText)
                -100*(StrToInt(EditNumberDosesErSusp.ReadText)+StrToInt(EditNumberDosesErSusp2.ReadText))
                +StrToInt(EditVolumeFiltrat.ReadText)+StrToInt(EditVolumeFiltrat2.ReadText)
                +StrToInt(EditVolumePlazma.ReadText)+StrToInt(EditVolumePlazma2.ReadText)
                +StrToInt(EditVolumeDefect.ReadText)+StrToInt(EditVolumeDefect2.ReadText);
        if ValueChecksOnTheAdequacy.CheckingEqualities(Value1, StrToInt(EditAllStoredBlood.ReadText),
          'Количество консервированной крови не совпадает с суммой ее компонентов (скорее всего неправильно введен фильтрат или брак цельной крови)!') then
        begin
          result:=true;
          exit;
        end;
        value1:=StrToInt(EditNumberDosesErSusp.ReadText)+StrToInt(EditNumberDosesDefect.ReadText)
                +StrToInt(EditNumberDosesErSusp2.ReadText)+StrToInt(EditNumberDosesDefect2.ReadText);
        if ValueChecksOnTheAdequacy.CheckingEqualities(value1, StrToInt(EditNumberOfDonors.ReadText),
          'Сумма донаций эр. взвеси не совпадает с количеством доноров!') then
        begin
          result:=true;
          exit;
        end;
        value1:=StrToInt(EditNumberDosesPlazma.ReadText)+StrToInt(EditNumberDosesDefect.ReadText)
                +StrToInt(EditNumberDosesPlazma2.ReadText)+StrToInt(EditNumberDosesDefect2.ReadText);
        if ValueChecksOnTheAdequacy.CheckingEqualities(value1, StrToInt(EditNumberOfDonors.ReadText),
          'Сумма донаций плазмы не совпадает с количеством доноров!') then
        begin
          result:=true;
          exit;
        end;
        value1:=StrToInt(EditVolumeErSusp.ReadText)+StrToInt(EditVolumeErSusp2.ReadText);
        value2:=StrToInt(EditVolumePlazma.ReadText)+StrToInt(EditVolumePlazma2.ReadText);
        if value1<value2 then
          if MessageDlg('Объем плазмы больше объема эр. взвеси!' + chr(13) + 'Все равно сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)<>6 then
          begin
            result:=true;
            exit;
          end;
        value1:=StrToInt(EditVolumeErSusp.ReadText)+StrToInt(EditVolumeErSusp2.ReadText);
        value2:=StrToInt(EditVolumePlazma.ReadText)+StrToInt(EditVolumePlazma2.ReadText);
        if (value1<StrToInt(EditVolumeFiltrat.ReadText)+StrToInt(EditVolumeFiltrat2.ReadText)) or
           (value2<StrToInt(EditVolumeFiltrat.ReadText)+StrToInt(EditVolumeFiltrat2.ReadText)) then
        begin
          ShowMessage('Объем фильтрата почему-то больше объема эр. взвеси или плазмы!');
          result:=true;
          exit;
        end;
      end;
    end;
  result:=false;
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
  result := CBoxVolumeOfDonation.GetComboBox('CBoxVolumeOfDonation', 200, 120, 100, 10, NameForm);
  SQL:='SELECT top 1 * ' +
  'FROM BloodDoza';
  CBoxVolumeOfDonation.GetListOfTheNameColumns(SQL);
  for i := CBoxVolumeOfDonation.GetItemsCount downto 0 do
    if (CBoxVolumeOfDonation.GetItemsValue(i)<>'350') and (CBoxVolumeOfDonation.GetItemsValue(i)<>'450') then CBoxVolumeOfDonation.DeleteRecord(i);
  for i := CBoxVolumeOfDonation.GetItemsCount downto 0 do
    if CBoxVolumeOfDonation.GetItemsValue(i)='450' then CBoxVolumeOfDonation.WriteItemIndex(i);
end;

function TVHMManualHarvesting.GetCBoxVolumeOfDonation2(NameForm: TForm): TComboBox;
var
  i: integer;
begin
  if not Assigned(CBoxVolumeOfDonation2) then
    CBoxVolumeOfDonation2 := TComboboxTag5.create;
  result := CBoxVolumeOfDonation2.GetComboBox('CBoxVolumeOfDonation2', 320, 120, 100, 10, NameForm);
  SQL:='SELECT top 1 * ' +
  'FROM BloodDoza';
  CBoxVolumeOfDonation2.GetListOfTheNameColumns(SQL);
  for i := CBoxVolumeOfDonation2.GetItemsCount downto 0 do
    if (CBoxVolumeOfDonation2.GetItemsValue(i)<>'350') and (CBoxVolumeOfDonation2.GetItemsValue(i)<>'450') then CBoxVolumeOfDonation2.DeleteRecord(i);
  for i := CBoxVolumeOfDonation.GetItemsCount downto 0 do
    if CBoxVolumeOfDonation2.GetItemsValue(i)='350' then CBoxVolumeOfDonation2.WriteItemIndex(i);
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
  result := CBoxTypeErSusp.GetComboBox('CBoxTypeErSusp', 340, 330, 90, 10, NameForm);
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
  result := CBoxTypePlazma.GetComboBox('CBoxTypePlazma', 340, 357, 90, 10, NameForm);
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
  result := CBoxTypeDefect.GetComboBox('CBoxTypeDefect', 340, 413, 90, 10, NameForm);
  SQL:='SELECT TypeOfDefects.TypeDef ' +
  'FROM TypeOfDefects ' +
  'WHERE (TypeOfDefects.Other=True)';
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
  result := CBoxTypeErSusp2.GetComboBox('CBoxTypeErSusp2', 780, 330, 90, 10, NameForm);
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
  result := CBoxTypePlazma2.GetComboBox('CBoxTypePlazma2', 780, 357, 90, 10, NameForm);
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
  result := CBoxTypeDefect2.GetComboBox('CBoxTypeDefect2', 780, 413, 90, 10, NameForm);
  SQL:='SELECT TypeOfDefects.TypeDef ' +
  'FROM TypeOfDefects ' +
  'WHERE (TypeOfDefects.Other=True)';
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
  StringGrid.ResultFormat(DT_CENTER, 1, DT_CENTER, 11, DT_CENTER, 14, DT_CENTER, 19, DT_CENTER, 36, DT_CENTER);
  Result:=StringGrid.GetStringGrid(30, 480, 840, 160, 20, 2, 9, NameForm);
  StringGrid.NumberOfFixedCol(0);
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
  StringGrid.ColWidth(16,90);
  StringGrid.ColWidth(17,90);
  StringGrid.ColWidth(18,100);
  StringGrid.ColWidth(19, 40);
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
  StringGrid.WriteCells(19, 0, 'Выезд');
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
        StringGrid.WriteCells(15, i+1, ContentForStringGrid.GetNumberOfDosesFiltrat(j));
        StringGrid.WriteCells(16, i+1, ContentForStringGrid.GetVolomeDefect(j));
        StringGrid.WriteCells(17, i+1, ContentForStringGrid.GetNumberOfDosesDefect(j));
        StringGrid.WriteCells(18, i+1, ContentForStringGrid.GetTypeDefect(j));
        StringGrid.WriteCells(19, i+1, ContentForStringGrid.GetOuting(j));
        j:=j+1;
      end;
end;

procedure TVHMManualHarvesting.Show;
begin
  LabelDate.Visible(true);
  LabelNumberOfDonors.Visible(true);
  LabelVolumeOfDonation.Visible(true);
  LabelNumberOfDoses.Visible(true);
  LabelSentToPreserving.Visible(true);
  LabelForLaboratoryResearch.Visible(true);
  LabelAllWholeBlood.Visible(true);
  LabelAllStoredBlood.Visible(true);
  LabelBlood.Visible(true);
  LabelVolume.Visible(true);
  LabelNumberDoses.Visible(true);
  LabelType.Visible(true);
  LabelErSusp.Visible(true);
  LabelPlazma.Visible(true);
  LabelFiltrat.Visible(true);
  LabelDefectWholeBlood.Visible(true);

  PanelGorBlood.Visible(true);
  PanelVertBlood1.Visible(true);
  PanelVertBlood2.Visible(true);
  PanelVertBlood3.Visible(true);
  PanelVertBlood4.Visible(true);
  PanelVert1Components1.Visible(true);
  PanelVert2Components1.Visible(true);
  PanelVert3Components1.Visible(true);
  PanelGor1Components1.Visible(true);
  PanelGor2Components1.Visible(true);
  PanelGor3Components1.Visible(true);
  PanelGor4Components1.Visible(true);

  EditNumberOfDonors.Visible(true);
  EditNumberOfDoses.Visible(true);
  EditSentToPreserving.Visible(true);
  EditForLaboratoryResearch.Visible(true);
  EditAllWholeBlood.Visible(true);
  EditAllStoredBlood.Visible(true);
  EditVolumeErSusp.Visible(true);
  EditVolumePlazma.Visible(true);
  EditVolumeFiltrat.Visible(true);
  EditVolumeDefect.Visible(true);
  EditNumberDosesErSusp.Visible(true);
  EditNumberDosesPlazma.Visible(true);
  EditNumberDosesFiltrat.Visible(true);
  EditNumberDosesDefect.Visible(true);

  StringGrid.Visible(true);
  DateCal.Visible(true);
  CheckBox.Visible(true);
  CheckBoxOuting.Visible(true);

  CBoxVolumeOfDonation.Visible(true);
  CBoxTypeErSusp.Visible(true);
  CBoxTypeDefect.Visible(true);
  CBoxTypePlazma.Visible(true);

  ButtonEdit.Visible(true);
  ButtonAdd.Visible(true);
  ButtonDelete.Visible(true);
  ButtonBlock.Visible(true);
end;

end.

