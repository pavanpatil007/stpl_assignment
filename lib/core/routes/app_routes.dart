import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stpl_assignment/features/splash/presentation/pages/candidate_info_page.dart';
import '../../features/customer/presentation/pages/customer_list_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../injection_container.dart';
import '../../features/customer/presentation/bloc/customer_bloc.dart';
import '../../features/customer/presentation/bloc/customer_event.dart';

class AppRoutes {
  static const String splash = '/';
  static const String customerList = '/customer-list';
  static const String candidateInfoPage = '/candidate-info';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case candidateInfoPage:
        return MaterialPageRoute(builder: (_) => const CandidateInfoPage());

      case customerList:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<CustomerBloc>()..add(LoadCustomersEvent()),
            child: const CustomerListPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}