unit _Help_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, TrMemo, Menus;

type
  THelp_ = class(TForm)
    Shape3: TShape;
    Label8: TLabel;
    ProgramIcon: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Shape4: TShape;
    Shape1: TShape;
    Shape2: TShape;
    CheckBox1: TCheckBox;
    Label7: TLabel;
    Shape5: TShape;
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Showmore1: TMenuItem;
    N1: TMenuItem;
    Close1: TMenuItem;
    Exit1: TMenuItem;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure FormPaint(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Showmore1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    Function Execute:Boolean;
  end;

var
  Help_: THelp_;

implementation

uses _Main_, _Options_;

{$R *.DFM}

function THelp_.Execute: Boolean;
begin
  Result:=(ShowModal=mrOK);
end;

procedure THelp_.FormPaint(Sender: TObject);
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

procedure THelp_.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure THelp_.FormCreate(Sender: TObject);
begin
  SpeedButton1.Hint:='Close help window'#13'[shortcut Esc]';
  SpeedButton2.Hint:='Open the options window'#13'[shortcut F2]';
  SpeedButton3.Hint:='Open the help window'#13'[shortcut F1]';
  CheckBox1.Hint:='Show more information'#13'[shortcut M]';
  Label7.Hint:='Show more information'#13'[shortcut M]';
  SpeedButton4.Hint:='Close help window'#13'[shortcut Enter]';
end;

procedure THelp_.CheckBox1Click(Sender: TObject);
begin
  Shape1.Visible:=Not CheckBox1.Checked;
  Shape2.Visible:=Not CheckBox1.Checked;
  Shape3.Visible:=Not CheckBox1.Checked;
  Shape4.Visible:=Not CheckBox1.Checked;
  Label1.Visible:=Not CheckBox1.Checked;
  Label2.Visible:=Not CheckBox1.Checked;
  Label3.Visible:=Not CheckBox1.Checked;
  Label4.Visible:=Not CheckBox1.Checked;
  Label5.Visible:=Not CheckBox1.Checked;
  Label6.Visible:=Not CheckBox1.Checked;
  ProgramIcon.Visible:=Not CheckBox1.Checked;
  Shape5.Visible:=CheckBox1.Checked;
  Memo1.Visible:=CheckBox1.Checked;
end;

procedure THelp_.Showmore1Click(Sender: TObject);
begin
  CheckBox1.Checked:=Not CheckBox1.Checked;
end;    

procedure THelp_.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

procedure THelp_.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Help_.Handle,WM_SYSCOMMAND,$F012,0);
end;

end.
