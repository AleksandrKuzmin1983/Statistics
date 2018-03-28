unit BQNTheNumberOfPlasmaDonations;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Data.DB, Dialogs,
  USCheckNull,
  GetAdoConnect;

type
  IBQNTheNumberOfPlasmaDonations = interface
    function GetValue: string;
    procedure Free;
  end;

  TBQNTheNumberOfPlasmaDonations = class(TInterfacedObject,
    IBQNTheNumberOfPlasmaDonations)
  private
    NumberOfPD: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    function GetValue: string;
    // procedure Free;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfPlasmaDonations }

constructor TBQNTheNumberOfPlasmaDonations.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    TempQuery.SQL.Add
      ('SELECT SUM(Plasma. ƒœ) FROM Plasma WHERE (Plasma.ƒ‡Ú‡œ) Between #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  TempQuery.Open;
  NumberOfPD := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;
end;

{ procedure TTheNumberOfPlasmaDonations.Free;
  begin
  self.Free;
  end; }

function TBQNTheNumberOfPlasmaDonations.GetValue: string;
begin
  result := NumberOfPD;
end;

end.
