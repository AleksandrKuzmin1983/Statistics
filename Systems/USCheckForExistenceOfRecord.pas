unit USCheckForExistenceOfRecord;

interface

uses
  Data.DB, Dialogs, CodeSiteLogging, SysUtils, Data.Win.ADODB,
  USCheckNull,
  GetAdoConnect;

type
  IUSCheckForExistenceOfRecord = interface
    function CheckForExistenceOfRecord(CSQL: String): boolean;
  end;

  TUSCheckForExistenceOfRecord = class(TInterfacedObject,
    IUSCheckForExistenceOfRecord)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
  public
    function CheckForExistenceOfRecord(CSQL: String): boolean;
  end;

implementation

{ TMHMCheckForExistenceOfRecord }

function TUSCheckForExistenceOfRecord.CheckForExistenceOfRecord
  (CSQL: String): boolean;
begin
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add(CSQL);
      Open;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  if TempQuery.IsEmpty then
    Result := false
  else
  begin
    ShowMessage('Запись за такую дату уже существует!' + chr(13) +
      'Введите другую дату, либо воспользуйтесь функцией изменения существующей записи!');
    Result := true;
  end;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TUSCheckForExistenceOfRecord.CheckForExistenceOfRecord выполнена');
end;

end.
