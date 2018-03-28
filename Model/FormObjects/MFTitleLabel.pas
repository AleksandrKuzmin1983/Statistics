unit MFTitleLabel;

interface

uses
  SysUtils, Graphics, StdCtrls, Forms, Classes, Controls;

type
  IMFTitleLabel = class
    function GetTitleLabel(FontSize: integer; CCaption: String;
      CurrentForm: TForm): TLabel; virtual; abstract;
    procedure destroy; virtual; abstract;
  end;

  TMFTitleLabel = class(IMFTitleLabel)
  private
    TempLabel: TLabel;
  public
    function GetTitleLabel(FontSize: integer; CCaption: String;
      CurrentForm: TForm): TLabel; override;
    procedure destroy; override;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFTitleLabel.destroy;
begin
  if Assigned(TempLabel) then
    FreeAndNil(TempLabel);
end;

function TMFTitleLabel.GetTitleLabel(FontSize: integer; CCaption: String;
  CurrentForm: TForm): TLabel;
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
