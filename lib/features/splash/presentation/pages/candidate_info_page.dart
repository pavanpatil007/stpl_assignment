import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateInfoPage extends StatelessWidget {
  const CandidateInfoPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Candidate Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                      .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 2.seconds, curve: Curves.easeInOut)
                      .fadeOut(begin: 0.3),

                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue,
                    backgroundImage: AssetImage("assets/profile_photo.png"), // Add your photo here
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms).scale(delay: 200.ms),

            const SizedBox(height: 24),

            const Text(
              "PAVAN PATIL",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ).animate().slideY(begin: 0.3, end: 0).fadeIn(),

            Text(
              "Flutter Developer | Mobile Development Enthusiast",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 32),
            _buildSectionCard(
              title: "About Me",
              content: "Hi, I am a Senior Flutter Developer with over 5 years of experience in Flutter. I have worked on multiple production-level applications, handling end-to-end development including UI, state management, API integration, and performance optimization. For the last two years, I’ve also been leading a tech team, contributing to architecture decisions and mentoring developers.",
            ).animate().fade(delay: 600.ms).slideX(begin: -0.1, end: 0),

            const SizedBox(height: 20),

            // 4. Contact & Social Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: [
                _buildContactTile(Icons.email_outlined, "Email", () => _launchUrl("mailto:patilpavan0001@email.com")),
                _buildContactTile(Icons.phone_outlined, "Contact", () => _launchUrl("tel:+917020740710")),
                _buildContactTile(Icons.link_rounded, "LinkedIn", () => _launchUrl("https://www.linkedin.com/in/pavan-patil1/")),
                _buildContactTile(Icons.code_rounded, "GitHub", () => _launchUrl("https://github.com/pavanpatil007")),
              ],
            ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),

            const SizedBox(height: 30),

            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: (){
                _launchUrl("https://github.com/pavanpatil007/stpl_assignment");
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 8),
                    const Text("View Assignment Source", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
                  .shimmer(delay: 2.seconds, duration: 1500.ms)
                  .moveY(begin: 0, end: -5, duration: 2.seconds),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Text(content, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildContactTile(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.blue.shade600),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}