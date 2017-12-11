unit MainFormUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls, DateUtils,
  ActnMenus, Menus, Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, Generics.Collections, Contnrs, Bde.DBTables,
  Vcl.ComCtrls, Vcl.ExtCtrls,
  GetAdoQuery,
  VQNNumberOfDonations,
  VQBBloodProduct,
  VQPProcurementOfTheComponentsTotal,
  VQHHarvestingOfBloodComponentsByTypes,
  VIOATheAmountOfUsableErSusp,
  VIOATheAmountOfUsableErSuspVer2,
  UMSMoldCleaning  ;

type
  TMyMainForm = class(TForm)
    MainMenu1: TMainMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    Help1: TMenuItem;
    CloseButton: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    HandlyHarvesting: TMenuItem;
    AutoAferez: TMenuItem;
    Citoferez: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    AmountUsableErSusp: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N7: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N1: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    QueryNumberOfDonations: TMenuItem;
    HarvestingBloodComponentsByTypes: TMenuItem;
    BloodProduction: TMenuItem;
    procedure CloseButtonClick(Sender: TObject);
    procedure QueryNumberOfDonationsClick(Sender: TObject);
    procedure BloodProductionClick(Sender: TObject);
    procedure ProcurementOfComponentsTotalClick(Sender: TObject);
    procedure HarvestingBloodComponentsByTypesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AmountUsableErSuspClick(Sender: TObject);
    procedure Help1Click(Sender: TObject);
   private
    TempAdoQuery: TTempAdoQuery;
    NumberOfDonations: IVQNNumberOfDonations;
    BloodProduct: IBloodProduct;
    ProcurementOfTheComponentsTotal: IProcurementOfTheComponentsTotal;
    HarvestingOfBloodComponentsByTypes: IHarvestingOfBloodComponentsByTypes;
    TheAmountOfUsableErSusp: TTheAmountOfUsableErSusp;
    TheAmountOfUsableErSuspVer2: TTheAmountOfUsableErSuspVer2;
    CleanForm1: TMSMoldCleaning;
  public

    { Public declarations }

  end;

var
  MyMainForm: TMyMainForm;

implementation

{$R *.dfm}
// �������/���������� �������

procedure TMyMainForm.AmountUsableErSuspClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(TheAmountOfUsableErSusp) then
    BloodProduct:=nil;
  TheAmountOfUsableErSusp := TTheAmountOfUsableErSusp.Create(self);
end;

procedure TMyMainForm.BloodProductionClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(BloodProduct) then
    BloodProduct:=nil;
  BloodProduct := TBloodProduct.Create(self);
end;

procedure TMyMainForm.HarvestingBloodComponentsByTypesClick(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(HarvestingOfBloodComponentsByTypes) then
    HarvestingOfBloodComponentsByTypes:=nil;
  HarvestingOfBloodComponentsByTypes := THarvestingOfBloodComponentsByTypes.Create(self);

end;

procedure TMyMainForm.Help1Click(Sender: TObject);
begin
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(TheAmountOfUsableErSuspVer2) then
    BloodProduct:=nil;
  TheAmountOfUsableErSuspVer2 := TTheAmountOfUsableErSuspVer2.Create(self);
end;

procedure TMyMainForm.QueryNumberOfDonationsClick(Sender: TObject);
begin

  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(NumberOfDonations) then
    NumberOfDonations:=nil;
  NumberOfDonations := TNumberOfDonations.Create(self);

end;

procedure TMyMainForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMyMainForm.FormCreate(Sender: TObject);
var
  SysMenu:HMENU;
begin
  SysMenu := GetSystemMenu(Handle, false);
  Windows.EnableMenuItem(SysMenu, SC_CLOSE, MF_DISABLED or MF_GRAYED);
  GetSystemMenu(Handle, false);
  Perform(WM_NCPAINT, Handle, 0);
end;

procedure TMyMainForm.ProcurementOfComponentsTotalClick(Sender: TObject);
begin
  if Assigned(TheAmountOfUsableErSusp) then
    TheAmountOfUsableErSusp.destroy;
  if not Assigned(CleanForm1) then
    CleanForm1.Free;
  CleanForm1 := TMSMoldCleaning.Create(self);
  CleanForm1.Free;

  if not Assigned(ProcurementOfTheComponentsTotal) then
    ProcurementOfTheComponentsTotal := nil;
  ProcurementOfTheComponentsTotal := TProcurementOfTheComponentsTotal.Create(self);

end;

end.
