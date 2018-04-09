unit BQBTheAmountOfReinfusionWithAPA;

interface

uses
  SysUtils, Variants, Dialogs, CodeSiteLogging, Data.Win.ADODB, Data.DB,
  GetAdoConnect,
  USCheckNull;

type
  IBQBTheAmountOfReinfusionWithAPA = interface
    function GetValue: string;
  end;

  TBQBTheAmountOfReinfusionWithAPA = class(TInterfacedObject,
    IBQBTheAmountOfReinfusionWithAPA)
  private
    AmountOfRWAPA: string;
    TempConnect: ITempAdoQuery;
    TempQuery: TADOQuery;
    CheckNull: IUSCheckNull;
  public
    function GetValue: string;
    constructor create(DateStart, DateEnd: TDate);
  end;

implementation

{ TTheNumberOfBloodDonations }

constructor TBQBTheAmountOfReinfusionWithAPA.create(DateStart, DateEnd: TDate);
begin
  if not Assigned(TempConnect) then
    TempConnect := TTempAdoQuery.create;
  if not Assigned(CheckNull) then
    CheckNull := TUSCheckNull.create;
  if not Assigned(TempQuery) then
    TempQuery := TADOQuery.create(nil);
  TempQuery.Connection := TempConnect.GetConnect;
  TempQuery.Close;
  TempQuery.SQL.Clear;
  Try
    TempQuery.SQL.Add
      ('SELECT Sum(Plasma.КонП), Sum(PlasmaComponents.КПЛП), Sum(PlazmaBrak.КБРП) '
      + 'FROM (Plasma INNER JOIN PlazmaDoza ON Plasma.ДатаП=PlazmaDoza.ДатаП) '
      + 'INNER JOIN (PlasmaComponents INNER JOIN PlazmaBrak ' +
      'ON PlasmaComponents.КодДП = PlazmaBrak.КодКП) ON ' +
      'PlazmaDoza.КодПл = PlasmaComponents.КодДП ' +
      'WHERE (Plasma.ДатаП) Between #' + FormatDateTime('mm''/''dd''/''yyyy',
      DateStart) + '# And #' + FormatDateTime('mm''/''dd''/''yyyy',
      DateEnd) + '#');
    TempQuery.Open;
  except
    On e: EDatabaseError do
      messageDlg(e.message, mtError, [mbOK], 0);
  End;
  AmountOfRWAPA := VarToStr(CheckNull.CheckedValue(TempQuery.Fields[0].value) -
    CheckNull.CheckedValue(TempQuery.Fields[1].value) - CheckNull.CheckedValue
    (TempQuery.Fields[2].value));
  TempQuery.Close;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQBTheAmountOfReinfusionWithAPA.create выполнена');
end;

function TBQBTheAmountOfReinfusionWithAPA.GetValue: string;
begin
  result := AmountOfRWAPA;

  CodeSite.Send(FormatDateTime('c', Now) + ' TBQBTheAmountOfReinfusionWithAPA.GetValue выполнена');
end;

end.
