import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:raon/models/channel_model.dart';
import 'package:raon/models/video_model.dart';
import 'package:raon/services/api_service.dart';

class VideoScreen extends StatefulWidget {

  final String id;

  VideoScreen({this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  YoutubePlayerController _controller;
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        forceHD: true,
        loop: true,
      enableCaption: false),
    );
    _initChannel();
  }

  @override
  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCQn1FqrR2OCjSe6Nl4GlVHw');
    setState(() {
      _channel = channel;
    });
  }
  bool oynat = false;
  bool oyna()
  {
    oynat = !oynat;
    return oynat;
  }
  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoScreen(id: video.id),
            ),
          ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
           Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  int itemCount = null;
  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId:'PLsOs4PXXz9yGo9W5ymlZeHT8Rrg2kktfz', searchVideo: ''); //PLsOs4PXXz9yGo9W5ymlZeHT8Rrg2kktfz
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;

    });
    _isLoading = false;
  }


  IndexedWidgetBuilder itemBuilder;
  Widget build(BuildContext context) {
    return Stack(children: [
     Container(color: Colors.black,
       margin: EdgeInsets.all(20.0),
       padding: EdgeInsets.all(20.0),
       alignment: Alignment.topCenter, child: Container(color: Colors.black,
            margin: EdgeInsets.only(top: 0),
            padding: EdgeInsets.only(top: 0),),),
      NotificationListener<ScrollUpdateNotification>(
          child: ListView.builder(
            padding: EdgeInsets.all(0),
              itemCount: 1 + _channel.videos.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    color: Colors.purple.withOpacity(0),
                    child: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        ),

                  );
                }
                Video video = _channel.videos[index - 1];
                return _buildVideo(video);
              }
          )
      ),
      ]
      );
  }
}
