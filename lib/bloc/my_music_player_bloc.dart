import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

enum PlayerStatus {
  pause,
  play,
  stop,
}

class MyMusicPlayerBLoc with ChangeNotifier {
  AudioPlayer audioPlayer;
  FlutterAudioQuery audioQuery;

  MyMusicPlayerBLoc() {
    this.audioPlayer = AudioPlayer();
    this.audioQuery = FlutterAudioQuery();
  }

  List<SongInfo> songs;

  PlayerStatus _playerStatus = PlayerStatus.stop;
  PlayerStatus get playerStatus => _playerStatus;
  set playerStatus(PlayerStatus playerStatus) {
    _playerStatus = playerStatus;
    notifyListeners();
  }

  SongInfo _selectedSong;
  SongInfo get selectedSong => _selectedSong;
  set selectedSong(SongInfo selectedSong) {
    _selectedSong = selectedSong;
    notifyListeners();
  }

  int _selectedSongSeek;

  int get selectedSongSeek => _selectedSongSeek;

  set selectedSongSeek(int selectedSongSeek) {
    _selectedSongSeek = selectedSongSeek;
    if (_selectedSongSeek > int.parse(selectedSong.duration)) {
      selectedSong = songs[songs.indexOf(selectedSong) + 1];
      _selectedSongSeek = 0;
    }
    notifyListeners();
  }

  Future<void> getAllFiles() async {
    songs = await audioQuery.getSongs();
    print("GET ALL FILES");
  }

  playPause(SongInfo song) {
    if (selectedSong != song) {
      selectedSong = song;
      play();
    } else if (playerStatus == PlayerStatus.play) {
      pause();
    } else {
      play();
    }
  }

  play() async {
    if (selectedSong != null) {
      int result = await audioPlayer.play(selectedSong.filePath, isLocal: true);
      print(result);
      playerStatus = PlayerStatus.play;
    }
  }

  Future<int> seek(int seekTime) async {
    int result = await audioPlayer.seek(Duration(milliseconds: seekTime));
    await getSeek();
    return result;
  }

  pause() async {
    int result = await audioPlayer.pause();
    print(result);
    playerStatus = PlayerStatus.pause;
  }

  stop() async {
    await audioPlayer.stop();
    playerStatus = PlayerStatus.stop;
  }

  Future<int> getSeek() async {
    int currentPosition = await audioPlayer.getCurrentPosition();
    selectedSongSeek = currentPosition;
    return currentPosition;
  }
}
