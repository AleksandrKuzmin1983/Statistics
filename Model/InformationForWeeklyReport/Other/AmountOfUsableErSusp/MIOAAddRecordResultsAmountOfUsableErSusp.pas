unit MIOAAddRecordResultsAmountOfUsableErSusp;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMIOAAddRecordResultsAmountOfUsableErSusp = interface
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String);
  end;

  TMIOAAddRecordResultsAmountOfUsableErSusp = class(TInterfacedObject,
    IMIOAAddRecordResultsAmountOfUsableErSusp)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
  public
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOAAddRecordResultsAmountOfUsableErSusp.AddRecord(Date: Extended; ProdList: String; Volume: String);
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
      SQL.Add('INSERT INTO Exped (ƒ¿“¿À«, Õ—, œ√›—) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
        ProdList + ''', ' +
        Volume + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.
