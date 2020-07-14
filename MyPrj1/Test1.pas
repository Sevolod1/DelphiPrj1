unit Test1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.EditBox, FMX.NumberBox,
  FMX.DateTimeCtrls, System.ImageList, FMX.ImgList, FMX.StdCtrls, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Layouts, FMX.TreeView;

type
  TForm1 = class(TForm)
    DE1: TDateEdit;
    NB1: TNumberBox;
    Ed1: TEdit;
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    SpeedButton2: TSpeedButton;
    SaveD: TSaveDialog;
    OpenD: TOpenDialog;
    TV1: TTreeView;
    SG1: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StyleBook1: TStyleBook;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SG1DrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;



implementation
{$R *.fmx}

uses JSON, System.IOUtils;


procedure TForm1.FormCreate(Sender: TObject);
var tvi, tvi1 : TTReeViewItem;
begin
  tvi := TTReeViewItem.Create(TV1);
  tvi.Text := 'item1';
  tvi.ResultingTextSettings.Font.Size:= 8;
  tvi.ResultingTextSettings.FontColor:= TAlphaColorRec.Red;
  TV1.AddObject(tvi);
  tvi1 := TTReeViewItem.Create(tv1);
  tvi1.Text := 'item2';
  tvi.AddObject(tvi1);
  Sg1.RowCount := 3;
  Sg1.Columns[0].Header := 'Title1';
  Sg1.Cells[0, 0] := 'Info1';
  Sg1.Columns[1].Header := 'Title2';
  Sg1.Cells[1, 0] := 'Info2';
  Sg1.Cells[1, 1] := 'Info3';
end;

procedure TForm1.SG1DrawColumnCell(Sender: TObject; const Canvas: TCanvas;
  const Column: TColumn; const Bounds: TRectF; const Row: Integer;
  const Value: TValue; const State: TGridDrawStates);
var
  aRowColor: TBrush;
begin
   aRowColor := Tbrush.Create(TBrushKind.Solid,TAlphaColors.Alpha);
   if Row = 1 then
      aRowColor.Color := TAlphaColors.Red
   else
      aRowColor.Color := TAlphaColors.Gray;
   Canvas.FillRect(Bounds, 0, 0, [], 1, aRowColor);
   Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);
   aRowColor.Free;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  lJsonObj: TJSONObject;
begin
  if SaveD.Execute then
  begin
    lJsonObj:= TJSONObject.Create;
    lJsonObj.AddPair('DE1', de1.text);
    lJsonObj.AddPair('NE1', TJSONNumber.Create(NB1.Value));
    lJsonObj.AddPair('Ed1', Ed1.text);
    TFile.WriteAllText(SaveD.FileName, lJsonObj.ToString);
    lJsonObj.Free;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  vJSON: TJSONObject;
  sStr: String;
begin
  if OpenD.Execute then
  begin
    sStr:= TFile.ReadAlltext(OpenD.FileName);
    vJSON := TJSONObject.ParseJSONValue(sStr, false, true) as TJsonObject;
    de1.text := vJSON.Values['DE1'].Value;
    NB1.Text := vJSON.Values['NE1'].Value;
    Ed1.Text := vJSON.Values['Ed1'].Value;
    vJSON.Free;
  end;
end;

end.
