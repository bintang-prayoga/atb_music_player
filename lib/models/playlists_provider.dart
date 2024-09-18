import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:atb_music_player/models/song.dart';

class PlaylistsProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "Thoughts Of You",
        artistName: "For Tracy Hyde",
        albumName: "New Young City",
        albumArtImagePath: "assets/images/NYC.jpg",
        songPath: "audio/03 - For Tracy Hyde - Thoughts of You.mp3"),
    Song(
        songName: "Wasurekaze",
        artistName: "HoneyComeBear",
        albumName: "Wasurekaze",
        albumArtImagePath: "assets/images/Wasurekaze.jpg",
        songPath: "audio/01. 忘れ風.flac")
  ];

  // curent song playing index
  int? _currentSongIndex = 0;

  // Audio Player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Constructor
  PlaylistsProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  // Play
  void play() async {
    final String path = _playlist[currentSongIndex!].songPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause Or Resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // Seek
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Play Next
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < playlist.length - 1) {
        // go to next song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's last, loop back to first
        currentSongIndex = 0;
      }
    }
  }

  void playPrevSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = playlist.length - 1;
      }
    }
  }

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // Getters

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setters

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }

  // Setters
}
