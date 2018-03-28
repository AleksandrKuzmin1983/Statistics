unit BIOAChangeRecordResultsAmountOfUsableErSusp;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOAChangeRecordResultsAmountOfUsableErSusp = interface
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String;
      Id: String);
  end;

  TBIOAChangeRecordResultsAmountOfUsableErSusp = class(TInterfacedObject,
    IBIOAChangeRecordResultsAmountOfUsableErSusp)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String;
      Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOAChangeRecordResultsAmountOfUsableErSusp.ChangeRecord
  (Date: Extended; ProdList: String; Volume: String; Id: String);
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
    with TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE Exped SET Exped.������ = #' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'Exped.�� =''' + ProdList + ''', ' + 'Exped.����=' + Volume + ' ' +
        'WHERE Exped.���=' + Id);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

end.
