import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:lermmusic/models/song_model.dart';


class PlayListProvider extends ChangeNotifier {
  final List<Song> _playList = [
    //song 1
    Song(
        songName: 'Тысячи рук',
        artistName: 'СодаLuv',
        albumImagePath: 'assets/image/SodaLuvAlb.png',
        audioPath: 'audio/oneThouthedHand.mp3'
    ),
    //song 2
    Song(
        songName: 'DONPAPA',
        artistName:  'GoneFludd',
        albumImagePath: 'assets/image/goneAlb.png',
        audioPath: 'audio/donPapa.mp3'
    ),
    //song 3
    Song(
        songName: 'Удлинённый магазин',
        artistName: 'GoneFludd',
        albumImagePath: 'assets/image/goneAlbom.jpg',
        audioPath: 'audio/longMagazine.mp3'
    ),
  ];

  //cur song playing index
  int? _currentSongIndex = 0;

  /*

 A U D I O P L A Y E R

   */
  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlayListProvider () {listenToDuration();}

  //initialy not playing
  bool _isPlaying = false;

  //play the song
  void play () async {
    final String path = _playList[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
}

  //pause cur song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async{
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if(_isPlaying){
      pause();
    }else{
      resume();
    }
    notifyListeners();
  }
  //seek to a specific position in the cur song
    void seek(Duration position) async{
    await _audioPlayer.seek(position);
    }

  //play next song
  void playNextSong() {
    if(_currentSongIndex != null){
      if(_currentSongIndex! < _playList.length - 1){
            currentSongIndex = _currentSongIndex! + 1;
      }else{
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong () async {
    if(_currentDuration.inSeconds > 2){
        seek(Duration.zero);
    }else if(_currentSongIndex! > 0){
      currentSongIndex = _currentSongIndex! -1;
    }else{
      currentSongIndex = _playList.length - 1;
    }
  }


  //lisen to duration
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration){
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((position){
      _currentDuration = position;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }


  //dispose audio

  /*

  G E T T E R S

   */
List<Song> get playList => _playList;
int? get currentSongIndex => _currentSongIndex;
bool get isPlaying => _isPlaying;
Duration get currentDuration => _currentDuration;
Duration get totalDuration => _totalDuration;

/*

  S E T T E R S

   */
   set currentSongIndex (int? newIndex) {
    _currentSongIndex = newIndex;

    if(newIndex != null){
      play();
    }

    notifyListeners();
   }

}