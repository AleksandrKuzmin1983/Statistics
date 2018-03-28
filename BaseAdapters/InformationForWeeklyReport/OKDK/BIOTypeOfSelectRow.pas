unit BIOTypeOfSelectRow;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBIOTypeOfSelectRow = interface
    function GetCurrentTypeOfSelectRow(StringBoxValue: string): string;
    procedure destroy;
  end;

  TBIOTypeOfSelectRow = class(TInterfacedObject, IBIOTypeOfSelectRow)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
  public
    function GetCurrentTypeOfSelectRow(StringBoxValue: string): string;
    procedure destroy;
  end;

implementation

{ TTheNumberOfBloodDonations }

procedure TBIOTypeOfSelectRow.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;
  CheckNull := nil;
end;

function TBIOTypeOfSelectRow.GetCurrentTypeOfSelectRow(StringBoxValue
  : string): string;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    TempQuery.SQL.Add('SELECT Taps.TypeOfTap ' + 'FROM Taps  ' +
      'WHERE Taps.NameTap=''' + StringBoxValue + ''';');
    TempQuery.Open;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  result := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
  TempQuery.Close;
end;

end.
