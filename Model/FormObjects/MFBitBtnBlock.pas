unit MFBitBtnBlock;

interface

uses
  SysUtils, Classes, Forms, CodeSiteLogging, Buttons;

type
  IMFBitBtnBlock = interface
    function GetBitBtnBlock(CLeft, CTop: integer;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeCaption(i: Boolean);
    function GetCaption: Boolean;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

  TMFBitBtnBlock = class(TInterfacedObject, IMFBitBtnBlock)
  private
    TempBitBtnBlock: TBitBtn;
  public
    function GetBitBtnBlock(CLeft, CTop: integer;
      ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
    procedure ChangeCaption(i: Boolean);
    function GetCaption: Boolean;
    procedure ChangeEnabled(i: Boolean);
    procedure Visible(i: Boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

function TMFBitBtnBlock.GetCaption: Boolean;
begin
  if TempBitBtnBlock.Caption = '��������������' then
    Result := True
  else
    Result := False;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.GetCaption ���������', Result);
end;

procedure TMFBitBtnBlock.Visible(i: Boolean);
begin
  TempBitBtnBlock.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.Visible ���������', i);
end;

procedure TMFBitBtnBlock.ChangeCaption(i: Boolean);
begin
  if i then
    TempBitBtnBlock.Caption := '�������������'
  else
    TempBitBtnBlock.Caption := '��������������';

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.ChangeCaption ���������', TempBitBtnBlock.Caption);
end;

procedure TMFBitBtnBlock.ChangeEnabled(i: Boolean);
begin
  TempBitBtnBlock.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.ChangeEnabled ���������', i);
end;

procedure TMFBitBtnBlock.destroy;
begin
  if Assigned(TempBitBtnBlock) then
    FreeAndNil(TempBitBtnBlock);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.destroy ���������');
end;

function TMFBitBtnBlock.GetBitBtnBlock(CLeft, CTop: integer;
  ProcedureOnClick: TNotifyEvent; CurrentForm: TForm): TBitBtn;
begin
  if not Assigned(TempBitBtnBlock) then
  begin
    TempBitBtnBlock := TBitBtn.create(CurrentForm);
    TempBitBtnBlock.parent := CurrentForm;
    with TempBitBtnBlock do
    begin
      if CLeft = 0 then
        left := 650
      else
        left := CLeft;
      if CTop = 0 then
        Top := 230
      else
        Top := CTop;
      Font.name := 'Times New Roman';
      Font.Size := 14;
      Caption := '��������������';
      Width := 200;
      Height := 30;
      Tag := 5;
      OnClick := ProcedureOnClick;
      Visible := False;
    end;
  end;
  Result := TempBitBtnBlock;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFBitBtnAdd.GetBitBtnBlock ���������');
end;

end.
