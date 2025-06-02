import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AspectDetailsScreen extends StatelessWidget {
  final int lifePathNumber;
  final String aspect;
  final String title;

  const AspectDetailsScreen({
    super.key,
    required this.lifePathNumber,
    required this.aspect,
    required this.title,
  });

  String getAspectDetails(int number, String aspect) {
    final details = {
      'tinh_duyen': {
        1: '''Người số 1 trong tình yêu thường thể hiện sự độc lập và tự chủ rõ nét. Họ thích là người dẫn dắt và làm chủ trong mối quan hệ, đôi khi có xu hướng áp đặt ý kiến cá nhân. Họ cần một người bạn đời mạnh mẽ, có chính kiến nhưng cũng sẵn sàng nhường nhịn để tạo sự cân bằng. Sự nhàm chán là kẻ thù của họ, nên mối quan hệ cần sự mới mẻ và thử thách để duy trì ngọn lửa tình yêu. Họ trân trọng không gian riêng và sự nghiệp cá nhân của bạn đời.''',
        2: '''Người số 2 là những người tình nhạy cảm, chu đáo và luôn đặt sự hòa hợp lên hàng đầu. Họ có khả năng thấu hiểu và lắng nghe tuyệt vời, là bờ vai đáng tin cậy cho bạn đời. Sự ổn định, an toàn và lãng mạn nhẹ nhàng là điều họ tìm kiếm. Tuy nhiên, đôi khi họ có thể quá phụ thuộc hoặc ngại đối mặt với xung đột, dẫn đến việc giữ lại cảm xúc tiêu cực. Họ hợp với người biết trân trọng sự tinh tế và lòng tốt của họ.''',
        3: '''Số 3 mang đến sự vui vẻ, lãng mạn và sáng tạo cho tình yêu. Họ giỏi biểu đạt cảm xúc, thích những cử chỉ ngọt ngào và không ngại thể hiện tình cảm ở nơi công cộng. Tính cách hài hước, lạc quan giúp họ dễ dàng kết nối và làm cho mối quan hệ luôn tươi mới. Tuy nhiên, họ cần học cách cam kết sâu sắc hơn và tránh để cảm xúc nhất thời chi phối. Họ tìm kiếm người bạn đời thông minh, dí dỏm và biết cách cùng họ tận hưởng cuộc sống.''',
        4: '''Tình yêu của người số 4 được xây dựng trên nền tảng của sự ổn định, tin cậy và trách nhiệm. Họ nghiêm túc trong các mối quan hệ, luôn hướng tới sự bền vững và an toàn. Họ là người bạn đời đáng tin cậy, luôn sẵn sàng hỗ trợ và cùng nhau xây dựng tương lai. Đôi khi họ có thể hơi cứng nhắc hoặc thiếu lãng mạn, nhưng tình yêu của họ sâu sắc và chân thành. Họ cần người bạn đời kiên nhẫn, thấu hiểu và biết cách khích lệ họ mở lòng hơn.''',
        5: '''Người số 5 yêu thích tự do, phiêu lưu và sự thay đổi ngay cả trong tình yêu. Họ không thích bị ràng buộc, luôn tìm kiếm những trải nghiệm mới mẻ và thú vị cùng bạn đời. Sự năng động, linh hoạt và khả năng thích ứng cao giúp họ dễ dàng vượt qua khó khăn. Tuy nhiên, họ cần cẩn trọng để không trở nên quá bất ổn hoặc thiếu cam kết. Họ hợp với người bạn đời cởi mở, độc lập và sẵn sàng cùng họ khám phá thế giới.''',
        6: '''Số 6 là biểu tượng của tình yêu thương, sự quan tâm và trách nhiệm trong các mối quan hệ. Họ là người bạn đời tận tụy, luôn chăm sóc và đặt hạnh phúc gia đình lên hàng đầu. Họ tìm kiếm sự hài hòa, ổn định và một tổ ấm yên bình. Đôi khi họ có thể quá lo lắng hoặc hy sinh bản thân quá nhiều cho người khác. Họ cần người bạn đời biết trân trọng sự hy sinh của họ và cùng chia sẻ trách nhiệm xây dựng gia đình.''',
        7: '''Người số 7 trong tình yêu thường có chiều sâu nội tâm và khá kín đáo. Họ không dễ dàng mở lòng, cần thời gian để xây dựng niềm tin và sự kết nối sâu sắc với bạn đời. Họ trân trọng sự yên tĩnh, không gian riêng và những cuộc trò chuyện ý nghĩa. Tình yêu của họ dựa trên sự thấu hiểu tâm hồn và trí tuệ. Họ cần người bạn đời kiên nhẫn, tinh tế và biết cách tôn trọng thế giới nội tâm của họ.''',
        8: '''Số 8 mang đến sự mạnh mẽ, quyết đoán và tham vọng vào tình yêu. Họ có xu hướng làm chủ và bảo vệ mối quan hệ, luôn hướng tới sự thành công và ổn định tài chính. Họ là người bạn đời đáng tin cậy và có khả năng giải quyết vấn đề tốt. Tuy nhiên, đôi khi họ có thể quá tập trung vào vật chất hoặc kiểm soát. Họ hợp với người bạn đời có chí tiến thủ, biết cách tôn trọng và cùng họ xây dựng cuộc sống thịnh vượng.''',
        9: '''Người số 9 trong tình yêu thể hiện tấm lòng nhân ái, bao dung và vị tha. Họ có xu hướng quan tâm đến người khác, đôi khi đặt nhu cầu của bạn đời lên trên mình. Tình yêu của họ rộng lớn, không phân biệt và luôn hướng đến những giá trị cao đẹp. Tuy nhiên, họ cần học cách yêu bản thân và đặt ra giới hạn lành mạnh. Họ tìm kiếm người bạn đời có tấm lòng nhân hậu, biết trân trọng sự hy sinh của họ và cùng họ hướng đến những mục tiêu nhân văn.''',
      },
      'su_nghiep': {
        1: '''Trong sự nghiệp, người số 1 là những nhà lãnh đạo bẩm sinh và tiên phong. Họ có ý chí mạnh mẽ, quyết đoán và không ngại thử thách bản thân trong những lĩnh vực mới. Họ thích làm việc độc lập, tự đưa ra quyết định và chịu trách nhiệm với công việc của mình. Vị trí quản lý, điều hành hoặc khởi nghiệp rất phù hợp với họ. Để thành công, họ cần học cách lắng nghe ý kiến đóng góp của người khác và tránh sự độc đoán.''',
        2: '''Số 2 phát huy tối đa khả năng trong môi trường làm việc nhóm hoặc các công việc đòi hỏi sự hợp tác, ngoại giao. Họ là những người đồng đội tuyệt vời, biết lắng nghe và kết nối mọi người lại với nhau. Các lĩnh vực tư vấn, đàm phán, nhân sự hoặc trợ lý là nơi họ tỏa sáng. Họ cần cẩn trọng để không bị lợi dụng hoặc trở nên quá thụ động trong công việc.''',
        3: '''Sự nghiệp của người số 3 thường gắn liền với sự sáng tạo, biểu đạt và giao tiếp. Họ có tài năng nghệ thuật, khả năng truyền cảm hứng và thu hút người khác. Các công việc trong lĩnh vực truyền thông, giải trí, nghệ thuật, giảng dạy hoặc marketing rất phù hợp. Họ cần học cách quản lý thời gian và tập trung năng lượng để hoàn thành mục tiêu dài hạn.''',
        4: '''Người số 4 là những người làm việc chăm chỉ, có tổ chức và đáng tin cậy. Họ yêu thích sự ổn định, các quy trình rõ ràng và có khả năng xây dựng nền tảng vững chắc. Các công việc đòi hỏi sự tỉ mỉ, kỷ luật như kỹ thuật, kế toán, xây dựng, quản lý dự án rất phù hợp với họ. Đôi khi họ cần học cách linh hoạt hơn và không quá sợ hãi trước sự thay đổi.''',
        5: '''Sự nghiệp của người số 5 luôn tràn đầy năng lượng, sự khám phá và thay đổi. Họ không thích sự nhàm chán, luôn tìm kiếm những thử thách mới và có khả năng thích ứng nhanh với mọi môi trường. Các công việc trong lĩnh vực kinh doanh, du lịch, báo chí, công nghệ hoặc các công việc đòi hỏi sự di chuyển nhiều rất phù hợp. Họ cần học cách kiên định với mục tiêu và tránh phân tán năng lượng vào quá nhiều thứ cùng lúc.''',
        6: '''Số 6 tìm thấy ý nghĩa trong sự nghiệp khi có thể chăm sóc, giúp đỡ và tạo ra sự hài hòa cho người khác. Họ có trách nhiệm cao, đáng tin cậy và có khả năng giải quyết các vấn đề liên quan đến con người. Các công việc trong lĩnh vực giáo dục, y tế, công tác xã hội, tư vấn hoặc quản lý cộng đồng rất phù hợp. Đôi khi họ cần học cách từ chối và không ôm đồm quá nhiều trách nhiệm.''',
        7: '''Người số 7 phát huy tối đa trí tuệ và trực giác trong sự nghiệp. Họ thích nghiên cứu, phân tích sâu sắc và tìm hiểu bản chất của vấn đề. Các công việc trong lĩnh vực khoa học, triết học, công nghệ thông tin, tư vấn chuyên môn hoặc các công việc đòi hỏi sự tập trung cao rất phù hợp. Họ cần học cách chia sẻ kiến thức và kết nối với đồng nghiệp để không bị cô lập.''',
        8: '''Sự nghiệp của người số 8 gắn liền với quyền lực, tham vọng và thành công tài chính. Họ có khả năng lãnh đạo, quản lý và đưa ra các quyết định quan trọng. Các vị trí quản lý cấp cao, kinh doanh lớn, tài chính hoặc chính trị rất phù hợp với họ. Để duy trì thành công, họ cần cẩn trọng với việc cân bằng giữa công việc và cuộc sống, tránh trở nên quá độc đoán hoặc chỉ chạy theo vật chất.''',
        9: '''Số 9 mang đến tầm nhìn rộng lớn và lý tưởng cao đẹp vào sự nghiệp. Họ có tấm lòng nhân ái, luôn muốn giúp đỡ người khác và đóng góp cho cộng đồng. Các công việc trong lĩnh vực xã hội, nhân đạo, giáo dục, nghệ thuật hoặc các công việc đòi hỏi sự sáng tạo và tầm hưởng lớn rất phù hợp. Họ cần học cách biến lý tưởng thành hành động cụ thể và tránh sự mơ mộng hão huyền.''',
      },
      'con_cai': {
        1: '''Với con cái, cha mẹ số 1 thường khuyến khích con tính độc lập, tự chủ ngay từ sớm. Họ muốn con mình mạnh mẽ, có chính kiến và khả năng tự giải quyết vấn đề. Họ dạy con cách đứng lên bằng đôi chân của mình và không ngại đối mặt với thử thách. Tuy nhiên, đôi khi họ có thể hơi nghiêm khắc hoặc áp đặt kỳ vọng lên con.''',
        2: '''Cha mẹ số 2 là những người rất tình cảm, nhạy cảm và luôn tạo môi trường an toàn, yêu thương cho con cái. Họ lắng nghe, thấu hiểu và luôn sẵn sàng chia sẻ cùng con. Họ dạy con về sự hòa hợp, sẻ chia và tầm quan trọng của các mối quan hệ. Họ cần cẩn trọng để không quá bao bọc hoặc lo lắng thái quá cho con.''',
        3: '''Cha mẹ số 3 mang đến năng lượng vui tươi, sáng tạo và sự cởi mở trong việc nuôi dạy con cái. Họ khuyến khích con phát huy tài năng, thể hiện bản thân và luôn nhìn mọi việc một cách tích cực. Họ thích trò chuyện, chơi đùa và tạo ra những kỷ niệm đáng nhớ cùng con. Họ cần học cách thiết lập kỷ luật và ranh giới rõ ràng cho con.''',
        4: '''Cha mẹ số 4 là những người có trách nhiệm, có tổ chức và luôn xây dựng nền tảng vững chắc cho con cái. Họ dạy con về kỷ luật, nề nếp, giá trị của sự chăm chỉ và tính tự lập. Họ luôn đảm bảo con được học hành đầy đủ và có một cuộc sống ổn định. Đôi khi họ cần học cách linh hoạt hơn và không quá cứng nhắc trong việc nuôi dạy con.''',
        5: '''Cha mẹ số 5 là những người năng động, cởi mở và luôn khuyến khích con cái khám phá thế giới xung quanh. Họ dạy con về sự thích ứng, lòng can đảm và tầm quan trọng của trải nghiệm thực tế. Họ thích cùng con tham gia các hoạt động ngoại khóa, du lịch và thử những điều mới. Họ cần cẩn trọng để không quá nuông chiều hoặc thiếu kiên định trong việc giáo dục con.''',
        6: '''Cha mẹ số 6 là những người đầy yêu thương, quan tâm và luôn đặt gia đình lên hàng đầu. Họ tạo ra một tổ ấm hài hòa, an toàn và dạy con về giá trị của tình thân, lòng trắc ẩn và trách nhiệm với cộng đồng. Họ sẵn sàng hy sinh bản thân vì con cái. Đôi khi họ cần học cách dành thời gian cho bản thân và tránh sự lo lắng thái quá.''',
        7: '''Cha mẹ số 7 có xu hướng nuôi dạy con cái theo hướng phát triển trí tuệ và chiều sâu nội tâm. Họ khuyến khích con tư duy độc lập, tìm hiểu kiến thức và phát triển trực giác. Họ trân trọng sự yên tĩnh và không gian riêng của con. Họ cần học cách thể hiện tình cảm rõ ràng hơn và kết nối cảm xúc với con.''',
        8: '''Cha mẹ số 8 là những người có tầm nhìn xa, luôn hướng đến sự thành công và dạy con cái về giá trị của sự chăm chỉ, quyết tâm và khả năng lãnh đạo. Họ tạo động lực, đặt ra mục tiêu và hỗ trợ con phát triển hết tiềm năng. Họ cần cẩn trọng để không đặt quá nhiều áp lực lên con hoặc chỉ tập trung vào thành tích vật chất.''',
        9: '''Cha mẹ số 9 là những người có tấm lòng nhân ái, bao dung và luôn dạy con cái về giá trị của sự sẻ chia, lòng vị tha và trách nhiệm với xã hội. Họ là tấm gương về sự cho đi và luôn khuyến khích con tham gia các hoạt động cộng đồng. Họ cần học cách cân bằng giữa việc quan tâm đến người khác và chăm sóc gia đình nhỏ của mình.''',
      },
      'huynh_de': {
        1: '''Trong mối quan hệ với anh chị em, người số 1 thường thể hiện vai trò là người dẫn đầu, có tiếng nói và đôi khi là người bảo vệ. Họ có xu hướng đưa ra ý kiến và quyết định, mong muốn anh chị em nghe theo mình. Họ có trách nhiệm và sẵn sàng đứng ra giải quyết vấn đề. Tuy nhiên, cần tránh sự độc đoán và học cách tôn trọng sự khác biệt.''',
        2: '''Người số 2 là cầu nối hòa bình trong mối quan hệ anh chị em. Họ giỏi lắng nghe, thấu hiểu và luôn tìm cách xoa dịu mâu thuẫn. Họ đề cao sự hòa thuận và sẻ chia. Đôi khi họ có thể trở nên bị động hoặc né tránh xung đột, dẫn đến việc tích tụ cảm xúc tiêu cực.''',
        3: '''Số 3 mang đến không khí vui vẻ, hài hước và sự kết nối trong mối quan hệ anh chị em. Họ thích trò chuyện, chia sẻ và tạo ra những khoảnh khắc đáng nhớ. Họ có khả năng truyền cảm hứng và làm cho mọi người cảm thấy thoải mái. Tuy nhiên, họ cần học cách lắng nghe sâu sắc hơn và tránh sự hời hợt trong giao tiếp.''',
        4: '''Người số 4 là người anh/chị/em đáng tin cậy, có trách nhiệm và luôn quan tâm đến sự ổn định của gia đình. Họ nghiêm túc trong việc giữ gìn nề nếp và sẵn sàng hỗ trợ khi cần. Họ có khả năng xây dựng và duy trì các mối quan hệ bền chặt. Đôi khi họ có thể hơi cứng nhắc hoặc thiếu linh hoạt.''',
        5: '''Người số 5 mang đến sự năng động, mới mẻ và những trải nghiệm thú vị vào mối quan hệ anh chị em. Họ thích khám phá cùng nhau, không ngại thử thách và luôn tìm kiếm sự tự do, độc lập. Tuy nhiên, họ cần học cách cam kết và duy trì sự kết nối thường xuyên, tránh sự bất ổn.''',
        6: '''Số 6 là người anh/chị/em đầy yêu thương, quan tâm và có trách nhiệm. Họ luôn sẵn sàng chăm sóc, giúp đỡ và bảo vệ anh chị em của mình. Họ coi trọng sự hòa thuận và xây dựng một mối quan hệ gia đình khăng khít. Đôi khi họ có thể quá lo lắng hoặc can thiệp sâu vào cuộc sống của người khác.''',
        7: '''Người số 7 có chiều sâu và sự kín đáo ngay cả với anh chị em. Họ trân trọng không gian riêng, thích những cuộc trò chuyện sâu sắc và có khả năng đưa ra lời khuyên hữu ích. Tuy nhiên, họ cần học cách mở lòng và chia sẻ cảm xúc nhiều hơn để tăng sự gắn kết.''',
        8: '''Số 8 thể hiện sự mạnh mẽ, quyết đoán và đôi khi là người có tiếng nói trong mối quan hệ anh chị em. Họ có trách nhiệm, có khả năng lãnh đạo và sẵn sàng bảo vệ người thân. Họ hướng đến sự thành công chung của gia đình. Cần cẩn trọng tránh sự áp đặt hoặc kiểm soát.''',
        9: '''Người số 9 mang đến sự bao dung, vị tha và lòng nhân ái vào mối quan hệ anh chị em. Họ sẵn sàng giúp đỡ, sẻ chia và luôn nhìn nhận mọi việc một cách tích cực. Họ có tầm nhìn rộng và mong muốn mọi người trong gia đình sống hòa thuận. Cần học cách đặt ra ranh giới và không để người khác lợi dụng lòng tốt của mình.''',
      },
    };

    return details[aspect]?[number] ?? 'Không có thông tin chi tiết.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.quicksand(fontSize: 20),
        ),
        backgroundColor: Colors.purple.shade700,
        foregroundColor: Colors.white,
      ),
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
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      getAspectDetails(lifePathNumber, aspect),
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
