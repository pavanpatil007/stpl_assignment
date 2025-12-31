import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_customers.dart';
import '../../domain/entities/customer.dart';
import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetCustomers getCustomersUseCase;

  int _currentPage = 1;
  final int _pageSize = 10;
  final List<Customer> _allFetchedCustomers = [];
  bool _isFetching = false;

  CustomerBloc({required this.getCustomersUseCase}) : super(CustomerInitial()) {
    on<LoadCustomersEvent>(
      _onLoadCustomers,
      transformer: droppable(),
    );

    on<SearchCustomerEvent>(_onSearchCustomers);
  }

  Future<void> _onLoadCustomers(LoadCustomersEvent event, Emitter<CustomerState> emit) async {
    if (event.isRefresh) {
      _currentPage = 1;
      _allFetchedCustomers.clear();
    }

    if (state is CustomerLoaded && (state as CustomerLoaded).hasReachedMax && !event.isRefresh) return;
    if (_isFetching) return;

    _isFetching = true;

    if (_currentPage == 1) emit(CustomerLoading());

    final result = await getCustomersUseCase(GetCustomersParams(
      pageNo: _currentPage,
      pageSize: _pageSize,
    ));

    result.fold(
          (failure) {
        _isFetching = false;
        emit(CustomerError(failure.message));
      },
          (newCustomers) {
        final existingIds = _allFetchedCustomers.map((e) => e.customerId).toSet();
        final uniqueNewCustomers = newCustomers.where((c) => !existingIds.contains(c.customerId)).toList();

        _allFetchedCustomers.addAll(uniqueNewCustomers);
        _currentPage++;
        _isFetching = false;

        emit(CustomerLoaded(
          customers: List.from(_allFetchedCustomers),
          hasReachedMax: newCustomers.length < _pageSize,
        ));
      },
    );
  }

  void _onSearchCustomers(SearchCustomerEvent event, Emitter<CustomerState> emit) {
    if (_allFetchedCustomers.isEmpty) return;

    final query = event.query.toLowerCase();
    final filtered = _allFetchedCustomers.where((customer) {
      return customer.fullName.toLowerCase().contains(query) || customer.phoneNumber.toLowerCase().contains(query);
    }).toList();

    emit(CustomerLoaded(
      customers: filtered,
      hasReachedMax: true,
      searchQuery: event.query,
    ));
  }
}