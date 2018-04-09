unit BQNTheNumberOfPlasmaDonations;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, CodeSiteLogging, Data.DB, Dialogs,
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
      ('SELECT SUM(Plasma.КДП) FROM Plasma WHERE (Plasma.ДатаП) Between #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateEnd) + '#');
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  TempQuery.Open;
  NumberOfPD := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].Value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQNTheNumberOfPlasmaDonations.create выполнена');
end;

{ procedure TTheNumberOfPlasmaDonations.Free;
  begin
  self.Free;
  end; }

function TBQNTheNumberOfPlasmaDonations.GetValue: string;
begin
  result := NumberOfPD;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQNTheNumberOfPlasmaDonations.GetValue выполнена');
end;

end.
