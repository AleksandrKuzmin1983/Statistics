unit BIEChangeRecordResultsInLPU;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIEChangeRecordResultsInLPU = interface
    procedure ChangeRecord(Date: Extended; ProdList: String; TypeLPU: String;
      Volume: String; NumOfDoses: String; Percentage: String;
      NumOfPackets: String; Id: String);
  end;

  TBIEChangeRecordResultsInLPU = class(TInterfacedObject,
    IBIEChangeRecordResultsInLPU)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure ChangeRecord(Date: Extended; ProdList: String; TypeLPU: String;
      Volume: String; NumOfDoses: String; Percentage: String;
      NumOfPackets: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIEChangeRecordResultsInLPU.ChangeRecord(Date: Extended;
  ProdList: String; TypeLPU: String; Volume: String; NumOfDoses: String;
  Percentage: String; NumOfPackets: String; Id: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection := TempConnect.GetConnect;
      Close;
      SQL.Clear;
      SQL.Add('UPDATE Exped SET Exped.ƒ¿“¿À« = #' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        'Exped.Õ— =''' + ProdList + ''', ' + 'Exped.¬À« =''' + TypeLPU + ''', '
        + 'Exped.À«Œ=' + Volume + ', ' + 'Exped.À«ƒ=' + NumOfDoses + ', ' +
        'Exped.À«œ–=' + Percentage + ', ' + 'Exped.À«œ¿ =' + NumOfPackets + ' '
        + 'WHERE Exped. Ó‰=' + Id);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

end.
