program KaraOK;

uses
  Forms,
  _Main_ in '_Main_.pas' {Main_},
  _Open_ in '_Open_.pas' {Open_},
  _Help_ in '_Help_.pas' {Help_},
  _Options_ in '_Options_.pas' {Options_},
  _Playlist_ in '_Playlist_.pas' {Playlist_},
  _Fullscreen_ in '_Fullscreen_.pas' {Fullscreen_};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMain_, Main_);
  Application.CreateForm(TOpen_, Open_);
  Application.CreateForm(THelp_, Help_);
  Application.CreateForm(TOptions_, Options_);
  Application.CreateForm(TPlaylist_, Playlist_);
  Application.CreateForm(TFullscreen_, Fullscreen_);
  Application.Run;
end.
