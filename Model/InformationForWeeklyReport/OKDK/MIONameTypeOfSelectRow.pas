unit MIONameTypeOfSelectRow;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;

type
  IMIONameTypeOfSelectRow = interface
    function GetCurrentNameTypeOfSelectRow(StringBoxValue: string): string;
  end;

  TMIONameTypeOfSelectRow = class(TInterfacedObject, IMIONameTypeOfSelectRow)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
  public
    function GetCurrentNameTypeOfSelectRow(StringBoxValue: string): string;
  end;

implementation

{ TTheNumberOfBloodDonations }

function TMIONameTypeOfSelectRow.GetCurrentNameTypeOfSelectRow(StringBoxValue: string): string;
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
  TempQuery.SQL.Add('SELECT TypesOfTaps.Type ' +
    'FROM TypesOfTaps  ' +
    'WHERE TypesOfTaps.Id=' + StringBoxValue + ';');
    TempQuery.Open;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  result := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
  TempQuery.Close;
end;
end.
