unit MainFormUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus,  Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, Generics.Collections, Contnrs, Bde.DBTables, Query1Unit1,
  Vcl.ComCtrls, GetDataSoursUnit1;

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
    N26: TMenuItem;
    procedure N4Click(Sender: TObject);
    procedure Query1Click(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure ActionBut(Sender: TObject);
  private
    QBlood: TADOQuery;
    QueryX: DataBaseTables;
    LabelQueryStartDate, LabelQueryEndDate, LabelQueryStat1, LabelQueryStat2, LabelQueryStat3: TLabel;
    LabelQueryStat4, LabelQueryStat5, LabelQueryStat6, LabelQueryStat7: TLabel;
    CalendarStart, CalendarEnd: TDateTimePicker;
    EditQueryStat1, EditQueryStat2, EditQueryStat3, EditQueryStat4: TEdit;
    EditQueryStat5, EditQueryStat6, EditQueryStat7: TEdit;
    BackButton, ActionButton: TBitBtn;
    FQuery1: FormQuery1;
    SQL: string;
  public

    { Public declarations }

  end;
var
  MyMainForm: TMyMainForm;



implementation

{$R *.dfm}

//�������/���������� �������

procedure TMyMainForm.ActionBut(Sender: TObject);
//var
//  ColDon: integer;
begin
  if CalendarStart.Date>=CalendarEnd.Date then
  begin
    ShowMessage('�������� ���� ������ ���� ������ ���������');
    exit;
  end;
{  if not Assigned(QueryX) then
    QueryX:=DataBaseTables.create;
  QBlood:=QueryX.GetBlood;
  QueryX.Close;
  QBlood.Open;
  QBlood.First;
  ColDon:=0;
  while not QBlood.Eof do
  begin
    if (QBlood.Fields.FieldByName('�����').Value>=(CalendarStart.Date-1)) and (QBlood.Fields.FieldByName('�����').Value<=CalendarEnd.Date) then
    begin
      ColDon:=ColDon+QBlood.Fields.FieldByName('���').Value;
    end;
    QBlood.Next;
  end;
  EditQueryStat1.Text:=IntToStr(ColDon);
  QBlood.Close;  }

  if not Assigned(QueryX) then
    QueryX:=DataBaseTables.create;
  SQL:='SELECT SUM(Blood.���) FROM Blood WHERE (Blood.�����) Between #' + FormatDateTime( 'mm''/''dd''/''yyyy', CalendarStart.Date) + '# And #' +
                                                                          FormatDateTime( 'mm''/''dd''/''yyyy', CalendarEnd.Date) + '#';
  QBlood:=QueryX.GetSQL(SQL);
  QBlood.Open;
  EditQueryStat1.Text:=VarToStr(QBlood.Fields[0].Value);
  QBlood.Close;


  SQL:='SELECT SUM(Plasma.���) FROM Plasma WHERE (Plasma.�����) Between #' + FormatDateTime( 'mm''/''dd''/''yyyy', CalendarStart.Date) + '# And #' +
                                                                          FormatDateTime( 'mm''/''dd''/''yyyy', CalendarEnd.Date) + '#';
  QBlood:=QueryX.GetSQL(SQL);
  QBlood.Open;
  EditQueryStat2.Text:=VarToStr(QBlood.Fields[0].Value);
  QBlood.Close;

  SQL:='SELECT SUM(Tromb.���) FROM Tromb WHERE (Tromb.�����) Between #' + FormatDateTime( 'mm''/''dd''/''yyyy', CalendarStart.Date) + '# And #' +
                                                                          FormatDateTime( 'mm''/''dd''/''yyyy', CalendarEnd.Date) + '#';
  QBlood:=QueryX.GetSQL(SQL);
  QBlood.Open;
  EditQueryStat3.Text:=VarToStr(QBlood.Fields[0].Value);
  QBlood.Close;
end;

procedure TMyMainForm.Query1Click(Sender: TObject);
begin
  Label1.Caption:='���������� ������� � ������������� �����';
  label1.Font.Size:=25;
  FQuery1:=FormQuery1.Create;
  LabelQueryStartDate:=FQuery1.GetLabelStartDate(self);
  LabelQueryEndDate:=FQuery1.GetLabelEndDate(self);
  LabelQueryStat1:=FQuery1.GetLabelNameStat1(self);
  LabelQueryStat2:=FQuery1.GetLabelNameStat2(self);
  LabelQueryStat3:=FQuery1.GetLabelNameStat3(self);
  EditQueryStat1:=FQuery1.GenEdit1(self);
  EditQueryStat2:=FQuery1.GenEdit2(self);
  EditQueryStat3:=FQuery1.GenEdit3(self);
  CalendarStart:=FQuery1.GetCalendarStartDate(self);
  CalendarEnd:=FQuery1.GetCalendarEndDate(self);
  BackButton:=FQuery1.GetButtonBack(self);
  BackButton.OnClick:=BackClick;
  ActionButton:=FQuery1.GetButtonAction(self);
  ActionButton.OnClick:=ActionBut;
end;

procedure TMyMainForm.BackClick(Sender: TObject);
begin
  Label1.Caption:='����������';
  label1.Font.Size:=40;
  FQuery1.Free;;
  LabelQueryStartDate.Free;
  LabelQueryEndDate.Free;
  LabelQueryStat1.Free;
  LabelQueryStat2.Free;
  LabelQueryStat3.Free;
  EditQueryStat1.Free;
  EditQueryStat2.Free;
  EditQueryStat3.Free;
  CalendarStart.Free;
  CalendarEnd.Free;
  ActionButton.Free;
  BackButton.Free;
end;

//�������/��������� �����

procedure TMyMainForm.N4Click(Sender: TObject);
begin
  Close;
end;
end.
