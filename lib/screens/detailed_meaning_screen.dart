import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'aspect_details_screen.dart';

class DetailedMeaningScreen extends StatelessWidget {
  final int lifePathNumber;

  const DetailedMeaningScreen({
    super.key,
    required this.lifePathNumber,
  });

  String getDetailedMeaning(int number) {
    final detailedMeanings = {
      1: '''Con số 1 đại diện cho sự lãnh đạo và độc lập. Những người có con số đường đời 1 thường:
• Có khả năng lãnh đạo bẩm sinh
• Độc lập và tự tin trong quyết định
• Sáng tạo và đổi mới
• Có tinh thần tiên phong
• Thích tự mình làm chủ cuộc sống'''
          .trim(),
      2: '''Con số 2 tượng trưng cho sự hòa hợp và cân bằng. Những người có con số đường đời 2 thường:
• Có khả năng làm việc nhóm tốt
• Nhạy cảm và thấu hiểu người khác
• Có tài ngoại giao và hòa giải
• Thích hợp tác và chia sẻ
• Có trực giác tốt'''
          .trim(),
      3: '''Con số 3 đại diện cho sự sáng tạo và biểu đạt. Những người có con số đường đời 3 thường:
• Có tài năng nghệ thuật
• Lạc quan và vui vẻ
• Giao tiếp tốt
• Có khả năng truyền cảm hứng
• Thích thể hiện bản thân'''
          .trim(),
      4: '''Con số 4 tượng trưng cho sự ổn định và thực tế. Những người có con số đường đời 4 thường:
• Có tổ chức và kỷ luật
• Thực tế và đáng tin cậy
• Chăm chỉ và kiên trì
• Thích sự ổn định
• Có khả năng xây dựng nền tảng vững chắc'''
          .trim(),
      5: '''Con số 5 đại diện cho sự tự do và phiêu lưu. Những người có con số đường đời 5 thường:
• Thích khám phá và trải nghiệm mới
• Năng động và linh hoạt
• Thích sự thay đổi
• Có khả năng thích nghi tốt
• Thích tự do và độc lập'''
          .trim(),
      6: '''Con số 6 tượng trưng cho tình yêu và trách nhiệm. Những người có con số đường đời 6 thường:
• Quan tâm đến gia đình và người thân
• Có trách nhiệm và đáng tin cậy
• Thích chăm sóc người khác
• Có khả năng hòa giải
• Thích sự hài hòa và cân bằng'''
          .trim(),
      7: '''Con số 7 đại diện cho sự tâm linh và trí tuệ. Những người có con số đường đời 7 thường:
• Có tư duy phân tích sâu sắc
• Thích nghiên cứu và học hỏi
• Có trực giác tốt
• Thích sự yên tĩnh và suy ngẫm
• Có khả năng tâm linh'''
          .trim(),
      8: '''Con số 8 tượng trưng cho quyền lực và thành công. Những người có con số đường đời 8 thường:
• Có khả năng lãnh đạo
• Tham vọng và quyết tâm cao
• Có tài quản lý tài chính
• Thích sự thành công và quyền lực
• Có khả năng đạt được mục tiêu'''
          .trim(),
      9: '''Con số 9 đại diện cho sự hoàn thiện và nhân đạo. Những người có con số đường đời 9 thường:
• Có tấm lòng nhân ái
• Thích giúp đỡ người khác
• Có tầm nhìn rộng
• Thích sự hoàn thiện
• Có khả năng truyền cảm hứng'''
          .trim(),
    };
    return detailedMeanings[number] ?? 'Không có thông tin chi tiết';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        'Chi Tiết Con Số Đường Đời',
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
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
                                    color: Colors.black.withOpacity(0.2),
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
                              getDetailedMeaning(lifePathNumber),
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildAspectButton(
                            context,
                            'Tình Duyên',
                            Icons.favorite,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AspectDetailsScreen(
                                    lifePathNumber: lifePathNumber,
                                    aspect: 'tinh_duyen',
                                    title: 'Chi Tiết Tình Duyên',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildAspectButton(
                            context,
                            'Sự Nghiệp',
                            Icons.work,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AspectDetailsScreen(
                                    lifePathNumber: lifePathNumber,
                                    aspect: 'su_nghiep',
                                    title: 'Chi Tiết Sự Nghiệp',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildAspectButton(
                            context,
                            'Con Cái',
                            Icons.child_care,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AspectDetailsScreen(
                                    lifePathNumber: lifePathNumber,
                                    aspect: 'con_cai',
                                    title: 'Chi Tiết Con Cái',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildAspectButton(
                            context,
                            'Huynh Đệ',
                            Icons.people,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AspectDetailsScreen(
                                    lifePathNumber: lifePathNumber,
                                    aspect: 'huynh_de',
                                    title: 'Chi Tiết Huynh Đệ',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAspectButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.white30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 8),
            Text(
              text,
              style: GoogleFonts.quicksand(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
