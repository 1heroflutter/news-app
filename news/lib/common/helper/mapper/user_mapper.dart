import 'package:news/data/user/models/user_req_params.dart';
import 'package:news/domain/user/entities/user_req_params.dart';


class UserMapper {
  static UserEntity toEntity(UserModel user) {
    return UserEntity(
      isFirstLogin: user.isFirstLogin,
      id: user.id,
      email: user.email,
      username: user.username,
      phoneNumber: user.phoneNumber,
      fullName: user.fullName,
      image: user.image,
      searchHistory: user.searchHistory
          ?.map((history) => SearchHistoryMapper.toEntity(history))
          .toList(),
      v: user.v,
      otp: user.otp,
      country: user.country,
      preferredCategory: user.preferredCategory,
      following: user.following
    );
  }
}

class SearchHistoryMapper {
  static SearchHistoryEntity toEntity(SearchHistoryModel model) {
    return SearchHistoryEntity(
      id: model.id,
      image: model.image,
      title: model.title,
      searchType: model.searchType,
      createdAt: model.createdAt,
    );
  }
}
