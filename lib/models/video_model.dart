class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String playlistTitle;

  Video({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
    this.playlistTitle,
  });

  factory Video.fromMap(Map<String, dynamic> id, bool i) {
    if(i == true)
    {
      return Video(
      id: id['id']['videoId'],
      title: id['snippet']['title'],
      thumbnailUrl: id['snippet']['thumbnails']['high']['url'],
      channelTitle: id['snippet']['channelTitle'],
      playlistTitle: id['snippet']['playlistTitle']
    );
    }
    if(i == false)
    {
      return Video(
      id: id['resourceId']['videoId'],
      title: id['title'],
      thumbnailUrl: id['thumbnails']['medium']['url'],
      channelTitle: id['channelTitle'],
      playlistTitle: id['playlistTitle']
      );
    }
  }
}