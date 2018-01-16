unit MIOAChangeRecordResultsAmountOfUsableErSusp;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOAChangeRecordResultsAmountOfUsableErSusp = interface
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String; Id: String);
  end;

  TMIOAChangeRecordResultsAmountOfUsableErSusp = class(TInterfacedObject,
    IMIOAChangeRecordResultsAmountOfUsableErSusp)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure ChangeRecord(Date: Extended; ProdList: String; Volume: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOAChangeRecordResultsAmountOfUsableErSusp.ChangeRecord(Date: Extended; ProdList: String;
  Volume: String; Id: String);
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
    with TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE Exped SET Exped.ƒ¿“¿À« = #' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'Exped.Õ— =''' + ProdList + ''', ' +
        'Exped.œ√›—=' + Volume + ' ' +
        'WHERE Exped. Ó‰=' + Id);
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;
end.
