import 'package:atb_music_player/components/neu_box.dart';
import 'package:atb_music_player/models/playlists_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // convert duration
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistsProvider>(builder: (context, value, child) {
      // get playlist
      final playlist = value.playlist;

      // get current song
      final currentSong = playlist[value.currentSongIndex ?? 0];

      // return scaffold ui
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back)),
                      const Text("P L A Y L I S T"),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
                    ],
                  ),

                  const SizedBox(
                    height: 100,
                  ),

                  NeuBox(
                      child: Column(
                    children: [
                      // Album Art
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          currentSong.albumArtImagePath,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Name & Artist
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(currentSong.artistName)
                              ],
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(height: 25),

                  // Progress bar
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(formatTime(value.currentDuration)),
                            const Icon(Icons.shuffle),
                            const Icon(Icons.repeat),
                            Text(formatTime(value.totalDuration))
                          ],
                        ),
                      ),
                      SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 0)),
                          child: Slider(
                            min: 0,
                            max: value.totalDuration.inSeconds.toDouble(),
                            value: value.currentDuration.inSeconds.toDouble(),
                            activeColor: Colors.lightBlueAccent,
                            onChanged: (double double) {},
                            onChangeEnd: (double double) {
                              value.seek(Duration(seconds: double.toInt()));
                            },
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      // Back
                      Expanded(
                          child: GestureDetector(
                        onTap: value.playPrevSong,
                        child: const NeuBox(child: Icon(Icons.skip_previous)),
                      )),

                      const SizedBox(
                        width: 20,
                      ),

                      // Play/Pause
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                                child: Icon(value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow)),
                          )),

                      const SizedBox(
                        width: 20,
                      ),

                      //Forward
                      Expanded(
                          child: GestureDetector(
                        onTap: value.playNextSong,
                        child: const NeuBox(child: Icon(Icons.skip_next)),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ));
    });
  }
}
