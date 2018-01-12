unit MHMAddRecordManualHarvesting;

interface

uses
  SysUtils, Data.Win.ADODB, Dialogs, Data.DB, DateUtils,
  UCheckNull,
  GetAdoQuery;

type
  IMHMAddRecordManualHarvesting = interface
    procedure AddRecordBlood(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String; Outing: String);
    procedure AddRecordBloodDoze(Date: Extended; Volue300: String; Volue350: String;
      Volue400: String; Volue450: String; Volue500: String);
    procedure AddRecordBloodErSusp(VolumeErSusp: String; NumberDosesErSusp: String; TypeProduction: String);
    procedure AddRecordBloodPlazma(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordBloodFiltrat(VolumeFiltrat: String; NumberDosesFiltrat: String);
    procedure AddRecordBloodDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
  end;

  TMHMAddRecordManualHarvesting = class(TInterfacedObject,
    IMHMAddRecordManualHarvesting)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    TempId: String;
  public
    procedure AddRecordBlood(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String; Outing: String);
    procedure AddRecordBloodDoze(Date: Extended; Volue300: String; Volue350: String;
      Volue400: String; Volue450: String; Volue500: String);
    procedure AddRecordBloodErSusp(VolumeErSusp: String; NumberDosesErSusp: String; TypeProduction: String);
    procedure AddRecordBloodPlazma(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
    procedure AddRecordBloodFiltrat(VolumeFiltrat: String; NumberDosesFiltrat: String);
    procedure AddRecordBloodDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMHMAddRecordManualHarvesting.AddRecordBlood(Date: Extended; VolumeDonors: String; SentToPreserving: String;
      ForLaboratoryResearch: String; AllWholeBlood: String; AllStoredBlood: String; Outing: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
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
      SQL.Add('INSERT INTO Blood([ДатаК], [КДК], [НаКонК], [ЛабК], [ЦелК], [КонК], [Выезд]) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        VolumeDonors + ', ' +
        SentToPreserving + ', ' +
        ForLaboratoryResearch + ', ' +
        AllWholeBlood + ', ' +
        AllStoredBlood + ', ' +
        Outing + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHMAddRecordManualHarvesting.AddRecordBloodDoze(Date: Extended; Volue300: String; Volue350: String;
  Volue400: String; Volue450: String; Volue500: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
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
      SQL.Add('INSERT INTO BloodDoza([ДатаК], [300], [350], [400], [450], [500]) VALUES ' +
        '(#' + FormatDateTime('mm''/''dd''/''yyyy', dateOf(Date)) + '#, ' +
        Volue300 + ', ' +
        Volue350 + ', ' +
        Volue400 + ', ' +
        Volue450 + ', ' +
        Volue500 + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHMAddRecordManualHarvesting.AddRecordBloodErSusp(VolumeErSusp: String; NumberDosesErSusp: String; TypeProduction: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
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
      TempId:=IntToStr(Fields[0].value);
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO BloodErSusp([Код], [ДЭВ], [КЭВ], [ВидЭВ]) VALUES ' +
        '(' + TempId + ', ' +
        VolumeErSusp + ', ' +
        NumberDosesErSusp + ', ''' +
        TypeProduction + ''')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHMAddRecordManualHarvesting.AddRecordBloodPlazma(VolumePlazma: String; NumberDosesPlazma: String; TypeProduction: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
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
      SQL.Add('INSERT INTO BloodPlasma([КодЭ], [ДПЛ], [КПЛ], [ВидПЛ]) VALUES ' +
        '(' + TempId + ', ' +
        VolumePlazma + ', ' +
        NumberDosesPlazma + ', ''' +
        TypeProduction + ''')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHMAddRecordManualHarvesting.AddRecordBloodFiltrat(VolumeFiltrat: String; NumberDosesFiltrat: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
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
      SQL.Add('INSERT INTO Filtrat([КодП], [ДФ], [КФ]) VALUES ' +
        '(' + TempId + ', ' +
        VolumeFiltrat + ', ' +
        NumberDosesFiltrat + ')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

procedure TMHMAddRecordManualHarvesting.AddRecordBloodDefect(VolumeDefects: String; NumberDosesDefects: String; TypeOfDefect: String);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
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
      SQL.Add('INSERT INTO BloodBrak([КодФ], [ДБР], [КБР], [ВидБР]) VALUES ' +
        '(' + TempId + ', ' +
        VolumeDefects + ', ' +
        NumberDosesDefects + ', ''' +
        TypeOfDefect + ''')');
      ExecSQL;
    end;
  except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

end.


{
  'Проверка существования записи
  Set mdb = CurrentDb
  sSQL = "Select top 2 BloodDoza.[ДатаК] FROM BloodDoza order by BloodDoza.[ДатаК] DESC"
  Set rst = mdb.OpenRecordset(sSQL)

  rst.MoveFirst
  FirstRec = CStr(rst.Fields("ДатаК").Value)
  rst.MoveLast
  SecondRec = CStr(rst.Fields("ДатаК").Value)

  rst.Close: Set rst = Nothing
  mdb.Close: Set mdb = Nothing

  If FirstRec = SecondRec Then
    MsgBox "Запись уже сохранена!"
    Exit Function
  End If

  Set mdb = CurrentDb


  CurrentDb.Execute "INSERT INTO BloodDoza([ДатаК], [450], [350]) values" _
  & "('" & Forms.MoreThenOneType.ДатаК.Value & "','" _
  & Forms.MoreThenOneType.Поле55.Value & "', '" _
  & Forms.MoreThenOneType.Поле57.Value & "'); "

  rst.Close: Set rst = Nothing
  mdb.Close: Set mdb = Nothing

  Set mdb = CurrentDb
  sSQL = "SELECT top 1 BloodDoza.[КодД] FROM BloodDoza order by BloodDoza.[КодД] DESC"
  Set rst = mdb.OpenRecordset(sSQL)
  rst.MoveLast

  CurrentDb.Execute "INSERT INTO BloodErSusp([ДЭВ], [КЭВ], [Код], [ВидЭВ]) values" _
  & "('" & Forms.MoreThenOneType.Поле61.Value & "','" _
  & Forms.MoreThenOneType.Поле59.Value & "', '" _
  & rst.Fields("КодД").Value & "', '" _
  & Forms.MoreThenOneType.ПолеСоСписком83.Value & "'); "

  CurrentDb.Execute "INSERT INTO BloodPlasma([ДПЛ], [КПЛ], [КодЭ], [ВидПЛ]) values" _
  & "('" & Forms.MoreThenOneType.Поле67.Value & "','" _
  & Forms.MoreThenOneType.Поле65.Value & "', '" _
  & rst.Fields("КодД").Value & "', '" _
  & Forms.MoreThenOneType.ПолеСоСписком85.Value & "'); "

  CurrentDb.Execute "INSERT INTO Filtrat([ДФ], [КодП], [КФ]) values" _
  & "('" & Forms.MoreThenOneType.Поле73.Value & "','" _
  & rst.Fields("КодД").Value & "', '" _
  & Forms.MoreThenOneType.Поле71.Value & "'); "

  CurrentDb.Execute "INSERT INTO BloodBrak([ДБР], [КБР], [КодФ], [ВидБР]) values" _
  & "('" & Forms.MoreThenOneType.Поле77.Value & "','" _
  & Forms.MoreThenOneType.Поле75.Value & "', '" _
  & rst.Fields("КодД").Value & "', '" _
  & Forms.MoreThenOneType.ПолеСоСписком87.Value & "'); "

  rst.Close: Set rst = Nothing
  mdb.Close: Set mdb = Nothing

  MsgBox "Запись сохранена!"





'Проверка кол-ва доноров
  If (Forms.MoreThenOneType.[450].Value + Forms.MoreThenOneType.[350].Value + Forms.MoreThenOneType.Поле55.Value + Forms.MoreThenOneType.Поле57.Value) <> Forms.MoreThenOneType.[КДК].Value Then
    MsgBox "Суммарное количество донаций (поля ""Кол-во доз объемом 450 и 350"") не совпадает с количеством доноров!" & Chr(13) & "Исправьте и сохраните еще раз!"
    Exit Function
  End If

  'Проверка кол-ва крови на лаб исслед-я
  If Forms.MoreThenOneType.[ЛабК].Value <> (20 * Forms.MoreThenOneType.[КДК].Value) Then
    MsgBox "Количество крови на лабораторные исследования не соответствует количеству доноров!" & Chr(13) & "Исправьте и сохраните еще раз!"
    Exit Function
  End If

  'Проверка кол-ва Конс крови крови
  If ((Forms.MoreThenOneType.[КЭВ].Value + Forms.MoreThenOneType.Поле59.Value) - 100 * (Forms.MoreThenOneType.[ДЭВ].Value + Forms.MoreThenOneType.Поле61.Value) + (Forms.MoreThenOneType.[КФ].Value + Forms.MoreThenOneType.Поле71.Value) + (Forms.MoreThenOneType.[КПЛ].Value + Forms.MoreThenOneType.Поле65.Value) + (Forms.MoreThenOneType.[КБР].Value + Forms.MoreThenOneType.Поле75.Value)) <> Forms.MoreThenOneType.[КонК].Value Then
    MsgBox "Количество консервированной крови не совпадает с суммой ее компонентов (скорее всего неправильно введен фильтрат или брак цельной крови)!" & Chr(13) & "Исправьте и сохраните еще раз!"
    Exit Function
  End If

  'Проверка кол-ва Цельной крови
  If (Forms.MoreThenOneType.[ЛабК].Value + Forms.MoreThenOneType.[НаКонК].Value) <> Forms.MoreThenOneType.[ЦелК].Value Then
    MsgBox "Количество цельной крови не совпадает с суммой ""Отправлено на консервирование"" и ""На лабораторные иследования""!" & Chr(13) & "Исправьте и сохраните еще раз!"
    Exit Function
  End If

  'Проверка кол-ва доз эр взвеси
  If (Forms.MoreThenOneType.[450].Value + Forms.MoreThenOneType.[350].Value + Forms.MoreThenOneType.Поле55.Value + Forms.MoreThenOneType.Поле57.Value) <> (Forms.MoreThenOneType.[ДЭВ].Value + Forms.MoreThenOneType.Поле61.Value) Then
    MsgBox "Суммарное количество донаций (поля ""Кол-во доз объемом 450 и 350"") не совпадает с количеством доноров!" & Chr(13) & "Исправьте и сохраните еще раз!"
    Exit Function
  End If

  'Проверка кол-ва доз плазмы
  If (Forms.MoreThenOneType.[450].Value + Forms.MoreThenOneType.[350].Value + Forms.MoreThenOneType.Поле55.Value + Forms.MoreThenOneType.Поле57.Value) <> (Forms.MoreThenOneType.[ДПЛ].Value + Forms.MoreThenOneType.Поле67.Value) Then
    MsgBox "Суммарное количество донаций (поля ""Кол-во доз объемом 450 и 350"") не совпадает с количеством доноров!" & Chr(13) & "Исправьте и сохраните еще раз!"
    Exit Function
  End If

}
