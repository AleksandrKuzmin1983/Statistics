unit BIOFChangeRecordFlowRateOfWholeBlood;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, CodeSiteLogging, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBIOFChangeRecordFlowRateOfWholeBlood = interface
    procedure ChangeRecord(Date: Extended; Volume: String; NumOfDoses: String;
      Reason: String; Id: String);
  end;

  TBIOFChangeRecordFlowRateOfWholeBlood = class(TInterfacedObject,
    IBIOFChangeRecordFlowRateOfWholeBlood)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
  public
    procedure ChangeRecord(Date: Extended; Volume: String; NumOfDoses: String;
      Reason: String; Id: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBIOFChangeRecordFlowRateOfWholeBlood.ChangeRecord(Date: Extended;
  Volume: String; NumOfDoses: String; Reason: String; Id: String);
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
      SQL.Add('UPDATE [Брак компонентов и другой расход] SET ' +
        '[Брак компонентов и другой расход].ДАТАЗАГ = #' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[Брак компонентов и другой расход].ДАТАБР = #' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        '[Брак компонентов и другой расход].БЦКО=' + Volume + ', ' +
        '[Брак компонентов и другой расход].БЦКД=' + NumOfDoses + ', ' +
        '[Брак компонентов и другой расход].БКЦП=''' + Reason + ''' ' +
        'WHERE [Брак компонентов и другой расход].Код=' + Id);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBIOFChangeRecordFlowRateOfWholeBlood.ChangeRecord выполнена');
end;
end.
