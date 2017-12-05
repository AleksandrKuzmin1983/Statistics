unit UVFPanel;

interface

uses
  Graphics, Controls,
  Forms, Vcl.ExtCtrls ;

type
  ITempPanelTag5 = interface
    function GetTempPanel(CLeft, CTop, CHeight, CWidth, CColor: integer;
  CurrentForm: TForm): TPanel;
  end;


  TTempPanelTag5 = class(TInterfacedObject, ITempPanelTag5)
  private
    TempPanel: TPanel;
  public
    function GetTempPanel(CLeft, CTop, CHeight, CWidth, CColor: integer;
  CurrentForm: TForm): TPanel;
  end;

implementation

{ TTempPanelTag5 }

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
  end;
  result:=TempPanel;
end;

end.