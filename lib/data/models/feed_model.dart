import '../../domain/entities/feed.dart';

class FeedModel extends Feed {
  FeedModel({
    required super.id,
    required super.video,
    required super.thumbnail,
    required super.description,
    required super.userName,
    required super.userImage,
    required super.createdAt,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      id: json["id"] ?? 0,
      video: (json["video"] ?? "").toString(),
      thumbnail: (json["image"] ?? "").toString(),
      description: (json["description"] ?? "").toString(),
      userName: (json["user"]?["name"] ?? "User").toString(),
      userImage: (json["user"]?["image"] ?? "https://i.pravatar.cc/150?img=3")
          .toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
    );
  }
}
