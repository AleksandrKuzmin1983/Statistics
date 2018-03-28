unit BIOFAddRecordFlowRateOfWholeBlood;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOFAddRecordFlowRateOfWholeBlood = interface
    procedure AddRecord(Date: Extended; Volume: String; NumOfDoses: String;
      Reason: String);
  end;

  TBIOFAddRecordFlowRateOfWholeBlood = class(TInterfacedObject,
    IBIOFAddRecordFlowRateOfWholeBlood)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure AddRecord(Date: Extended; Volume: String; NumOfDoses: String;
      Reason: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOFAddRecordFlowRateOfWholeBlood.AddRecord(Date: Extended;
  Volume: String; NumOfDoses: String; Reason: String);
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
      SQL.Add('INSERT INTO [Брак компонентов и другой расход] (ДАТАЗАГ, ДАТАБР, БЦКО, БЦКД, БКЦП) VALUES '
        + '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        Volume + ', ' + NumOfDoses + ', ''' + Reason + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
end;

end.
