import 'package:flutter/material.dart';
import 'chatbot_widget.dart';

class ChatbotButton extends StatefulWidget {
  const ChatbotButton({super.key});

  @override
  State<ChatbotButton> createState() => _ChatbotButtonState();
}

class _ChatbotButtonState extends State<ChatbotButton> {
  double _xPosition = 0;
  double _yPosition = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonSize = 56.0; // Kích thước mặc định của FloatingActionButton

    return Positioned(
      right: 16 + _xPosition,
      bottom: 80 + _yPosition,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            // Giới hạn di chuyển theo chiều ngang
            double newX = _xPosition - details.delta.dx;
            if (newX >=
                    -screenSize.width + buttonSize + 32 && // Giới hạn bên trái
                newX <= screenSize.width - buttonSize - 32) {
              // Giới hạn bên phải
              _xPosition = newX;
            }

            // Giới hạn di chuyển theo chiều dọc
            double newY = _yPosition - details.delta.dy;
            if (newY >=
                    -screenSize.height +
                        buttonSize +
                        96 && // Giới hạn phía dưới
                newY <= screenSize.height - buttonSize - 96) {
              // Giới hạn phía trên
              _yPosition = newY;
            }
          });
        },
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.8,
                margin: const EdgeInsets.all(16),
                child: const ChatbotWidget(),
              ),
            );
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.chat_bubble_outline,
            color: Colors.purple.shade900,
          ),
        ),
      ),
    );
  }
}
