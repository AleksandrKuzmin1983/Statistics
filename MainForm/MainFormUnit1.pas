unit MainFormUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus,  Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, ConnectivgUnit1_ver2, Generics.Collections, Contnrs, Bde.DBTables, Query1Unit1,
  Vcl.ComCtrls;

type
  TMyMainForm = class(TForm)
    Label1: TLabel;
    MainMenu1: TMainMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    Help1: TMenuItem;
    N4: TMenuItem;
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
    N15: TMenuItem;
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
    Query1: TMenuItem;
    Query2: TMenuItem;
    Query3: TMenuItem;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    procedure N4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Query1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private

  public
    { Public declarations }

  end;
var
  MyMainForm: TMyMainForm;
  QBlood, QPlasma, QTrombo: TADOQuery;
  QueryX: DataBaseTables;
  FQuery1: FormQuery1;
  LabelQuery1_1, LabelQuery1_2: TLabel;
  CalendarStart, CalendarEnd: TDateTimePicker;
  BackButton: TBitBtn;


implementation

{$R *.dfm}

procedure TMyMainForm.BitBtn1Click(Sender: TObject);
begin
    ShowMessage('Я нажата!');
end;

procedure TMyMainForm.Button1Click(Sender: TObject);
begin
  QBlood:=QueryX.GetBlood;
  QPlasma:=QueryX.GetPlasma;
  QTrombo:=QueryX.GetTrombo;

end;

procedure TMyMainForm.FormCreate(Sender: TObject);
begin
  QueryX:=DataBaseTables.create;
end;

procedure TMyMainForm.N4Click(Sender: TObject);
begin
  Close;
end;

procedure TMyMainForm.Query1Click(Sender: TObject);
begin
  Label1.Caption:='Количество донаций и заготовленной крови';
  label1.Font.Size:=25;
  FQuery1:=FormQuery1.Create;
  LabelQuery1_1:=FQuery1.GetLabelStartDate(self);
  LabelQuery1_2:=FQuery1.GetLabelEndDate(self);
  CalendarStart:=FQuery1.GetCalendarStartDate(self);
  CalendarEnd:=FQuery1.GetCalendarEndDate(self);
  BackButton:=FQuery1.GetButtonBack(self);
  BackButton.OnClick:=FQuery1.ButtonBackClick; //не работает

end;

end.
