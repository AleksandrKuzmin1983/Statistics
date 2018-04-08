unit BIONameTypeOfSelectRow;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBIONameTypeOfSelectRow = interface
    function GetCurrentNameTypeOfSelectRow(StringBoxValue: string): string;
    procedure destroy;
  end;

  TBIONameTypeOfSelectRow = class(TInterfacedObject, IBIONameTypeOfSelectRow)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
  public
    function GetCurrentNameTypeOfSelectRow(StringBoxValue: string): string;
    procedure destroy;
  end;

implementation

{ TTheNumberOfBloodDonations }

procedure TBIONameTypeOfSelectRow.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;
  CheckNull := nil;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIONameTypeOfSelectRow.destroy выполнена');
end;

function TBIONameTypeOfSelectRow.GetCurrentNameTypeOfSelectRow
  (StringBoxValue: string): string;
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
    TempQuery.SQL.Add('SELECT TypesOfTaps.Type ' + 'FROM TypesOfTaps  ' +
      'WHERE TypesOfTaps.Id=' + StringBoxValue + ';');
    TempQuery.Open;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  result := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIONameTypeOfSelectRow.GetCurrentNameTypeOfSelectRow выполнена');
end;
end.
