unit USCheckFillStringFields;

interface

type
  IUSCheckFillStringFields = interface
    function CheckStringFields(CheckValue: String): String;
  end;

  TUSCheckFillStringFields = class(TInterfacedObject, IUSCheckFillStringFields)
  private
    IncomingValue: String;
  public
    function CheckStringFields(CheckValue: String): String;
  end;

implementation

{ TCheckNull }

function TUSCheckFillStringFields.CheckStringFields(CheckValue: String): String;
begin
  IncomingValue := '0';
  if CheckValue <> '' then
    IncomingValue := CheckValue;
  result := IncomingValue;
end;

end.
