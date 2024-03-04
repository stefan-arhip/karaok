unit _Fullscreen_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, Buttons;

type
  TFullscreen_ = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Shape3: TShape;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure Exit1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResizer1PostResize(Sender: TObject; Comp: TControl; HeightRatio, WidthRatio: Double);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fullscreen_: TFullscreen_;

implementation

uses _Options_;

{$R *.DFM}

procedure TFullscreen_.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TFullscreen_.FormResize(Sender: TObject);
begin
  //FormResizer1.ResizeAll;
  Label6.Font.Size:=Round(12*Width/500);
  Label6.Left:=8;
  Label6.Top:=Round(126*Width/500);
  Label6.Width:=Round(485*Width/500);
  Label6.Height:=Round(18*Width/500);
  Label7.Font.Size:=Round(12*Width/500);
  Label7.Left:=8;
  Label7.Top:=Round(148*Width/500);
  Label7.Width:=Round(485*Width/500);
  Label7.Height:=Round(18*Width/500);
  Label8.Font.Size:=Round(12*Width/500);
  Label8.Left:=8;
  Label8.Top:=Round(170*Width/500);
  Label8.Width:=Round(485*Width/500);
  Label8.Height:=Round(18*Width/500);
  SpeedButton3.Top:=8;
  SpeedButton3.Left:=Width-75;
  SpeedButton2.Top:=8;
  SpeedButton2.Left:=Width-55;
  SpeedButton1.Top:=8;
  SpeedButton1.Left:=Width-35;
end;

procedure TFullscreen_.FormCreate(Sender: TObject);
begin
  Label6.Caption:='';
  Label7.Caption:='';
  Label8.Caption:='';
end;

procedure TFullscreen_.FormResizer1PostResize(Sender: TObject; Comp: TControl; HeightRatio, WidthRatio: Double);
begin
  Label6.Width:=Width;
  Label7.Width:=Width;
  Label8.Width:=Width;
  Label6.Alignment:=taCenter;
  Label7.Alignment:=taCenter;
  Label8.Alignment:=taCenter;
  SpeedButton1.Width:=20;
  SpeedButton1.Height:=20;
  SpeedButton1.Left:=Width-SpeedButton1.Width-13;
  SpeedButton1.Top:=36;
  SpeedButton2.Width:=20;
  SpeedButton2.Height:=20;
  SpeedButton2.Left:=Width-SpeedButton1.Width-SpeedButton2.Width-13;
  SpeedButton2.Top:=36;
  SpeedButton3.Width:=20;
  SpeedButton3.Height:=20;
  SpeedButton3.Left:=Width-SpeedButton1.Width-SpeedButton2.Width-SpeedButton3.Width-13;
  SpeedButton3.Top:=36;
end;

procedure TFullscreen_.FormPaint(Sender: TObject);
Var Row,Ht:Word;
    r,g,b:Byte;
begin
  //Label2.Font.Color:=clSilver;
(*  Ht:=(ClientHeight+255) div 256;
  for Row:=0 to ClientHeight do
    with Canvas do
      begin
        r:=Row*(GetRValue(Options_.ColorGrid1.ForegroundColor)-
                GetRValue(Options_.ColorGrid2.ForegroundColor)) Div ClientHeight;
        g:=Row*(GetGValue(Options_.ColorGrid1.ForegroundColor)-
                GetGValue(Options_.ColorGrid2.ForegroundColor)) Div ClientHeight;
        b:=Row*(GetBValue(Options_.ColorGrid1.ForegroundColor)-
                GetBValue(Options_.ColorGrid2.ForegroundColor)) Div ClientHeight;
        Brush.Color:=RGB(r,g,b);
        FillRect(Rect(0,Row*Ht,ClientWidth,(Row+1)*Ht));
      end;*)
end;

end.
