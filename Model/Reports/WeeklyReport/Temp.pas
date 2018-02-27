unit Temp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, DateUtils,
  Vcl.StdCtrls, frxPreview, MRWTableForDefect;

type
  TForm3 = class(TForm)
    frxReport1: TfrxReport;
    frxPreview1: TfrxPreview;
    frxUserDataSet1: TfrxUserDataSet;
    procedure frxReport1GetValue(const VarName: String; var Value: Variant);
    procedure GetResultMass;
    procedure FormCreate(Sender: TObject);
  private
    TableForDefect: TMRWTableForDefect;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

{ TForm3 }
var
  n: integer;
  ar: array[0..4] of string = ('qy', 'qt', 'qr', 'qe', 'wq');
//  ar: array[0..100, 0..1] of string;

procedure TForm3.GetResultMass;
var
  i: integer;
begin
  if not Assigned(TableForDefect) then
    TableForDefect:=TMRWTableForDefect.Create;
  TableForDefect.GetContent;
  n:=5;//TableForDefect.GetRowCount-1;
  for i:=0 to n do
  begin
//    ar[i]:='qweq' + IntToStr(i);//TableForDefect.GetTypeOfDefect(i)+TableForDefect.GetTypeOfProduct(i);
//    ar[i,1]:=TableForDefect.GetVolume(i);
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
//  frxReport1.OnGetValue:=frxReport1GetValue;
end;

procedure TForm3.frxReport1GetValue(const VarName: String; var Value: Variant);
begin
//  ShowMessage('frxReport1GetValue; ' + 'ar[' + IntToStr(frxUserDataSet1.RecNo) + ']=' + ar[frxUserDataSet1.RecNo]);
  if CompareText(VarName, 'qq') = 0 then
    Value := ar[frxUserDataSet1.RecNo];
//  if CompareText(VarName, 'Volume') = 0 then
//    Value := ar[frxDefect.RecNo, 1];
end;



end.
