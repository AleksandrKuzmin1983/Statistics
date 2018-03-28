unit BQNTheNumberOfPlasmaDonations;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Data.DB, Dialogs,
  USCheckNull,
  GetAdoConnect;

type
  ITheNumberOfPlasmaDonations = interface
    function GetValue: string;
    procedure Free;
  end;

  TTheNumberOfPlasmaDonations = class(TInterfacedObject,
    ITheNumberOfPlasmaDonations)
  private
    NumberOfPD: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    function GetValue: string;
    // procedure Free;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfPlasmaDonations }

constructor TTheNumberOfPlasmaDonations.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
  TempQuery.SQL.Add
    ('SELECT SUM(Plasma.���) FROM Plasma WHERE (Plasma.�����) Between #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
    FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  TempQuery.Open;
  NumberOfPD := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

{ procedure TTheNumberOfPlasmaDonations.Free;
  begin
  self.Free;
  end; }

function TTheNumberOfPlasmaDonations.GetValue: string;
begin
  result := NumberOfPD;
end;

end.
