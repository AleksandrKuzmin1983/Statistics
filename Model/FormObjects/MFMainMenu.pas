unit MFMainMenu;

interface

uses
  Graphics, Controls, SysUtils,
  Forms, Vcl.ExtCtrls, Vcl.Menus, Classes, frxClass, frxDBSet, frxPreview;

type
  IMFMainMenu = interface
    function GetTempMainMenu(CurrentForm: TForm): TMainMenu;
    procedure OnClickCloseForm(ProcedureOnClick: TNotifyEvent);
    procedure OnClickPrintReport(ProcedureOnClick: TNotifyEvent);
    procedure OnClickExportPDF(ProcedureOnClick: TNotifyEvent);
    procedure destroy;
  end;

  TMFMainMenu = class(TInterfacedObject, IMFMainMenu)
  private
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

procedure TMFMainMenu.destroy;
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

function TMFMainMenu.GetTempMainMenu(CurrentForm: TForm): TMainMenu;
begin
  if not Assigned(TempMainMenu) then
    TempMainMenu := TMainMenu.create(CurrentForm);
  if not Assigned(ExportPDF) then
    ExportPDF := TMenuItem.create(TempMainMenu);
  ExportPDF.Caption := 'Экспорт в PDF';
  if not Assigned(PrintReport) then
    PrintReport := TMenuItem.create(TempMainMenu);
  PrintReport.Caption := 'Печать';
  if not Assigned(CloseForm) then
    CloseForm := TMenuItem.create(TempMainMenu);
  CloseForm.Caption := 'Закрыть';
  TempMainMenu.Items.Add(ExportPDF);
  TempMainMenu.Items.Add(PrintReport);
  TempMainMenu.Items.Add(CloseForm);
  result := TempMainMenu;
end;

procedure TMFMainMenu.OnClickCloseForm(ProcedureOnClick: TNotifyEvent);
begin
  CloseForm.OnClick := ProcedureOnClick;
end;

procedure TMFMainMenu.OnClickExportPDF(ProcedureOnClick: TNotifyEvent);
begin
  ExportPDF.OnClick := ProcedureOnClick;
end;

procedure TMFMainMenu.OnClickPrintReport(ProcedureOnClick: TNotifyEvent);
begin
  PrintReport.OnClick := ProcedureOnClick;
end;

end.
