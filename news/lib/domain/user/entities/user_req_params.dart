class UserEntity {
  UserEntity({
    required this.isFirstLogin,
    required this.following,
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.fullName,
    required this.image,
    required this.searchHistory,
    required this.v,
    required this.otp,
    required this.country,
    required this.preferredCategory,
  });

  final bool? isFirstLogin;
  final List<String>? following;
  final String? id;
  final String? email;
  final String? username;
  final String? phoneNumber;
  final String? fullName;
  final String? image;
  final List<SearchHistoryEntity>? searchHistory;
  final int? v;
  final String? otp;
  final String? country;
  final List<String>? preferredCategory;

  UserEntity copyWith({
    bool? isFirstLogin,
    List<String>? following,
    String? id,
    String? email,
    String? username,
    String? phoneNumber,
    String? fullName,
    String? image,
    List<SearchHistoryEntity>? searchHistory,
    int? v,
    String? otp,
    String? country,
    List<String>? preferredCategory,
  }) {
    return UserEntity(
      isFirstLogin: isFirstLogin ?? this.isFirstLogin,
      following: following ?? this.following,
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      image: image ?? this.image,
      searchHistory: searchHistory ?? this.searchHistory,
      v: v ?? this.v,
      otp: otp ?? this.otp,
      country: country ?? this.country,
      preferredCategory: preferredCategory ?? this.preferredCategory,
    );
  }
}

class SearchHistoryEntity {
  SearchHistoryEntity({
    required this.id,
    required this.image,
    required this.title,
    required this.searchType,
    required this.createdAt,
  });

  final String? id;
  final String? image;
  final String? title;
  final String? searchType;
  final DateTime? createdAt;

}
