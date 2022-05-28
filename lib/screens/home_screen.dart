import 'package:flutter/material.dart';
import 'package:raon/models/channel_model.dart';
import 'package:raon/models/video_model.dart';
import 'package:raon/screens/video_screen.dart';
import 'package:raon/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController editingController = TextEditingController();
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCQn1FqrR2OCjSe6Nl4GlVHw');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      width: 320,
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        children: <Widget> [
          Expanded(
              child: TextField(
            controller: editingController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              _loadMoreVideos(value, true);
            },
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search, color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.redAccent,
                  width: 2.0,
                ),
              ),
            ),
          )),
          Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              width: 320,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35.0,
                    backgroundImage: NetworkImage(_channel.profilePictureUrl),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _channel.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${_channel.subscriberCount} Radoongs',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
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
                  fontSize: 16.0,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos(String id, bool val) async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance.fetchVideosFromPlaylist(
        playlistId: 'PLsOs4PXXz9yGo9W5ymlZeHT8Rrg2kktfz',searchVideo: id);

    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    if(val == false)
    {
    setState(() {
      _channel.videos = allVideos;
    });
    }
    if(val == true)
    {
    setState(() {
      _channel.videos = moreVideos;
    });
    }
    _isLoading = false;
  }

  // _loadThatVideo(String tex) async {
  //   _isLoading = true;
  //   List<Video> moreVideos = await APIService.instance
  //       .fetchVideosFromPlaylist(playlistId:'PLsOs4PXXz9yGo9W5ymlZeHT8Rrg2kktfz');
  //   print(moreVideos);
  //   setState(() {
  //     _channel.videos = moreVideos;
  //   });
  //   _isLoading = false;
  // }
/*
  _Search(){
    Video video;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search...'
        ),
        onChanged: (text) {
         Video video = _loadThatVideo(text);
        },
      ),
    );
  }

  _listItem(index){
    if (index == 0) {
      return _buildProfileInfo();
    }
    Video video = _channel.videos[index -1];
    return _buildVideo(video);
  }
*/
/*
  Future<void> filterSearchResults(String query) async {
    List<Video> dummySearchList;
    List<Video> dummyListData;
    _loadMoreVideos();
    dummySearchList.addAll(_channel.videos);
    if(query.isNotEmpty) {
      dummySearchList.forEach((item) {
        if(item.title.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _channel.videos.clear();
        _channel.videos.addAll(dummyListData);
      });
      return;
    } else {
      setState((){
          _channel.videos.clear();
      _channel.videos.addAll(dummySearchList);
      });
    }
  }

*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading) {
                  print("load!!!!!!!!!!");
                    _loadMoreVideos('', false);
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 1 + _channel.videos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildProfileInfo();
                  }
                  Video video = _channel.videos[index - 1];
                  return _buildVideo(video);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}
