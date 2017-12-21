unit UMSGContentOfTheList;

interface

uses
  Variants, Data.Win.ADODB, Data.DB, Dialogs,
  GetAdoQuery;

type
  IContentOfTheList = interface
    function GetContentOfTheList(i: integer): string;
    procedure GetContent(CSQL: String);
  end;

  TContentOfTheList = class(TInterfacedObject, IContentOfTheList)
  private
    TempArray: array of string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    function GetContentOfTheList(i: integer): string;
    function GetCount: integer;
    procedure GetContent(CSQL: String);
  end;

implementation

{TTheNumberOfBloodDonations}

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

end.
