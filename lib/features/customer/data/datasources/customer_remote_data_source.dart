import 'package:dio/dio.dart';
import '../models/customer_model.dart';
import '../../../../core/error/failures.dart';

abstract class CustomerRemoteDataSource {
  Future<List<CustomerModel>> getCustomers({required int pageNo, required int pageSize});
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final Dio dio;

  CustomerRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CustomerModel>> getCustomers({required int pageNo, required int pageSize}) async {
    try {
      final response = await dio.get(
        'https://machintestapi.erpguru.in/api/CustomerDetails/GetCustomerDetails',
        queryParameters: {
          'pageno': pageNo,
          'pagesize': pageSize,
          'UnitId': 724,
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data['responseData'];
        return data.map((json) => CustomerModel.fromJson(json)).toList();
      } else {
        throw ServerFailure("Server Error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? "Connection Error");
    }
  }
}