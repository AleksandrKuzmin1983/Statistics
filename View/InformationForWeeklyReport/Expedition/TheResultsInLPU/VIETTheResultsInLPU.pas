unit VIETTheResultsInLPU;

interface

uses
  WinProcs, SysUtils, StdCtrls, Buttons, Vcl.Grids,
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
  MIETTheResultsInLPU;

type
  IVIETTheResultsInLPU = interface
  end;

  TVIETTheResultsInLPU = class(TInterfacedObject, IVIETTheResultsInLPU)
  private
    LabelReportDate: ITempLabelTag5;
    LabelTheNameOfTheEnvironment: ITempLabelTag5;
    LabelTypeOfLPU: ITempLabelTag5;
    LabelVolume: ITempLabelTag5;
    LabelNumberOfDoses: ITempLabelTag5;
    LabelPercentage: ITempLabelTag5;
    LabelNumberOfPackets: ITempLabelTag5;
    Title: ITitleLabelTag5;
    SQL: String;

    StringGrid: IStringGridTag5;
    ContentForStringGrid: IMIETTheResultsInLPU;

    EditVolume: IEditTag5;
    EditNumberOfDoses: IEditTag5;
    EditPercentage: IEditTag5;
    EditNumberOfPackets: IEditTag5;

    ProductList: IComboboxTag5;
    TypeLPUList: IComboboxTag5;

    ReportDateCal: IDTPickerTag5;
    CheckFillStrFields: ICheckFillStringFields;
    BlockMainMenu: IBlockMainMenu;

    ButtonAdd: IBitBtnAddTag5;
    ButtonDelete: IBitBtnDeleteTag5;
    ButtonEdit: IBitBtnEditTag5;
    ButtonBlock: IBitBtnBlockTag5;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelTheNameOfTheEnvironment(NameForm: TForm): TLabel;
    function GetLabelTypeOfLPU(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelNumberOfDoses(NameForm: TForm): TLabel;
    function GetLabelPercentage(NameForm: TForm): TLabel;
    function GetLabelNumberOfPackets(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetEditVolume(NameForm: TForm): TEdit;
    function GetEditNumberOfDoses(NameForm: TForm): TEdit;
    function GetEditPercentage(NameForm: TForm): TEdit;
    function GetEditNumberOfPackets(NameForm: TForm): TEdit;

    function GetProductList(NameForm: TForm): TComboBox;
    function GetTypeLPUList(NameForm: TForm): TComboBox;

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

constructor TVIETTheResultsInLPU.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelReportDate(form);
  GetLabelTheNameOfTheEnvironment(form);
  GetLabelTypeOfLPU(form);
  GetLabelVolume(form);
  GetLabelNumberOfDoses(form);
  GetLabelPercentage(form);
  GetLabelNumberOfPackets(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);
  GetEditNumberOfDoses(form);
  GetEditPercentage(form);
  GetEditNumberOfPackets(form);

  GetProductList(form);
  GetTypeLPUList(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

//Button

// ���������� ����� ������

procedure TVIETTheResultsInLPU.ButtonAdded(Sender: TObject);
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
  EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses.ReadText));
  EditPercentage.WriteText(CheckFillStrFields.CheckStringFields(EditPercentage.ReadText));
  EditNumberOfPackets.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfPackets.ReadText));
  if (EditVolume.ReadText='0') or (EditNumberOfDoses.ReadText='0') or (EditPercentage.ReadText='0')
    or (ProductList.GetItemIndex=-1) or (TypeLPUList.GetItemIndex=-1) then
    begin
      Showmessage('��� ���� ������ ���� ���������!');
      exit;
    End;
  try
    if MessageDlg('��������� ������?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('INSERT INTO Exped (������, ��, ���, ���, ���, ����, �����) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(ReportDateCal.GetDate)) + '#, ''' +
        ProductList.GetItemsValue(ProductList.GetItemIndex) + ''', ''' +
        TypeLPUList.GetItemsValue(TypeLPUList.GetItemIndex) + ''', ' +
        EditVolume.ReadText + ', ' + EditNumberOfDoses.ReadText + ', ' +
        EditPercentage.ReadText + ', ' + EditNumberOfPackets.ReadText + ')');
        ExecSQL;
      end;
    ShowMessage('������ ������� ���������!');
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
    end;
  except
    ShowMessage('������ �� ���������!');
  end;
    EditVolume.WriteText('0');
    EditNumberOfDoses.WriteText('0');
    EditPercentage.WriteText('0');
    EditNumberOfPackets.WriteText('0');
    ProductList.WriteItemIndex(-1);
    TypeLPUList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// ������������� ������

procedure TVIETTheResultsInLPU.ButtonBlocked(Sender: TObject);
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

//������ ��������

procedure TVIETTheResultsInLPU.ButtonDeleted(Sender: TObject);
begin
  try
    if MessageDlg('������� ������ ����� ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('DELETE FROM Exped WHERE Exped.���=' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)));
        ExecSQL;
      end;
      ShowMessage('������ ������� �������!');
    end;
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
  except
    ShowMessage('������ �� �������!');
  end;
    EditVolume.WriteText('0');
    EditNumberOfDoses.WriteText('0');
    EditPercentage.WriteText('0');
    EditNumberOfPackets.WriteText('0');
    ProductList.WriteItemIndex(-1);
    TypeLPUList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// �������� ���������

procedure TVIETTheResultsInLPU.ButtonEdited(Sender: TObject);
var
  i: integer;
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TCheckFillStringFields.create;
  if not Assigned(BlockMainMenu) then
    BlockMainMenu := TBlockMainMenu.create;
  if ButtonEdit.GetCaption='��������' then
  begin
    BlockMainMenu.BlockMainMenu(False, CurrentForm);
    ButtonBlock.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    StringGrid.Enabled(False);

    ReportDateCal.WriteDateTime(StrToDate(StringGrid.GetValue(1, StringGrid.CurrentRow)));
    for i:=0 to ProductList.GetItemsCount-1 do
      if VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow))=ProductList.GetItemsValue(i) then  ProductList.WriteItemIndex(i);
    if ProductList.GetItemIndex=-1 then ShowMessage('�������� ���������� ��������� ��� ������ ������ ������ �� �����!' + chr(13) + '���������� � ��������������!');
    for i:=0 to TypeLPUList.GetItemsCount-1 do
      if VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow))=TypeLPUList.GetItemsValue(i) then  TypeLPUList.WriteItemIndex(i);
    if TypeLPUList.GetItemIndex=-1 then ShowMessage('��� ��� ��� ������ ������ ����� �� �����!' + chr(13) + '���������� � ��������������!');
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(4, StringGrid.CurrentRow)));
    EditNumberOfDoses.WriteText(VarToStr(StringGrid.GetValue(5, StringGrid.CurrentRow)));
    EditPercentage.WriteText(VarToStr(StringGrid.GetValue(6, StringGrid.CurrentRow)));
    EditNumberOfPackets.WriteText(VarToStr(StringGrid.GetValue(7, StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetCaption='��������� ���������' then
  begin
    EditVolume.WriteText(CheckFillStrFields.CheckStringFields(EditVolume.ReadText));
    EditNumberOfDoses.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfDoses.ReadText));
    EditPercentage.WriteText(CheckFillStrFields.CheckStringFields(EditPercentage.ReadText));
    EditNumberOfPackets.WriteText(CheckFillStrFields.CheckStringFields(EditNumberOfPackets.ReadText));
    if (EditVolume.ReadText='0') or (EditNumberOfDoses.ReadText='0') or (EditPercentage.ReadText='0')
      or (ProductList.GetItemIndex=-1) or (TypeLPUList.GetItemIndex=-1) then
    begin
      Showmessage('��� ���� ������ ���� ���������!');
      exit;
    End;
    BlockMainMenu.BlockMainMenu(True, CurrentForm);
    ButtonBlock.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
    StringGrid.Enabled(True);
  try
    if MessageDlg('��������� ���������?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('UPDATE Exped SET Exped.������ = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(ReportDateCal.GetDate)) + '#, ' +
        'Exped.�� =''' + ProductList.GetItemsValue(ProductList.GetItemIndex) + ''', ' +
        'Exped.���=''' + TypeLPUList.GetItemsValue(TypeLPUList.GetItemIndex) + ''', ' +
        'Exped.���=' + EditVolume.ReadText + ', ' +
        'Exped.���=' + EditNumberOfDoses.ReadText + ', ' +
        'Exped.����=' + EditPercentage.ReadText + ', ' +
        'Exped.�����=' + EditNumberOfPackets.ReadText + ' ' +
        'WHERE Exped.���=' + StringGrid.GetValue(0, StringGrid.CurrentRow));
        ExecSQL;
      end;
    end
    else
    begin
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      EditPercentage.WriteText('0');
      EditNumberOfPackets.WriteText('0');
      ProductList.WriteItemIndex(-1);
      TypeLPUList.WriteItemIndex(-1);
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
      ButtonEdit.ChangeCaption('��������');
      exit;
    end;
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
  except
    ShowMessage('��������� �� ���������!');
  end;
      EditVolume.WriteText('0');
      EditNumberOfDoses.WriteText('0');
      EditPercentage.WriteText('0');
      EditNumberOfPackets.WriteText('0');
      ProductList.WriteItemIndex(-1);
      TypeLPUList.WriteItemIndex(-1);
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
  end;
  if ButtonEdit.GetCaption='��������' then ButtonEdit.ChangeCaption('��������� ���������') else ButtonEdit.ChangeCaption('��������');
end;

// �������� ������

function TVIETTheResultsInLPU.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TVIETTheResultsInLPU.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TVIETTheResultsInLPU.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TVIETTheResultsInLPU.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TVIETTheResultsInLPU.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal:=TDTPickerTag5.Create;
  result:=ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-7, NameForm);
end;

//Edit

function TVIETTheResultsInLPU.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TEditTag5.create;
  Result:=EditVolume.GetEdit(400, 185, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);
end;

function TVIETTheResultsInLPU.GetEditNumberOfDoses(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfDoses) then
    EditNumberOfDoses := TEditTag5.create;
  Result:=EditNumberOfDoses.GetEdit(400, 220, 185, 12, False, NameForm);
  EditNumberOfDoses.NumberOnly(True);
end;

function TVIETTheResultsInLPU.GetEditPercentage(NameForm: TForm): TEdit;
begin
  if not Assigned(EditPercentage) then
    EditPercentage := TEditTag5.create;
  Result:=EditPercentage.GetEdit(400, 255, 185, 12, False, NameForm);
  EditPercentage.NumberOnly(True);
end;

function TVIETTheResultsInLPU.GetEditNumberOfPackets(NameForm: TForm): TEdit;
begin
  if not Assigned(EditNumberOfPackets) then
    EditNumberOfPackets := TEditTag5.create;
  Result:=EditNumberOfPackets.GetEdit(400, 290, 185, 12, False, NameForm);
  EditNumberOfPackets.NumberOnly(True);
end;

//Label

function TVIETTheResultsInLPU.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(16, '������ �������������� ���� � ���', NameForm);
end;

function TVIETTheResultsInLPU.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TTempLabelTag5.create;
  result := LabelReportDate.GetTempLabel(50, 80, 16, '�������� ������: ', NameForm);
end;

function TVIETTheResultsInLPU.GetLabelTheNameOfTheEnvironment(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTheNameOfTheEnvironment) then
    LabelTheNameOfTheEnvironment := TTempLabelTag5.create;
  result := LabelTheNameOfTheEnvironment.GetTempLabel(50, 115, 14, '������������ ���������: ', NameForm);
end;

function TVIETTheResultsInLPU.GetLabelTypeOfLPU(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTypeOfLPU) then
    LabelTypeOfLPU := TTempLabelTag5.create;
  result := LabelTypeOfLPU.GetTempLabel(50, 150, 14, '��� ���: ', NameForm);
end;

function TVIETTheResultsInLPU.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(50, 185, 14, '����� ���������: ', NameForm);
end;

function TVIETTheResultsInLPU.GetLabelNumberOfDoses(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfDoses) then
    LabelNumberOfDoses := TTempLabelTag5.create;
  result := LabelNumberOfDoses.GetTempLabel(50, 220, 14, '���������� ���: ', NameForm);
end;

function TVIETTheResultsInLPU.GetLabelPercentage(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelPercentage) then
    LabelPercentage := TTempLabelTag5.create;
  result := LabelPercentage.GetTempLabel(50, 255, 14, '������� �� ������ �� �������: ', NameForm);
end;

function TVIETTheResultsInLPU.GetLabelNumberOfPackets(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelNumberOfPackets) then
    LabelNumberOfPackets := TTempLabelTag5.create;
  result := LabelNumberOfPackets.GetTempLabel(50, 290, 14, '���������� ������� �����������������: ', NameForm);
end;

//ComboBox


function TVIETTheResultsInLPU.GetProductList(NameForm: TForm): TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TComboboxTag5.create;
  result := ProductList.GetComboBox(285, 115, 300, 14, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id ' +
  'FROM NameProducts ' +
  'WHERE (NameProducts.ForExped=True);';
  ProductList.TheContentOfTheList(SQL);
end;

function TVIETTheResultsInLPU.GetTypeLPUList(NameForm: TForm): TComboBox;
begin
  if not Assigned(TypeLPUList) then
    TypeLPUList := TComboboxTag5.create;
  result := TypeLPUList.GetComboBox(400, 150, 185, 14, NameForm);
  SQL:='SELECT TypeOfLPUandOther.NameRecord ' +
  'FROM TypeOfLPUandOther ' +
  'WHERE (((TypeOfLPUandOther.TypeLPU)=True));';
  TypeLPUList.TheContentOfTheList(SQL);
end;

// StringGrid

function TVIETTheResultsInLPU.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 4, DT_RIGHT, 5, DT_RIGHT, 6, DT_RIGHT, 7, DT_RIGHT);
  Result:=StringGrid.GetStringGrid(40, 330, 820, 190, 8, 2, 11, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0,40);
  StringGrid.ColWidth(1,75);
  StringGrid.ColWidth(2,230);
  StringGrid.ColWidth(3,110);
  StringGrid.ColWidth(4,80);
  StringGrid.ColWidth(5,70);
  StringGrid.ColWidth(6,100);
  StringGrid.ColWidth(7,85);
  StringGrid.Visible(true);
  StringGrid.WriteCells(0, 0, '���');
  StringGrid.WriteCells(1, 0, '����');
  StringGrid.WriteCells(2, 0, '������������ ���������');
  StringGrid.WriteCells(3, 0, '��� ���');
  StringGrid.WriteCells(4, 0, '�����, ��');
  StringGrid.WriteCells(5, 0, '����, ��');
  StringGrid.WriteCells(6, 0, '% ����������');
  StringGrid.WriteCells(7, 0, '������, ��');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TMIETTheResultsInLPU.create;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetReportDate(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetTypeOfLPU(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetTheNameOfTheEnvironment(j));
        StringGrid.WriteCells(4, i+1, ContentForStringGrid.GetVolume(j));
        StringGrid.WriteCells(5, i+1, ContentForStringGrid.GetNumberOfDoses(j));
        StringGrid.WriteCells(6, i+1, ContentForStringGrid.GetPercentage(j));
        StringGrid.WriteCells(7, i+1, ContentForStringGrid.GetNumberOfPackets(j));
        j:=j+1;
      end;
end;

end.


