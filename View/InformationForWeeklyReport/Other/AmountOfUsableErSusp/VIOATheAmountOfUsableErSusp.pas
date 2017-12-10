unit VIOATheAmountOfUsableErSusp;

interface

uses
  Vcl.DBGrids, SysUtils, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,
  UMSBlockMainMenu,
  UVFComboBox,
  UVFLabel,
  UVFTitleLabel,
  UVFEdit,
  UVFDateTimePicker,
  UVFBitBtnAdd,
  UVFBitBtnDelete,
  UVFBitBtnEdit,
  UVFBitBtnBlock,
  UVFDBGrid;

type
  ITheAmountOfUsableErSusp = interface
//    function GetLabelReportDate(NameForm: TForm): TLabel;
//    function GetLabelProductList(NameForm: TForm): TLabel;
//    function GetLabelVolume(NameForm: TForm): TLabel;
//    function GetLabelTitle(NameForm: TForm): TLabel;

//    function GetGridDB(NameForm: TForm): TDBGrid;

//    function GetEditVolume(NameForm: TForm): TEdit;
//    function GetProductList(NameForm: TForm): TComboBox;
//    function GetCalendarReportDateCal(NameForm: TForm): TDateTimePicker;

//    function GetButtonSave(NameForm: TForm): TBitBtn;
//    procedure ButtonSaved(Sender: TObject);
//    function GetButtonAdd(NameForm: TForm): TBitBtn;
//    procedure ButtonAdded(Sender: TObject);
//    function GetButtonDelete(NameForm: TForm): TBitBtn;
//    procedure ButtonDeleted(Sender: TObject);
//    function GetButtonBlock(NameForm: TForm): TBitBtn;
//    procedure ButtonBlocked(Sender: TObject);
  end;

  TTheAmountOfUsableErSusp = class(TInterfacedObject, ITheAmountOfUsableErSusp)
  private
    LabelReportDate: ITempLabelTag5;
    LabelProductList: ITempLabelTag5;
    LabelVolume: ITempLabelTag5;
    Title: ITitleLabelTag5;
    SQL: String;

    GridDB: IGridDB;

    EditVolume: IEditTag5;
    ProductList: IComboboxTag5;

    ReportDateCal: IDTPickerTag5;

    BlockMainMenu: IBlockMainMenu;

    ButtonAdd: IBitBtnAddTag5;
    ButtonDelete: IBitBtnDeleteTag5;
    ButtonEdit: IBitBtnEditTag5;
    ButtonBlock: IBitBtnBlockTag5;
    CurrentForm: TForm;
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelProductList(NameForm: TForm): TLabel;
    function GetLabelVolume(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetGridDB(NameForm: TForm): TDBGrid;

    function GetEditVolume(NameForm: TForm): TEdit;
    function GetProductList(NameForm: TForm): TComboBox;
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
    destructor destroy;
  end;

implementation

{ TBloodProduct }

constructor TTheAmountOfUsableErSusp.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelReportDate(form);
  GetLabelProductList(form);
  GetLabelVolume(form);
  GetLabelTitle(form);

  GetGridDB(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);

  GetProductList(form);
  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

destructor TTheAmountOfUsableErSusp.destroy;
begin
  GridDB.CloseConnect;
end;

//Button

// ���������� ����� ������

procedure TTheAmountOfUsableErSusp.ButtonAdded(Sender: TObject);
begin
 //
end;

// ������������� ������

procedure TTheAmountOfUsableErSusp.ButtonBlocked(Sender: TObject);
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

procedure TTheAmountOfUsableErSusp.ButtonDeleted(Sender: TObject);
begin
    ShowMessage('�������!');
end;

// �������� ���������

procedure TTheAmountOfUsableErSusp.ButtonEdited(Sender: TObject);
var
 i: integer;
begin
  if not Assigned(BlockMainMenu) then
    BlockMainMenu := TBlockMainMenu.create;
  if ButtonEdit.GetCaption='��������' then
  begin
    BlockMainMenu.BlockMainMenu(False, CurrentForm);
    ButtonBlock.ChangeEnabled(False);
    ButtonAdd.ChangeEnabled(False);
    ButtonDelete.ChangeEnabled(False);
    ReportDateCal.WriteData(GridDB.GetValue(1));
    for i:=0 to ProductList.GetItemsCount-1 do
      if VarToStr(GridDB.GetValue(2))=ProductList.GetItemsValue(i) then  ProductList.WriteItemIndex(i);
    if ProductList.GetItemIndex=-1 then ShowMessage('�������� ��������� ��� ������ ������ ������ �� �����!');
    EditVolume.WriteText(VarToStr(GridDB.GetValue(3)));
    GridDB.Enable(False);
  end;
  if ButtonEdit.GetCaption='��������� ���������' then
  begin
    BlockMainMenu.BlockMainMenu(True, CurrentForm);
    ButtonBlock.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
  try
    if MessageDlg('��������� ���������?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      GridDB.Enable(True);
      with GridDB do
      begin
        EditValue;
        WriteValue(1, ReportDateCal.GetData);
        WriteValue(2, ProductList.GetItemsValue(ProductList.GetItemIndex));
        WriteValue(3, StrToInt(EditVolume.ReadText));
        PostValue;
      end;
    end
    else
    begin
      GridDB.Enable(True);
      EditVolume.WriteText('');
      ProductList.WriteItemIndex(-1);
      ReportDateCal.WriteData(StartOfTheWeek(Date)-7);
      ButtonEdit.ChangeCaption('��������');
      exit;
    end;
  except
    ShowMessage('�� ���������');
  end;
    EditVolume.WriteText('');
    ProductList.WriteItemIndex(-1);
    ReportDateCal.WriteData(StartOfTheWeek(Date)-7);
  end;
  if ButtonEdit.GetCaption='��������' then ButtonEdit.ChangeCaption('��������� ���������') else ButtonEdit.ChangeCaption('��������');
end;

// �������� ������

function TTheAmountOfUsableErSusp.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TTheAmountOfUsableErSusp.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TTheAmountOfUsableErSusp.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TTheAmountOfUsableErSusp.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TTheAmountOfUsableErSusp.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal:=TDTPickerTag5.Create;
  result:=ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-7, NameForm);
end;

//Edit

function TTheAmountOfUsableErSusp.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TEditTag5.create;
  Result:=EditVolume.GetEdit(400, 180, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);
end;

//DBGrid

function TTheAmountOfUsableErSusp.GetGridDB(NameForm: TForm): TDBGrid;
begin
  if not Assigned(GridDB) then
    GridDB := TGridDB.create;
  Result:=GridDB.GetGridDB(50, 280, 800, 240, 12, NameForm);
  SQL:='SELECT Exped.���, Exped.������, Exped.��, Sum(Exped.����) AS [Sum-����] ' +
  'FROM Exped GROUP BY Exped.������, Exped.��, Exped.��� HAVING (((Sum(Exped.����))>0)) ORDER BY Exped.������ desc;';
  GridDB.OpenConnect(SQL);
  GridDB.Visible(0, false);
  GridDB.TitleColumn(1, '����');
  GridDB.TitleColumn(2, '������������ ���������');
  GridDB.TitleColumn(3, '�����, ��');
  GridDB.WidthColumn(1, 100);
  GridDB.WidthColumn(2, 300);
  GridDB.WidthColumn(3, 100);
end;

//Label

function TTheAmountOfUsableErSusp.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TTempLabelTag5.create;
  result := LabelReportDate.GetTempLabel(50, 80, 16, '�������� ������: ', NameForm);
end;

function TTheAmountOfUsableErSusp.GetLabelProductList(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProductList) then
    LabelProductList := TTempLabelTag5.create;
  result := LabelProductList.GetTempLabel(50, 130, 16, '�������� ��������: ', NameForm);
end;

function TTheAmountOfUsableErSusp.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(50, 180, 16, '����������� ������ ���������, ��: ', NameForm);
end;

function TTheAmountOfUsableErSusp.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(18, '����� ������ �������������� ���� ������������� �� �������� ������', NameForm);
end;

//ComboBox

function TTheAmountOfUsableErSusp.GetProductList(NameForm: TForm): TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TComboboxTag5.create;
  result := ProductList.GetComboBox(400, 130, 185, 14, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id FROM NameProducts ' +
  'WHERE (((NameProducts.TypeProduct)="�� ������") And NameProducts.Production=True);';
  ProductList.TheContentOfTheList(SQL);
end;

end.
