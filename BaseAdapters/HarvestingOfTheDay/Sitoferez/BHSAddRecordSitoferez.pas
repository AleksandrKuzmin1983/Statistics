unit BHSAddRecordSitoferez;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, CodeSiteLogging, Data.DB, DateUtils,
  USCheckNull,
  GetAdoConnect;

type
  IBHSAddRecordSitoferez = interface
    procedure AddRecordTrombo(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String);
    procedure AddRecordTromboDoza(Date: Extended; Value: String);
    procedure AddRecordTromboComponents(VolumeTrombo: String;
      NumberOfPacketsTrombo: String; NumberOfDosesTrombo: String;
      TypeProduction: String);
    procedure AddRecordTromboDefect(VolumeDefects: String;
      NumberOfPacketsDefect: String; NumberOfDosesDefect: String;
      TypeOfDefect: String);
  end;

  TBHSAddRecordSitoferez = class(TInterfacedObject, IBHSAddRecordSitoferez)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure AddRecordTrombo(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String);
    procedure AddRecordTromboDoza(Date: Extended; Value: String);
    procedure AddRecordTromboComponents(VolumeTrombo: String;
      NumberOfPacketsTrombo: String; NumberOfDosesTrombo: String;
      TypeProduction: String);
    procedure AddRecordTromboDefect(VolumeDefects: String;
      NumberOfPacketsDefect: String; NumberOfDosesDefect: String;
      TypeOfDefect: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBHSAddRecordSitoferez.AddRecordTrombo(Date: Extended;
  VolumeDonors: String; SentToPreserving: String; ForLaboratoryResearch: String;
  AllWholeBlood: String; AllStoredBlood: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
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
      SQL.Add('INSERT INTO Tromb([ДатаТ], [КДТ], [НаКонТ], [ЛабТ], [ЦелТ], [КонТ]) VALUES '
        + '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        VolumeDonors + ', ' + SentToPreserving + ', ' + ForLaboratoryResearch +
        ', ' + AllWholeBlood + ', ' + AllStoredBlood + ' )');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSAddRecordSitoferez.AddRecordTrombo выполнена');
end;

procedure TBHSAddRecordSitoferez.AddRecordTromboDoza(Date: Extended;
  Value: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
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
      SQL.Add('INSERT INTO TrombDoza([ДатаТ], [ДозаТ]) VALUES ' + '(#' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        Value + ' )');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSAddRecordSitoferez.AddRecordTromboDoza выполнена');
end;

procedure TBHSAddRecordSitoferez.AddRecordTromboComponents(VolumeTrombo: String;
  NumberOfPacketsTrombo: String; NumberOfDosesTrombo: String;
  TypeProduction: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  Try
    with TempQuery do
    begin
      Connection;
      Close;
      SQL.Clear;
      SQL.Add('SELECT top 1 TrombDoza.[КодТ] FROM TrombDoza ORDER BY TrombDoza.[КодТ] DESC');
      Open;
      Recordset.MoveFirst;
      TempId := IntToStr(Fields[0].Value);
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO TrombComponents([КодДТ], [КПЛТ], [ПакТ], [ДПЛТ], [ВидТ]) VALUES '
        + '(' + TempId + ', ' + VolumeTrombo + ', ' + NumberOfPacketsTrombo +
        ', ' + NumberOfDosesTrombo + ', ''' + TypeProduction + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSAddRecordSitoferez.AddRecordTromboComponents выполнена');
end;

procedure TBHSAddRecordSitoferez.AddRecordTromboDefect(VolumeDefects: String;
  NumberOfPacketsDefect: String; NumberOfDosesDefect: String;
  TypeOfDefect: String);
begin
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
      SQL.Add('INSERT INTO TrombBrak([КодКТ], [КБРТ], [КПБТ], [ДБРТ], [ВидБРТ]) VALUES '
        + '(' + TempId + ', ' + VolumeDefects + ', ' + NumberOfPacketsDefect +
        ', ' + NumberOfDosesDefect + ', ''' + TypeOfDefect + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSAddRecordSitoferez.AddRecordTromboDefect выполнена');
end;
end.
