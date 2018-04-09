unit BHSChangeRecordSitoferez;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, CodeSiteLogging, DateUtils,
  GetAdoConnect;

type
  IBHSChangeRecordSitoferez = interface
    procedure ChangeRecordTrombo(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String);
    procedure ChangeRecordTromboDoza(Date: Extended; Value: String);
    procedure ChangeRecordTromboComponents(VolumeTrombo: String;
      NumberOfPacketsTrombo: String; NumberDosesTrombo: String;
      TypeProduction: String);
    procedure ChangeRecordTromboDefect(VolumeDefects: String;
      NumberOfPacketsDefects: String; NumberDosesDefects: String;
      TypeOfDefect: String);
    procedure GetTempId(Date: String);
  end;

  TBHSChangeRecordSitoferez = class(TInterfacedObject,
    IBHSChangeRecordSitoferez)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure ChangeRecordTrombo(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String);
    procedure ChangeRecordTromboDoza(Date: Extended; Value: String);
    procedure ChangeRecordTromboComponents(VolumeTrombo: String;
      NumberOfPacketsTrombo: String; NumberDosesTrombo: String;
      TypeProduction: String);
    procedure ChangeRecordTromboDefect(VolumeDefects: String;
      NumberOfPacketsDefects: String; NumberDosesDefects: String;
      TypeOfDefect: String);
    procedure GetTempId(Date: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBHSChangeRecordSitoferez.ChangeRecordTrombo(Date: Extended;
  VolumeDonors: String; SentToPreserving: String; ForLaboratoryResearch: String;
  AllWholeBlood: String; AllStoredBlood: String);
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
      SQL.Add('UPDATE Tromb SET ' + 'Tromb.���=' + VolumeDonors + ', ' +
        'Tromb.������=' + SentToPreserving + ', ' + 'Tromb.����=' +
        ForLaboratoryResearch + ', ' + 'Tromb.����=' + AllWholeBlood + ', ' +
        'Tromb.����=' + AllStoredBlood + ' ' + 'WHERE Tromb.�����=#' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSChangeRecordSitoferez.ChangeRecordTrombo ���������');
end;

procedure TBHSChangeRecordSitoferez.ChangeRecordTromboDoza(Date: Extended;
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
      SQL.Add('UPDATE TrombDoza SET ' + 'TrombDoza.�����=' + Value + ' ' +
        'WHERE TrombDoza.�����=#' + FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSChangeRecordSitoferez.ChangeRecordTromboDoza ���������');
end;

procedure TBHSChangeRecordSitoferez.GetTempId(Date: String);
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
      SQL.Add('SELECT TrombDoza.���� ' + 'FROM TrombDoza ' +
        'WHERE (TrombDoza.����� = #' + Date + '#)');
      Open;
      if not TempQuery.IsEmpty then
      begin
        Recordset.MoveFirst;
        TempId := IntToStr(Fields[0].Value);
      end
      else
        ShowMessage('Id ���������� ������ �� ���������!');
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSChangeRecordSitoferez.GetTempId ���������');
end;

procedure TBHSChangeRecordSitoferez.ChangeRecordTromboComponents
  (VolumeTrombo: String; NumberOfPacketsTrombo: String;
  NumberDosesTrombo: String; TypeProduction: String);
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
      SQL.Add('UPDATE TrombComponents SET ' + 'TrombComponents.����=' +
        VolumeTrombo + ', ' + 'TrombComponents.����=' + NumberOfPacketsTrombo +
        ', ' + 'TrombComponents.����=' + NumberDosesTrombo + ', ' +
        'TrombComponents.����=''' + TypeProduction + ''' ' +
        'WHERE TrombComponents.�����=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSChangeRecordSitoferez.ChangeRecordTromboComponents ���������');
end;

procedure TBHSChangeRecordSitoferez.ChangeRecordTromboDefect
  (VolumeDefects: String; NumberOfPacketsDefects: String;
  NumberDosesDefects: String; TypeOfDefect: String);
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
      SQL.Add('UPDATE TrombBrak SET ' + 'TrombBrak.����=' + VolumeDefects + ', '
        + 'TrombBrak.����=' + NumberOfPacketsDefects + ', ' + 'TrombBrak.����='
        + NumberDosesDefects + ', ' + 'TrombBrak.������=''' + TypeOfDefect +
        ''' ' + 'WHERE TrombBrak.�����=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHSChangeRecordSitoferez.ChangeRecordTromboDefect ���������');
end;
end.
