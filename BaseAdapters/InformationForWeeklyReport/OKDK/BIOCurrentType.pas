unit BIOCurrentType;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBIOCurrentType = interface
    function GetCurrentType(CBoxValue: string): string;
    procedure destroy;
  end;

  TBIOCurrentType = class(TInterfacedObject, IBIOCurrentType)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
  public
    function GetCurrentType(CBoxValue: string): string;
    procedure destroy;
  end;

implementation

{ TTheNumberOfBloodDonations }

procedure TBIOCurrentType.destroy;
begin
  CheckNull := nil;
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOCurrentType.destroy выполнена');
end;

function TBIOCurrentType.GetCurrentType(CBoxValue: string): string;
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
    TempQuery.SQL.Add('SELECT TypesOfTaps.Id ' + 'FROM TypesOfTaps  ' +
      'WHERE TypesOfTaps.Type=''' + CBoxValue + ''';');
    TempQuery.Open;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  result := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOCurrentType.GetCurrentType выполнена');
end;
end.
