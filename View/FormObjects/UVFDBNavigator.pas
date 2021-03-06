unit UVFDBNavigator;

interface

uses
  Vcl.DBCtrls, Graphics, StdCtrls, Forms, Classes, Controls;

type
  INavigatorDB = interface
    function GetGridDB(Cleft, �top, FontSize: integer; CurrentForm: TForm): TDBNavigator;
  end;

  TNavigatorDB = class(TInterfacedObject, INavigatorDB)
  private
    Navigator: TDBNavigator;
  public
    function GetGridDB(Cleft, �top, FontSize: integer; CurrentForm: TForm): TDBNavigator;
  end;

implementation

{ TTempLabelTag5 }

function TNavigatorDB.GetGridDB(Cleft, �top, FontSize: integer; CurrentForm: TForm): TDBNavigator;
begin
  if not Assigned(Navigator) then
    Navigator := TDBNavigator.create(CurrentForm);
  Navigator.parent := CurrentForm;
  with Navigator do
  begin
    left := Cleft;
    top := �top;
//    Width := CWidth;
//    Height:= CHeight;
//    Font.Size := FontSize;
//    Font.name := 'Times New Roman';
//    Font.Style:=[fsbold];
//    Options:=[goFixedVertLine]+[goFixedHorzLine]+[goVertLine]+[goHorzLine];
//    ReadOnly:=true;
//    TitleFont.Size := FontSize;
//    TitleFont.name := 'Times New Roman';
//    TitleFont.Style:=[fsbold];
    Tag := 5;
  end;
  result := Navigator;
end;

end.
