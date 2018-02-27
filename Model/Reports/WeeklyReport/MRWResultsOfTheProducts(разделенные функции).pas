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
    'SELECT [��������� 1]![Sum-���]/1000 AS [��������� 1�] ' +
    'FROM [��������� 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrDosesCity: string;
begin
  TempSQL:=
      'SELECT [��������� 1].[Sum-���] AS [��������� 1�] ' +
      'FROM [��������� 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrVolumeArea: string;
begin
  TempSQL:=
    'SELECT [�������� 1]![Sum-���]/1000 AS [�������� 1�] ' +
    'FROM [�������� 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrDosesArea: string;
begin
  TempSQL:=
    'SELECT [�������� 1].[Sum-���] AS [�������� 1�] ' +
    'FROM [�������� 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrPercentCity: string;
begin
  TempSQL:=
      'SELECT [��������� 1].[Sum-����] AS [��������� 1��] ' +
      'FROM [��������� 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastFiltrPercentArea: string;
begin
  TempSQL:=
    'SELECT [�������� 1].[Sum-����] AS [�������� 1��] ' +
    'FROM [�������� 1];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastVolumeCity: string;
begin
  TempSQL:=
    'SELECT [��������� 2]![Sum-���]/1000 AS [��������� 2�] ' +
    'FROM [��������� 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastDosesCity: string;
begin
  TempSQL:=
      'SELECT [��������� 2].[Sum-���] AS [��������� 2�] ' +
      'FROM [��������� 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastVolumeArea: string;
begin
  TempSQL:=
    'SELECT [�������� 2]![Sum-���]/1000 AS [�������� 2�] ' +
    'FROM [�������� 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastDosesArea: string;
begin
  TempSQL:=
    'SELECT [�������� 2].[Sum-���] AS [�������� 2�] ' +
    'FROM [�������� 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastPercentCity: string;
begin
  TempSQL:=
      'SELECT [��������� 2].[Sum-����] AS [��������� 2��] ' +
      'FROM [��������� 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithResuspRastPercentArea: string;
begin
  TempSQL:=
    'SELECT [�������� 2].[Sum-����] AS [�������� 2��] ' +
    'FROM [�������� 2];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastVolumeCity: string;
begin
  TempSQL:=
    'SELECT [��������� 3]![Sum-���]/1000 AS [��������� 3�] ' +
    'FROM [��������� 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastDosesCity: string;
begin
  TempSQL:=
      'SELECT [��������� 3].[Sum-���] AS [��������� 3�] ' +
      'FROM [��������� 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastVolumeArea: string;
begin
  TempSQL:=
    'SELECT [�������� 3]![Sum-���]/1000 AS [�������� 3�] ' +
    'FROM [�������� 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastDosesArea: string;
begin
  TempSQL:=
    'SELECT [�������� 3].[Sum-���] AS [�������� 3�] ' +
    'FROM [�������� 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastPercentCity: string;
begin
  TempSQL:=
      'SELECT [��������� 3].[Sum-����] AS [��������� 3��] ' +
      'FROM [��������� 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetErSuspWithFisioRastPercentArea: string;
begin
  TempSQL:=
    'SELECT [�������� 3].[Sum-����] AS [�������� 3��] ' +
    'FROM [�������� 3];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantVolumeCity: string;
begin
  TempSQL:=
    'SELECT [��������� 4]![Sum-���]/1000 AS [��������� 4�] ' +
    'FROM [��������� 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantDosesCity: string;
begin
  TempSQL:=
      'SELECT [��������� 4].[Sum-���] AS [��������� 4�] ' +
      'FROM [��������� 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantVolumeArea: string;
begin
  TempSQL:=
    'SELECT [�������� 4]![Sum-���]/1000 AS [�������� 4�] ' +
    'FROM [�������� 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantDosesArea: string;
begin
  TempSQL:=
    'SELECT [�������� 4].[Sum-���] AS [�������� 4�] ' +
    'FROM [�������� 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantPercentCity: string;
begin
  TempSQL:=
      'SELECT [��������� 4].[Sum-����] AS [��������� 4��] ' +
      'FROM [��������� 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPKarantPercentArea: string;
begin
  TempSQL:=
    'SELECT [�������� 4].[Sum-����] AS [�������� 4��] ' +
    'FROM [�������� 4];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktVolumeCity: string;
begin
  TempSQL:=
    'SELECT [��������� 5]![Sum-���]/1000 AS [��������� 5�] ' +
    'FROM [��������� 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktDosesCity: string;
begin
  TempSQL:=
      'SELECT [��������� 5].[Sum-���] AS [��������� 5�] ' +
      'FROM [��������� 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktVolumeArea: string;
begin
  TempSQL:=
    'SELECT [�������� 5]![Sum-���]/1000 AS [�������� 5�] ' +
    'FROM [�������� 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktDosesArea: string;
begin
  TempSQL:=
    'SELECT [�������� 5].[Sum-���] AS [�������� 5�] ' +
    'FROM [�������� 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktPercentCity: string;
begin
  TempSQL:=
      'SELECT [��������� 5].[Sum-����] AS [��������� 5��] ' +
      'FROM [��������� 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetSZPVirusInaktPercentArea: string;
begin
  TempSQL:=
    'SELECT [�������� 5].[Sum-����] AS [�������� 5��] ' +
    'FROM [�������� 5];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatVolumeCity: string;
begin
  TempSQL:=
    'SELECT [��������� 6]![Sum-���]/1000 AS [��������� 6�] ' +
    'FROM [��������� 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatDosesCity: string;
begin
  TempSQL:=
      'SELECT [��������� 6].[Sum-���] AS [��������� 6�] ' +
      'FROM [��������� 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatVolumeArea: string;
begin
  TempSQL:=
    'SELECT [�������� 6]![Sum-���]/1000 AS [�������� 6�] ' +
    'FROM [�������� 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatDosesArea: string;
begin
  TempSQL:=
    'SELECT [�������� 6].[Sum-���] AS [�������� 6�] ' +
    'FROM [�������� 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatPercentCity: string;
begin
  TempSQL:=
      'SELECT [��������� 6].[Sum-����] AS [��������� 6��] ' +
      'FROM [��������� 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetKriopresipitatPercentArea: string;
begin
  TempSQL:=
    'SELECT [�������� 6].[Sum-����] AS [�������� 6��] ' +
    'FROM [�������� 6];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboVolumeCity: string;
begin
  TempSQL:=
    'SELECT [��������� 7]![Sum-���]/1000 AS [��������� 7�] ' +
    'FROM [��������� 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboDosesCity: string;
begin
  TempSQL:=
      'SELECT [��������� 7].[Sum-���] AS [��������� 7�] ' +
      'FROM [��������� 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboVolumeArea: string;
begin
  TempSQL:=
    'SELECT [�������� 7]![Sum-���]/1000 AS [�������� 7�] ' +
    'FROM [�������� 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboDosesArea: string;
begin
  TempSQL:=
    'SELECT [�������� 7].[Sum-���] AS [�������� 7�] ' +
    'FROM [�������� 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboPercentCity: string;
begin
  TempSQL:=
      'SELECT [��������� 7].[Sum-����] AS [��������� 7��] ' +
      'FROM [��������� 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetTromboPercentArea: string;
begin
  TempSQL:=
    'SELECT [�������� 7].[Sum-����] AS [�������� 7��] ' +
    'FROM [�������� 7];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranVolumeCity: string;
begin
  TempSQL:=
    'SELECT [��������� 8]![Sum-���]/1000 AS [��������� 8�] ' +
    'FROM [��������� 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranDosesCity: string;
begin
  TempSQL:=
      'SELECT [��������� 8].[Sum-���] AS [��������� 8�] ' +
      'FROM [��������� 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranVolumeArea: string;
begin
  TempSQL:=
    'SELECT [�������� 8]![Sum-���]/1000 AS [�������� 8�] ' +
    'FROM [�������� 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0.000',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranDosesArea: string;
begin
  TempSQL:=
    'SELECT [�������� 8].[Sum-���] AS [�������� 8�] ' +
    'FROM [�������� 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue));
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranPercentCity: string;
begin
  TempSQL:=
      'SELECT [��������� 8].[Sum-����] AS [��������� 8��] ' +
      'FROM [��������� 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;

function TMRWResultsOfTheProducts.GetPerftoranPercentArea: string;
begin
  TempSQL:=
    'SELECT [�������� 8].[Sum-����] AS [�������� 8��] ' +
    'FROM [�������� 8];';
  GetSQL(TempSQL);
  result:=VarToStr(FormatFloat('0',TempValue)) + '%';
  if TempValue=0 then result:=' ';
end;
end.
