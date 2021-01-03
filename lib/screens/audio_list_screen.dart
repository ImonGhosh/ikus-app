import 'package:flutter/material.dart';
import 'package:ikus_app/components/cards/audio_card.dart';
import 'package:ikus_app/components/main_list_view.dart';
import 'package:ikus_app/i18n/strings.g.dart';
import 'package:ikus_app/model/audio.dart';
import 'package:ikus_app/screens/audio_screen.dart';
import 'package:ikus_app/service/audio_service.dart';
import 'package:ikus_app/utility/globals.dart';
import 'package:ikus_app/utility/ui.dart';

class AudioListScreen extends StatefulWidget {

  @override
  _AudioListScreenState createState() => _AudioListScreenState();
}

class _AudioListScreenState extends State<AudioListScreen> {

  List<Audio> audioGroups;

  @override
  void initState() {
    super.initState();
    loadAudio();
  }

  Future<void> loadAudio() async {
    audioGroups = await AudioService.instance.getAudio();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OvguColor.primary,
        title: Text(t.audioList.title),
      ),
      body: MainListView(
        children: [
          SizedBox(height: 30),
          if (audioGroups != null && audioGroups.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: Container(
                  child: Text(t.audioList.empty, style: TextStyle(color: OvguColor.secondaryDarken2, fontSize: 20)),
                ),
              ),
            ),
          if (audioGroups != null)
            ...audioGroups.map((audio) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: AudioCard(
                  audio: audio,
                  onTap: () {
                    pushScreen(context, () => AudioScreen(audio: audio));
                  },
                ),
              );
            }),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
