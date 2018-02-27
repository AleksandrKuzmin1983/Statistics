unit UVFForm;

interface

uses
  SysUtils, Graphics, StdCtrls, Forms, Classes, Controls;

type
  TFormTag5 = class(TForm)
  private
    TempForm: TForm;
  public
//    function GetForm: TForm;
//    procedure ShowModal;
    procedure destroy;
    constructor create;
  end;

implementation

{ TTempLabelTag5 }

procedure TFormTag5.destroy;
begin
  if Assigned(TempForm) then
    FreeAndNil(TempForm);
end;

constructor TFormTag5.create;
begin
  if not Assigned(TempForm) then
    TempForm := TForm.Create(Application);
  with TempForm do
  begin
    BorderStyle:=bsSingle;
    Width := 860;
    Height:=750;
  end;
end;
{
procedure TFormTag5.ShowModal;
begin
  TempForm.ShowModal;
end;   }

end.
