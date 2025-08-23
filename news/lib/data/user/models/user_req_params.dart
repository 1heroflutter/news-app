import '../../../domain/user/entities/user_req_params.dart';


class UserModel {
  UserModel({
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
  final List<SearchHistoryModel>? searchHistory;
  final int? v;
  final String? otp;
  final String? country;
  final List<String>? preferredCategory;

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      isFirstLogin: json["isFirstLogin"],
      following: json["following"] == null ? [] : List<String>.from(json["following"]!.map((x) => x)),
      id: json["_id"],
      email: json["email"],
      username: json['username']??"",
      phoneNumber: json['phoneNumber']??"",
      fullName: json["fullName"]??"",
      image: json["image"],
      searchHistory: json["searchHistory"] == null ? [] : List<SearchHistoryModel>.from(json["searchHistory"]!.map((x) => SearchHistoryModel.fromJson(x))),
      v: json["__v"],
      otp: json["otp"],
      country: json["country"],
      preferredCategory: json["preferredCategory"] == null ? [] : List<String>.from(json["preferredCategory"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (username != null) data['username'] = username;
    if (fullName != null) data['fullName'] = fullName;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (image != null) data['image'] = image;
    if (country != null) data['country'] = country;
    if (preferredCategory != null) data['preferredCategory'] = preferredCategory;
    if (following != null) data['following'] = following;
    if (searchHistory != null) {
      data['searchHistory'] = searchHistory!.map((e) => e.toJson()).toList();
    }

    return data;
  }
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      isFirstLogin: entity.isFirstLogin,
      following: entity.following,
      id: entity.id,
      email: entity.email,
      username: entity.username,
      phoneNumber: entity.phoneNumber,
      fullName: entity.fullName,
      image: entity.image,
      searchHistory: entity.searchHistory
          ?.map((e) => SearchHistoryModel.fromEntity(e))
          .toList(),
      v: entity.v,
      otp: entity.otp,
      country: entity.country,
      preferredCategory: entity.preferredCategory,
    );
  }

  factory UserModel.updateCategory(List<String> category) {
    return UserModel(
      isFirstLogin: null,
      id: null,
      email: null,
      username: null,
      phoneNumber: null,
      fullName: null,
      image: null,
      searchHistory: null,
      v: null,
      otp: null,
      country: null,
      preferredCategory: category,
      following: null
    );
  }

}

class SearchHistoryModel {
  SearchHistoryModel({
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

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json){
    return SearchHistoryModel(
      id: json["id"],
      image: json["image"],
      title: json["title"],
      searchType: json["searchType"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "searchType": searchType,
    "createdAt": createdAt?.toIso8601String(),
  };
  factory SearchHistoryModel.fromEntity(SearchHistoryEntity entity) {
    return SearchHistoryModel(
      id: entity.id,
      image: entity.image,
      title: entity.title,
      searchType: entity.searchType,
      createdAt: entity.createdAt,
    );
  }

}
