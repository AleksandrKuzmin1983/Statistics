unit USGlobalVariant;

interface

uses
  Forms;

Type
  TUSGlobalVariant = class
  public
    constructor create(form: TForm); virtual; abstract;
    destructor destroy; virtual; abstract;
  end;

implementation

end.
