unit USCheckNull;

interface

uses
  Variants;

type
  IUSCheckNull = interface
    function CheckedValue(CheckValue: variant): variant;
  end;

  TUSCheckNull = class(TInterfacedObject, IUSCheckNull)
  private
    IncomingValue: variant;
  public
    function CheckedValue(CheckValue: variant): variant;
  end;

implementation

{ TCheckNull }

function TUSCheckNull.CheckedValue(CheckValue: variant): variant;
begin
  IncomingValue := 0;
  if CheckValue <> null then
    IncomingValue := CheckValue;
  result := IncomingValue;
end;

end.
