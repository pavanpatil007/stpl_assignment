import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_routes.dart';
import '../bloc/customer_bloc.dart';
import '../bloc/customer_event.dart';
import '../bloc/customer_state.dart';
import '../widgets/customer_card.dart';
import '../widgets/shimmer_loader.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Customer List",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, AppRoutes.candidateInfoPage);

                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        context.read<CustomerBloc>().add(SearchCustomerEvent(value));
                      },
                      decoration: InputDecoration(
                        hintText: "Search customer name / number",
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        prefixIcon: Icon(Icons.search_rounded, color: Colors.blue.shade700),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        // Adding a clear button (Optional UX improvement)
                        suffixIcon: Icon(Icons.tune_rounded, color: Colors.blue.shade700, size: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.9) {
            final currentState = context.read<CustomerBloc>().state;
            if (currentState is CustomerLoaded && !currentState.hasReachedMax) {
              context.read<CustomerBloc>().add(LoadCustomersEvent());
            }
          }
          return true;
        },
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is CustomerLoading) {
              return const ShimmerLoader();
            }

            if (state is CustomerError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, style: const TextStyle(color: Colors.red)),
                    ElevatedButton(
                      onPressed: () => context.read<CustomerBloc>().add(LoadCustomersEvent(isRefresh: true)),
                      child: const Text("Retry"),
                    )
                  ],
                ),
              );
            }

            if (state is CustomerLoaded) {
              if (state.customers.isEmpty) {
                return const Center(child: Text("No customers found."));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<CustomerBloc>().add(LoadCustomersEvent(isRefresh: true));
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 20),
                  itemCount: state.hasReachedMax ? state.customers.length : state.customers.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.customers.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return CustomerCard(
                      customer: state.customers[index],
                      index: index,
                    );
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}