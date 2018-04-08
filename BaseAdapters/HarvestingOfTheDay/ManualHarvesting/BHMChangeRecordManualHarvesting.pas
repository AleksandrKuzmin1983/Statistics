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
      SQL.Add('UPDATE Blood SET ' + 'Blood.КДК=' + VolumeDonors + ', ' +
        'Blood.НаКонК=' + SentToPreserving + ', ' + 'Blood.ЛабК=' +
        ForLaboratoryResearch + ', ' + 'Blood.ЦелК=' + AllWholeBlood + ', ' +
        'Blood.КонК=' + AllStoredBlood + ', ' + 'Blood.Выезд=' + Outing + ' ' +
        'WHERE Blood.ДатаК=#' + FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBlood выполнена');
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
        + 'WHERE BloodDoza.ДатаК=#' + FormatDateTime('mm''/''dd''/''yyyy',
        dateOf(Date)) + '# ');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodDoze выполнена');
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
      SQL.Add('UPDATE BloodErSusp SET ' + 'BloodErSusp.ДЭВ=' + NumberDosesErSusp
        + ', ' + 'BloodErSusp.КЭВ=' + VolumeErSusp + ', ' +
        'BloodErSusp.ВидЭВ=''' + TypeProduction + ''' ' +
        'WHERE BloodErSusp.Код=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodErSusp выполнена');
end;

procedure TBHMChangeRecordManualHarvesting.destroy;
begin
  TempConnect.destroy;
  TempConnect := nil;
  if Assigned(TempQuery) then
    TempQuery.Free;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.destroy выполнена');
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
      SQL.Add('SELECT BloodErSusp.Код ' +
        'FROM (Blood INNER JOIN BloodDoza ON Blood.ДатаК = BloodDoza.ДатаК) ' +
        'INNER JOIN BloodErSusp ON BloodDoza.КодД = BloodErSusp.Код ' +
        'WHERE (BloodErSusp.ДЭВ=' + DosesErSusp + ') AND ' + '(BloodErSusp.КЭВ='
        + VolumeErSusp + ') AND ' + '(BloodErSusp.ВидЭВ=''' + TypeOfErSusp +
        ''') AND ' + '(Blood.ДатаК = #' + Date + '#)');
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

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.GetTempId выполнена');
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
      SQL.Add('UPDATE BloodPlasma SET ' + 'BloodPlasma.ДПЛ=' + NumberDosesPlazma
        + ', ' + 'BloodPlasma.КПЛ=' + VolumePlazma + ', ' +
        'BloodPlasma.ВидПЛ=''' + TypeProduction + ''' ' +
        'WHERE BloodPlasma.КодЭ=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodPlazma выполнена');
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
      SQL.Add('UPDATE Filtrat SET ' + 'Filtrat.ДФ=' + NumberDosesFiltrat + ', '
        + 'Filtrat.КФ=' + VolumeFiltrat + ' ' + 'WHERE Filtrat.КодП=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodFiltrat выполнена');
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
      SQL.Add('UPDATE BloodBrak SET ' + 'BloodBrak.ДБР=' + NumberDosesDefects +
        ', ' + 'BloodBrak.КБР=' + VolumeDefects + ', ' + 'BloodBrak.ВидБР=''' +
        TypeOfDefect + ''' ' + 'WHERE BloodBrak.КодФ=' + TempId);
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMChangeRecordManualHarvesting.ChangeRecordBloodDefect выполнена');
end;
end.
