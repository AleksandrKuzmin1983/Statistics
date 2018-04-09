unit BHMChangeRecordManualHarvesting;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  GetAdoConnect;

type
  IBHMChangeRecordManualHarvesting = interface
    procedure ChangeRecordBlood(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String; Outing: String);
    procedure ChangeRecordBloodDoze(Date: Extended; Volue300: String;
      Volue350: String; Volue400: String; Volue450: String; Volue500: String);
    procedure GetTempId(VolumeErSusp: string; DosesErSusp: string;
      TypeOfErSusp: string; Date: String);
    procedure ChangeRecordBloodErSusp(VolumeErSusp: String;
      NumberDosesErSusp: String; TypeProduction: String);
    procedure ChangeRecordBloodPlazma(VolumePlazma: String;
      NumberDosesPlazma: String; TypeProduction: String);
    procedure ChangeRecordBloodFiltrat(VolumeFiltrat: String;
      NumberDosesFiltrat: String);
    procedure ChangeRecordBloodDefect(VolumeDefects: String;
      NumberDosesDefects: String; TypeOfDefect: String);
    procedure destroy;
  end;

  TBHMChangeRecordManualHarvesting = class(TInterfacedObject,
    IBHMChangeRecordManualHarvesting)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure ChangeRecordBlood(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String; Outing: String);
    procedure ChangeRecordBloodDoze(Date: Extended; Volue300: String;
      Volue350: String; Volue400: String; Volue450: String; Volue500: String);
    procedure GetTempId(VolumeErSusp: string; DosesErSusp: string;
      TypeOfErSusp: string; Date: String);
    procedure ChangeRecordBloodErSusp(VolumeErSusp: String;
      NumberDosesErSusp: String; TypeProduction: String);
    procedure ChangeRecordBloodPlazma(VolumePlazma: String;
      NumberDosesPlazma: String; TypeProduction: String);
    procedure ChangeRecordBloodFiltrat(VolumeFiltrat: String;
      NumberDosesFiltrat: String);
    procedure ChangeRecordBloodDefect(VolumeDefects: String;
      NumberDosesDefects: String; TypeOfDefect: String);
    procedure destroy;
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBHMChangeRecordManualHarvesting.ChangeRecordBlood(Date: Extended;
  VolumeDonors: String; SentToPreserving: String; ForLaboratoryResearch: String;
  AllWholeBlood: String; AllStoredBlood: String; Outing: String);
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
      SQL.Add('UPDATE Blood SET ' + 'Blood.���=' + VolumeDonors + ', ' +
        'Blood.������=' + SentToPreserving + ', ' + 'Blood.����=' +
        ForLaboratoryResearch + ', ' + 'Blood.����=' + AllWholeBlood + ', ' +
        'Blood.����=' + AllStoredBlood + ', ' + 'Blood.�����=' + Outing + ' ' +
        'WHERE Blood.�����=#' + FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBlood ���������');
end;

procedure TBHMChangeRecordManualHarvesting.ChangeRecordBloodDoze(Date: Extended;
  Volue300: String; Volue350: String; Volue400: String; Volue450: String;
  Volue500: String);
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
      SQL.Add('UPDATE BloodDoza SET ' + 'BloodDoza.300=' + Volue300 + ', ' +
        'BloodDoza.350=' + Volue350 + ', ' + 'BloodDoza.400=' + Volue400 + ', '
        + 'BloodDoza.450=' + Volue450 + ', ' + 'BloodDoza.500=' + Volue500 + ' '
        + 'WHERE BloodDoza.�����=#' + FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodDoze ���������');
end;

procedure TBHMChangeRecordManualHarvesting.ChangeRecordBloodErSusp
  (VolumeErSusp: String; NumberDosesErSusp: String; TypeProduction: String);
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
      SQL.Add('UPDATE BloodErSusp SET ' + 'BloodErSusp.���=' + NumberDosesErSusp
        + ', ' + 'BloodErSusp.���=' + VolumeErSusp + ', ' +
        'BloodErSusp.�����=''' + TypeProduction + ''' ' +
        'WHERE BloodErSusp.���=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodErSusp ���������');
end;

procedure TBHMChangeRecordManualHarvesting.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.destroy ���������');
end;

procedure TBHMChangeRecordManualHarvesting.GetTempId(VolumeErSusp: string;
  DosesErSusp: string; TypeOfErSusp: string; Date: String);
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
      SQL.Add('SELECT BloodErSusp.��� ' +
        'FROM (Blood INNER JOIN BloodDoza ON Blood.����� = BloodDoza.�����) ' +
        'INNER JOIN BloodErSusp ON BloodDoza.���� = BloodErSusp.��� ' +
        'WHERE (BloodErSusp.���=' + DosesErSusp + ') AND ' + '(BloodErSusp.���='
        + VolumeErSusp + ') AND ' + '(BloodErSusp.�����=''' + TypeOfErSusp +
        ''') AND ' + '(Blood.����� = #' + Date + '#)');
      Open;
      if not TempQuery.IsEmpty then
      begin
        Recordset.MoveFirst;
        TempId := IntToStr(Fields[0].value);
      end
      else
        ShowMessage('Id ���������� ������ �� ���������!');
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.GetTempId ���������');
end;

procedure TBHMChangeRecordManualHarvesting.ChangeRecordBloodPlazma
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
      SQL.Add('UPDATE BloodPlasma SET ' + 'BloodPlasma.���=' + NumberDosesPlazma
        + ', ' + 'BloodPlasma.���=' + VolumePlazma + ', ' +
        'BloodPlasma.�����=''' + TypeProduction + ''' ' +
        'WHERE BloodPlasma.����=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodPlazma ���������');
end;

procedure TBHMChangeRecordManualHarvesting.ChangeRecordBloodFiltrat
  (VolumeFiltrat: String; NumberDosesFiltrat: String);
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
      SQL.Add('UPDATE Filtrat SET ' + 'Filtrat.��=' + NumberDosesFiltrat + ', '
        + 'Filtrat.��=' + VolumeFiltrat + ' ' + 'WHERE Filtrat.����=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodFiltrat ���������');
end;

procedure TBHMChangeRecordManualHarvesting.ChangeRecordBloodDefect
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
      SQL.Add('UPDATE BloodBrak SET ' + 'BloodBrak.���=' + NumberDosesDefects +
        ', ' + 'BloodBrak.���=' + VolumeDefects + ', ' + 'BloodBrak.�����=''' +
        TypeOfDefect + ''' ' + 'WHERE BloodBrak.����=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodDefect ���������');
end;
end.
