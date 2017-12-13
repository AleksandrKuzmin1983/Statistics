unit MIOCCheckLPU;

interface

uses
  SysUtils, Variants, Data.Win.ADODB, Dialogs,
  UCheckNull,
  GetAdoQuery;

type
  IMIOCCheckLPU = interface
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetCheckLPU(i: integer): string;
    function GetRowCount: integer;
    procedure OpenConnect;
    procedure Insert;
    procedure post;
    procedure CloseConnect;
    procedure ExecSQL;
    procedure Clear;
    procedure AddSQL(SQL: string);
    procedure WriteValue(NumberField: integer; Value: Variant);
  end;

  TResultRecord=Record
  private
    Kod: string;
    Date: String;
    CheckLPU: String;

  end;

  TMIOCCheckLPU = class(TInterfacedObject,
    IMIOCCheckLPU)
  private
    SQL: String;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: TCheckNull;
    ResultMass: array of TResultRecord;
  public
    function GetKod(i: integer): string;
    function GetDate(i: integer): string;
    function GetCheckLPU(i: integer): string;
    function GetRowCount: integer;
    procedure OpenConnect;
    procedure Insert;
    procedure post;
    procedure CloseConnect;
    procedure ExecSQL;
    procedure Clear;
    procedure AddSQL(SQL: string);
    constructor create;
    procedure WriteValue(NumberField: integer; Value: Variant);
  end;

implementation

{ TTheNumberOfTromboDonations }

procedure TMIOCCheckLPU.AddSQL(SQL: string);
begin
  TempQuery.SQL.Add(SQL);
end;

procedure TMIOCCheckLPU.Clear;
begin
  TempQuery.SQL.Clear;
end;

procedure TMIOCCheckLPU.CloseConnect;
begin
  TempQuery.Close;
end;

constructor TMIOCCheckLPU.create;
var i: integer;
begin
  if not Assigned(CheckNull) then
    CheckNull := TCheckNull.create;
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  SQL:='SELECT Consultations. Ó‰, Consultations.ƒ‡Ú‡ ÓÌ, Consultations.œÀœ” ' +
  'FROM Consultations ' +
  'WHERE not (Consultations.œÀœ” = 0) ' +
  'ORDER BY Consultations.ƒ‡Ú‡ ÓÌ desc;';
  TempQuery.SQL.Add(SQL);
  TempQuery.Open;
  if not TempQuery.IsEmpty then
  begin
    SetLength(ResultMass, TempQuery.RecordCount);
    TempQuery.Recordset.MoveFirst;
    for i:=0 to TempQuery.RecordCount-1 do
    begin
      ResultMass[i].Kod:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value));
      ResultMass[i].Date:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[1].value));
      ResultMass[i].CheckLPU:=VarToStr(CheckNull.CheckedValue(TempQuery.Fields[2].value));
      TempQuery.Next;
    end;
  end;
  TempQuery.Close;
end;

procedure TMIOCCheckLPU.ExecSQL;
begin
  TempQuery.ExecSQL;
end;

function TMIOCCheckLPU.GetRowCount: integer;
begin
  result:=Length(ResultMass);
end;

procedure TMIOCCheckLPU.Insert;
begin
  TempQuery.Insert;
end;

procedure TMIOCCheckLPU.OpenConnect;
begin
  TempQuery.Open;
end;

procedure TMIOCCheckLPU.post;
begin
  TempQuery.Post;
end;

procedure TMIOCCheckLPU.WriteValue(NumberField: integer;
  Value: Variant);
begin
  TempQuery.Fields[NumberField].Value:=Value;
end;

function TMIOCCheckLPU.GetCheckLPU(i: integer): string ;
begin
  result := ResultMass[i].CheckLPU;
end;

function TMIOCCheckLPU.GetDate(i: integer): string;
begin
  result := ResultMass[i].Date;
end;

function TMIOCCheckLPU.GetKod(i: integer): string;
begin
  result := ResultMass[i].Kod;
end;

end.
