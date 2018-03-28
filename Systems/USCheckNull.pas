unit USCheckNull;

interface

uses
  SysUtils, Variants;

type
  ICheckNull = interface
    function CheckedValue(CheckValue: variant): variant;
  end;

  TCheckNull = class(TInterfacedObject, ICheckNull)
  private
    IncomingValue: variant;
  public
    function CheckedValue(CheckValue: variant): variant;
  end;

implementation

{ TCheckNull }

function TCheckNull.CheckedValue(CheckValue: variant): variant;
begin
  IncomingValue := 0;
  if CheckValue <> null then
    IncomingValue := CheckValue;
  result := IncomingValue;
end;
end.
