unit UMSGContentOfTheList;

interface

uses
  Variants, Data.Win.ADODB,
  GetAdoQuery;

type
  IContentOfTheList = interface
    function GetContentOfTheList(i: integer): string;
  end;

  TContentOfTheList = class(TInterfacedObject, IContentOfTheList)
  private
    TempArray: array of string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
  public
    function GetContentOfTheList(i: integer): string;
    function GetCount: integer;
    constructor create(CSQL: String);
  end;

implementation

{TTheNumberOfBloodDonations}

constructor TContentOfTheList.create(CSQL: String);
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
  TempQuery.SQL.Add(CSQL);
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
