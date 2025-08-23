class SourcesEntity {
  SourcesEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
    this.isFollowed = false,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? url;
  final String? category;
  final String? language;
  final String? country;
  late bool? isFollowed;

}
