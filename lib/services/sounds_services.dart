import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';

final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

void playBoxingBellSound() {
  assetsAudioPlayer.open(Audio('assets/audios/boxing_bell.mp3'));
}

void playRingToneDevice() async {
  FlutterRingtonePlayer.play(
    android: AndroidSounds.ringtone,
    ios: IosSounds.bell,
    looping: true, // Android only - API >= 28
    volume: 1, // Android only - API >= 28
    asAlarm: true,
  );
  await Future.delayed(Duration(seconds: 2));
  FlutterRingtonePlayer.stop();
}

void vibrateDevice() async {
  if (await Vibration.hasVibrator()) {
    Vibration.vibrate(duration: 2000);
  }
}
