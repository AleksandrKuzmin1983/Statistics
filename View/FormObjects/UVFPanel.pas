unit UVFPanel;

interface

uses
  Graphics, Controls, SysUtils,
  Forms, Vcl.ExtCtrls ;

type
  ITempPanelTag5 = interface
    function GetTempPanel(CLeft, CTop, CHeight, CWidth, CColor: integer;
  CurrentForm: TForm): TPanel;
    procedure Visible(i: boolean);
    procedure destroy;
  end;


  TTempPanelTag5 = class(TInterfacedObject, ITempPanelTag5)
  private
    TempPanel: TPanel;
  public
    function GetTempPanel(CLeft, CTop, CHeight, CWidth, CColor: integer;
      CurrentForm: TForm): TPanel;
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempPanelTag5 }

procedure TTempPanelTag5.destroy;
begin
  if Assigned(TempPanel) then
    FreeAndNil(TempPanel);
end;

function TTempPanelTag5.GetTempPanel(CLeft, CTop, CHeight, CWidth, CColor: integer;
  CurrentForm: TForm): TPanel;
begin
  if not Assigned(TempPanel) then
    TempPanel := TPanel.create(CurrentForm);
  TempPanel.parent := CurrentForm;
  with TempPanel do
  begin
    left := CLeft;
    top := CTop;
    height:=CHeight;
    width:=CWidth;
    color:=clBlack;
    Tag := 5;
    BevelOuter:=bvNone;
    Visible:=False;
  end;
  result:=TempPanel;
end;

procedure TTempPanelTag5.Visible(i: boolean);
begin
  TempPanel.Visible:=i;
end;

end.
