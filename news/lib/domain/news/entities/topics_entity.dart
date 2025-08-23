class TopicsEntity {
  TopicsEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.img,
   this.isSaved = false,

  });
  final String? id;
  final String? name;
  final String? description;
  final String? img;
  late  bool isSaved;
}
