import 'package:news/domain/news/entities/sources_entity.dart';

import '../../../data/news/models/sources_model.dart';

class SourcesMapper {
  static SourcesEntity toEntity(SourcesModel model) {
    return SourcesEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      url: model.url,
      category: model.category,
      language: model.language,
      country: model.country,
    );
  }
}
