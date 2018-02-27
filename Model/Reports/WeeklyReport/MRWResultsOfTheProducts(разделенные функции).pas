unit MRWResultsOfTheProducts;

interface

uses
  SysUtils, Variants, Dialogs, Data.Win.ADODB, Data.DB,
  GetAdoQuery,
  UCheckNull;
type
  IMRWResultsOfTheProducts = interface
    function GetErSuspWithResuspRastFiltrVolumeCity: string;
    function GetErSuspWithResuspRastFiltrDosesCity: string;
    function GetErSuspWithResuspRastFiltrVolumeArea: string;
    function GetErSuspWithResuspRastFiltrDosesArea: string;
    function GetErSuspWithResuspRastFiltrPercentCity: string;
    function GetErSuspWithResuspRastFiltrPercentArea: string;
    function GetErSuspWithResuspRastVolumeCity: string;
    function GetErSuspWithResuspRastDosesCity: string;
    function GetErSuspWithResuspRastVolumeArea: string;
    function GetErSuspWithResuspRastDosesArea: string;
    function GetErSuspWithResuspRastPercentCity: string;
    function GetErSuspWithResuspRastPercentArea: string;
    function GetErSuspWithFisioRastVolumeCity: string;
    function GetErSuspWithFisioRastDosesCity: string;
    function GetErSuspWithFisioRastVolumeArea: string;
    function GetErSuspWithFisioRastDosesArea: string;
    function GetErSuspWithFisioRastPercentCity: string;
    function GetErSuspWithFisioRastPercentArea: string;
    function GetSZPKarantVolumeCity: string;
    function GetSZPKarantDosesCity: string;
    function GetSZPKarantVolumeArea: string;
    function GetSZPKarantDosesArea: string;
    function GetSZPKarantPercentCity: string;
    function GetSZPKarantPercentArea: string;
    function GetSZPVirusInaktVolumeCity: string;
    function GetSZPVirusInaktDosesCity: string;
    function GetSZPVirusInaktVolumeArea: string;
    function GetSZPVirusInaktDosesArea: string;
    function GetSZPVirusInaktPercentCity: string;
    function GetSZPVirusInaktPercentArea: string;
    function GetKriopresipitatVolumeCity: string;
    function GetKriopresipitatDosesCity: string;
    function GetKriopresipitatVolumeArea: string;
    function GetKriopresipitatDosesArea: string;
    function GetKriopresipitatPercentCity: string;
    function GetKriopresipitatPercentArea: string;
    function GetTromboVolumeCity: string;
    function GetTromboDosesCity: string;
    function GetTromboVolumeArea: string;
    function GetTromboDosesArea: string;
    function GetTromboPercentCity: string;
    function GetTromboPercentArea: string;
    function GetPerftoranVolumeCity: string;
    function GetPerftoranDosesCity: string;
    function GetPerftoranVolumeArea: string;
    function GetPerftoranDosesArea: string;
    function GetPerftoranPercentCity: string;
    function GetPerftoranPercentArea: string;
  end;

  TMRWResultsOfTheProducts = class(TInterfacedObject, IMRWResultsOfTheProducts)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: ICheckNull;
    TempValue: Real;
    TempSQL: String;
    procedure GetSQL(CSQL: String);
  public
    function GetErSuspWithResuspRastFiltrVolumeCity: string;
    function GetErSuspWithResuspRastFiltrDosesCity: string;
    function GetErSuspWithResuspRastFiltrVolumeArea: string;
    function GetErSuspWithResuspRastFiltrDosesArea: string;
    function GetErSuspWithResuspRastFiltrPercentCity: string;
    function GetErSuspWithResuspRastFiltrPercentArea: string;
    function GetErSuspWithResuspRastVolumeCity: string;
    function GetErSuspWithResuspRastDosesCity: string;
    function GetErSuspWithResuspRastVolumeArea: string;
    function GetErSuspWithResuspRastDosesArea: string;
    function GetErSuspWithResuspRastPercentCity: string;
    function GetErSuspWithResuspRastPercentArea: string;
    function GetErSuspWithFisioRastVolumeCity: string;
    function GetErSuspWithFisioRastDosesCity: string;
    function GetErSuspWithFisioRastVolumeArea: string;
    function GetErSuspWithFisioRastDosesArea: string;
    function GetErSuspWithFisioRastPercentCity: string;
    function GetErSuspWithFisioRastPercentArea: string;
    function GetSZPKarantVolumeCity: string;
    function GetSZPKarantDosesCity: string;
    function GetSZPKarantVolumeArea: string;
    function GetSZPKarantDosesArea: string;
    function GetSZPKarantPercentCity: string;
    function GetSZPKarantPercentArea: string;
    function GetSZPVirusInaktVolumeCity: string;
    function GetSZPVirusInaktDosesCity: string;
    function GetSZPVirusInaktVolumeArea: string;
    function GetSZPVirusInaktDosesArea: string;
    function GetSZPVirusInaktPercentCity: string;
    function GetSZPVirusInaktPercentArea: string;
    function GetKriopresipitatVolumeCity: string;
    function GetKriopresipitatDosesCity: string;
    function GetKriopresipitatVolumeArea: string;
    function GetKriopresipitatDosesArea: string;
    function GetKriopresipitatPercentCity: string;
    function GetKriopresipitatPercentArea: string;
    function GetTromboVolumeCity: string;
    function GetTromboDosesCity: string;
    function GetTromboVolumeArea: string;
    function GetTromboDosesArea: string;
    function GetTromboPercentCity: string;
    function GetTromboPercentArea: string;
    function GetPerftoranVolumeCity: string;
    function GetPerftoranDosesCity: string;
    function GetPerftoranVolumeArea: string;
    function GetPerftoranDosesArea: string;
    function GetPerftoranPercentCity: string;
    function GetPerftoranPercentArea: string;
    constructor create;
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TMRWResultsOfTheProducts.create;
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
end;

procedure TMRWResultsOfTheProducts.GetSQL(CSQL: String);
begin
  Try
    With TempQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add(CSQL);
      Open;
      TempValue:=CheckNull.CheckedValue(TempQuery.Fields[0].value);
      Close;
    end;
  Except
  On e : EDatabaseError do
    messageDlg(e.message, mtError, [mbOK],0);
  End;
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrVolumeCity: string;
begin
  TempSQL:=
    'SELECT [Городские 1]![Sum-ЛЗО]/1000 AS [Городские 1л] ' +
    'FROM [Городские 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrDosesCity: string;
begin
  TempSQL:=
      'SELECT [Городские 1].[Sum-ЛЗД] AS [Городские 1д] ' +
      'FROM [Городские 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrVolumeArea: string;
begin
  TempSQL:=
    'SELECT [Районные 1]![Sum-ЛЗО]/1000 AS [Районные 1л] ' +
    'FROM [Районные 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrDosesArea: string;
begin
  TempSQL:=
    'SELECT [Районные 1].[Sum-ЛЗД] AS [Районные 1д] ' +
    'FROM [Районные 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrPercentCity: string;
begin
  TempSQL:=
      'SELECT [Городские 1].[Sum-ЛЗПР] AS [Городские 1пр] ' +
      'FROM [Городские 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrPercentArea: string;
begin
  TempSQL:=
    'SELECT [Районные 1].[Sum-ЛЗПР] AS [Районные 1пр] ' +
    'FROM [Районные 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastVolumeCity: string;
begin
  TempSQL:=
    'SELECT [Городские 2]![Sum-ЛЗО]/1000 AS [Городские 2л] ' +
    'FROM [Городские 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastDosesCity: string;
begin
  TempSQL:=
      'SELECT [Городские 2].[Sum-ЛЗД] AS [Городские 2д] ' +
      'FROM [Городские 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastVolumeArea: string;
begin
  TempSQL:=
    'SELECT [Районные 2]![Sum-ЛЗО]/1000 AS [Районные 2л] ' +
    'FROM [Районные 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastDosesArea: string;
begin
  TempSQL:=
    'SELECT [Районные 2].[Sum-ЛЗД] AS [Районные 2д] ' +
    'FROM [Районные 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastPercentCity: string;
begin
  TempSQL:=
      'SELECT [Городские 2].[Sum-ЛЗПР] AS [Городские 2пр] ' +
      'FROM [Городские 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastPercentArea: string;
begin
  TempSQL:=
    'SELECT [Районные 2].[Sum-ЛЗПР] AS [Районные 2пр] ' +
    'FROM [Районные 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastVolumeCity: string;
begin
  TempSQL:=
    'SELECT [Городские 3]![Sum-ЛЗО]/1000 AS [Городские 3л] ' +
    'FROM [Городские 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastDosesCity: string;
begin
  TempSQL:=
      'SELECT [Городские 3].[Sum-ЛЗД] AS [Городские 3д] ' +
      'FROM [Городские 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastVolumeArea: string;
begin
  TempSQL:=
    'SELECT [Районные 3]![Sum-ЛЗО]/1000 AS [Районные 3л] ' +
    'FROM [Районные 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastDosesArea: string;
begin
  TempSQL:=
    'SELECT [Районные 3].[Sum-ЛЗД] AS [Районные 3д] ' +
    'FROM [Районные 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastPercentCity: string;
begin
  TempSQL:=
      'SELECT [Городские 3].[Sum-ЛЗПР] AS [Городские 3пр] ' +
      'FROM [Городские 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastPercentArea: string;
begin
  TempSQL:=
    'SELECT [Районные 3].[Sum-ЛЗПР] AS [Районные 3пр] ' +
    'FROM [Районные 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantVolumeCity: string;
begin
  TempSQL:=
    'SELECT [Городские 4]![Sum-ЛЗО]/1000 AS [Городские 4л] ' +
    'FROM [Городские 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantDosesCity: string;
begin
  TempSQL:=
      'SELECT [Городские 4].[Sum-ЛЗД] AS [Городские 4д] ' +
      'FROM [Городские 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantVolumeArea: string;
begin
  TempSQL:=
    'SELECT [Районные 4]![Sum-ЛЗО]/1000 AS [Районные 4л] ' +
    'FROM [Районные 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantDosesArea: string;
begin
  TempSQL:=
    'SELECT [Районные 4].[Sum-ЛЗД] AS [Районные 4д] ' +
    'FROM [Районные 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantPercentCity: string;
begin
  TempSQL:=
      'SELECT [Городские 4].[Sum-ЛЗПР] AS [Городские 4пр] ' +
      'FROM [Городские 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantPercentArea: string;
begin
  TempSQL:=
    'SELECT [Районные 4].[Sum-ЛЗПР] AS [Районные 4пр] ' +
    'FROM [Районные 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktVolumeCity: string;
begin
  TempSQL:=
    'SELECT [Городские 5]![Sum-ЛЗО]/1000 AS [Городские 5л] ' +
    'FROM [Городские 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktDosesCity: string;
begin
  TempSQL:=
      'SELECT [Городские 5].[Sum-ЛЗД] AS [Городские 5д] ' +
      'FROM [Городские 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktVolumeArea: string;
begin
  TempSQL:=
    'SELECT [Районные 5]![Sum-ЛЗО]/1000 AS [Районные 5л] ' +
    'FROM [Районные 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktDosesArea: string;
begin
  TempSQL:=
    'SELECT [Районные 5].[Sum-ЛЗД] AS [Районные 5д] ' +
    'FROM [Районные 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktPercentCity: string;
begin
  TempSQL:=
      'SELECT [Городские 5].[Sum-ЛЗПР] AS [Городские 5пр] ' +
      'FROM [Городские 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktPercentArea: string;
begin
  TempSQL:=
    'SELECT [Районные 5].[Sum-ЛЗПР] AS [Районные 5пр] ' +
    'FROM [Районные 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatVolumeCity: string;
begin
  TempSQL:=
    'SELECT [Городские 6]![Sum-ЛЗО]/1000 AS [Городские 6л] ' +
    'FROM [Городские 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatDosesCity: string;
begin
  TempSQL:=
      'SELECT [Городские 6].[Sum-ЛЗД] AS [Городские 6д] ' +
      'FROM [Городские 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatVolumeArea: string;
begin
  TempSQL:=
    'SELECT [Районные 6]![Sum-ЛЗО]/1000 AS [Районные 6л] ' +
    'FROM [Районные 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatDosesArea: string;
begin
  TempSQL:=
    'SELECT [Районные 6].[Sum-ЛЗД] AS [Районные 6д] ' +
    'FROM [Районные 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatPercentCity: string;
begin
  TempSQL:=
      'SELECT [Городские 6].[Sum-ЛЗПР] AS [Городские 6пр] ' +
      'FROM [Городские 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatPercentArea: string;
begin
  TempSQL:=
    'SELECT [Районные 6].[Sum-ЛЗПР] AS [Районные 6пр] ' +
    'FROM [Районные 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboVolumeCity: string;
begin
  TempSQL:=
    'SELECT [Городские 7]![Sum-ЛЗО]/1000 AS [Городские 7л] ' +
    'FROM [Городские 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboDosesCity: string;
begin
  TempSQL:=
      'SELECT [Городские 7].[Sum-ЛЗД] AS [Городские 7д] ' +
      'FROM [Городские 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboVolumeArea: string;
begin
  TempSQL:=
    'SELECT [Районные 7]![Sum-ЛЗО]/1000 AS [Районные 7л] ' +
    'FROM [Районные 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboDosesArea: string;
begin
  TempSQL:=
    'SELECT [Районные 7].[Sum-ЛЗД] AS [Районные 7д] ' +
    'FROM [Районные 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboPercentCity: string;
begin
  TempSQL:=
      'SELECT [Городские 7].[Sum-ЛЗПР] AS [Городские 7пр] ' +
      'FROM [Городские 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboPercentArea: string;
begin
  TempSQL:=
    'SELECT [Районные 7].[Sum-ЛЗПР] AS [Районные 7пр] ' +
    'FROM [Районные 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranVolumeCity: string;
begin
  TempSQL:=
    'SELECT [Городские 8]![Sum-ЛЗО]/1000 AS [Городские 8л] ' +
    'FROM [Городские 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranDosesCity: string;
begin
  TempSQL:=
      'SELECT [Городские 8].[Sum-ЛЗД] AS [Городские 8д] ' +
      'FROM [Городские 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranVolumeArea: string;
begin
  TempSQL:=
    'SELECT [Районные 8]![Sum-ЛЗО]/1000 AS [Районные 8л] ' +
    'FROM [Районные 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranDosesArea: string;
begin
  TempSQL:=
    'SELECT [Районные 8].[Sum-ЛЗД] AS [Районные 8д] ' +
    'FROM [Районные 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranPercentCity: string;
begin
  TempSQL:=
      'SELECT [Городские 8].[Sum-ЛЗПР] AS [Городские 8пр] ' +
      'FROM [Городские 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranPercentArea: string;
begin
  TempSQL:=
    'SELECT [Районные 8].[Sum-ЛЗПР] AS [Районные 8пр] ' +
    'FROM [Районные 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;
end.
