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

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
      playlistTitle: snippet['playlistTitle']
    );
  }
}