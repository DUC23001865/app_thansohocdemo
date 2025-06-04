import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detailed_meaning_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'analysis_result_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:thansohoc/services/face_analysis_service.dart';
import '../widgets/chatbot_button.dart';

class ResultScreen extends StatefulWidget {
  final String name;
  final DateTime birthDate;

  const ResultScreen({
    super.key,
    required this.name,
    required this.birthDate,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  File? _imageFile;
  bool _isAnalyzing = false;
  String? _analysisResult;

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  int calculateLifePathNumber(DateTime date) {
    int sum = date.day + date.month + date.year;
    while (sum > 9) {
      sum = sum.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }
    return sum;
  }

  String getLifePathMeaning(int number) {
    final meanings = {
      1: 'Lãnh đạo, độc lập, sáng tạo',
      2: 'Hợp tác, cân bằng, hòa bình',
      3: 'Sáng tạo, biểu đạt, vui vẻ',
      4: 'Ổn định, thực tế, trật tự',
      5: 'Tự do, phiêu lưu, thay đổi',
      6: 'Tình yêu, trách nhiệm, hài hòa',
      7: 'Tâm linh, trí tuệ, phân tích',
      8: 'Quyền lực, tham vọng, thành công',
      9: 'Nhân đạo, trí tuệ, hoàn thiện',
    };
    return meanings[number] ?? 'Không có ý nghĩa';
  }

  String getAgeAdvice(int age) {
    if (age < 18) {
      return 'Giai đoạn này là thời gian để học hỏi, khám phá bản thân và xây dựng nền tảng kiến thức. Hãy tích cực tham gia các hoạt động ngoại khóa và tìm hiểu những điều mới mẻ.';
    } else if (age >= 18 && age <= 25) {
      return 'Đây là thời kỳ quan trọng để xác định hướng đi trong sự nghiệp và học vấn. Hãy mở rộng mạng lưới quan hệ và đừng ngại thử thách bản thân với những điều mới.';
    } else if (age >= 26 && age <= 35) {
      return 'Bạn có thể đang ở giai đoạn xây dựng sự nghiệp vững chắc và có những bước tiến quan trọng. Hãy tập trung vào mục tiêu dài hạn và cân bằng giữa công việc và cuộc sống cá nhân.';
    } else if (age >= 36 && age <= 50) {
      return 'Đây là thời điểm để củng cố vị trí, phát triển chuyên môn sâu hơn và có thể bắt đầu nghĩ đến việc truyền đạt kinh nghiệm. Đừng quên chăm sóc sức khỏe và dành thời gian cho gia đình.';
    } else if (age >= 51 && age <= 65) {
      return 'Giai đoạn chuẩn bị cho cuộc sống sau khi nghỉ hưu. Hãy xem xét các kế hoạch tài chính, duy trì hoạt động thể chất và tinh thần, và dành nhiều thời gian hơn cho sở thích cá nhân.';
    } else {
      return 'Hãy tận hưởng cuộc sống an yên, dành thời gian cho người thân và bạn bè. Chia sẻ kinh nghiệm sống của bạn có thể mang lại nhiều giá trị cho thế hệ sau.';
    }
  }

  Future<void> _handleImageSelection(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: source);

      if (photo != null) {
        setState(() {
          _imageFile = File(photo.path);
          _analysisResult = null;
          _isAnalyzing = true;
        });

        print(
            'Ảnh đã được ${source == ImageSource.camera ? "chụp" : "chọn"}: ${photo.path}');
        await _processImage();
      }
    } catch (e) {
      _handleImageError(e);
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  Future<void> _processImage() async {
    if (_imageFile == null) return;

    try {
      final analysisData = await analyzeFace(_imageFile!, widget.birthDate);

      setState(() {
        _analysisResult = analysisData.analysisText;
      });

      await _showAnalysisResult(analysisData);
    } catch (e) {
      _handleAnalysisError(e);
    } finally {
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  Future<void> _showAnalysisResult(FaceAnalysisResult analysisData) async {
    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalysisResultScreen(
          analysisResult: analysisData.analysisText,
        ),
      ),
    );
  }

  void _handleImageError(dynamic error) {
    print('Lỗi khi truy cập ảnh: $error');
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Không thể truy cập ảnh. Vui lòng kiểm tra lại quyền truy cập.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _handleAnalysisError(dynamic error) {
    print('Error during face analysis: $error');
    setState(() {
      _analysisResult = 'Đã xảy ra lỗi trong quá trình phân tích: $error';
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lỗi khi phân tích khuôn mặt: $error'),
        duration: Duration(seconds: 5),
      ),
    );
  }

  Future<void> _takePicture() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Chụp ảnh'),
                onTap: () {
                  Navigator.pop(context);
                  _handleImageSelection(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Chọn từ thư viện'),
                onTap: () {
                  Navigator.pop(context);
                  _handleImageSelection(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lifePathNumber = calculateLifePathNumber(widget.birthDate);
    final age = calculateAge(widget.birthDate);
    final ageAdvice = getAgeAdvice(age);

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple.shade300,
                  Colors.purple.shade900,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Kết Quả Phân Tích',
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 48), // Placeholder to keep alignment
                        ],
                      ),
                      const SizedBox(height: 30),
                      // User Info and Age Advice
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.purple.shade400.withOpacity(0.3),
                              Colors.purple.shade800.withOpacity(0.3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Họ và tên: ${widget.name}',
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Ngày sinh: ${widget.birthDate.day}/${widget.birthDate.month}/${widget.birthDate.year}',
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Tuổi: $age',
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Lời khuyên cho độ tuổi của bạn:',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              ageAdvice,
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Analysis Status or Result and Buttons
                      if (_isAnalyzing)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'AI đang phân tích...',
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.purple.shade400.withOpacity(0.3),
                                        Colors.purple.shade800.withOpacity(0.3),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.white30),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Con số đường đời của bạn là:',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.purple.shade400,
                                              Colors.purple.shade800,
                                            ],
                                          ),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            lifePathNumber.toString(),
                                            style: GoogleFonts.playfairDisplay(
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        getLifePathMeaning(lifePathNumber),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 16,
                                          color: Colors.white,
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailedMeaningScreen(
                                          lifePathNumber: lifePathNumber,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.purple.shade900,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    'Xem Chi Tiết',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _takePicture,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.purple.shade900,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'Phân tích khuôn mặt',
                                style: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (_analysisResult != null)
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.purple.shade400.withOpacity(0.3),
                                      Colors.purple.shade800.withOpacity(0.3),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.white30),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      _analysisResult!,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 16,
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                // ChatbotButton positioned within the SafeArea's Stack
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 16.0, bottom: 16.0), // Adjust padding as needed
                    child: ChatbotButton(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
