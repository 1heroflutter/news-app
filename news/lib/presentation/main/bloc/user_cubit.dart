import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/bloc/generic_data_state.dart';
import 'package:news/common/helper/mapper/user_mapper.dart';
import 'package:news/domain/news/usecase/get_sources.dart';
import 'package:news/domain/user/usecases/update_user_profile.dart';
import 'package:news/presentation/main/bloc/user_state.dart';
import 'package:news/presentation/splash/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/topic/list_topic.dart';
import '../../../data/user/models/user_req_params.dart';
import '../../../domain/news/entities/sources_entity.dart';
import '../../../domain/news/entities/topics_entity.dart';
import '../../../domain/user/entities/user_req_params.dart';
import '../../../domain/user/usecases/get_user_from_local.dart';
import '../../../service_locator.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  late List<String> selectedTopic = [];
  late List<String> selectedSource = [];
  List<TopicsEntity> topicList = listTopics;
  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final userEntity = UserMapper.toEntity(UserModel.fromJson(userMap));
      selectedSource = userEntity.following ?? [];
      emit(UserLoaded(userEntity));
    }
  }

  Future<void> loadTopicsFromPrefs() async {
    emit(TopicLoading());
    if (state is! UserLoaded) {
      await loadUserFromPrefs();
    }
    if (state is UserLoaded) {
      final currentUser = (state as UserLoaded).user;
      final savedTopics = currentUser.preferredCategory ?? [];
      selectedTopic = savedTopics;
      for (var topic in topicList) {
        topic.isSaved = savedTopics.contains(topic.name?.toLowerCase());
      }
      emit(TopicLoaded(topic: topicList));
    }
  }


  Future<void> updateUserProfile(UserEntity updatedUser) async {
    emit(UserLoading());

    final result = await sl<UpdateUserProfileUseCase>()
        .call(params: UserModel.fromEntity(updatedUser));

    result.fold(
          (error) => emit(UserError(error)),
          (_) async {
        final prefs = await SharedPreferences.getInstance();
        final userJson = jsonEncode(UserModel.fromEntity(updatedUser).toJson());
        await prefs.setString('user', userJson);
        setUser();
        emit(UserLoaded(updatedUser));
      },
    );
  }
  Future<void> getSource() async{
    emit(SourceLoading());
    final result = await sl<GetSourcesUseCase>().call();
    result.fold((error){
      emit(UserError(error));
    }, (data){
      if(state is UserLoaded){
        final currentUser = (state as UserLoaded).user;
        final List<String> savedSources = currentUser.following!;
        selectedSource = savedSources;
        for (SourcesEntity source in data) {
          source.isFollowed = savedSources.contains(source.name);
        }
        emit(SourceLoaded(sources: data));
      }
    }
    );
  }

}