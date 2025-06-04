import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatbotGreetingOverlay extends StatelessWidget {
  const ChatbotGreetingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    // Vị trí ước tính của nút chatbot (right: 16, bottom: 80)
    // Đặt overlay phía trên và hơi chếch sang trái nút
    return Positioned(
      right: 60, // Điều chỉnh vị trí sang trái hơn
      bottom: 120, // Điều chỉnh vị trí cao hơn
      child: Stack(
        alignment:
            Alignment.bottomRight, // Đặt mũi tên ở góc dưới bên phải của Stack
        children: [
          Container(
            margin: const EdgeInsets.only(
                bottom: 8), // Thêm margin để tạo không gian cho mũi tên
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              'Chatbot xin chào!',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                color: Colors.purple.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 10, // Điều chỉnh vị trí mũi tên
            bottom: -8, // Điều chỉnh vị trí mũi tên thấp hơn và khớp nối liền
            child: CustomPaint(
              painter: DropletTailPainter(color: Colors.white.withOpacity(0.9)),
              child: const SizedBox(
                width: 20, // Kích thước mũi tên
                height: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CustomPainter để vẽ hình giọt nước (mũi tên bong bóng thoại)
class DropletTailPainter extends CustomPainter {
  final Color color;

  DropletTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    // Bắt đầu ở cạnh trên của CustomPaint (tương ứng với đáy của container chat)
    path.moveTo(
        size.width * 0.2, 0); // Điểm bắt đầu trên cạnh trên, hơi lệch trái

    // Vẽ đường cong xuống tới đỉnh nhọn
    path.quadraticBezierTo(
      size.width * 0.5, // Control point X (gần tâm ngang)
      size.height * 0.8, // Control point Y (kéo cong xuống)
      size.width, // End point X (tại cạnh phải)
      size.height, // End point Y (tại cạnh dưới - đỉnh nhọn giả định)
    );

    // Vẽ đường cong ngược lại từ đỉnh nhọn về cạnh trên
    path.quadraticBezierTo(
      size.width * 0.8, // Control point X (hơi lệch phải)
      size.height * 0.5, // Control point Y (kéo cong lên)
      size.width *
          0.8, // End point X (trên cạnh trên, hơi lệch phải so với bắt đầu)
      0, // End point Y (trên cạnh trên)
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
