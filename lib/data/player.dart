import 'package:assets_audio_player/assets_audio_player.dart';

class Player {
  static final AssetsAudioPlayer playerBG = AssetsAudioPlayer();
  static final AssetsAudioPlayer playerTap = AssetsAudioPlayer();
  static final AssetsAudioPlayer playerW = AssetsAudioPlayer();
  static final AssetsAudioPlayer playerL = AssetsAudioPlayer();
  static final AssetsAudioPlayer playerK = AssetsAudioPlayer();
  static init() async {
    await playerBG.open(
      Audio('assets/sounds/backgr.mp3'),
      loopMode: LoopMode.single,
      autoStart: false,
      playInBackground: PlayInBackground.disabledRestoreOnForeground,
    );
    await playerTap.open(
      Audio('assets/sounds/tap.mp3'),
      autoStart: false,
    );
    await playerW.open(
      Audio('assets/sounds/win.mp3'),
      autoStart: false,
    );
    await playerL.open(
      Audio('assets/sounds/lose.mp3'),
      autoStart: false,
    );
    await playerK.open(
      Audio('assets/sounds/key.mp3'),
      autoStart: false,
    );
  }

  static backgroundPlay() {
    playerBG.play();
  }

  static backgroundMute() {
    playerBG.pause();
  }

  static tabPlay() {
    playerTap.play();
  }

  static winPlay() {
    playerW.play();
  }

  static losePlay() {
    playerL.play();
  }

  static keyPlay() {
    playerK.play();
  }
}
