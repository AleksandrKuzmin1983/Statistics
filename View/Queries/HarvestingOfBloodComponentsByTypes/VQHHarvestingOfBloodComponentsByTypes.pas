unit VQHHarvestingOfBloodComponentsByTypes;

interface

uses
  WinProcs, Vcl.Grids, SysUtils, StdCtrls, Buttons,
  Vcl.ComCtrls, DateUtils, Forms, Dialogs, Vcl.ExtCtrls,
  MQHBloodComponents,
  MQHBloodComponentsPlasma,
  MQHPlasmaAPA,
  MQHTrombo,
  UVFStringGrid,
  UVFLabel,
  UVFTitleLabel,
  UVFDateTimePicker,
  UVFBitBtn,
  UMSGlobalVariant;

type
  IHarvestingOfBloodComponentsByTypes = interface
  end;

  THarvestingOfBloodComponentsByTypes = class(TGlobalVariant)
  private
    StartDate: ITempLabelTag5;
    EndDate: ITempLabelTag5;

    Title: ITitleLabelTag5;

    StartDateCal: IDTPickerTag5;
    EndDateCal: IDTPickerTag5;

    TempStringGrid: TStringGridTag5;

    ButtonAction: IBitBtnTag5;

    CurrentForm: TForm;

    BloodComponents: IBloodComponents;
    BloodComponentsPlasma: IBloodComponentsPlasma;
    PlasmaAPA: IPlasmaAPA;
    Trombo: ITrombo;
    function GetLabelStartDate(NameForm: TForm): TLabel;
    function GetLabelEndDate(NameForm: TForm): TLabel;

    function GetLabelTitle(NameForm: TForm): TLabel;

    function GetCalendarStartDate(NameForm: TForm): TDateTimePicker;
    function GetCalendarEndDate(NameForm: TForm): TDateTimePicker;

    function GetStringGrid(NameForm: TForm): TStringGrid;

    function GetButtonAction(NameForm: TForm): TBitBtn;
    procedure ButtonAct(Sender: TObject);
  public
    constructor create(form: TForm);  override;
    destructor destroy;  override;
  end;

implementation

{ TProcurementOfTheComponentsTotal }

constructor THarvestingOfBloodComponentsByTypes.create(form: TForm);
begin
  CurrentForm := form;

  GetLabelStartDate(CurrentForm);
  GetLabelEndDate(CurrentForm);

  GetLabelTitle(CurrentForm);

  GetStringGrid(CurrentForm);

  GetCalendarStartDate(CurrentForm);
  GetCalendarEndDate(CurrentForm);

  GetButtonAction(CurrentForm);
end;

destructor THarvestingOfBloodComponentsByTypes.destroy;
begin
    StartDate.destroy;
    EndDate.destroy;

    Title.destroy;

    StartDateCal.destroy;
    EndDateCal.destroy;

    TempStringGrid.destroy;

    ButtonAction.destroy;
  inherited;
end;

procedure THarvestingOfBloodComponentsByTypes.ButtonAct(Sender: TObject);
var
  i,j: integer;
begin
  j:=0;
  if StartDateCal.GetDate > EndDateCal.GetDate then
  begin
    ShowMessage('Конечная дата не может быть меньше начальной');
    exit;
  end
  else
  begin
    if Assigned(TempStringGrid) then
      TempStringGrid.Visible(false);
    TempStringGrid:=nil;
    GetStringGrid(CurrentForm);
    TempStringGrid.Visible(true);
    TempStringGrid.WriteCells(1, 0, 'Объем, мл');
    TempStringGrid.WriteCells(2, 0, 'Дозы, шт');
    TempStringGrid.WriteCells(3, 0, 'Пакеты, шт');
    if not Assigned(BloodComponents) then
      BloodComponents := TBloodComponents.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    if BloodComponents.GetRowCount>0 then
      for i:=0 to BloodComponents.GetRowCount-1 do
      begin
        if TempStringGrid.GetValue(0, 1)<>'' then TempStringGrid.AddRowCount;
        TempStringGrid.WriteCells(0, i+1, BloodComponents.GetName(j));
        TempStringGrid.WriteCells(1, i+1, BloodComponents.GetVolume(j));
        TempStringGrid.WriteCells(2, i+1, BloodComponents.GetNumber(j));
        j:=j+1;
      end;
     BloodComponents := nil;
    j:=0;
    if not Assigned(BloodComponentsPlasma) then
      BloodComponentsPlasma := TBloodComponentsPlasma.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    if BloodComponentsPlasma.GetRowCount>0 then
      for i:=TempStringGrid.GetRowCount to TempStringGrid.GetRowCount+BloodComponentsPlasma.GetRowCount-1 do
      begin
        TempStringGrid.AddRowCount;
        TempStringGrid.WriteCells(0, i, BloodComponentsPlasma.GetName(j));
        TempStringGrid.WriteCells(1, i, BloodComponentsPlasma.GetVolume(j));
        TempStringGrid.WriteCells(2, i, BloodComponentsPlasma.GetNumber(j));
        j:=j+1;
      end;
     BloodComponentsPlasma := nil;

    j:=0;
    if not Assigned(PlasmaAPA) then
      PlasmaAPA := TPlasmaAPA.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    if PlasmaAPA.GetRowCount>0 then
      for i:=TempStringGrid.GetRowCount to TempStringGrid.GetRowCount+PlasmaAPA.GetRowCount-1 do
      begin
        TempStringGrid.AddRowCount;
        TempStringGrid.WriteCells(0, i, PlasmaAPA.GetName(j));
        TempStringGrid.WriteCells(1, i, PlasmaAPA.GetVolume(j));
        TempStringGrid.WriteCells(2, i, PlasmaAPA.GetNumber(j));
        j:=j+1;
      end;
     PlasmaAPA := nil;
    j:=0;
    if not Assigned(Trombo) then
      Trombo := TTrombo.create
        (StartDateCal.GetDate, EndDateCal.GetDate);
    if Trombo.GetRowCount>0 then
      for i:=TempStringGrid.GetRowCount to TempStringGrid.GetRowCount+Trombo.GetRowCount-1 do
      begin
        TempStringGrid.AddRowCount;
        TempStringGrid.WriteCells(0, i, Trombo.GetName(j));
        TempStringGrid.WriteCells(1, i, Trombo.GetVolume(j));
        TempStringGrid.WriteCells(2, i, Trombo.GetNumber(j));
        TempStringGrid.WriteCells(3, i, Trombo.GetPacet(j));
        j:=j+1;
      end;
     Trombo := nil;
    ShowMessage('Запрос выполнен!');
  end;
end;



//Button

function THarvestingOfBloodComponentsByTypes.GetButtonAction(NameForm: TForm): TBitBtn;
begin
  if not Assigned(ButtonAction) then
    ButtonAction := TBitBtnTag5.create;
  Result:=ButtonAction.GetBitBtn(385, 510, 'Сформировать', ButtonAct, NameForm);
end;

//DataTimePicker

function THarvestingOfBloodComponentsByTypes.GetCalendarStartDate(NameForm: TForm)
  : TDateTimePicker;
var
  CYear, CMonth: Word;
begin
  if MonthOf(Now)=1 then CMonth:=12 else CMonth:=MonthOf(Now) - 1;
  if CMonth=12 then CYear:=YearOf(Now)-1 else CYear:=YearOf(Now);
  if not Assigned(StartDateCal) then
    StartDateCal:=TDTPickerTag5.Create;
  result:=StartDateCal.GetDTPicker(250, 80, EncodeDate(CYear, CMonth, 1), NameForm);
end;

function THarvestingOfBloodComponentsByTypes.GetCalendarEndDate(NameForm: TForm)
  : TDateTimePicker;
begin
  if not Assigned(EndDateCal) then
    EndDateCal:=TDTPickerTag5.Create;
  result:=EndDateCal.GetDTPicker(250, 120, EncodeDate(YearOf(Now), MonthOf(Now), 1) - 1, NameForm);
end;

//Edit

function THarvestingOfBloodComponentsByTypes.GetLabelStartDate(NameForm: TForm): TLabel;
begin
  if not Assigned(StartDate) then
    StartDate := TTempLabelTag5.create;
  Result:=StartDate.GetTempLabel(50, 80, 20, 'Начальная дата:', NameForm);
end;

function THarvestingOfBloodComponentsByTypes.GetLabelEndDate(NameForm: TForm): TLabel;
begin
  if not Assigned(EndDate) then
    EndDate := TTempLabelTag5.create;
  Result:=EndDate.GetTempLabel(50, 120, 20, 'Конечная дата:', NameForm);
end;

function THarvestingOfBloodComponentsByTypes.GetLabelTitle(NameForm: TForm): TLabel;
begin
  if not Assigned(Title) then
    Title := TTitleLabelTag5.create;
  Result:=Title.GetTitleLabel(25, 'Заготовка компонентов крови (по видам)', NameForm);
end;

//StringGrid

function THarvestingOfBloodComponentsByTypes.GetStringGrid(
  NameForm: TForm): TStringGrid;
begin
  if not Assigned(TempStringGrid) then
    TempStringGrid := TStringGridTag5.create;
  Result:=TempStringGrid.GetStringGrid(50, 180, 580, 200, 4, 2, 13, NameForm);
  TempStringGrid.ColWidth(0,300);
  TempStringGrid.ColWidth(1,90);
  TempStringGrid.ColWidth(2,80);
  TempStringGrid.ColWidth(3,90);
  TempStringGrid.ResultFormat(DT_CENTER, 0, DT_LEFT, 1, DT_RIGHT, 2, DT_RIGHT, 3, DT_RIGHT, 5, DT_RIGHT);
end;

end.
