unit _Playlist_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, SnapForm, StdCtrls, Grids, IniFiles, ComCtrls;

type
  TPlaylist_ = class(TForm)
    Shape3: TShape;
    Shape2: TShape;
    SnapForm1: TSnapForm;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    StringGrid1: TStringGrid;
    Label11: TLabel;
    Shape8: TShape;
    Label6: TLabel;
    Label13: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    procedure FormPaint(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    { Private declarations }
//    Moving:Boolean;
//    Delta:TPoint;
    //procedure wmnchittest (var m:twmnchittest);message wm_nchittest;
    Procedure OpenLSTFile(Fisier:String);
   public
    { Public declarations }
    Relativ:TPoint;
  end;

var
  Playlist_: TPlaylist_;

implementation

uses _Options_, _Main_, _Open_;

{$R *.DFM}

//procedure TPlaylist_.wmnchittest (var m:twmnchittest);
//begin
//  defaulthandler(m);
//  if m.result=htclient then m.result :=htcaption; //Paint;
//end;

procedure TPlaylist_.FormPaint(Sender: TObject);
Var Row,Ht:Word;
    r,g,b:Byte;
begin
  //Label2.Font.Color:=clSilver;
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

procedure TPlaylist_.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TPlaylist_.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:='Pos';
  StringGrid1.Cells[0,1]:='1';
  StringGrid1.Cells[1,0]:='Song filename';
  StringGrid1.Cells[2,0]:='Song title';
  StringGrid1.Cells[3,0]:='Song time';
  SnapForm1:=TSnapForm.create(self);
  SnapForm1.Active:=True;
  SnapForm1.AddFormSnap((Main_ as TForm));
  //Snap.DelFormSnap((Form2 as TForm)); --pentru stergere lipire!!!
  SnapForm1.ActiveStick:=True;
  SnapForm1.SnapStrenght:=10;
  SnapForm1.SnapScreenBorder:=True;
end;

procedure TPlaylist_.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(PlayList_.Handle, WM_SYSCOMMAND, $F012, 0);
end;

procedure TPlaylist_.FormActivate(Sender: TObject);
begin
  If Tag=0 Then //daca este deschisa pt. prima data...
    Begin
      Left:=Main_.Left;
      Top:=Main_.Top+Main_.Height;
      Tag:=1;
    End;  
end;

Procedure TPlaylist_.OpenLSTFile(Fisier:String);
Var f:TIniFile;
    i,NumberOfEntries:Longint;
    s1,s2,s3:Array [1..1000] Of String;
Begin
  For i:=1 To 1000 Do
    Begin
      StringGrid1.Cells[0,i]:='';
      StringGrid1.Cells[1,i]:='';//file
      StringGrid1.Cells[2,i]:='';//title
      StringGrid1.Cells[3,i]:='';//length
      s1[i]:='';
      s2[i]:='';
      s3[i]:='';
    End;
  f:=TIniFile.Create(Fisier);
  Try
    NumberOfEntries:=f.ReadInteger('playlist','NumberOfEntries',0);
    For i:=1 To NumberOfEntries Do
      Begin
        s1[i]:=f.ReadString('playlist','File'+IntToStr(i),'');
        s2[i]:=f.ReadString('playlist','Title'+IntToStr(i),'');
        s3[i]:=f.ReadString('playlist','Length'+IntToStr(i),'');
        StringGrid1.Cells[0,i]:=IntToStr(i);
        StringGrid1.Cells[1,i]:=s1[i];
        If s2[i]<>'' Then
          StringGrid1.Cells[2,i]:=s2[i]
        Else
          StringGrid1.Cells[2,i]:=s1[i];
        If s3[i]<>'' Then
          StringGrid1.Cells[3,i]:=IntToStr(Trunc(StringToNumber(s3[i])*1000))
        Else
          StringGrid1.Cells[3,i]:='[ ? ]';
      End;
    StringGrid1.RowCount:=NumberOfEntries+1;
  Finally
    f.Free;
  End;
End;

procedure TPlaylist_.SpeedButton5Click(Sender: TObject);
begin
  If SpeedButton5.Enabled Then
    Begin
      Open_.Label11.Caption:='Open file';
      Open_.Edit1.ReadOnly:=True;
      Open_.SpeedButton4.Caption:='Open';
      Open_.FilterComboBox1.ItemIndex:=4;//pls
      Open_.FileListBox1.Mask:='*.pls';
      If Open_.Execute Then
        Begin
          Label13.Caption:=ExtractFileName(Open_.Fisier);
          OpenLSTFile(Open_.Fisier);
        End;
    End;
end;

end.
