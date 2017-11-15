unit Query2Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus,  Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids,
  Vcl.DBCtrls, Generics.Collections, Contnrs, Bde.DBTables, Query1Unit1,
  Vcl.ComCtrls, GetDataSoursUnit1;

type
  FormQuery2 = class (TObject)
  private
    StartDate: TLabel;
    EndDate: TLabel;
    StartDateCal: TDateTimePicker;
    EndDateCal: TDateTimePicker;
    ButtonBack: TBitBtn;
    ButtonAction: TBitBtn;
    NameStat1: Tlabel;
    NameStat2: Tlabel;
    NameStat3: Tlabel;
    NameStat4: Tlabel;
    NameStat5: Tlabel;
    NameStat6: Tlabel;
    NameStat7: Tlabel;
    ResultEdit1: TEdit;
    ResultEdit2: TEdit;
    ResultEdit3: TEdit;
    ResultEdit4: TEdit;
    ResultEdit5: TEdit;
    ResultEdit6: TEdit;
    ResultEdit7: TEdit;
  public
    function GetLabelStartDate(NameForm: TwinControl): TLabel;
    function GetLabelEndDate(NameForm: TwinControl): TLabel;
    function GetCalendarStartDate(NameForm: TwinControl): TDateTimePicker;
    function GetCalendarEndDate(NameForm: TwinControl): TDateTimePicker;
    function GetButtonBack(NameForm: TwinControl): TBitBtn;
    function GetLabelNameStat1(NameForm: TwinControl): Tlabel;
    function GenEdit1(NameForm: TwinControl): TEdit;
    function GetLabelNameStat2(NameForm: TwinControl): Tlabel;
    function GenEdit2(NameForm: TwinControl): TEdit;
    function GetLabelNameStat3(NameForm: TwinControl): Tlabel;
    function GenEdit3(NameForm: TwinControl): TEdit;
    function GetLabelNameStat4(NameForm: TwinControl): Tlabel;
    function GenEdit4(NameForm: TwinControl): TEdit;
    function GetLabelNameStat5(NameForm: TwinControl): Tlabel;
    function GenEdit5(NameForm: TwinControl): TEdit;
    function GetLabelNameStat6(NameForm: TwinControl): Tlabel;
    function GenEdit6(NameForm: TwinControl): TEdit;
    function GetLabelNameStat7(NameForm: TwinControl): Tlabel;
    function GenEdit7(NameForm: TwinControl): TEdit;
    //  procedure ButtonBackClick(Sender: TObject);
    function GetButtonAction(NameForm: TwinControl): TBitBtn;
  end;
implementation

end.
