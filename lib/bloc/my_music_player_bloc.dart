import 'dart:async';

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

  int _selectedSongSeek = 0;

  int get selectedSongSeek => _selectedSongSeek;

  set selectedSongSeek(int selectedSongSeek) {
    _selectedSongSeek = selectedSongSeek;
    notifyListeners();
  }

  Future<void> getAllFiles() async {
    songs = await audioQuery.getSongs();
    print("GET ALL FILES");
  }

  goNext() {
    _timer.cancel();
    selectedSong = songs[songs.indexOf(selectedSong) + 1];
    selectedSongSeek = 0;
    play();
  }

  goBack() {
    _timer.cancel();
    selectedSong = songs[songs.indexOf(selectedSong) - 1];
    selectedSongSeek = 0;
    play();
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

  int timeTest = 0;
  Timer _timer;
  play() async {
    if (selectedSong != null) {
      if (_timer != null) {
        _timer.cancel();
      }
      const oneSec = const Duration(seconds: 1);
      _timer = Timer.periodic(oneSec, (Timer timer) {
        if (int.tryParse(selectedSong.duration) - selectedSongSeek < 1000) {
          timer.cancel();
          selectedSong = songs[songs.indexOf(selectedSong) + 1];
          selectedSongSeek = 0;
          play();
        } else {
          selectedSongSeek += 1000;
        }
      });
      await audioPlayer.play(selectedSong.filePath, isLocal: true);
      playerStatus = PlayerStatus.play;
    }
  }

  pause() async {
    await audioPlayer.pause();
    _timer.cancel();
    playerStatus = PlayerStatus.pause;
  }

  Future<int> seek(int seekTime) async {
    int result = await audioPlayer.seek(Duration(milliseconds: seekTime));
    await getSeek();
    return result;
  }

  stop() async {
    await audioPlayer.stop();
    playerStatus = PlayerStatus.stop;
  }

  Future<int> getSeek() async {
    if (audioPlayer != null) {
      int currentPosition = await audioPlayer.getCurrentPosition();
      selectedSongSeek = currentPosition;
      return currentPosition;
    } else {
      selectedSongSeek = 0;
      return 0;
    }
  }
}
