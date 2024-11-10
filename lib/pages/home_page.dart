import 'package:atb_music_player/components/my_drawer.dart';
import 'package:atb_music_player/models/playlists_provider.dart';
import 'package:atb_music_player/themes/theme_provider.dart';
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
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("ATB Radio"),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search songs...",
                hintStyle: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white38
                      : Colors.black38,
                ),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<PlaylistsProvider>(
              builder: (context, value, child) {
                final List<Song> playlist = value.playlist;
                final filteredPlaylist = playlist.where((song) {
                  final songName = song.songName.toLowerCase();
                  final artistName = song.artistName.toLowerCase();
                  return songName.contains(searchQuery) ||
                      artistName.contains(searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: filteredPlaylist.length,
                  itemBuilder: (context, index) {
                    final Song song = filteredPlaylist[index];
                    return ListTile(
                      title: Text(song.songName),
                      subtitle: Text(song.artistName),
                      leading: Image.asset(song.albumArtImagePath),
                      onTap: () => goToSong(index),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            Provider.of<ThemeProvider>(context).isDarkMode
                ? const BoxShadow(
                    color: Colors.white38,
                    spreadRadius: 0,
                    blurRadius: 10,
                  )
                : const BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0,
                    blurRadius: 10,
                  ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            currentIndex: Provider.of<ThemeProvider>(context).currentPageIndex,
            onTap: (index) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .currentPageIndex = index;
            },
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            selectedItemColor: Colors.lightBlueAccent,
          ),
        ),
      ),
    );
  }
}
