import 'package:flutter/material.dart';
import 'package:flutter_youtube_api/models/channel_model.dart';
import 'package:flutter_youtube_api/models/video_model.dart';
import 'package:flutter_youtube_api/screens/video_screen.dart';


import 'package:flutter_youtube_api/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Channel _channel;
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCwXdFgeE9KYzlDdR7TG9cMw');
    setState(() {
      _channel = channel;
    });
    if (!_isLoading &&
        _channel.videos.length != int.parse(_channel.videoCount))
      _loadMoreVideos();
  }
  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }
PageController pageController=PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
      return Container(
        child:PageView.builder(

        scrollDirection: Axis.vertical,
      controller: pageController,
onPageChanged: (index){
          setState(() {
index=index%(_channel.videos.length);

          });
},

         itemCount: _channel.videos.length,
    itemBuilder: (context,index){


    return _videoPlayer(_channel.videos[index].id);
    },
    ),);}




  Widget _videoPlayer(String id) {
return   Container(
    height: MediaQuery.of(context).size.height/1.5,
    width: MediaQuery.of(context).size.width,
    child: VideoScreen(id: id),
  );
  }


}