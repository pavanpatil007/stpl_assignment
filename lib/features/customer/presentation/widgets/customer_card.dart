import 'package:flutter/material.dart';
import '../../domain/entities/customer.dart';
import 'customer_details_dialog.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  final int index;

  const CustomerCard({super.key, required this.customer, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<Color> patternColors = [Colors.red, Colors.green, Colors.blue];
    final Color nameColor = patternColors[index % 3];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: (){
          showDialog(
            context: context,
            builder: (context) => CustomerDetailsDialog(customer: customer),
          );
        },
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: customer.isCow == 1
                ? Image.asset("assets/cow.png")
                :customer.isBuffalo == 1
                ? Image.asset("assets/buffalo.png"):Image.asset("assets/placeholderimg.png"),
          ),
          title: Text(
            customer.fullName,
            style: TextStyle(color: nameColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text("Mobile: ${customer.mobileNo}"),
          trailing: const Icon(Icons.call, size: 14,color: Colors.grey,),
        ),
      ),
    );
  }
}