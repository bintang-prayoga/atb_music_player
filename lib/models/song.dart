class Song {
  final String songName;
  final String artistName;
  final String albumName;

  final String albumArtImagePath;
  final String songPath;

  Song(
      {required this.songName,
      required this.artistName,
      required this.albumName,
      required this.albumArtImagePath,
      required this.songPath});
}
