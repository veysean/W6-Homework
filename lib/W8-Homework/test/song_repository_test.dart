import '../data/repositories/songs/song_repository_mock.dart';

// // - Using async/await with try/catch.
// void main() async {
//   //   Instantiate the  song_repository_mock

//   // Test both the success and the failure of the post request

//   // Handle the Future using 2 ways  (2 tests)
//   // - Using then() with .catchError().
//   // - Using async/await with try/catch.

//   // This code will display song title
//   final repo = SongRepositoryMock();
//   try {
//     final song = await repo.fetchSongById('s1');
//     print('Song title ${song?.title}');
//   } catch (e) {
//     print(e);
//   }

//   // This code will throw an error
//   try {
//     final song = await repo.fetchSongById('s10');
//     print('Song title ${song?.title}');
//   } catch (e) {
//     print(e);
//   }
// }

// - Using then() with .catchError().
void main() {
  //   Instantiate the  song_repository_mock

  // Test both the success and the failure of the post request

  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  // - Using async/await with try/catch.

  final repo = SongRepositoryMock();

  // This code will display song title
  repo
      .fetchSongById('s1')
      .then((song) {
        print('Song title ${song?.title}');
      })
      .catchError((error) {
        print(error);
      });

  // This code will throw an error
  repo
      .fetchSongById('s10')
      .then((song) {
        print('Song title ${song?.title}');
      })
      .catchError((error) {
        print(error);
      });
}
