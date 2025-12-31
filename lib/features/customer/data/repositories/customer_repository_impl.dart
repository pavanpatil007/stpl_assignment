import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_remote_data_source.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CustomerRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Customer>>> getCustomers({
    required int pageNo,
    required int pageSize,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCustomers = await remoteDataSource.getCustomers(
          pageNo: pageNo,
          pageSize: pageSize,
        );
        return Right(remoteCustomers);
      } on ServerFailure catch (e) {
        return Left(e);
      } catch (e) {
        return const Left(ServerFailure("An unexpected error occurred"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}