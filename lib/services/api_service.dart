import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:raon/models/channel_model.dart';
import 'package:raon/models/video_model.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<Channel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': 'AIzaSyDRfDu7S4WKQQ_p2HH2elvsh0edaaKTbmY',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    print("GET CHANNEL");
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      print(response.statusCode);
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
     channel.videos = await fetchVideosFromPlaylist(playlistId:'PLsOs4PXXz9yGo9W5ymlZeHT8Rrg2kktfz',searchVideo: '');
      return channel;
    } else {
      print("HTTP");
      throw json.decode(response.body)['error']['message'];
    }
  }
/*
  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '20',
      'pageToken': _nextPageToken,
      'key': 'AIzaSyB556zIbD2yOaHCNPbimGfqYN7TdbM8vcY',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
            (json) =>
            videos.add(
              Video.fromMap(json['snippet']),
            ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
  
*/
Future<List<Video>> fetchVideosFromPlaylist({String playlistId, String searchVideo}) async {
  if(searchVideo != '')
  {
    print("IFFFFFFFFFFFFFFFFFFFFFFF");
    Map<String, String> parameters = {
      'part': 'snippet',
      'channelId' : 'UCQn1FqrR2OCjSe6Nl4GlVHw',
      'q': searchVideo,
      'maxResults' : '20',
      'key': 'AIzaSyDRfDu7S4WKQQ_p2HH2elvsh0edaaKTbmY',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/search',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
            (json) =>
            videos.add(
              Video.fromMap(json,true),
            ),
      );
      return videos;
      print("VIDEOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
      print(videosJson);
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
  if(searchVideo == ''){
    print("ELSEEEEEEEEEEE");
  Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '20',
      'pageToken': _nextPageToken,
      'key': 'AIzaSyDRfDu7S4WKQQ_p2HH2elvsh0edaaKTbmY',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
            (json) =>
            videos.add(
              Video.fromMap(json['snippet'], false),
            ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
  
}
  
}
