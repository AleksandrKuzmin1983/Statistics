unit USValueChecksOnTheAdequacy;

interface

uses
  Data.DB, Dialogs, CodeSiteLogging, Data.Win.ADODB, SysUtils,
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TUSValueChecksOnTheAdequacy.CheckingEqualities выполнена', result);
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
      ShowMessage('Данное значение (' + Value + ') не является целым числом!');
  end;

  CodeSite.Send(FormatDateTime('c', Now) + ' TUSValueChecksOnTheAdequacy.CheckZeroValues выполнена', result);
end;
end.
