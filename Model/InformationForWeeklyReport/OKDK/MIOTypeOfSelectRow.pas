unit MIOTypeOfSelectRow;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;

type
  IMIOTypeOfSelectRow = interface
    function GetCurrentTypeOfSelectRow(StringBoxValue: string): string;
  end;

  TMIOTypeOfSelectRow = class(TInterfacedObject, IMIOTypeOfSelectRow)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
  public
    function GetCurrentTypeOfSelectRow(StringBoxValue: string): string;
  end;

implementation

{ TTheNumberOfBloodDonations }

function TMIOTypeOfSelectRow.GetCurrentTypeOfSelectRow(StringBoxValue: string): string;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
  TempQuery.SQL.Add('SELECT Taps.TypeOfTap ' +
    'FROM Taps  ' +
    'WHERE Taps.NameTap=''' + StringBoxValue + ''';');
    TempQuery.Open;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  result := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
  TempQuery.Close;
end;

end.
