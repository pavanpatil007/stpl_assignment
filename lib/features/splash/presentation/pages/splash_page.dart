import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < -100) {
            Navigator.pushReplacementNamed(context, AppRoutes.customerList);
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, Colors.blue.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                // 1. App Identity
                const Icon(Icons.architecture_rounded, size: 80, color: Colors.white),
                const SizedBox(height: 20),
                const Text(
                  "STPL ASSIGNMENT",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
                const SizedBox(height: 40),

                _buildInfoCard("Architecture", "Clean Architecture (Data, Domain, Presentation)"),
                _buildInfoCard("State Management", "BLoC Pattern with bloc_concurrency"),
                _buildInfoCard("Principles", "SOLID & OOP Principles"),
                _buildInfoCard("Key Features", "Pagination, Search, Network Guard, Unique UI"),

                const Spacer(),

                Column(
                  children: [
                    const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30),
                    const Text(
                      "SWIPE UP TO START",
                      style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // "Continue" button as fallback
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.customerList),
                      child: const Text("OR TAP TO CONTINUE", style: TextStyle(color: Colors.white30, fontSize: 10)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String desc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }}