import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/chatbot_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.developer_board,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Thông tin nhà phát triển',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoCard(
                  title: 'Ứng dụng',
                  content: 'Phân tích khuôn mặt và thần số học',
                  icon: Icons.psychology,
                ),
                _buildInfoCard(
                  title: 'Phiên bản',
                  content: '1.0.0',
                  icon: Icons.info,
                ),
                _buildInfoCard(
                  title: 'Liên hệ email',
                  content: 'nduc82157@gmail.com', // Replace with your email
                  icon: Icons.email,
                ),
                _buildInfoCard(
                  title: 'Website',
                  content: 'https://github.com/DUC23001865',
                  icon: Icons.web,
                  onTap: () {
                    _launchURL('https://github.com/DUC23001865');
                  },
                ),
                _buildInfoCard(
                  title: 'Facebook',
                  content: 'https://www.facebook.com/duc.nguyen.58278',
                  icon: Icons.facebook,
                  onTap: () {
                    _launchURL('https://www.facebook.com/duc.nguyen.58278');
                  },
                ),
              ],
            ),
          ),
          const ChatbotButton(),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
