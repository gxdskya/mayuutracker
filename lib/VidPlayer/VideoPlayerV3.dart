import 'package:csia/consts.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerV3 extends StatefulWidget {
  final String title;
  final String vidID;
  VideoPlayerV3({this.vidID,this.title});
  @override
  _VideoPlayerV3State createState() => _VideoPlayerV3State();
}

class _VideoPlayerV3State extends State<VideoPlayerV3> {
  YoutubePlayerController _controller;
  @override
  void initState(){
    super.initState();
    _controller = YoutubePlayerController(//initializes controller when initializing the widget
      initialVideoId: widget.vidID,
      params: YoutubePlayerParams(//initialize the player controller
        startAt: Duration(seconds: 0),
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myTheme.primaryColor,
      appBar: AppBar(
        title: Text(widget.title, style: kTextStyle,),
        backgroundColor: myTheme.accentColor,
      ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: YoutubePlayerIFrame(//player
                  controller: _controller,
                  aspectRatio: 16/9,
                ),
              ),
            ),
    );
  }
}
