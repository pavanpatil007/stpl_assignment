import '../../domain/entities/customer.dart';
import 'package:equatable/equatable.dart';

abstract class CustomerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final List<Customer> customers;
  final bool hasReachedMax;
  final String searchQuery;

  CustomerLoaded({
    required this.customers,
    this.hasReachedMax = false,
    this.searchQuery = "",
  });

  @override
  List<Object?> get props => [customers, hasReachedMax, searchQuery];
}

class CustomerError extends CustomerState {
  final String message;
  CustomerError(this.message);
}