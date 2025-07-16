import 'package:intern_intelligence_social_media_application/core/api/db_api.dart';

sealed class HomeRemoteDataSource {}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DbApi _dbApi;

  HomeRemoteDataSourceImpl(this._dbApi);
}
