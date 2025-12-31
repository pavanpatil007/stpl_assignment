import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/customer.dart';

abstract class CustomerRepository {
  Future<Either<Failure, List<Customer>>> getCustomers({
    required int pageNo,
    required int pageSize
  });
}