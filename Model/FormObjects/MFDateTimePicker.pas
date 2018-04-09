unit MFDateTimePicker;

interface

uses
  DateUtils, SysUtils, Vcl.ComCtrls, CodeSiteLogging, Forms;

type
  IMFDateTimePicker = interface
    function GetDTPicker(Cleft, �top: integer; CDate: Extended;
      CurrentForm: TForm): TDateTimePicker;
    function GetDate: Extended;
    procedure WriteDateTime(DateTime: TDateTime);
    procedure Width(Value: integer);
    procedure FontSize(Value: integer);
    procedure Enabled(i: boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

  TMFDateTimePicker = class(TInterfacedObject, IMFDateTimePicker)
  private
    TempDTPicker: TDateTimePicker;
  public
    function GetDTPicker(Cleft, �top: integer; CDate: Extended;
      CurrentForm: TForm): TDateTimePicker;
    function GetDate: Extended;
    procedure WriteDateTime(DateTime: TDateTime);
    procedure Width(Value: integer);
    procedure FontSize(Value: integer);
    procedure Enabled(i: boolean);
    procedure Visible(i: boolean);
    procedure destroy;
  end;

implementation

{ TTempLabelTag5 }

procedure TMFDateTimePicker.destroy;
begin
  if Assigned(TempDTPicker) then
    FreeAndNil(TempDTPicker);

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFDateTimePicker.destroy ���������');
end;

procedure TMFDateTimePicker.Enabled(i: boolean);
begin
  TempDTPicker.Enabled := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFDateTimePicker.Enabled ���������', i);
end;

procedure TMFDateTimePicker.FontSize(Value: integer);
begin
  TempDTPicker.Font.Size := Value;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFDateTimePicker.FontSize ���������', Value);
end;

function TMFDateTimePicker.GetDate: Extended;
begin
  Result := TempDTPicker.Date;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFDateTimePicker.GetDate ���������', Result);
end;

function TMFDateTimePicker.GetDTPicker(Cleft, �top: integer; CDate: Extended;
  CurrentForm: TForm): TDateTimePicker;
begin
  if not Assigned(TempDTPicker) then
  begin
    TempDTPicker := TDateTimePicker.create(CurrentForm);
    TempDTPicker.parent := CurrentForm;
    with TempDTPicker do
    begin
      left := Cleft;
      top := �top;
      Date := CDate;
      Font.Size := 12;
      Tag := 5;
      Visible := False;
    end;
  end;
  Result := TempDTPicker;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFDateTimePicker.GetDTPicker ���������');
end;

procedure TMFDateTimePicker.Visible(i: boolean);
begin
  TempDTPicker.Visible := i;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFDateTimePicker.Visible ���������', i);
end;

procedure TMFDateTimePicker.Width(Value: integer);
begin
  TempDTPicker.Width := Value;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFDateTimePicker.Width ���������', Value);
end;

procedure TMFDateTimePicker.WriteDateTime(DateTime: TDateTime);
begin
  TempDTPicker.DateTime := DateTime;

  CodeSite.Send(FormatDateTime('c', Now) + ' TMFDateTimePicker.WriteDateTime ���������', DateTime);
end;

end.
