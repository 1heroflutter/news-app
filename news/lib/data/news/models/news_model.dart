class NewsModel {
  NewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final SourceModel? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;
  factory NewsModel.fromJson(Map<String, dynamic> json){
    return NewsModel(
      source: json["source"] == null ? null : SourceModel.fromJson(json["source"]),
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      content: json["content"],
    );
  }
}

class SourceModel {
  SourceModel({
    required this.id,
    required this.name,
  });

  final dynamic id;
  final String? name;

  factory SourceModel.fromJson(Map<String, dynamic> json){
    return SourceModel(
      id: json["id"],
      name: json["name"],
    );
  }

}
