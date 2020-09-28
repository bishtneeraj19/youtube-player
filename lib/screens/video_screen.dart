import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;

  VideoScreen({this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    );
    print(_controller.value.position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator:false,

        ),
        Container(
            margin: EdgeInsets.only(bottom: 0,top: 200),
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _controller.seekTo( _controller.value.position- Duration(hours: 0,seconds: 15,minutes: 0));
                    });
                  },
                  child: Icon(Icons.replay_10,color: Colors.white,),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if(_controller.value.isPlaying){
                        _controller.pause();

                      }else{
                      _controller.play();


                      }
                      print(_controller.value.position);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left:60,right: 60),
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        color: Colors.white),
                    child: Center(

                      child: Icon((_controller.value.isPlaying?Icons.pause:Icons.play_arrow),color: Colors.blue,),
                    ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    setState(() {

                      _controller.seekTo( _controller.value.position+ Duration(hours: 0,seconds: 15,minutes: 0));
                    });
                  },
                  child: Icon(Icons.forward_10,color: Colors.white,),
                ),

                ]),
    )],
            ))
    ;
  }
}
