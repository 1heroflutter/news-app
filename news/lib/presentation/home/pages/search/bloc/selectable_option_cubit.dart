import 'package:flutter_bloc/flutter_bloc.dart';

enum SearchType { news, topic ,source }

class SelectableOptionCubit extends Cubit<SearchType> {
  SelectableOptionCubit() : super(SearchType.news);
  void selectedNews() => emit(SearchType.news);
  void selectedTopic()=>emit(SearchType.topic);
  void selectedSource() => emit(SearchType.source);
}
