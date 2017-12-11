unit VIOATheAmountOfUsableErSuspVer2;

interface

uses
  Vcl.DBGrids, SysUtils, StdCtrls, Buttons, Vcl.Grids,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,
  UMCGetDataSource,
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
  UVFDBGrid,
  UVFStringGrid,
  MIOATheAmountOfUsableErSuspVer2;

type
  ITheAmountOfUsableErSuspVer2 = interface
  end;

  TTheAmountOfUsableErSuspVer2 = class(TInterfacedObject, ITheAmountOfUsableErSuspVer2)
  private
    LabelReportDate: ITempLabelTag5;
    LabelProductList: ITempLabelTag5;
    LabelVolume: ITempLabelTag5;
    Title: ITitleLabelTag5;
    SQL: String;

    TempADOQuery: IGetDataSource;
    GridDB: IGridDBTag5;
    StringGrid: IStringGridTag5;
    ContentForStringGrid: IAmountOfUsableErSuspVer2;

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

    function GetStringGrid(NameForm: TForm): TStringGrid;

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

constructor TTheAmountOfUsableErSuspVer2.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelReportDate(form);
  GetLabelProductList(form);
  GetLabelVolume(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditVolume(form);

  GetProductList(form);
  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

destructor TTheAmountOfUsableErSuspVer2.destroy;
begin
  GridDB.CloseConnect;
end;

//Button

// ���������� ����� ������

procedure TTheAmountOfUsableErSuspVer2.ButtonAdded(Sender: TObject);
begin
    if (EditVolume.ReadText='') or (EditVolume.ReadText='0') then
    begin
      Showmessage('���� "����������� ������ ���������, ��" ������ ���� ���������!');
      exit;
    End;
    if ProductList.GetItemIndex=-1 then
    begin
      ShowMessage('��� ��������� �� �����!');
      exit;
    end;
  try
    if MessageDlg('��������� ������?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('INSERT INTO Exped (������, ��, ����) VALUES (#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(ReportDateCal.GetDate)) +
               '#, ''' + ProductList.GetItemsValue(ProductList.GetItemIndex) + ''', ' + EditVolume.ReadText + ')');
        ExecSQL;
     {  OpenConnect;
        Insert;
        WriteValue(1, dateOf(ReportDateCal.GetDate));
        WriteValue(2, ProductList.GetItemsValue(ProductList.GetItemIndex));
        WriteValue(3, StrToInt(EditVolume.ReadText));
        Post;
        CloseConnect; }
      end;
    end;
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
  except
    ShowMessage('������ �� ���������!');
  end;
    EditVolume.WriteText('0');
    ProductList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// ������������� ������

procedure TTheAmountOfUsableErSuspVer2.ButtonBlocked(Sender: TObject);
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

procedure TTheAmountOfUsableErSuspVer2.ButtonDeleted(Sender: TObject);
begin
    ShowMessage('�������!');
end;

// �������� ���������

procedure TTheAmountOfUsableErSuspVer2.ButtonEdited(Sender: TObject);
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
    ReportDateCal.WriteDateTime(StrToDate(StringGrid.GetValue(1, StringGrid.CurrentRow)));
    for i:=0 to ProductList.GetItemsCount-1 do
      if VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow))=ProductList.GetItemsValue(i) then  ProductList.WriteItemIndex(i);
    if ProductList.GetItemIndex=-1 then ShowMessage('�������� ��������� ��� ������ ������ ������ �� �����!');
    EditVolume.WriteText(VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetCaption='��������� ���������' then
  begin
    if (EditVolume.ReadText='') or (EditVolume.ReadText='0') then
    begin
      Showmessage('���� "����������� ������ ���������, ��" ������ ���� ���������!' + char(13) + '���� �������� ���������� �������, �� �������� ��������� � �������������� ������� "������� ������"!');
      exit;
    End;
    BlockMainMenu.BlockMainMenu(True, CurrentForm);
    ButtonBlock.ChangeEnabled(True);
    ButtonAdd.ChangeEnabled(True);
    ButtonDelete.ChangeEnabled(True);
  try
    if MessageDlg('��������� ���������?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('UPDATE Exped SET Exped.������ = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(ReportDateCal.GetDate)) +
               '#, Exped.�� =''' + ProductList.GetItemsValue(ProductList.GetItemIndex) + ''', ' +
               'Exped.����=' + EditVolume.ReadText + ' WHERE Exped.���=' + StringGrid.GetValue(0, StringGrid.CurrentRow));
        ExecSQL;
      end;
    end
    else
    begin
      EditVolume.WriteText('0');
      ProductList.WriteItemIndex(-1);
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
    ProductList.WriteItemIndex(-1);
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
  end;
  if ButtonEdit.GetCaption='��������' then ButtonEdit.ChangeCaption('��������� ���������') else ButtonEdit.ChangeCaption('��������');
end;

// �������� ������

function TTheAmountOfUsableErSuspVer2.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TTheAmountOfUsableErSuspVer2.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TTheAmountOfUsableErSuspVer2.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TTheAmountOfUsableErSuspVer2.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TTheAmountOfUsableErSuspVer2.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal:=TDTPickerTag5.Create;
  result:=ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-7, NameForm);
end;

//Edit

function TTheAmountOfUsableErSuspVer2.GetEditVolume(NameForm: TForm): TEdit;
begin
  if not Assigned(EditVolume) then
    EditVolume := TEditTag5.create;
  Result:=EditVolume.GetEdit(400, 180, 185, 12, False, NameForm);
  EditVolume.NumberOnly(True);
end;

//Label

function TTheAmountOfUsableErSuspVer2.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TTempLabelTag5.create;
  result := LabelReportDate.GetTempLabel(50, 80, 16, '�������� ������: ', NameForm);
end;

function TTheAmountOfUsableErSuspVer2.GetLabelProductList(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelProductList) then
    LabelProductList := TTempLabelTag5.create;
  result := LabelProductList.GetTempLabel(50, 130, 16, '�������� ��������: ', NameForm);
end;

function TTheAmountOfUsableErSuspVer2.GetLabelVolume(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelVolume) then
    LabelVolume := TTempLabelTag5.create;
  result := LabelVolume.GetTempLabel(50, 180, 16, '����������� ������ ���������, ��: ', NameForm);
end;

function TTheAmountOfUsableErSuspVer2.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(18, '����� ������ �������������� ���� ������������� �� �������� ������', NameForm);
end;

//ComboBox

function TTheAmountOfUsableErSuspVer2.GetProductList(NameForm: TForm): TComboBox;
begin
  if not Assigned(ProductList) then
    ProductList := TComboboxTag5.create;
  result := ProductList.GetComboBox(270, 130, 315, 14, NameForm);
  SQL:='SELECT NameProducts.ShortName, NameProducts.id FROM NameProducts ' +
  'WHERE (((NameProducts.TypeProduct)="�� ������") And NameProducts.Production=True);';
  ProductList.TheContentOfTheList(SQL);
end;


function TTheAmountOfUsableErSuspVer2.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  Result:=StringGrid.GetStringGrid(50, 280, 800, 240, 4, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0,60);
  StringGrid.ColWidth(1,100);
  StringGrid.ColWidth(2,300);
  StringGrid.ColWidth(3,100);
  StringGrid.Visible(true);
  StringGrid.WriteCells(0, 0, '���');
  StringGrid.WriteCells(1, 0, '����');
  StringGrid.WriteCells(2, 0, '������������ ���������, ��');
  StringGrid.WriteCells(3, 0, '�����, ��');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TAmountOfUsableErSuspVer2.create;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetDate(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetName(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetVolume(j));
        j:=j+1;
      end;
end;

end.
