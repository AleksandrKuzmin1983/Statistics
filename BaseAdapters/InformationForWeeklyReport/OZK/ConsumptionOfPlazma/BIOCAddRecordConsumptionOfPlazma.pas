unit BIOCAddRecordConsumptionOfPlazma;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOCAddRecordConsumptionOfPlazma = interface
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; Reason: String);
  end;

  TBIOCAddRecordConsumptionOfPlazma = class(TInterfacedObject,
    IBIOCAddRecordConsumptionOfPlazma)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure AddRecord(Date: Extended; ProdList: String; Volume: String;
      NumOfDoses: String; Reason: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOCAddRecordConsumptionOfPlazma.AddRecord(Date: Extended;
  ProdList: String; Volume: String; NumOfDoses: String; Reason: String);
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
      SQL.Add('INSERT INTO [Брак компонентов и другой расход] (ДАТАЗАГ, ДАТАБР, БПВ, БПО, БПД, БПП) VALUES '
        + '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ''' +
        ProdList + ''', ' + Volume + ', ' + NumOfDoses + ', ''' +
        Reason + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

end.
