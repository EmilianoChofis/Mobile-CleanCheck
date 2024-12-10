import 'package:mobile_clean_check/data/models/models.dart';

class ReportModel {
  String? id;
  String description;
  String? createdAt;
  String? status;
  String? userId;
  String? roomId;
  List<ImageModel>? images;
  List<String> files;
  UserModel? user;
  RoomModel? room;

  ReportModel({
    this.id,
    required this.description,
    this.createdAt,
    this.status,
    this.userId,
    this.roomId,
    this.images,
    this.files = const [],
    this.user,
    this.room,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      description: json['description'],
      createdAt: json['createdAt'],
      status: json['status'],
      userId: json['userId'],
      roomId: json['roomId'],
      images: json['images'] != null
          ? (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList()
          : null,
      files: json['files'] != null
          ? (json['files'] as List).map((e) => e.toString()).toList()
          : [],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      room: json['room'] != null ? RoomModel.fromJson(json['room']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'createdAt': createdAt,
      'status': status,
      'userId': userId,
      'roomId': roomId,
      'images': images?.map((e) => e.toJson()).toList(),
      'files': files,
      'user': user?.toJson(),
      'room': room?.toJson(),
    };
  }

  ReportModel copyWith({
    String? id,
    String? createdAt,
    String? status,
    String? userId,
    String? roomId,
    List<ImageModel>? images,
    List<String>? files,
    UserModel? user,
    RoomModel? room,
  }) {
    return ReportModel(
      id: id ?? this.id,
      description: description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      images: images ?? this.images,
      files: files ?? this.files,
      user: user ?? this.user,
      room: room ?? this.room,
    );
  }
}
