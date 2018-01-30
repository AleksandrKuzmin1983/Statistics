unit UVFMainMenu;

interface

uses
  Graphics, Controls, SysUtils,
  Forms, Vcl.ExtCtrls, Vcl.Menus, Classes, frxClass, frxDBSet, frxPreview;
type
  IUVFMainMenu = interface
    function GetTempMainMenu(CurrentForm: TForm): TMainMenu;
    procedure OnClickCloseForm(ProcedureOnClick: TNotifyEvent);
    procedure OnClickPrintReport(ProcedureOnClick: TNotifyEvent);
    procedure OnClickExportPDF(ProcedureOnClick: TNotifyEvent);
    procedure destroy;
  end;


  TUVFMainMenu = class(TInterfacedObject, IUVFMainMenu)
  private
    CurrentReport: TfrxReport;
    TempMainMenu: TMainMenu;
    CloseForm, PrintReport, ExportPDF: TMenuItem;
  public
    function GetTempMainMenu(CurrentForm: TForm): TMainMenu;
    procedure OnClickCloseForm(ProcedureOnClick: TNotifyEvent);
    procedure OnClickPrintReport(ProcedureOnClick: TNotifyEvent);
    procedure OnClickExportPDF(ProcedureOnClick: TNotifyEvent);
    procedure destroy;
  end;

implementation

{ TTempPanelTag5 }

procedure TUVFMainMenu.destroy;
begin
  if Assigned(CloseForm) then
    FreeAndNil(CloseForm);
  if Assigned(PrintReport) then
    FreeAndNil(PrintReport);
  if Assigned(ExportPDF) then
    FreeAndNil(ExportPDF);
  if Assigned(TempMainMenu) then
    FreeAndNil(TempMainMenu);
end;

function TUVFMainMenu.GetTempMainMenu(CurrentForm: TForm): TMainMenu;
begin
  if not Assigned(TempMainMenu) then
    TempMainMenu := TMainMenu.create(CurrentForm);
  if not Assigned(ExportPDF) then
    ExportPDF := TMenuItem.create(TempMainMenu);
  ExportPDF.Caption:='Экспорт в PDF';
  if not Assigned(PrintReport) then
    PrintReport := TMenuItem.create(TempMainMenu);
  PrintReport.Caption:='Печать';
  if not Assigned(CloseForm) then
    CloseForm := TMenuItem.create(TempMainMenu);
  CloseForm.Caption:='Закрыть';
  TempMainMenu.Items.Add(ExportPDF);
  TempMainMenu.Items.Add(PrintReport);
  TempMainMenu.Items.Add(CloseForm);
  result:=TempMainMenu;
end;

procedure TUVFMainMenu.OnClickCloseForm(ProcedureOnClick: TNotifyEvent);
begin
  CloseForm.OnClick:=ProcedureOnClick;
end;

procedure TUVFMainMenu.OnClickExportPDF(ProcedureOnClick: TNotifyEvent);
begin
  ExportPDF.OnClick:=ProcedureOnClick;
end;

procedure TUVFMainMenu.OnClickPrintReport(ProcedureOnClick: TNotifyEvent);
begin
  PrintReport.OnClick:=ProcedureOnClick;
end;

end.
