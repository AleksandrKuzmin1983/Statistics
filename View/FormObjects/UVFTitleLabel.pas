unit UVFTitleLabel;

interface

uses
Graphics, StdCtrls, Forms, Classes, Controls;

type
  ITitleLabelTag5 = interface
    function GetTitleLabel(FontSize: integer;
      CCaption: String; CurrentForm: TForm): TLabel;
  end;


  TTitleLabelTag5 = class(TInterfacedObject, ITitleLabelTag5)
  private
    TempLabel: TLabel;
  public
    function GetTitleLabel(FontSize: integer;
      CCaption: String; CurrentForm: TForm): TLabel;
  end;

implementation

{ TTempLabelTag5 }

function TTitleLabelTag5.GetTitleLabel(FontSize: integer;
  CCaption: String; CurrentForm: TForm): TLabel;
begin
  if not Assigned(TempLabel) then
    TempLabel := TLabel.create(CurrentForm);
  TempLabel.parent := CurrentForm;
  with TempLabel do
  begin
    Align := alTop;
    Alignment := taCenter;
    Layout := tlCenter;
    AutoSize := False;
    Height := 60;
    Font.name := 'Times New Roman';
    Font.Size := FontSize;
    Font.Style := [fsBold];
    Caption := CCaption;
    Tag := 5;
  end;
  result := TempLabel;
end;

end.
