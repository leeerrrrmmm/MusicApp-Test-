import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lermmusic/components/neu_box.dart';
import 'package:lermmusic/models/play_list_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration){
    String twoDigitalSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formatterTime = "${duration.inMinutes}:$twoDigitalSeconds";

    return formatterTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
        builder: (context, value, child) {
          //get playList
            final playList = value.playList;
          //get curSong
            final curSong = playList[value.currentSongIndex ?? 0];
          //return Scafold UI
          return Scaffold(
              backgroundColor:Theme.of(context).colorScheme.surface,
              appBar:AppBar(
                title:Text("P L A Y L I S T "),
                centerTitle: true,
              ),

              body:SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left:25,right: 25,bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NeuBox(
                          child:
                          Column(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child:
                                  Image.asset(curSong.albumImagePath)
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(curSong.songName,
                                            style:TextStyle(
                                              fontSize:20,
                                              fontWeight:FontWeight.bold,
                                            )),
                                        Text(curSong.artistName),
                                      ],
                                    ),
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                      const SizedBox(height: 10,),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  ///start tune
                                  Text(formatTime(value.currentDuration)),
                                  ///shuffle icon
                                  Icon(Icons.shuffle),
                                  /// repeat icon
                                  Icon(Icons.repeat),
                                  /// end time
                                  Text(formatTime(value.totalDuration))
                                ]
                            ),
                          ),
                          /// song progress time
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 0
                                )
                            ),
                            child: Slider(
                              activeColor: Colors.red,
                              value: value.currentDuration.inSeconds.toDouble(),
                              min:0,
                              max: value.totalDuration.inSeconds.toDouble(),
                              onChanged: (double double) {

                              },
                              onChangeEnd: (double double) {
                                     value.seek(Duration(seconds: double.toInt()));
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child:
                                  GestureDetector(
                                    onTap: value.playPreviousSong,
                                    child: NeuBox(
                                        child: Icon(Icons.skip_previous_rounded)
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                  flex: 2,
                                  child:
                                  GestureDetector(
                                    onTap:value.pauseOrResume,
                                    child: NeuBox(
                                        child: Icon(value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded)
                                    ),
                                  )
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                  child:
                                  GestureDetector(
                                    onTap: value.playNextSong,
                                    child: NeuBox(
                                        child: Icon(Icons.skip_next_rounded)
                                    ),
                                  )
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
          );
        }
    );
  }
}
