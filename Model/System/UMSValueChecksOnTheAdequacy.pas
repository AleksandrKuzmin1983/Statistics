unit UMSValueChecksOnTheAdequacy;

interface
uses
  Data.DB, Dialogs, Data.Win.ADODB, SysUtils,
  UCheckNull,
  UMSCheckFillStringFields,
  GetAdoQuery;
type
  IUMSValueChecksOnTheAdequacy = interface
    function CheckZeroValues(Value: String; TheMessage: String): boolean;
    function CheckingEqualities(Value1, Value2: integer; TheMessage: String): boolean;
  end;

  TUMSValueChecksOnTheAdequacy = class(TInterfacedObject,
    IUMSValueChecksOnTheAdequacy)
  private
    CheckFillStrFields: ICheckFillStringFields;
  public
    function CheckZeroValues(Value: String; TheMessage: String): boolean;
    function CheckingEqualities(Value1, Value2: integer; TheMessage: String): boolean;
  end;

implementation

{ TMHMCheckForExistenceOfRecord }

function TUMSValueChecksOnTheAdequacy.CheckingEqualities(Value1, Value2: integer;
  TheMessage: String): boolean;
begin
  if Value1<>Value2 then
  begin
    ShowMessage(TheMessage);
    result:=true;
  end
  else
    result:=false;
end;

function TUMSValueChecksOnTheAdequacy.CheckZeroValues(Value: String; TheMessage: String): boolean;
begin
    if not Assigned(CheckFillStrFields) then
      CheckFillStrFields := TCheckFillStringFields.create;
    Value:=CheckFillStrFields.CheckStringFields(Value);
    try
      if StrToInt(Value)=0 then
      begin
        ShowMessage(TheMessage);
        result:=true;
      end
      else
        result:=false;
     Except
       on EConvertError do ShowMessage('ƒанное значение (' + Value + ') не €вл€етс€ целым числом!');
     end;
end;

end.


