unit BHAChangeRecordAutomaticApheresis;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  GetAdoConnect;

type
  IBHAChangeRecordAutomaticApheresis = interface
    procedure ChangeRecordPlasma(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String);
    procedure ChangeRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure ChangeRecordPlasmaComponents(VolumePlazma: String;
      NumberDosesPlazma: String; TypeProduction: String);
    procedure ChangeRecordPlasmaDefect(VolumeDefects: String;
      NumberDosesDefects: String; TypeOfDefect: String);
    procedure GetTempId(Date: String);
  end;

  TBHAChangeRecordAutomaticApheresis = class(TInterfacedObject,
    IBHAChangeRecordAutomaticApheresis)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure ChangeRecordPlasma(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String);
    procedure ChangeRecordPlasmaDoza(Date: Extended; Volue600: String);
    procedure ChangeRecordPlasmaComponents(VolumePlazma: String;
      NumberDosesPlazma: String; TypeProduction: String);
    procedure ChangeRecordPlasmaDefect(VolumeDefects: String;
      NumberDosesDefects: String; TypeOfDefect: String);
    procedure GetTempId(Date: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBHAChangeRecordAutomaticApheresis.ChangeRecordPlasma(Date: Extended;
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
      SQL.Add('UPDATE Plasma SET ' + 'Plasma.КДП=' + VolumeDonors + ', ' +
        'Plasma.НаКонП=' + SentToPreserving + ', ' + 'Plasma.ЛабП=' +
        ForLaboratoryResearch + ', ' + 'Plasma.ЦелП=' + AllWholeBlood + ', ' +
        'Plasma.КонП=' + AllStoredBlood + ' ' + 'WHERE Plasma.ДатаП=#' +
        FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAChangeRecordAutomaticApheresis.ChangeRecordPlasma выполнена');
end;

procedure TBHAChangeRecordAutomaticApheresis.ChangeRecordPlasmaDoza
  (Date: Extended; Volue600: String);
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
      SQL.Add('UPDATE PlazmaDoza SET ' + 'PlazmaDoza.600=' + Volue600 + ' ' +
        'WHERE PlazmaDoza.ДатаП=#' + FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAChangeRecordAutomaticApheresis.ChangeRecordPlasmaDoza выполнена');
end;

procedure TBHAChangeRecordAutomaticApheresis.GetTempId(Date: String);
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
      SQL.Add('SELECT PlazmaDoza.КодПл ' + 'FROM PlazmaDoza ' +
        'WHERE (PlazmaDoza.ДатаП = #' + Date + '#)');
      Open;
      if not TempQuery.IsEmpty then
      begin
        Recordset.MoveFirst;
        TempId := IntToStr(Fields[0].value);
      end
      else
        ShowMessage('Id изменяемой строки не определен!');
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAChangeRecordAutomaticApheresis.CheckedValue выполнена');
end;

procedure TBHAChangeRecordAutomaticApheresis.ChangeRecordPlasmaComponents
  (VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
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
      SQL.Add('UPDATE PlasmaComponents SET ' + 'PlasmaComponents.ДПЛП=' +
        NumberDosesPlazma + ', ' + 'PlasmaComponents.КПЛП=' + VolumePlazma +
        ', ' + 'PlasmaComponents.ВидПЛП=''' + TypeProduction + ''' ' +
        'WHERE PlasmaComponents.КодДП=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAChangeRecordAutomaticApheresis.ChangeRecordPlasmaComponents выполнена');
end;

procedure TBHAChangeRecordAutomaticApheresis.ChangeRecordPlasmaDefect
  (VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
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
      SQL.Add('UPDATE PlazmaBrak SET ' + 'PlazmaBrak.ДБРП=' + NumberDosesDefects
        + ', ' + 'PlazmaBrak.КБРП=' + VolumeDefects + ', ' +
        'PlazmaBrak.ВидБРП=''' + TypeOfDefect + ''' ' +
        'WHERE PlazmaBrak.КодКП=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHAChangeRecordAutomaticApheresis.ChangeRecordPlasmaDefect выполнена');
end;
end.
