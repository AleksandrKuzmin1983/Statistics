unit MIOCurrentType;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;

type
  IMIOCurrentType = interface
    function GetCurrentType(CBoxValue: string): string;
  end;

  TMIOCurrentType = class(TInterfacedObject, IMIOCurrentType)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
  public
    function GetCurrentType(CBoxValue: string): string;
  end;

implementation

{ TTheNumberOfBloodDonations }

function TMIOCurrentType.GetCurrentType(CBoxValue: string): string;
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
  TempQuery.SQL.Add('SELECT TypesOfTaps.Id ' +
    'FROM TypesOfTaps  ' +
    'WHERE TypesOfTaps.Type=''' + CBoxValue + ''';');
    TempQuery.Open;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  result := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
  TempQuery.Close;
end;

end.
