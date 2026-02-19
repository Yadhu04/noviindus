class Feed {
  final int id;
  final String video;
  final String thumbnail;
  final String description;
  final String userName;
  final String userImage;
  final DateTime createdAt;

  Feed({
    required this.id,
    required this.video,
    required this.thumbnail,
    required this.description,
    required this.userName,
    required this.userImage,
    required this.createdAt,
  });
}
