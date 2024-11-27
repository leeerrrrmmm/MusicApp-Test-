import 'package:flutter/material.dart';
import 'package:lermmusic/components/my_drawer.dart';
import 'package:lermmusic/models/play_list_provider.dart';
import 'package:lermmusic/models/song_model.dart';
import 'package:lermmusic/pages/songPage.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  late final dynamic playListProvider;

  @override @override
  void initState() {
    super.initState();
    playListProvider =  Provider.of<PlayListProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playListProvider.currentSongIndex = songIndex;

    Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('P L A Y L I S T'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlayListProvider>
        (builder: (context, value, child) {
        final List<Song> playList = value.playList;
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: playList.length,
            itemBuilder: (context, index) {
            final Song song = playList[index];
            return ListTile(
              title:Text(song.songName,
              style:TextStyle(
                color:Theme.of(context).colorScheme.inversePrimary,
              )),
              subtitle: Text(song.artistName,
              style:TextStyle(
                color: Theme.of(context).colorScheme.primary,
              )),
              leading: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(song.albumImagePath),
                      fit:BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () => goToSong(index),

            );

        });
      })
    );
  }
}
