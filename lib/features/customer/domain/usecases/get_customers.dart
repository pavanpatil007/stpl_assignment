import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class GetCustomers implements UseCase<List<Customer>, GetCustomersParams> {
  final CustomerRepository repository;

  GetCustomers(this.repository);

  @override
  Future<Either<Failure, List<Customer>>> call(GetCustomersParams params) async {
    return await repository.getCustomers(
      pageNo: params.pageNo,
      pageSize: params.pageSize,
    );
  }
}

class GetCustomersParams extends Equatable {
  final int pageNo;
  final int pageSize;

  const GetCustomersParams({
    required this.pageNo,
    required this.pageSize,
  });

  @override
  List<Object?> get props => [pageNo, pageSize];
}