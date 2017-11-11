unit MainFormUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, Menus, ConnectingUnit1, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids;

type
  TMyMainForm = class(TForm)
    Label1: TLabel;
    MainMenu1: TMainMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    Help1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    HandlyHarvesting: TMenuItem;
    AutoAferez: TMenuItem;
    Citoferez: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N7: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N1: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Label2: TLabel;
    procedure N4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    connect: Connecting;
    fConnecting: Connecting;
    TableBlood: BloodTable;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  MyMainForm: TMyMainForm;
  MyList: TMyList;
implementation

{$R *.dfm}

procedure TMyMainForm.Button1Click(Sender: TObject);
//var
//DataSet : TDataSet;
begin
  TableBlood:=BloodTable.Create;
  MyList:= TMyList.Create(true);
  fConnecting:= Connecting.Create;
  fConnecting.GetDataQuery('SELECT [ÊÄÊ] FROM Blood');

  while not fConnecting.GetQuery.DataSet.Eof do
begin
  MyList.AddNew(fConnecting.GetQuery.DataSet.Fields.Fields[0].AsInteger);
  fConnecting.GetQuery.DataSet.next;

end;

end;

procedure TMyMainForm.FormCreate(Sender: TObject);
begin
  connect:=connecting.create;
  //dbGrid1.DataSource:=connect.GetDataSource('SELECT * FROM Blood');

end;


procedure TMyMainForm.N4Click(Sender: TObject);
begin
  Close;
end;

end.
