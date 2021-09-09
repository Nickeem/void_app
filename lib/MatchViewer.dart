import 'constraints.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:video_viewer/video_viewer.dart';

class MatchViewer extends StatefulWidget {
  const MatchViewer(this.match,  {Key? key, this.DB=false}) : super(key: key);

  final Match match;
  final bool DB;


  @override
  _MatchViewerState createState() => _MatchViewerState();
}

class _MatchViewerState extends State<MatchViewer> {


  //Future<void> initializePlayer() async {}
  // nxt try yoyo player
  // https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8
  static final VideoViewerController controller = VideoViewerController();
  late MapEntry<String, String> initial;
  String link = "";
  String dropdownValue ="";



  @override
  void initState() {

    initial = widget.match.sources.entries.first;
    link = initial.key;
    dropdownValue = widget.match.sources.entries.first.key;

    super.initState();
  }

  Widget linkbuttons(){
    //final isSelected = <bool>[];
    final sources = <String>[];

    widget.match.sources.forEach((key, value) {
      sources.add(key);
    });


    return DropdownButton<String>(
      hint: Text("Select Link"),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        print("He4e");
        onLinkSelection(widget.match.sources.entries.firstWhere((element) => element.key == dropdownValue));
      },
      items: sources
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  void onLinkSelection(MapEntry<String, String> entry) async {
    final String linkName = entry.key;
    if (link != linkName) {
      //final String qualities = entry.value;
      final String url = entry.value;

      late Map<String, VideoSource> sources;

      if (url.contains("m3u8")) {
        sources = await VideoSource.fromM3u8PlaylistUrl(url);
      }/* else {
        sources = VideoSource.fromNetworkVideoSources(url);
      }*/

      final MapEntry<String, VideoSource> video = sources.entries.first;

      controller.closeSettingsMenu();

      await controller.changeSource(
        inheritPosition: false, //RESET SPEED TO NORMAL AND POSITION TO ZERO
        source: video.value,
        name: video.key,
      );

      link = linkName;
      controller.source = sources;
      setState(() {});
    } else {
      controller.closeSettingsMenu();
    }
  }

  @override
  void dispose() async {
    super.dispose();
    //await _videoViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String intUrl = widget.match.sources.entries.first.value;
    return widget.DB ? linkbuttons() : BetterPlayer.network("https://edgesports-plex.amagi.tv/playlist.m3u8?Urj7svfj=&Rkj2f3jk=&Czj1i9k6=");


    /*linkbuttons():VideoViewer(
      //onFullscreenFixLandscape: true,
      enableHorizontalSwapingGesture: false,
      enableFullscreenScale: true,
      controller: controller,
      source: VideoSource.fromNetworkVideoSources({
        "video":intUrl,
      }
      ),
      style: CustomVideoViewerStyle(match: widget.match, context: context),
    );*/


  }
}