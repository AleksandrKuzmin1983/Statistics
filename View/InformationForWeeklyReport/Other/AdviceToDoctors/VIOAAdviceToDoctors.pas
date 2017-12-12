unit VIOAAdviceToDoctors;

interface

uses
  WinProcs, Vcl.DBGrids, SysUtils, StdCtrls, Buttons, Vcl.Grids,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Variants,
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
  MIOAAdviceToDoctors;

type
  IAdviceToDoctors = interface
  end;

  TAdviceToDoctors = class(TInterfacedObject, IAdviceToDoctors)
  private
    LabelReportDate: ITempLabelTag5;
    LabelTheDoctorTransfuziolog: ITempLabelTag5;
    LabelMedicalLaboratoryScientist: ITempLabelTag5;
    Title: ITitleLabelTag5;
    SQL: String;

    StringGrid: IStringGridTag5;
    ContentForStringGrid: IAdviceTDoctors;

    EditTheDoctorTransfuziolog: IEditTag5;
    EditMedicalLaboratoryScientist: IEditTag5;

    ReportDateCal: IDTPickerTag5;

    BlockMainMenu: IBlockMainMenu;

    ButtonAdd: IBitBtnAddTag5;            //
    ButtonDelete: IBitBtnDeleteTag5;       //
    ButtonEdit: IBitBtnEditTag5;
    ButtonBlock: IBitBtnBlockTag5;         //
    CurrentForm: TForm;                   //
    function GetLabelReportDate(NameForm: TForm): TLabel;
    function GetLabelTheDoctorTransfuziolog(NameForm: TForm): TLabel;
    function GetLabelMedicalLaboratoryScientist(NameForm: TForm): TLabel;
    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetStringGrid(NameForm: TForm): TStringGrid;     //
    function GetEditTheDoctorTransfuziolog(NameForm: TForm): TEdit;
    function GetEditMedicalLaboratoryScientist(NameForm: TForm): TEdit;
    function GetCalendarReportDateCal(NameForm: TForm): TDateTimePicker;

    function GetButtonEdit(NameForm: TForm): TBitBtn;      //
    procedure ButtonEdited(Sender: TObject);               //
    function GetButtonAdd(NameForm: TForm): TBitBtn;       //
    procedure ButtonAdded(Sender: TObject);                  //
    function GetButtonDelete(NameForm: TForm): TBitBtn;      //
    procedure ButtonDeleted(Sender: TObject);                 //
    function GetButtonBlock(NameForm: TForm): TBitBtn;       //
    procedure ButtonBlocked(Sender: TObject);
  public
    constructor create(form: TForm);                    //
  end;

implementation

{ TBloodProduct }

constructor TAdviceToDoctors.create(form: TForm);
begin
  CurrentForm:=Form;

  GetLabelReportDate(form);
  GetLabelTheDoctorTransfuziolog(form);
  GetLabelMedicalLaboratoryScientist(form);
  GetLabelTitle(form);

  GetStringGrid(form);

  GetCalendarReportDateCal(form);

  GetEditTheDoctorTransfuziolog(form);
  GetEditMedicalLaboratoryScientist(form);

  GetButtonEdit(form);
  GetButtonAdd(form);
  GetButtonDelete(form);
  GetButtonBlock(form);
end;

//Button

// Добавление новой записи

procedure TAdviceToDoctors.ButtonAdded(Sender: TObject);
begin
    if (EditTheDoctorTransfuziolog.ReadText='') or (EditMedicalLaboratoryScientist.ReadText='') or ((EditMedicalLaboratoryScientist.ReadText='0') and (EditTheDoctorTransfuziolog.ReadText='0')) then
    begin
      Showmessage('Поле "Произведено годной продукции, мл" должно быть заполнено!');
      exit;
    End;
  try
    if MessageDlg('Сохранить запись?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
 //       AddSQL('INSERT INTO Exped (ДАТАЛЗ, НС, ПГЭС) VALUES (#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(ReportDateCal.GetDate)) +
 //              '#, ''' + ProductList.GetItemsValue(ProductList.GetItemIndex) + ''', ' + EditVolume.ReadText + ')');
        ExecSQL;
     {  OpenConnect;
        Insert;
        WriteValue(1, dateOf(ReportDateCal.GetDate));
        WriteValue(2, ProductList.GetItemsValue(ProductList.GetItemIndex));
        WriteValue(3, StrToInt(EditVolume.ReadText));
        Post;
        CloseConnect; }
      end;
    ShowMessage('Запись успешно добавлена!');
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
    end;
  except
    ShowMessage('Запись не сохранена!');
  end;
    EditTheDoctorTransfuziolog.WriteText('0');
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Разблокировка кнопок

procedure TAdviceToDoctors.ButtonBlocked(Sender: TObject);
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

procedure TAdviceToDoctors.ButtonDeleted(Sender: TObject);
begin
  try
    if MessageDlg('Удалить запись номер ' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)) + '?', mtConfirmation, [mbYes, mbNo], 0)=6 then
    begin
      with ContentForStringGrid do
      begin
        CloseConnect;
        Clear;
        AddSQL('DELETE FROM Exped WHERE Exped.Код=' + VarToStr(StringGrid.GetValue(0, StringGrid.CurrentRow)));
        ExecSQL;
      end;
      ShowMessage('Запись успешно удалена!');
    end;
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
  except
    ShowMessage('Запись не удалена!');
  end;
    EditTheDoctorTransfuziolog.WriteText('0');
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
end;

// Внесение изменений

procedure TAdviceToDoctors.ButtonEdited(Sender: TObject);
begin
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
    EditTheDoctorTransfuziolog.WriteText(VarToStr(StringGrid.GetValue(2, StringGrid.CurrentRow)));
    EditMedicalLaboratoryScientist.WriteText(VarToStr(StringGrid.GetValue(3, StringGrid.CurrentRow)));
  end;
  if ButtonEdit.GetCaption='Сохранить изменения' then
  begin
    if (EditTheDoctorTransfuziolog.ReadText='') or (EditMedicalLaboratoryScientist.ReadText='') or ((EditMedicalLaboratoryScientist.ReadText='0') and (EditTheDoctorTransfuziolog.ReadText='0'))  then
    begin
      Showmessage('Поля "Количество консультаций трансфузиологом" и "Количество консультаций лаборантом"' + char(13) + 'не должны быть пустыми и хотя бы одно из них должно быть отлично от нуля!' + char(13) + 'Если запись необходимо удалить, то отмените изменения и воспользуйтесь кнопкой "Удалить запись"!');
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
        AddSQL('UPDATE Consultations SET Consultations.ДатаКон = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(ReportDateCal.GetDate)) +
               '#, Consultations.ВТ =' + EditTheDoctorTransfuziolog.ReadText + ', ' +
               'Consultations.ВЛ=' + EditMedicalLaboratoryScientist.ReadText + ' WHERE Consultations.Код=' + StringGrid.GetValue(0, StringGrid.CurrentRow));
        ExecSQL;
      end;
    end
    else
    begin
      EditTheDoctorTransfuziolog.WriteText('0');
      EditMedicalLaboratoryScientist.WriteText('0');
      ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
      ButtonEdit.ChangeCaption('Изменить');
      exit;
    end;
    StringGrid.Free;
    StringGrid:=nil;
    ContentForStringGrid:=nil;
    GetStringGrid(CurrentForm);
  except
    ShowMessage('Изменения не сохранены!');
  end;
    EditTheDoctorTransfuziolog.WriteText('0');
    ReportDateCal.WriteDateTime(StartOfTheWeek(Date)-7);
  end;
  if ButtonEdit.GetCaption='Изменить' then ButtonEdit.ChangeCaption('Сохранить изменения') else ButtonEdit.ChangeCaption('Изменить');
end;

// Создание кнопок

function TAdviceToDoctors.GetButtonAdd(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAdd) then
    ButtonAdd := TBitBtnAddTag5.create;
  Result:=ButtonAdd.GetBitBtnAdd(0, 0, ButtonAdded, NameForm);
end;

function TAdviceToDoctors.GetButtonBlock(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonBlock) then
    ButtonBlock := TBitBtnBlockTag5.create;
  Result:=ButtonBlock.GetBitBtnBlock(0, 0, ButtonBlocked, NameForm);
end;

function TAdviceToDoctors.GetButtonDelete(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonDelete) then
    ButtonDelete := TBitBtnDeleteTag5.create;
  Result:=ButtonDelete.GetBitBtnDelete(0, 0, ButtonDeleted, NameForm);
end;

function TAdviceToDoctors.GetButtonEdit(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonEdit) then
    ButtonEdit := TBitBtnEditTag5.create;
  Result:=ButtonEdit.GetBitBtnEdit(0, 0, ButtonEdited, NameForm);
end;

//TDateTimePicker

function TAdviceToDoctors.GetCalendarReportDateCal(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(ReportDateCal) then
    ReportDateCal:=TDTPickerTag5.Create;
  result:=ReportDateCal.GetDTPicker(400, 80, StartOfTheWeek(Date)-7, NameForm);
end;

//Edit

function TAdviceToDoctors.GetEditTheDoctorTransfuziolog(NameForm: TForm): TEdit;
begin
  if not Assigned(EditTheDoctorTransfuziolog) then
    EditTheDoctorTransfuziolog := TEditTag5.create;
  Result:=EditTheDoctorTransfuziolog.GetEdit(450, 130, 135, 12, False, NameForm);
  EditTheDoctorTransfuziolog.NumberOnly(True);
end;

function TAdviceToDoctors.GetEditMedicalLaboratoryScientist(NameForm: TForm): TEdit;
begin
  if not Assigned(EditMedicalLaboratoryScientist) then
    EditMedicalLaboratoryScientist := TEditTag5.create;
  Result:=EditMedicalLaboratoryScientist.GetEdit(450, 180, 135, 12, False, NameForm);
  EditMedicalLaboratoryScientist.NumberOnly(True);
end;

//Label

function TAdviceToDoctors.GetLabelMedicalLaboratoryScientist(
  NameForm: TForm): TLabel;
begin
  if not Assigned(LabelMedicalLaboratoryScientist) then
    LabelMedicalLaboratoryScientist := TTempLabelTag5.create;
  result := LabelMedicalLaboratoryScientist.GetTempLabel(50, 180, 14, 'Количество консультаций лаборантом: ', NameForm);
end;

function TAdviceToDoctors.GetLabelReportDate(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelReportDate) then
    LabelReportDate := TTempLabelTag5.create;
  result := LabelReportDate.GetTempLabel(50, 80, 16, 'Отчетная неделя: ', NameForm);
end;

function TAdviceToDoctors.GetLabelTheDoctorTransfuziolog(NameForm: TForm): TLabel;
begin
  if not Assigned(LabelTheDoctorTransfuziolog) then
    LabelTheDoctorTransfuziolog := TTempLabelTag5.create;
  result := LabelTheDoctorTransfuziolog.GetTempLabel(50, 130, 14, 'Количество консультаций трансфузиологом: ', NameForm);
end;

function TAdviceToDoctors.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  result := Title.GetTitleLabel(16, 'Количество проведенных консультаций врачем-трансфузиологом и врачем-лаборантом', NameForm);
end;

//StringGrid

function TAdviceToDoctors.GetStringGrid(
  NameForm: TForm): TStringGrid;
Var
  i, j: integer;
begin
  if not Assigned(StringGrid) then
    StringGrid := TStringGridTag5.create;
  StringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 1, DT_LEFT, 2, DT_Center, 3, DT_Center, 4, DT_Center);
  Result:=StringGrid.GetStringGrid(50, 280, 800, 240, 4, 2, 12, NameForm);
  StringGrid.NumberOfFixedCol(0);
  StringGrid.ColWidth(0,60);
  StringGrid.ColWidth(1,100);
  StringGrid.ColWidth(2,130);
  StringGrid.ColWidth(3,100);
  StringGrid.Visible(true);
  StringGrid.WriteCells(0, 0, 'Код');
  StringGrid.WriteCells(1, 0, 'Дата');
  StringGrid.WriteCells(2, 0, 'Трансфузиологом');
  StringGrid.WriteCells(3, 0, 'Лаборантом');
  if not Assigned(ContentForStringGrid) then
    ContentForStringGrid := TAdviceTDoctors.create;
    if ContentForStringGrid.GetRowCount>0 then
      for i:=0 to ContentForStringGrid.GetRowCount-1 do
      begin
        if StringGrid.GetValue(0, 1)<>'' then StringGrid.AddRowCount;
        StringGrid.WriteCells(0, i+1, ContentForStringGrid.GetKod(j));
        StringGrid.WriteCells(1, i+1, ContentForStringGrid.GetDate(j));
        StringGrid.WriteCells(2, i+1, ContentForStringGrid.GetTransfuziolog(j));
        StringGrid.WriteCells(3, i+1, ContentForStringGrid.GetLaboratoryScientist(j));
        j:=j+1;
      end;
end;

end.
