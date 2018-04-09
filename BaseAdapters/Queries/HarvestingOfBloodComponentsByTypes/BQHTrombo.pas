unit BQHTrombo;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, CodeSiteLogging, Dialogs, Data.DB,
  USCheckNull,
  GetAdoConnect;

type
  IBQHTrombo = interface
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumber(i: integer): string;
    function GetPacet(i: integer): string;
    function GetRowCount: integer;
  end;

  TResultRecord = Record
  private
    Name: String;
    Volume: String;
    Number: String;
    Pacet: String;
  end;

  TBQHTrombo = class(TInterfacedObject, IBQHTrombo)
  private
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TUSCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetName(i: integer): string;
    function GetVolume(i: integer): string;
    function GetNumber(i: integer): string;
    function GetPacet(i: integer): string;
    function GetRowCount: integer;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfTromboDonations }

constructor TBQHTrombo.create(DateStart, DateEnd: TDate);
var
  i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    TempQuery.SQL.Add
      ('SELECT TrombComponents.ВидТ, Sum(TrombComponents.КПЛТ), Sum(TrombComponents.ДПЛТ), Sum(TrombComponents.ПакТ) '
      + 'FROM TrombDoza INNER JOIN TrombComponents ON TrombDoza.КодТ = TrombComponents.КодДТ '
      + 'WHERE (((TrombDoza.ДатаТ) Between #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateStart) + '# And #' +
      FormatDateTime('mm''/''dd''/''yyyy', DateEnd) +
      '#)) GROUP BY TrombComponents.ВидТ;');
    TempQuery.Open;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i := 0 to TempQuery.RecordCount - 1 do
    begin
      ResultMass[i].Name :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Volume :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].Number :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      ResultMass[i].Pacet :=
        VarToStr(CheckNull.CheckedValue(TempQuery.Fields[3].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHTrombo.create выполнена');
end;

function TBQHTrombo.GetRowCount: integer;
begin
  result := Length(ResultMass);

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHTrombo.GetRowCount выполнена');
end;

function TBQHTrombo.GetVolume(i: integer): string;
begin
  result := ResultMass[i].Volume;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHTrombo.GetVolume выполнена');
end;

function TBQHTrombo.GetName(i: integer): string;
begin
  result := ResultMass[i].Name;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHTrombo.GetName выполнена');
end;

function TBQHTrombo.GetNumber(i: integer): string;
begin
  result := ResultMass[i].Number;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHTrombo.GetNumber выполнена');
end;

function TBQHTrombo.GetPacet(i: integer): string;
begin
  result := ResultMass[i].Pacet;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQHTrombo.GetPacet выполнена');
end;

end.
