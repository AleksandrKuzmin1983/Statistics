unit UMSGContentOfTheList;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Data.DB, Dialogs,
  GetAdoQuery;

type
  IContentOfTheList = interface
    function GetContentOfTheList(i: integer): string;
    procedure GetNameOfColumns(CSQL: String);
    procedure GetContent(CSQL: String);
    procedure destroy;
  end;

  TContentOfTheList = class(TInterfacedObject, IContentOfTheList)
  private
    TempArray: array of string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    function GetContentOfTheList(i: integer): string;
    function GetCount: integer;
    procedure GetNameOfColumns(CSQL: String);
    procedure GetContent(CSQL: String);
    procedure destroy;
  end;

implementation

{TTheNumberOfBloodDonations}

procedure TContentOfTheList.destroy;
begin
  if Assigned(TempConnect) then
   TempConnect.Destroy;

//  FreeAndNil(TempQuery);
  if Assigned(TempArray) then
    TempArray:=nil;
end;

procedure TContentOfTheList.GetContent(CSQL: String);
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
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
  TempQuery.Open;
  if not TempQuery.IsEmpty then
  begin
    i:=1;
    SetLength(TempArray, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    while not TempQuery.Eof do
    begin
      TempArray[i]:=VarToStr(TempQuery.Fields[0].Value);
      i:=i+1;
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

function TContentOfTheList.GetContentOfTheList(i: integer): string;
begin
  result := TempArray[i];
end;

function TContentOfTheList.GetCount: integer;
begin
  Result:=Length(TempArray);
end;

procedure TContentOfTheList.GetNameOfColumns(CSQL: String);
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
  On e : EDatabaseError do
    begin
      messageDlg(e.message, mtError, [mbOK],0);
      ShowMessage('Ошибка выполнения запроса!');
    end;
  End;
  TempQuery.Open;
  if not TempQuery.IsEmpty then
  begin
    SetLength(TempArray, TempQuery.FieldCount-2);
    for i:=2 to  TempQuery.FieldCount-1 do
    begin
      TempArray[i-2]:=VarToStr(TempQuery.Fields[i].FieldName);
    end;
  end;
  TempQuery.Close;
end;

end.
