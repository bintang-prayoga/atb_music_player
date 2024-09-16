import 'package:atb_music_player/components/my_drawer.dart';
import 'package:atb_music_player/models/playlists_provider.dart';
import 'package:atb_music_player/models/song.dart';
import 'package:atb_music_player/pages/song_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistsProvider;

  @override
  void initState() {
    super.initState();

    playlistsProvider = Provider.of<PlaylistsProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlistsProvider.currentSongIndex = songIndex;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SongPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("ATB Music Player"),
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistsProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;

          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                final Song song = playlist[index];

                return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumArtImagePath),
                  onTap: () => goToSong(index),
                );
              });
        },
      ),
    );
  }
}
