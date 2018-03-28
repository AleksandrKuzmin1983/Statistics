unit USValueChecksOnTheAdequacy;

interface

uses
  Data.DB, Dialogs, Data.Win.ADODB, SysUtils,
  USCheckNull,
  USCheckFillStringFields,
  GetAdoConnect;

type
  IUSValueChecksOnTheAdequacy = interface
    function CheckZeroValues(Value: String; TheMessage: String): boolean;
    function CheckingEqualities(Value1, Value2: integer;
      TheMessage: String): boolean;
  end;

  TUSValueChecksOnTheAdequacy = class(TInterfacedObject,
    IUSValueChecksOnTheAdequacy)
  private
    CheckFillStrFields: IUSCheckFillStringFields;
  public
    function CheckZeroValues(Value: String; TheMessage: String): boolean;
    function CheckingEqualities(Value1, Value2: integer;
      TheMessage: String): boolean;
  end;

implementation

{ TMHMCheckForExistenceOfRecord }

function TUSValueChecksOnTheAdequacy.CheckingEqualities(Value1, Value2: integer;
  TheMessage: String): boolean;
begin
  if Value1 <> Value2 then
  begin
    ShowMessage(TheMessage);
    result := true;
  end
  else
    result := false;
end;

function TUSValueChecksOnTheAdequacy.CheckZeroValues(Value: String;
  TheMessage: String): boolean;
begin
  if not Assigned(CheckFillStrFields) then
    CheckFillStrFields := TUSCheckFillStringFields.create;
  Value := CheckFillStrFields.CheckStringFields(Value);
  try
    if StrToInt(Value) = 0 then
    begin
      ShowMessage(TheMessage);
      result := true;
    end
    else
      result := false;
  Except
    on EConvertError do
      ShowMessage('������ �������� (' + Value + ') �� �������� ����� ������!');
  end;
end;

end.
