import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../data/repositories/songs/user_history_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  final UserHistoryRepository userHistoryRepository;

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.userHistoryRepository,
  });

  List<Song> _songs = [];
  List<Song> get songs => _songs;

  List<Song> _recentSongs = [];
  List<Song> get recentSongs => _recentSongs;

  Song? get currentSong => playerState.currentSong;

  void init() {
    _songs = songRepository.fetchSongs();

    final recentIds = userHistoryRepository.fetchRecentSongIds();
    _recentSongs = recentIds
        .map((id) => songRepository.fetchSongById(id))
        .whereType<Song>()
        .toList();

    // Listen to player state changes
    playerState.addListener(() {
      notifyListeners();
    });
  }

  void play(Song song) {
    playerState.start(song);
    notifyListeners();
  }

  void stop() {
    playerState.stop();
    notifyListeners();
  }
}
