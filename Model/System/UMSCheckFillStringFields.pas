unit UMSCheckFillStringFields;

interface

type
  ICheckFillStringFields = interface
    function CheckStringFields(CheckValue: String): String;
  end;

  TCheckFillStringFields = class(TInterfacedObject, ICheckFillStringFields)
  private
    IncomingValue: String;
  public
    function CheckStringFields(CheckValue: String): String;
  end;

implementation

{ TCheckNull }

function TCheckFillStringFields.CheckStringFields(CheckValue: String): String;
begin
  IncomingValue := '0';
  if CheckValue <> '' then
    IncomingValue := CheckValue;
  result := IncomingValue;
end;

end.
