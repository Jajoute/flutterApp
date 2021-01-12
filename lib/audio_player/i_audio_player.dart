

enum AudioPlayerState {
  STOPPED,
  PLAYING,
  PAUSED,
  COMPLETED
}

abstract class IAudioPlayer {

  void play();
  void stop();
  void pause();

}
