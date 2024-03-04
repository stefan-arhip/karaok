unit _Options_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Spin, ColorGrd, Menus;

Const SnapSize:Integer=30;  

type
  TOptions_ = class(TForm)
    Shape3: TShape;
    Label11: TLabel;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    Shape2: TShape;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit3: TSpinEdit;
    Label1: TLabel;
    Shape1: TShape;
    ColorGrid1: TColorGrid;
    ColorGrid2: TColorGrid;
    Shape4: TShape;
    Label5: TLabel;
    Shape5: TShape;
    CheckBox1: TCheckBox;
    Label15: TLabel;
    Shape6: TShape;
    Label6: TLabel;
    SpinEdit4: TSpinEdit;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Volume1: TMenuItem;
    Position1: TMenuItem;
    Lyricsadjust1: TMenuItem;
    Factorsadjust1: TMenuItem;
    Automaticopen1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Close1: TMenuItem;
    CheckBox2: TCheckBox;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure FormPaint(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Volume1Click(Sender: TObject);
    procedure Position1Click(Sender: TObject);
    procedure Lyricsadjust1Click(Sender: TObject);
    procedure Factorsadjust1Click(Sender: TObject);
    procedure Automaticopen1Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function Execute:Boolean;
  end;

var
  Options_: TOptions_;

implementation

uses _Main_;

{$R *.DFM}

procedure TOptions_.FormPaint(Sender: TObject);
Var Row,Ht:Word;
    r,g,b:Byte;
begin
  Ht:=(ClientHeight+255) div 256;
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
      end;
end;

function TOptions_.Execute: Boolean;
begin
  Result:=(ShowModal=mrOK);
end;

procedure TOptions_.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TOptions_.FormCreate(Sender: TObject);
begin
  SpeedButton1.Hint:='Close the options window'#13'[shortcut Esc]';
  SpeedButton2.Hint:='Open the options window'#13'[shortcut F2]';
  SpeedButton3.Hint:='Open the help window'#13'[shortcut F1]';
  SpeedButton4.Hint:='Close the options window'#13'[shortcut Enter]';
  CheckBox1.Hint:='Automatic open the lyrics file with audio file'#13'[shortcut A]';
  Label15.Hint:='Automatic open the lyrics file with audio file'#13'[shortcut A]';
  SpinEdit1.Hint:='Frequency value of volume'#13'[shortcut V]';
  SpinEdit2.Hint:='Frequency value of position'#13'[shortcut P]';
  SpinEdit3.Hint:='Frequency value of lyrics'#13'[shortcut L]';
  SpinEdit4.Hint:='Value of factor''s adjust'#13'[shortcut F]';
end;

procedure TOptions_.Volume1Click(Sender: TObject);
begin
  SpinEdit1.SetFocus;
end;

procedure TOptions_.Position1Click(Sender: TObject);
begin
  SpinEdit2.SetFocus;
end;

procedure TOptions_.Lyricsadjust1Click(Sender: TObject);
begin
  SpinEdit3.SetFocus;
end;

procedure TOptions_.Factorsadjust1Click(Sender: TObject);
begin
  SpinEdit4.SetFocus;
end;

procedure TOptions_.Automaticopen1Click(Sender: TObject);
begin
  CheckBox1.Checked:=Not CheckBox1.Checked;
end;

procedure TOptions_.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Options_.Handle,WM_SYSCOMMAND,$F012,0);
end;

procedure TOptions_.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

end.
