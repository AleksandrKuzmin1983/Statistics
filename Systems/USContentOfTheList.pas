unit USContentOfTheList;

interface

uses
  SysUtils, Variants, CodeSiteLogging, Data.Win.ADODB, Data.DB, Dialogs,
  GetAdoConnect;

type
  IUSContentOfTheList = interface
    function GetContentOfTheList(i: integer): string;
    procedure GetNameOfColumns(CSQL: String);
    procedure GetContent(CSQL: String);
    function GetCount: integer;
    procedure destroy;
  end;

  TUSContentOfTheList = class(TInterfacedObject, IUSContentOfTheList)
  private
    TempArray: array of string;
    TempConnect: TTempAdoQuery;
    TempQuery: TADOQuery;
  public
    function GetContentOfTheList(i: integer): string;
    function GetCount: integer;
    procedure GetNameOfColumns(CSQL: String);
    procedure GetContent(CSQL: String);
    procedure destroy;
  end;

implementation

{ TTheNumberOfBloodDonations }

procedure TUSContentOfTheList.destroy;
begin
  if Assigned(TempConnect) then
    FreeAndNil(TempConnect);
  TempConnect := nil;
  SetLength(TempArray, 0);

  CodeSite.Send(FormatDateTime('c', Now) + ' TUSBlockMainMenu.BlockMainMenu выполнена');
end;

procedure TUSContentOfTheList.GetContent(CSQL: String);
var
  i: integer;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    TempQuery.SQL.Add(CSQL);
  Except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  TempQuery.Open;
  if not TempQuery.IsEmpty then
  begin
    i := 0;
    SetLength(TempArray, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    while not TempQuery.Eof do
    begin
      TempArray[i] := VarToStr(TempQuery.Fields[0].Value);
      i := i + 1;
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TUSBlockMainMenu.BlockMainMenu выполнена');
end;

function TUSContentOfTheList.GetContentOfTheList(i: integer): string;
begin
  result := TempArray[i];

  CodeSite.Send(FormatDateTime('c', Now) + ' TUSBlockMainMenu.BlockMainMenu выполнена');
end;

function TUSContentOfTheList.GetCount: integer;
begin
  result := Length(TempArray);

  CodeSite.Send(FormatDateTime('c', Now) + ' TUSBlockMainMenu.BlockMainMenu выполнена');
end;

procedure TUSContentOfTheList.GetNameOfColumns(CSQL: String);
var
  i: integer;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    TempQuery.SQL.Add(CSQL);
  Except
    On e: EDatabaseError do
    begin
      messageDlg(e.message, mtError, [mbOK], 0);
      ShowMessage('Ошибка выполнения запроса!');
    end;
  End;
  TempQuery.Open;
  if not TempQuery.IsEmpty then
  begin
    SetLength(TempArray, TempQuery.FieldCount - 2);
    for i := 2 to TempQuery.FieldCount - 1 do
    begin
      TempArray[i - 2] := VarToStr(TempQuery.Fields[i].FieldName);
    end;
  end;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TUSContentOfTheList.GetNameOfColumns выполнена');
end;

end.
