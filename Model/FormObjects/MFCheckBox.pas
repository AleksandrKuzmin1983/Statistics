unit MFCheckBox;

interface

uses
  Graphics, SysUtils, StdCtrls, Forms, Classes, CodeSiteLogging, Controls;

type
  IMFCheckBox = interface
    function GetCheckBox(Cleft, �top, CWidth, CHeight, FontSize: integer;
      CChecked: boolean; CCaption: string; CurrentForm: TForm): TCheckBox;
    function GetChecked: boolean;
    function CheckedString: String;
    procedure WriteChecked(i: boolean);
    procedure OnClick(ProcedureOnClick: TNotifyEvent);
    procedure Enabled(i: boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TMFCheckBox = class(TInterfacedObject, IMFCheckBox)
  private
    TempCheckBox: TCheckBox;
  public
    function GetCheckBox(Cleft, �top, CWidth, CHeight, FontSize: integer;
      CChecked: boolean; CCaption: string; CurrentForm: TForm): TCheckBox;
    function GetChecked: boolean;
    function CheckedString: String;
    procedure WriteChecked(i: boolean);
    procedure OnClick(ProcedureOnClick: TNotifyEvent);
    procedure Enabled(i: boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

function TMFCheckBox.GetChecked: boolean;
begin
  Result := TempCheckBox.Checked;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFCheckBox.GetChecked ���������', Result);
end;

function TMFCheckBox.CheckedString: String;
begin
  if TempCheckBox.Checked then
    Result := 'true'
  else
    Result := 'false';

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFCheckBox.CheckedString ���������', Result);
end;

procedure TMFCheckBox.destroy;
begin
  if Assigned(TempCheckBox) then
    FreeAndNil(TempCheckBox);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFCheckBox.destroy ���������');
end;

procedure TMFCheckBox.Enabled(i: boolean);
begin
  TempCheckBox.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFCheckBox.Enabled ���������', i);
end;

function TMFCheckBox.GetCheckBox(Cleft, �top, CWidth, CHeight,
  FontSize: integer; CChecked: boolean; CCaption: string; CurrentForm: TForm)
  : TCheckBox;
begin
  if not Assigned(TempCheckBox) then
    TempCheckBox := TCheckBox.create(CurrentForm);
  TempCheckBox.parent := CurrentForm;
  with TempCheckBox do
  begin
    left := Cleft;
    top := �top;
    Width := CWidth;
    Height := CHeight;
    Font.Size := FontSize;
    Font.name := 'Times New Roman';
    Checked := CChecked;
    Caption := CCaption;
    WordWrap := True;
    Tag := 5;
    Visible := False;
  end;
  Result := TempCheckBox;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFCheckBox.GetCheckBox ���������');
end;

procedure TMFCheckBox.OnClick(ProcedureOnClick: TNotifyEvent);
begin
  TempCheckBox.OnClick := ProcedureOnClick;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFCheckBox.OnClick ���������');
end;

procedure TMFCheckBox.Visible(i: boolean);
begin
  TempCheckBox.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFCheckBox.Visible ���������', i);
end;

procedure TMFCheckBox.WriteChecked(i: boolean);
begin
  TempCheckBox.Checked := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFCheckBox.WriteChecked ���������', i);
end;

end.
