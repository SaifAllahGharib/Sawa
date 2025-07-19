import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_remote_data_source.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final IHomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);
}
