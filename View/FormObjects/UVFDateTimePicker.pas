unit UVFDateTimePicker;

interface

uses
  DateUtils, SysUtils, Vcl.ComCtrls, Forms;

type
  IDTPickerTag5 = interface
    function GetDTPicker(Cleft, Ñtop: integer; CDate: Extended; CurrentForm: TForm): TDateTimePicker;
    function GetDate: Extended;
    procedure WriteDateTime(DateTime: TDateTime);
    procedure Width(Value: integer);
    procedure FontSize(Value: integer);
  end;

  TDTPickerTag5 = class(TInterfacedObject, IDTPickerTag5)
  private
    TempDTPicker: TDateTimePicker;
  public
    function GetDTPicker(Cleft, Ñtop: integer; CDate: Extended; CurrentForm: TForm): TDateTimePicker;
    function GetDate: Extended;
    procedure WriteDateTime(DateTime: TDateTime);
    procedure Width(Value: integer);
    procedure FontSize(Value: integer);
  end;

implementation

{ TTempLabelTag5 }

procedure TDTPickerTag5.FontSize(Value: integer);
begin
  TempDTPicker.Font.Size:=Value;
end;

function TDTPickerTag5.GetDate: Extended;
begin
  Result:=TempDTPicker.Date;
end;

function TDTPickerTag5.GetDTPicker(Cleft, Ñtop: integer; CDate: Extended; CurrentForm: TForm): TDateTimePicker;
begin
  if not Assigned(TempDTPicker) then
  begin
    TempDTPicker := TDateTimePicker.create(CurrentForm);
    TempDTPicker.parent := CurrentForm;
    with TempDTPicker do
    begin
      left := Cleft;
      top := Ñtop;
      Date := CDate;
      Font.Size := 12;
      Tag := 5;
    end;
  end;
  result := TempDTPicker;
end;

procedure TDTPickerTag5.Width(Value: integer);
begin
  TempDTPicker.Width:=Value;
end;

procedure TDTPickerTag5.WriteDateTime(DateTime: TDateTime);
begin
  TempDTPicker.DateTime:=DateTime;
end;

end.
