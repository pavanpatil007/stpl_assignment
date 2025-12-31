import 'package:flutter/material.dart';
import '../../domain/entities/customer.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailsDialog extends StatelessWidget {
  final Customer customer;

  const CustomerDetailsDialog({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  child: customer.isCow == 1
                      ? Image.asset("assets/cow.png")
                      :customer.isBuffalo == 1
                      ? Image.asset("assets/buffalo.png"):Image.asset("assets/placeholderimg.png"),
                ),
                const SizedBox(height: 12),
                Text(
                  customer.fullName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  customer.isCow == 1 ? "Cow" :customer.isBuffalo == 1 ? "Buffalo":"Unknown",
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_android_rounded, color: Colors.blue.shade800),
                    const SizedBox(width: 10),
                    Text(
                      customer.mobileNo.isEmpty ? "No Number Provided" : customer.mobileNo,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: customer.mobileNo.isEmpty ?null:() => _makePhoneCall(customer.mobileNo),
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: const Text(
                      "CALL NOW",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close", style: TextStyle(color: Colors.grey.shade600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }
}