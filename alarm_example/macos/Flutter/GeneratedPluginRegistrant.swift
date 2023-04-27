//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
<<<<<<< HEAD
=======
import audioplayers_darwin
>>>>>>> 8e3031876c4fe357c29912609b1e59682fb7ae30
import flutter_local_notifications
import just_audio
import path_provider_foundation
import shared_preferences_foundation

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
<<<<<<< HEAD
=======
  AudioplayersDarwinPlugin.register(with: registry.registrar(forPlugin: "AudioplayersDarwinPlugin"))
>>>>>>> 8e3031876c4fe357c29912609b1e59682fb7ae30
  FlutterLocalNotificationsPlugin.register(with: registry.registrar(forPlugin: "FlutterLocalNotificationsPlugin"))
  JustAudioPlugin.register(with: registry.registrar(forPlugin: "JustAudioPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
}
