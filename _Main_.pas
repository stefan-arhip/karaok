unit _Main_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, MPlayer, ComCtrls, ColorGrd, ExtCtrls, Gauges, Grids, MMSystem,
  Menus, CoolButton, Jpeg;

Const PositionInStringGrid:Integer=2;//incep cu 2, ptr.ca la 1 este nr.de frame-uri
      MediaPlayerIsPlaying:Boolean=False;

type
  TMain_ = class(TForm)
    MediaPlayer1: TMediaPlayer;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Timer1: TTimer;
    Shape1: TShape;
    Shape2: TShape;
    Label11: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    TrackBar2: TTrackBar;
    Shape6: TShape;
    Shape7: TShape;
    Label12: TLabel;
    Shape8: TShape;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Openaudiofile1: TMenuItem;
    Openlyricsfile1: TMenuItem;
    N1: TMenuItem;
    Playpause1: TMenuItem;
    Mute1: TMenuItem;
    Volumeup1: TMenuItem;
    Volumedown1: TMenuItem;
    Forward1: TMenuItem;
    Backward1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    CheckBox1: TCheckBox;
    Label15: TLabel;
    StringGrid1: TStringGrid;
    Help1: TMenuItem;
    About1: TMenuItem;
    Savelyricsfile1: TMenuItem;
    Versestarttime1: TMenuItem;
    Versestoptime1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Showversesearlier1: TMenuItem;
    Showverseslater1: TMenuItem;
    N5: TMenuItem;
    Allowedit1: TMenuItem;
    N6: TMenuItem;
    Settings1: TMenuItem;
    ContinuousplayStopaftercurrent1: TMenuItem;
    Image2: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Shape3: TShape;
    SpeedButton9: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    View1: TMenuItem;
    Fullscreen1: TMenuItem;
    Playlist1: TMenuItem;
    Panel1: TPanel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Backward1Click(Sender: TObject);
    procedure Forward1Click(Sender: TObject);
    procedure Volumedown1Click(Sender: TObject);
    procedure Volumeup1Click(Sender: TObject);
    procedure Playpause1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure Allowedit1Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    Moving:Boolean;
    Delta:TPoint;
//    procedure wmnchittest (var m:twmnchittest);message wm_nchittest;
    Procedure OpenTextFile(Fisier:String);
    Procedure OpenSUBFile(Fisier:String);
  public
    { Public declarations }
    procedure SelectApplicationMode(AllowEdit:Boolean);
  end;

Function StringToNumber(s:String):Extended;

var
  Main_: TMain_;

implementation

uses _Open_, _Help_, _Options_, _Playlist_, _Fullscreen_;

{$R *.DFM}

procedure SetVolume(const volL,volR:Word);
var hWO:HWAVEOUT;
    waveF:TWAVEFORMATEX;
    vol:DWORD;
begin
  FillChar(waveF,SizeOf(waveF),0);             // init TWAVEFORMATEX
  waveOutOpen(@hWO,WAVE_MAPPER,@waveF,0,0,0);  // open WaveMapper = std output of playsound
  vol:=volL+volR shl 16;
  waveOutSetVolume(hWO,vol);                   // set volume
  waveOutClose(hWO);
end;

Function EsteNumar(s:String):Boolean;
Var Rezultat:Boolean;
    x:Extended;
Begin
  Rezultat:=True;
  Try
    x:=StrToFloat(s);
  Except
    Rezultat:=False;
  End;
  EsteNumar:=Rezultat;
End;

Function StringToNumber(s:String):Extended;
Begin
  Try
    Result:=StrToFloat(s);
  Except
    Result:=0;
  End;
End;

Function CautaCaracter(s:String;c:Char;n:Integer):Integer;
Var i,j:Integer;
Begin
  j:=0;
  Result:=0;
  For i:=1 To Length(s) Do
    Begin
      If s[i]=c Then
        Begin
          Inc(j);
        End;
      If j=n Then
        Begin
          Result:=i;
          Break;
        End;
    End;
End;

Function EsteFisierSUB(s:String):Boolean;
Var f:TextFile;
    s2,s3,s4,s5:String;
begin
  AssignFile(f,s);
  Reset(f);
  Result:=True;
  Repeat
    ReadLn(f,s2);
    s3:=s2;
    Delete(s3,1,CautaCaracter(s3,'{',1));
    Delete(s3,CautaCaracter(s3,'}',1),Length(s3));
    s4:=s2;
    Delete(s4,1,CautaCaracter(s4,'{',2));
    Delete(s4,CautaCaracter(s4,'}',1),Length(s4));
    s5:=s2;
    Delete(s5,1,CautaCaracter(s5,'}',2));
    If EsteNumar(s3) And EsteNumar(s4) And (s5<>'') Then
    Else
      Begin
        Result:=False;
        Break;
      End;
  Until EOF(f);
  Close(f);
end;

//procedure TMain_.wmnchittest (var m:twmnchittest);
//begin
//  defaulthandler(m);
//  if m.result=htclient then
//    Begin
//      m.result :=htcaption; //Paint;
//      Playlist_.Left:=Left;
//      Playlist_.Top:=Top+Height;
//    End;
//end;

procedure TMain_.SpeedButton1Click(Sender: TObject);
Var PlaylistLocation:TPoint;
begin
  PlaylistLocation.x:=Playlist_.Left;
  PlaylistLocation.y:=Playlist_.Top;
  Open_.Label11.Caption:='Open file';
  Open_.Edit1.ReadOnly:=True;
  Open_.SpeedButton4.Caption:='Open';
  Open_.FilterComboBox1.ItemIndex:=1;//mp3
  Open_.FileListBox1.Mask:='*.mp3';
  If Open_.Execute Then
    Begin
      SpeedButton1.Tag:=1;
      Label7.Caption:=ExtractFileName(Open_.Fisier);
      MediaPlayer1.FileName:=Open_.Fisier;
      MediaPlayer1.Open;
      SpeedButton2.Enabled:=True;
      Label8.Caption:=IntToStr(MediaPlayer1.Length);
      TrackBar1.Max:=MediaPlayer1.Length;
      TrackBar1.Enabled:=True;
      SelectApplicationMode(CheckBox1.Checked);
      PositionInStringGrid:=2;
      If Options_.CheckBox1.Checked Then
        Begin
          If FileExists(Open_.Fisier+'.txt') Then
            If CheckBox1.Checked Then
              OpenTextFile(Open_.Fisier+'.txt')
            Else
              If FileExists(Open_.Fisier+'.sub') Then
                OpenSUBFile(Open_.Fisier+'.sub');
        End;
      If Options_.CheckBox2.Checked Then
        SpeedButton2Click(Sender);
//      SpeedButton3Click(Sender);
//      SpeedButton2Click(Sender);
//      TrackBar1Change(Sender);//folosesc Change-ul pt.ca daca misc ulterior TrackBar-ul, apare defazaj
    End;
  Playlist_.Left:=PlaylistLocation.x;
  Playlist_.Top:=PlaylistLocation.y;
end;

procedure TMain_.SpeedButton2Click(Sender: TObject);
begin
  Timer1.Enabled:=True;
  MediaPlayer1.Play;
  MediaPlayerIsPlaying:=True;
  SpeedButton1.Enabled:=False;
  SpeedButton2.Enabled:=False;
  SpeedButton2.Visible:=False;
  SpeedButton3.Enabled:=True;
  SpeedButton3.Visible:=True;
  TrackBar1.Enabled:=True;
end;

procedure TMain_.SpeedButton3Click(Sender: TObject);
begin
  Timer1.Enabled:=False;
  MediaPlayer1.Pause;
  MediaPlayerIsPlaying:=False;
  SpeedButton1.Enabled:=True;
  SpeedButton2.Enabled:=True;
  SpeedButton2.Visible:=True;
  SpeedButton3.Enabled:=False;
  SpeedButton3.Visible:=False;
end;

procedure TMain_.FormPaint(Sender: TObject);
Var Row,Ht:Word;
    r,g,b:Byte;
begin
  Label2.Font.Color:=clSilver;
  Ht:=(ClientHeight+255) div 256;
  For Row:=0 To ClientHeight Do
    With Canvas Do
      Begin                 //r:[0..255]
        r:=Row*(GetRValue(Options_.ColorGrid1.ForegroundColor)-
                GetRValue(Options_.ColorGrid2.ForegroundColor)) Div ClientHeight;
        g:=Row*(GetGValue(Options_.ColorGrid1.ForegroundColor)-
                GetGValue(Options_.ColorGrid2.ForegroundColor)) Div ClientHeight;
        b:=Row*(GetBValue(Options_.ColorGrid1.ForegroundColor)-
                GetBValue(Options_.ColorGrid2.ForegroundColor)) Div ClientHeight;
        Brush.Color:=RGB(r,g,b);
        FillRect(Rect(0,Row*Ht,ClientWidth,(Row+1)*Ht));
      End;
end;

procedure TMain_.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

Procedure TMain_.OpenTextFile(Fisier:String);
Var f:TextFile;
    i:Longint;
    s1,s2:String;
Begin
  For i:=1 To 1000 Do
    Begin
      StringGrid1.Cells[0,i]:='';
      StringGrid1.Cells[1,i]:='';
      StringGrid1.Cells[2,i]:='';
      StringGrid1.Cells[3,i]:='';
      StringGrid1.Cells[4,i]:='';
    End;
  Label13.Caption:=ExtractFileName(Fisier);
  AssignFile(f,Fisier);
  Reset(f);
  i:=1;
  StringGrid1.Cells[0,i]:='1';
  StringGrid1.Cells[2,i]:='1';
  StringGrid1.Cells[3,i]:='1';
  StringGrid1.Cells[4,i]:=FloatToStrF(Options_.SpinEdit4.Value,ffFixed,16,2);
  While Not Eof(f) Do
    Begin
      Inc(i);
      s1:=IntToStr(i);
      ReadLn(f,s2);
      StringGrid1.Cells[0,i]:=s1;
      StringGrid1.Cells[4,i]:=s2;
    End;
  StringGrid1.RowCount:=i+1;
  CloseFile(f);
  SelectApplicationMode(CheckBox1.Checked);
  SpeedButton5.Tag:=1;
End;

Procedure TMain_.OpenSUBFile(Fisier:String);
Var f:TextFile;
    i:Longint;
    s1,s2,s3,s4,s5:String;
Begin
  For i:=1 To 1000 Do
    Begin
      StringGrid1.Cells[0,i]:='';
      StringGrid1.Cells[1,i]:='';
      StringGrid1.Cells[2,i]:='';
      StringGrid1.Cells[3,i]:='';
      StringGrid1.Cells[4,i]:='';
    End;
  Label13.Caption:=ExtractFileName(Fisier);
  AssignFile(f,Fisier);
  Reset(f);
  i:=0;
  While Not Eof(f) Do
    Begin
      Inc(i);
      s1:=IntToStr(i);
      ReadLn(f,s2);
      StringGrid1.Cells[0,i]:=s1;
      StringGrid1.Cells[1,i]:=s2;
      s3:=s2;
      Delete(s3,1,CautaCaracter(s3,'{',1));
      Delete(s3,CautaCaracter(s3,'}',1),Length(s3));
      s4:=s2;
      Delete(s4,1,CautaCaracter(s4,'{',2));
      Delete(s4,CautaCaracter(s4,'}',1),Length(s4));
      s5:=s2;
      Delete(s5,1,CautaCaracter(s5,'}',2));
      StringGrid1.Cells[2,i]:=s3;
      StringGrid1.Cells[3,i]:=s4;
      StringGrid1.Cells[4,i]:=s5;
    End;
  StringGrid1.RowCount:=i+1;
  CloseFile(f);
  SelectApplicationMode(CheckBox1.Checked);
  SpeedButton5.Tag:=1;
End;

procedure TMain_.SpeedButton5Click(Sender: TObject);
begin
  If SpeedButton5.Enabled Then
    Begin
      Open_.Label11.Caption:='Open file';
      Open_.Edit1.ReadOnly:=True;
      Open_.SpeedButton4.Caption:='Open';
      If CheckBox1.Checked Then
        Begin
          Open_.FilterComboBox1.ItemIndex:=2;//txt
          Open_.FileListBox1.Mask:='*.txt';
          If Open_.Execute Then
            OpenTextFile(Open_.Fisier);
        End
      Else
        Begin
          Open_.FilterComboBox1.ItemIndex:=3;//sub
          Open_.FileListBox1.Mask:='*.sub';
          If Open_.Execute Then
            If EsteFisierSUB(Open_.Fisier) Then
              OpenSUBFile(Open_.Fisier)
            Else
              MessageDlg('"'+Open_.Fisier+'" is not a ".SUB" file!',mtInformation,[mbOk],0);
        End;
//      SpeedButton3Click(Sender);
//      SpeedButton2Click(Sender);
//      TrackBar1Change(Sender);//folosesc Change-ul pt.ca daca misc ulterior TrackBar-ul, apare defazaj
    End;
end;

procedure TMain_.Timer1Timer(Sender: TObject);
begin
////////////
  try
    label14.caption:='media player: '+inttostr(MediaPlayer1.Position)+' of '+inttostr(mediaplayer1.Length);
    label16.caption:='trackbar position :'+inttostr(trackbar1.Position)+' of '+inttostr(trackbar1.max);
    label17.caption:='position in grid: '+inttostr(PositionInStringGrid);
  except
  end;
////////////
  If TrackBar1.Position>=TrackBar1.Max Then
    Begin
      Timer1.Enabled:=False;
      SpeedButton3Click(Sender);
      TrackBar1.Position:=0;
      If SpeedButton13.Visible Then
        SpeedButton2Click(Sender);
    End
  Else
    Begin
      TrackBar1.Tag:=1;
      TrackBar1.Position:=MediaPlayer1.Position;
      Label10.Caption:=IntToStr(TrackBar1.Position);
      TrackBar1.Tag:=0;
      If PositionInStringGrid<StringGrid1.RowCount-1 Then
        Begin
          If (TrackBar1.Position>StringToNumber(StringGrid1.Cells[2,PositionInStringGrid])*StringToNumber(StringGrid1.Cells[4,1])) And
             (TrackBar1.Position<StringToNumber(StringGrid1.Cells[3,PositionInStringGrid])*StringToNumber(StringGrid1.Cells[4,1])) Then
            Begin
              If Label3.Caption<>StringGrid1.Cells[4,PositionInStringGrid] Then
                Begin
                  If PositionInStringGrid-1>2 Then
                    Label2.Caption:=StringGrid1.Cells[4,PositionInStringGrid-1];
                  Label3.Caption:=StringGrid1.Cells[4,PositionInStringGrid];
                  Label4.Caption:=StringGrid1.Cells[4,PositionInStringGrid+1];
                  Fullscreen_.Label6.Caption:=Label2.Caption;
                  Fullscreen_.Label7.Caption:=Label3.Caption;
                  Fullscreen_.Label8.Caption:=Label4.Caption;
                End;
            End
          Else
            Begin
              If Label3.Caption<>'' Then
                Begin
                  If PositionInStringGrid-1>2 Then
                    Label2.Caption:=StringGrid1.Cells[4,PositionInStringGrid];
                  Label3.Caption:='';
                  Label4.Caption:=StringGrid1.Cells[4,PositionInStringGrid+1];
                  Fullscreen_.Label6.Caption:=Label2.Caption;
                  Fullscreen_.Label7.Caption:=Label3.Caption;
                  Fullscreen_.Label8.Caption:=Label4.Caption;
                  If TrackBar1.Position>=StringToNumber(StringGrid1.Cells[3,PositionInStringGrid])*StringToNumber(StringGrid1.Cells[4,1]) Then
                    Inc(PositionInStringGrid);
                End;
            End;
        End;
    End;
end;

procedure TMain_.TrackBar1Change(Sender: TObject);
begin
  If TrackBar1.Tag=0 Then
    Begin
      Label2.Caption:='';
      Label3.Caption:='';
      Label4.Caption:='';
      Fullscreen_.Label6.Caption:=Label2.Caption;
      Fullscreen_.Label7.Caption:=Label3.Caption;
      Fullscreen_.Label8.Caption:=Label4.Caption;
      If MediaPlayerIsPlaying Then
        Begin
          Timer1.Enabled:=False;
          MediaPlayer1.Pause;
        End;
      PositionInStringGrid:=2;
      MediaPlayer1.Position:=TrackBar1.Position;
      Label10.Caption:=IntToStr(TrackBar1.Position);
      If MediaPlayerIsPlaying Then
        Begin
          TrackBar1.Tag:=1;
          Timer1.Enabled:=True;
          MediaPlayer1.Play;
          Timer1Timer(Sender);
        End;
    End;
end;

procedure TMain_.FormCreate(Sender: TObject);
begin
  Label2.Caption:='';
  Label3.Caption:='';
  Label4.Caption:='';
  SpeedButton1.Hint:='Open the audio file'#13'[shortcut: Ins]';
  SpeedButton2.Hint:='Play the music file'#13'[shortcut: Space]';
  SpeedButton3.Hint:='Pause the music'#13'[shortcut: Space]';
  SpeedButton4.Hint:='Close the application'#13'[shortcut Esc]';
  SpeedButton5.Hint:='Open the lyrics file'#13'[shortcut: Ctrl+Ins]';
  SpeedButton6.Hint:='Mute & unmute the output speakers'#13'[shortcut: M]';
  SpeedButton7.Hint:='Mute & unmute the output speakers'#13'[shortcut: M]';
  SpeedButton8.Hint:='Open the options window'#13'[shortcut F2]';
  SpeedButton9.Hint:='Open the help window'#13'[shortcut F1]';
  SpeedButton10.Hint:='Show the verse lyrics earlier'#13'[shortcut Left]';
  SpeedButton11.Hint:='Show the verse lyrics later'#13'[shortcut Right]';
  SpeedButton12.Hint:='Save the lyrics file'#13'[shortcut Enter]';
  SpeedButton13.Hint:='Continuous play/Stop after current'#13'[shortcut 8]';
  SpeedButton14.Hint:='Set the start time from selected verse'#13'[shortcut Home]';
  SpeedButton15.Hint:='Set the stop time from selected verse'#13'[shortcut End]';
  SpeedButton16.Hint:='Continuous play/Stop after current'#13'[shortcut 8]';
  SpeedButton17.Hint:='Open/hide playlist window'#13'[shortcut L]';
  SpeedButton18.Hint:='Fullscreen lyrics'#13'[shortcut F]';
  TrackBar1.Hint:='Seek position in the audio file'#13'[shortcut: Left & Right]';
  TrackBar2.Hint:='Adjust the audio volume'#13'[shortcut: Up & Down]';
  CheckBox1.Hint:='Allow edit'#13'[shortcut E]';
  Label15.Hint:='Allow edit'#13'[shortcut E]';
  StringGrid1.Cells[0,0]:='Pos';
  StringGrid1.Cells[1,0]:='Entire row';//this is not shown
  StringGrid1.Cells[2,0]:='Start';
  StringGrid1.Cells[3,0]:='Stop';
  StringGrid1.Cells[4,0]:='Verse';
  StringGrid1.Cells[0,1]:='1';
end;

procedure TMain_.SpeedButton6Click(Sender: TObject);
begin
  TrackBar2.Enabled:=Not TrackBar2.Enabled;
  SpeedButton6.Visible:=TrackBar2.Enabled;
  SpeedButton7.Visible:=Not TrackBar2.Enabled;
  TrackBar2.Visible:=TrackBar2.Enabled;
  Label12.Visible:=Not TrackBar2.Enabled;
  If TrackBar2.Enabled Then
    SetVolume(TrackBar2.Position,TrackBar2.Position)
  Else
    SetVolume(0,0);
end;

procedure TMain_.TrackBar2Change(Sender: TObject);
begin
  SetVolume(TrackBar2.Position,TrackBar2.Position);
end;

procedure TMain_.Backward1Click(Sender: TObject);
begin
  If (TrackBar1.Position>Options_.SpinEdit2.Value) And (TrackBar1.Enabled) Then
    Begin
      TrackBar1.Position:=TrackBar1.Position-Options_.SpinEdit2.Value;
      TrackBar1Change(Sender);
    End;
end;

procedure TMain_.Forward1Click(Sender: TObject);
begin
  If (TrackBar1.Position<TrackBar1.Max-Options_.SpinEdit2.Value) And (TrackBar1.Enabled) Then
    Begin
      TrackBar1.Position:=TrackBar1.Position+Options_.SpinEdit2.Value;
      TrackBar1Change(Sender);
    End;
end;

procedure TMain_.Volumedown1Click(Sender: TObject);
begin
  If (TrackBar2.Position>Options_.SpinEdit1.Value) And (TrackBar2.Enabled) Then
    Begin
      TrackBar2.Position:=TrackBar2.Position-Options_.SpinEdit1.Value;
      TrackBar2Change(Sender);
    End;
end;

procedure TMain_.Volumeup1Click(Sender: TObject);
begin
  If (TrackBar2.Position>Options_.SpinEdit1.Value) And (TrackBar2.Enabled)Then
    Begin
      TrackBar2.Position:=TrackBar2.Position+Options_.SpinEdit1.Value;
      TrackBar2Change(Sender);
    End;
end;

procedure TMain_.Playpause1Click(Sender: TObject);
begin
  If SpeedButton2.Enabled Then
    SpeedButton2Click(Sender)
  Else
    If SpeedButton3.Enabled Then
      SpeedButton3Click(Sender);
end;

procedure TMain_.CheckBox1Click(Sender: TObject);
begin
  SelectApplicationMode(CheckBox1.Checked);
end;

procedure TMain_.SelectApplicationMode(AllowEdit:Boolean);
begin
  Label2.Visible:=Not AllowEdit;
  Label3.Visible:=Not AllowEdit;
  Label4.Visible:=Not AllowEdit;
  SpeedButton5.Enabled:=(SpeedButton1.Tag=1);// And Play;
  Openlyricsfile1.Enabled:=SpeedButton5.Enabled;
  SpeedButton10.Enabled:=(SpeedButton1.Tag=1) And (AllowEdit);//tag=5
  Showversesearlier1.Enabled:=SpeedButton10.Enabled;
  SpeedButton11.Enabled:=(SpeedButton1.Tag=1) And (AllowEdit);
  Showverseslater1.Enabled:=SpeedButton11.Enabled;
  SpeedButton12.Enabled:=(SpeedButton1.Tag=1) And (AllowEdit);
  Savelyricsfile1.Enabled:=SpeedButton12.Enabled;
  SpeedButton14.Enabled:=(SpeedButton1.Tag=1) And (AllowEdit);
  Versestarttime1.Enabled:=SpeedButton14.Enabled;
  SpeedButton15.Enabled:=(SpeedButton1.Tag=1) And (AllowEdit);
  Versestoptime1.Enabled:=SpeedButton15.Enabled;
  CheckBox1.Enabled:=SpeedButton1.Tag=1;
  Label15.Enabled:=SpeedButton1.Tag=1;
  StringGrid1.Visible:=AllowEdit;//Edit
end;

procedure TMain_.SpeedButton9Click(Sender: TObject);
begin
  Help_.Execute;
end;

procedure TMain_.SpeedButton14Click(Sender: TObject);
begin
  StringGrid1.Cells[2,StringGrid1.Row]:=FloatToStr(Round(StringToNumber(Label10.Caption)/Options_.SpinEdit4.Value));
end;

procedure TMain_.SpeedButton15Click(Sender: TObject);
begin
  StringGrid1.Cells[3,StringGrid1.Row]:=FloatToStr(Round(StringToNumber(Label10.Caption)/Options_.SpinEdit4.Value));
  If StringGrid1.Row<StringGrid1.RowCount-1 Then
    StringGrid1.Row:=StringGrid1.Row+1;
end;

procedure TMain_.SpeedButton10Click(Sender: TObject);
Var i:Integer;
begin
  For i:=1 To StringGrid1.RowCount-1 Do
    Begin
      StringGrid1.Cells[2,i]:=FloatToStr(Round(StringToNumber(StringGrid1.Cells[2,i])-Options_.SpinEdit3.Value));
      StringGrid1.Cells[3,i]:=FloatToStr(Round(StringToNumber(StringGrid1.Cells[3,i])-Options_.SpinEdit3.Value));
    End;
end;

procedure TMain_.SpeedButton11Click(Sender: TObject);
Var i:Integer;
begin
  For i:=1 To StringGrid1.RowCount-1 Do
    Begin
      StringGrid1.Cells[2,i]:=FloatToStr(Round(StringToNumber(StringGrid1.Cells[2,i])+Options_.SpinEdit3.Value));
      StringGrid1.Cells[3,i]:=FloatToStr(Round(StringToNumber(StringGrid1.Cells[3,i])+Options_.SpinEdit3.Value));
    End;
end;

procedure TMain_.SpeedButton12Click(Sender: TObject);
Var f:TextFile;
    i:Integer;
begin
  Open_.Label11.Caption:='Save file';
  Open_.Edit1.ReadOnly:=False;
  Open_.SpeedButton4.Caption:='Save';
  Open_.FilterComboBox1.ItemIndex:=3;//sub
  Open_.FileListBox1.Mask:='*.sub';
  If Open_.Execute Then
    Begin
      AssignFile(f,Open_.Fisier);
      Rewrite(f);
      WriteLn(f,'{1}{1}'+FloatToStrF(Options_.SpinEdit4.Value,ffFixed,16,2));
      For i:=2 To StringGrid1.RowCount-1 Do
        WriteLn(f,'{'+StringGrid1.Cells[2,i]+'}{'+StringGrid1.Cells[3,i]+'}'+StringGrid1.Cells[4,i]);
      CloseFile(f);
      Label7.Caption:=ExtractFileName(Open_.Fisier);
      SelectApplicationMode(CheckBox1.Checked);
      PositionInStringGrid:=2;
    End;
end;

procedure TMain_.Allowedit1Click(Sender: TObject);
begin
  If CheckBox1.Enabled Then
    Begin
      CheckBox1.Checked:=Not CheckBox1.Checked;
      SelectApplicationMode(CheckBox1.Checked);
    End;
end;

procedure TMain_.SpeedButton8Click(Sender: TObject);
begin
  Options_.Execute;
end;

procedure TMain_.SpeedButton16Click(Sender: TObject);   //si SpeedButton13 are aceeasi comanda
begin
  SpeedButton16.Visible:=Not SpeedButton16.Visible;
  SpeedButton13.Visible:=Not SpeedButton16.Visible;
end;

procedure TMain_.SpeedButton17Click(Sender: TObject);
begin
  If Playlist_.Visible Then
    Playlist_.Close
  Else
    Playlist_.Show;
end;

procedure TMain_.SpeedButton18Click(Sender: TObject);
begin
  Fullscreen_.ShowModal;
end;

procedure TMain_.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  ReleaseCapture;
//  SendMessage(Main_.Handle,WM_SYSCOMMAND,$F012,0);
  If Button=mbLeft Then
    Begin
      Moving:=True;
      Delta:=Point(X,Y);
    End;
end;

procedure TMain_.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
Const SnapSize:Integer=25;
Var l,t:Integer;
    WorkRect:TRect;
begin
  If Moving Then // You should add support for DualHead/Matrox Configurations
    Begin
      If Not SystemParametersInfo(SPI_GETWORKAREA,0,@WorkRect,0) Then
        WorkRect:=Bounds(0,0,Screen.Width,Screen.Height);
      Dec(WorkRect.Right,Width);
      Dec(WorkRect.Bottom,Height);
      l:=Left+X-Delta.X;
      t:=Top+Y-Delta.Y;
      If (l<WorkRect.Left+SnapSize) And (l>WorkRect.Left-SnapSize) Then
        l:=WorkRect.Left;
      If (l>WorkRect.Right-SnapSize) And (l<WorkRect.Right+SnapSize) Then
          l:=WorkRect.Right;
      If (t<WorkRect.Top+SnapSize) And (t>WorkRect.Top-SnapSize) Then
        t:=WorkRect.Top;
      If (t>WorkRect.Bottom-SnapSize) And (t<WorkRect.Bottom+SnapSize) Then
        t:=WorkRect.Bottom;
      Left:=l;  // NOTE: This will always "Show window
      Top:=t;   // contents while dragging"
    End;
end;

procedure TMain_.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Moving:=False;
end;

end.
