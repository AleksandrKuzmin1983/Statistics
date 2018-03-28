unit TestMFBitBtn;

interface

uses
  TestFramework, Classes, SysUtils, Forms, Buttons, MFBitBtn;

type
  // Test methods for class IMFBitBtn

  TestIMFBitBtn = class(TTestCase)
  strict private
    TempForm: TForm;
    FIMFBitBtn: IMFBitBtn;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetBitBtn;
    procedure TestVisible;
    procedure Testdestroy;
  end;

implementation

procedure TestIMFBitBtn.SetUp;
begin
//  TempForm:=TForm.Create(Application);
//  FIMFBitBtn:=TMFBitBtn.Create(TempForm);
  // TODO: Initialize FIMFBitBtn
end;

procedure TestIMFBitBtn.TearDown;
begin
  FIMFBitBtn := nil;
end;

procedure TestIMFBitBtn.TestGetBitBtn;
var
  ReturnValue: TBitBtn;
  CurrentForm: TForm;
  ProcedureOnClick: TNotifyEvent;
  CCaption: string;
  CTop: Integer;
  CLeft: Integer;
begin
  // TODO: Setup method call parameters
  ReturnValue := FIMFBitBtn.GetBitBtn(CLeft, CTop, CCaption, ProcedureOnClick,
      CurrentForm);
  // TODO: Validate method results
end;

procedure TestIMFBitBtn.TestVisible;
var
  i: Boolean;
begin
  // TODO: Setup method call parameters
  FIMFBitBtn.Visible(i);
  // TODO: Validate method results
end;

procedure TestIMFBitBtn.Testdestroy;
begin
  FIMFBitBtn.destroy;
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestIMFBitBtn.Suite);
end.

