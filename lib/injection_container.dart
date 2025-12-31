import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/network/network_info.dart';
import 'features/customer/data/datasources/customer_remote_data_source.dart';
import 'features/customer/data/repositories/customer_repository_impl.dart';
import 'features/customer/domain/repositories/customer_repository.dart';
import 'features/customer/domain/usecases/get_customers.dart';
import 'features/customer/presentation/bloc/customer_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => CustomerBloc(getCustomersUseCase: sl()));
  sl.registerLazySingleton(() => GetCustomers(sl()));
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),);
  sl.registerLazySingleton<CustomerRemoteDataSource>(() => CustomerRemoteDataSourceImpl(dio: sl()),);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnection());
}