unit UVFDateTimePicker;

interface

uses
  DateUtils, SysUtils, Vcl.ComCtrls, Forms;

type
  IDTPickerTag5 = interface
    function GetDTPicker(Cleft, Ñtop: integer; CDate: Extended; CurrentForm: TForm): TDateTimePicker;
    function GetData: Extended;
  end;

  TDTPickerTag5 = class(TInterfacedObject, IDTPickerTag5)
  private
    TempDTPicker: TDateTimePicker;
  public
    function GetDTPicker(Cleft, Ñtop: integer; CDate: Extended; CurrentForm: TForm): TDateTimePicker;
    function GetData: Extended;
  end;

implementation

{ TTempLabelTag5 }

function TDTPickerTag5.GetData: Extended;
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

end.
