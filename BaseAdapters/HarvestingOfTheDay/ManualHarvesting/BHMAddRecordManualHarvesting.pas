unit BHMAddRecordManualHarvesting;

interface

uses
  SysUtils, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB, DateUtils,
  GetAdoConnect;

type
  IBHMAddRecordManualHarvesting = interface
    procedure AddRecordBlood(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String; Outing: String);
    procedure AddRecordBloodDoze(Date: Extended; Volue300: String;
      Volue350: String; Volue400: String; Volue450: String; Volue500: String);
    procedure AddRecordBloodErSusp(VolumeErSusp: String;
      NumberDosesErSusp: String; TypeProduction: String);
    procedure AddRecordBloodPlazma(VolumePlazma: String;
      NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordBloodFiltrat(VolumeFiltrat: String;
      NumberDosesFiltrat: String);
    procedure AddRecordBloodDefect(VolumeDefects: String;
      NumberDosesDefects: String; TypeOfDefect: String);
  end;

  TBHMAddRecordManualHarvesting = class(TInterfacedObject,
    IBHMAddRecordManualHarvesting)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    TempId: String;
  public
    procedure AddRecordBlood(Date: Extended; VolumeDonors: String;
      SentToPreserving: String; ForLaboratoryResearch: String;
      AllWholeBlood: String; AllStoredBlood: String; Outing: String);
    procedure AddRecordBloodDoze(Date: Extended; Volue300: String;
      Volue350: String; Volue400: String; Volue450: String; Volue500: String);
    procedure AddRecordBloodErSusp(VolumeErSusp: String;
      NumberDosesErSusp: String; TypeProduction: String);
    procedure AddRecordBloodPlazma(VolumePlazma: String;
      NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordBloodFiltrat(VolumeFiltrat: String;
      NumberDosesFiltrat: String);
    procedure AddRecordBloodDefect(VolumeDefects: String;
      NumberDosesDefects: String; TypeOfDefect: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TBHMAddRecordManualHarvesting.AddRecordBlood(Date: Extended;
  VolumeDonors: String; SentToPreserving: String; ForLaboratoryResearch: String;
  AllWholeBlood: String; AllStoredBlood: String; Outing: String);
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
      SQL.Add('INSERT INTO Blood([ДатаК], [КДК], [НаКонК], [ЛабК], [ЦелК], [КонК], [Выезд]) VALUES '
        + '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        VolumeDonors + ', ' + SentToPreserving + ', ' + ForLaboratoryResearch +
        ', ' + AllWholeBlood + ', ' + AllStoredBlood + ', ' + Outing + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMAddRecordManualHarvesting.AddRecordBlood выполнена');
end;

procedure TBHMAddRecordManualHarvesting.AddRecordBloodDoze(Date: Extended;
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
      SQL.Add('INSERT INTO BloodDoza([ДатаК], [300], [350], [400], [450], [500]) VALUES '
        + '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        Volue300 + ', ' + Volue350 + ', ' + Volue400 + ', ' + Volue450 + ', ' +
        Volue500 + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMAddRecordManualHarvesting.AddRecordBloodDoze выполнена');
end;

procedure TBHMAddRecordManualHarvesting.AddRecordBloodErSusp
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
      SQL.Add('SELECT top 1 BloodDoza.[КодД] FROM BloodDoza order by BloodDoza.[КодД] DESC');
      Open;
      Recordset.MoveFirst;
      TempId := IntToStr(Fields[0].value);
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO BloodErSusp([Код], [ДЭВ], [КЭВ], [ВидЭВ]) VALUES ' +
        '(' + TempId + ', ' + NumberDosesErSusp + ', ' + VolumeErSusp + ', ''' +
        TypeProduction + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMAddRecordManualHarvesting.AddRecordBloodErSusp выполнена');
end;

procedure TBHMAddRecordManualHarvesting.AddRecordBloodPlazma
  (VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
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
      SQL.Add('INSERT INTO BloodPlasma([КодЭ], [ДПЛ], [КПЛ], [ВидПЛ]) VALUES ' +
        '(' + TempId + ', ' + NumberDosesPlazma + ', ' + VolumePlazma + ', ''' +
        TypeProduction + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMAddRecordManualHarvesting.AddRecordBloodPlazma выполнена');
end;

procedure TBHMAddRecordManualHarvesting.AddRecordBloodFiltrat
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
      SQL.Add('INSERT INTO Filtrat([КодП], [ДФ], [КФ]) VALUES ' + '(' + TempId +
        ', ' + NumberDosesFiltrat + ', ' + VolumeFiltrat + ')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMAddRecordManualHarvesting.AddRecordBloodFiltrat выполнена');
end;

procedure TBHMAddRecordManualHarvesting.AddRecordBloodDefect
  (VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
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
      SQL.Add('INSERT INTO BloodBrak([КодФ], [ДБР], [КБР], [ВидБР]) VALUES ' +
        '(' + TempId + ', ' + NumberDosesDefects + ', ' + VolumeDefects + ', '''
        + TypeOfDefect + ''')');
      ExecSQL;
    end;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBHMAddRecordManualHarvesting.AddRecordBloodDefect выполнена');
end;
end.
