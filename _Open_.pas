unit _Open_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, FileCtrl, Menus;

type
  TOpen_ = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Shape3: TShape;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Label11: TLabel;
    Selectdrive1: TMenuItem;
    N1: TMenuItem;
    Selectdirectory1: TMenuItem;
    Selectfile1: TMenuItem;
    Shape6: TShape;
    Panel3: TPanel;
    Edit1: TEdit;
    Shape2: TShape;
    Panel4: TPanel;
    Shape1: TShape;
    FilterComboBox1: TFilterComboBox;
    Editselectedfile1: TMenuItem;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure FormPaint(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Selectdrive1Click(Sender: TObject);
    procedure Selectdirectory1Click(Sender: TObject);
    procedure Selectfile1Click(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure Editselectedfile1Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Fisier:String;
    Result:Boolean;
    Function Execute:Boolean;
  end;

var
  Open_: TOpen_;

implementation

uses _Main_, _Options_;

{$R *.DFM}

procedure TOpen_.FormPaint(Sender: TObject);
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

function TOpen_.Execute: Boolean;
begin                 //mrOK
  Result:=(ShowModal=mrOK);//CheckBox1.Checked
  Fisier:=FileListBox1.Directory+'\'+Edit1.Text;
end;

procedure TOpen_.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TOpen_.FormCreate(Sender: TObject);
begin
  SpeedButton1.Hint:='Abandon selecting file'#13'[shortcut Esc]';
  SpeedButton2.Hint:='Open the options window'#13'[shortcut F2]';
  SpeedButton3.Hint:='Open the help window'#13'[shortcut F1]';
  DriveComboBox1.Hint:='Select drive'#13'[shortcut F2]';
  DirectoryListBox1.Hint:='Select directory'#13'[shortcut F3]';
  FileListBox1.Hint:='Select file'#13'[shortcut F4]';
  Edit1.Hint:='Edit selected filename'#13'[shortcut F5]';
  SpeedButton4.Hint:='Open the selected file'#13'[shortcut Enter]';
end;

procedure TOpen_.Selectdrive1Click(Sender: TObject);
begin
  DriveComboBox1.SetFocus;
end;

procedure TOpen_.Selectdirectory1Click(Sender: TObject);
begin
  DirectoryListBox1.SetFocus;
end;

procedure TOpen_.Selectfile1Click(Sender: TObject);
begin
  FileListBox1.SetFocus;
end;

procedure TOpen_.DriveComboBox1Change(Sender: TObject);
begin
  If (FileListBox1.ItemIndex=-1) And (FileListBox1.Items.Capacity<>0) Then
    FileListBox1.ItemIndex:=0;
  If FileListBox1.ItemIndex<>-1 Then
    Edit1.Text:=FileListBox1.Items[FileListBox1.ItemIndex]
  Else
    Edit1.Text:=''; 
  SpeedButton4.Enabled:=FileListBox1.ItemIndex<>-1;
end;

procedure TOpen_.Editselectedfile1Click(Sender: TObject);
begin
  Edit1.SetFocus;
end;    

procedure TOpen_.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Open_.Handle,WM_SYSCOMMAND,$F012,0);
end;

procedure TOpen_.SpeedButton4Click(Sender: TObject);
begin
  ModalResult:=mrOk;
//  Close;
end;

end.
