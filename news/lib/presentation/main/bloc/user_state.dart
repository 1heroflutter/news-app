import 'package:news/domain/user/entities/user_req_params.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/news/entities/sources_entity.dart';
import '../../../domain/news/entities/topics_entity.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;
  const UserLoaded(this.user);
  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
class TopicLoading extends UserState {}

class TopicLoaded extends UserState{
  final List<TopicsEntity> topic;
  const TopicLoaded({required this.topic});
  @override
  List<Object?> get props => [topic];
}
class SourceLoading extends UserState {}

class SourceLoaded extends UserState {
  final List<SourcesEntity> sources;
  const SourceLoaded({required this.sources});
  @override
  List<Object?> get props => [sources];
}

