import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCustomersEvent extends CustomerEvent {
  final bool isRefresh;
  LoadCustomersEvent({this.isRefresh = false});
}

class SearchCustomerEvent extends CustomerEvent {
  final String query;
  SearchCustomerEvent(this.query);
}