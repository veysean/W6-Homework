import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import '../../../../model/songs/song.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();
    AsyncValue<List<Song>> asyncValue = mv.songsValue;

    // if (asyncValue.isLoading case AsyncValue.loading) {
    //   content = const Center(child: CircularProgressIndicator());
    // } else if (asyncValue.isLoading case AsyncValue.error) {
    //   content = Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [const Text("Failed to load songs")],
    //     ),
    //   );
    // } else if (asyncValue.isLoading case AsyncValue.data) {
    //   final songs = asyncValue.value ?? [];
    //   content = ListView.builder(
    //     itemCount: songs.length,
    //     itemBuilder: (context, index) => SongTile(
    //       song: songs[index],
    //       isPlaying: mv.isSongPlaying(songs[index]),
    //       onTap: () {
    //         mv.start(songs[index]);
    //       },
    //     ),
    //   );
    // }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),
          Expanded(
            child: asyncValue.isLoading
                ? const Center(child: CircularProgressIndicator())
                : asyncValue.hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Failed to load songs")],
                    ),
                  )
                : ListView.builder(
                    itemCount: asyncValue.value?.length ?? 0,
                    itemBuilder: (context, index) {
                      final song = asyncValue.value![index];
                      return SongTile(
                        song: song,
                        isPlaying: mv.isSongPlaying(song),
                        onTap: () => mv.start(song),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
