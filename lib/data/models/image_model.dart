class ImageModel {
  final String id;
  final String url;
  final String key;
  final String firmedAt;

  ImageModel({
    required this.id,
    required this.url,
    required this.key,
    required this.firmedAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['url'],
      key: json['key'],
      firmedAt: json['firmedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'key': key,
      'firmedAt': firmedAt,
    };
  }

  ImageModel copyWith({
    String? id,
    String? url,
    String? key,
    String? firmedAt,
  }) {
    return ImageModel(
      id: id ?? this.id,
      url: url ?? this.url,
      key: key ?? this.key,
      firmedAt: firmedAt ?? this.firmedAt,
    );
  }

}
