import 'package:dartz/dartz.dart';

abstract class NewsRepository{
  Future<Either> getEverything();
  Future<Either> getTrending();
  Future<Either> getNewsBySource(String name);
  Future<Either> getByCategory(String category);
  Future<Either> search(String context);
  Future<Either> getSources();
}