import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatbotService {
  // Từ khóa chính và các từ đồng nghĩa
  final Map<String, List<String>> keywords = {
    'thần số học': [
      'thần số',
      'numerology',
      'số học',
      'thần số học là gì',
      'giải thích về thần số học',
    ],
    'con số chủ đạo': [
      'số chủ đạo',
      'con số chủ đạo là gì',
      'cách tính số chủ đạo',
      'ý nghĩa số chủ đạo',
      'số chủ đạo từ 1-9',
    ],
    'biểu đồ ngày sinh': [
      'biểu đồ sinh',
      'biểu đồ ngày sinh là gì',
      'cách đọc biểu đồ ngày sinh',
      'ý nghĩa biểu đồ ngày sinh',
      'phân tích biểu đồ ngày sinh',
    ],
    'đường đời': [
      'số đường đời',
      'con số đường đời',
      'đường đời là gì',
      'cách tính đường đời',
      'ý nghĩa đường đời',
    ],
    'linh hồn': [
      'số linh hồn',
      'con số linh hồn',
      'linh hồn là gì',
      'cách tính linh hồn',
      'ý nghĩa linh hồn',
    ],
    'biểu đạt': [
      'số biểu đạt',
      'con số biểu đạt',
      'biểu đạt là gì',
      'cách tính biểu đạt',
      'ý nghĩa biểu đạt',
    ],
    'chức năng': [
      'tính năng',
      'app làm gì',
      'ứng dụng làm gì',
      'có thể làm gì',
      'dùng để làm gì',
      'mục đích',
    ],
    'cách dùng': [
      'hướng dẫn sử dụng',
      'cách sử dụng',
      'sử dụng như thế nào',
      'dùng như thế nào',
      'cách tính',
      'tính như thế nào',
    ],
    'tác giả': [
      'ai làm',
      'người làm',
      'người phát triển',
      'developer',
      'nhà phát triển',
      'nguyễn anh đức',
    ],
    'hoạt động': [
      'cách hoạt động',
      'hoạt động như thế nào',
      'nguyên lý',
      'cơ chế',
      'algorithm',
      'thuật toán',
    ],
  };

  // Câu trả lời chi tiết cho từng chủ đề
  final Map<String, List<String>> responses = {
    'thần số học': [
      '''Thần số học là một môn khoa học nghiên cứu về ý nghĩa của các con số và ảnh hưởng của chúng đến cuộc sống con người. Nó giúp chúng ta hiểu rõ hơn về bản thân, tính cách, tài năng và con đường phát triển của mình.

Thần số học được phát triển bởi nhà toán học Pythagoras vào thế kỷ 6 TCN. Ông tin rằng mọi thứ trong vũ trụ đều có thể được biểu thị bằng các con số, và mỗi con số đều mang một ý nghĩa và năng lượng riêng.

Trong thần số học, chúng ta thường phân tích các con số quan trọng như:
- Con số chủ đạo: Thể hiện bản chất cốt lõi
- Biểu đồ ngày sinh: Phân tích chi tiết tính cách
- Đường đời: Mục đích sống
- Linh hồn: Khát vọng sâu thẳm
- Biểu đạt: Cách thể hiện bản thân

Thần số học giúp chúng ta:
1. Hiểu rõ bản thân
2. Khám phá tài năng tiềm ẩn
3. Xác định con đường phát triển
4. Cải thiện các mối quan hệ
5. Đưa ra quyết định tốt hơn''',
      '''Thần số học là một công cụ mạnh mẽ giúp chúng ta khám phá bản thân và hiểu rõ hơn về cuộc sống. Nó dựa trên nguyên lý rằng mỗi con số đều mang một năng lượng và ý nghĩa riêng, ảnh hưởng đến tính cách và vận mệnh của chúng ta.

Các nguyên lý cơ bản:
1. Mỗi con số đều có năng lượng riêng
2. Ngày sinh và tên gọi chứa thông tin quan trọng
3. Các con số tương tác với nhau
4. Năng lượng số học ảnh hưởng đến cuộc sống

Ứng dụng trong cuộc sống:
- Phát triển bản thân
- Định hướng nghề nghiệp
- Cải thiện quan hệ
- Đưa ra quyết định
- Tìm hiểu người khác''',
    ],
    'con số chủ đạo': [
      '''Con số chủ đạo là con số quan trọng nhất trong thần số học, được tính từ ngày sinh của bạn. Nó thể hiện bản chất cốt lõi và mục đích sống của một người.

Cách tính con số chủ đạo:
1. Cộng tất cả các chữ số trong ngày sinh
2. Nếu kết quả là số có 2 chữ số, tiếp tục cộng cho đến khi được số từ 1-9
3. Nếu kết quả là 11, 22, 33 thì giữ nguyên (đây là các số đặc biệt)

Ví dụ: Ngày sinh 15/08/1990
1 + 5 + 0 + 8 + 1 + 9 + 9 + 0 = 33
Con số chủ đạo là 33

Ý nghĩa các con số chủ đạo:
1. Số 1: Lãnh đạo, độc lập, sáng tạo
2. Số 2: Hợp tác, nhạy cảm, hòa giải
3. Số 3: Sáng tạo, giao tiếp, lạc quan
4. Số 4: Ổn định, thực tế, có tổ chức
5. Số 5: Tự do, phiêu lưu, thay đổi
6. Số 6: Yêu thương, trách nhiệm, hài hòa
7. Số 7: Phân tích, tâm linh, trí tuệ
8. Số 8: Quyền lực, tham vọng, vật chất
9. Số 9: Nhân đạo, bao dung, trí tuệ

Các số đặc biệt:
- Số 11: Trực giác cao, tâm linh
- Số 22: Xây dựng, kiến trúc sư
- Số 33: Thầy giáo, người hướng dẫn''',
      '''Con số chủ đạo là chìa khóa để hiểu về bản chất và mục đích sống của một người. Nó được xem như "vân tay" của linh hồn, cho thấy những tài năng bẩm sinh và thách thức mà chúng ta cần vượt qua trong cuộc đời.

Tác động của con số chủ đạo:
1. Tính cách:
   - Điểm mạnh bẩm sinh
   - Cách suy nghĩ
   - Phong cách sống
   - Sở thích

2. Nghề nghiệp:
   - Ngành nghề phù hợp
   - Môi trường làm việc
   - Phong cách lãnh đạo
   - Khả năng thăng tiến

3. Mối quan hệ:
   - Cách giao tiếp
   - Phong cách yêu đương
   - Tương tác xã hội
   - Khả năng hợp tác

4. Phát triển:
   - Thách thức cần vượt qua
   - Bài học cần học
   - Con đường phát triển
   - Mục tiêu cuộc sống''',
    ],
    'biểu đồ ngày sinh': [
      '''Biểu đồ ngày sinh là công cụ giúp phân tích chi tiết về tính cách và tiềm năng của một người. Nó được tạo ra từ ngày sinh của bạn, cho thấy các điểm mạnh và điểm yếu.

Cách tạo biểu đồ ngày sinh:
1. Vẽ một hình vuông 3x3
2. Đánh số các ô từ 1-9
3. Điền số lần xuất hiện của mỗi chữ số trong ngày sinh vào ô tương ứng

Ví dụ: Ngày sinh 15/08/1990
- Số 1 xuất hiện 2 lần
- Số 5 xuất hiện 1 lần
- Số 0 xuất hiện 2 lần
- Số 8 xuất hiện 1 lần
- Số 9 xuất hiện 2 lần

Ý nghĩa của các con số trong biểu đồ:
1. Số 1: Lãnh đạo, độc lập
2. Số 2: Hợp tác, nhạy cảm
3. Số 3: Sáng tạo, giao tiếp
4. Số 4: Ổn định, thực tế
5. Số 5: Tự do, phiêu lưu
6. Số 6: Yêu thương, trách nhiệm
7. Số 7: Phân tích, tâm linh
8. Số 8: Quyền lực, tham vọng
9. Số 9: Nhân đạo, bao dung

Cách đọc biểu đồ:
- Số xuất hiện nhiều: Điểm mạnh nổi bật
- Số không xuất hiện: Thách thức cần vượt qua
- Số xuất hiện 1 lần: Phẩm chất cần phát triển''',
      '''Biểu đồ ngày sinh là một công cụ mạnh mẽ trong thần số học, giúp chúng ta hiểu rõ về tính cách và tiềm năng của bản thân. Nó cho thấy sự phân bố năng lượng của các con số trong ngày sinh của bạn.

Phân tích chi tiết:

1. Các trục trong biểu đồ:
   - Trục ngang: Thể hiện mối quan hệ với người khác
   - Trục dọc: Thể hiện mối quan hệ với bản thân
   - Trục chéo: Thể hiện sự cân bằng trong cuộc sống

2. Các mức độ năng lượng:
   - Không có số: Cần phát triển
   - 1 số: Mức độ cơ bản
   - 2 số: Mức độ trung bình
   - 3 số trở lên: Mức độ mạnh

3. Ứng dụng thực tế:
   - Hiểu rõ điểm mạnh
   - Nhận biết điểm yếu
   - Phát triển tài năng
   - Cải thiện bản thân

4. Tương tác với các con số khác:
   - Kết hợp với số chủ đạo
   - Tương tác với đường đời
   - Ảnh hưởng đến linh hồn
   - Tác động đến biểu đạt''',
    ],
    'đường đời': [
      '''Đường đời là con số thể hiện mục đích sống và con đường phát triển của bạn. Nó được tính từ tổng các chữ số trong ngày sinh của bạn.

Cách tính đường đời:
1. Cộng tất cả các chữ số trong ngày sinh
2. Nếu kết quả là số có 2 chữ số, tiếp tục cộng cho đến khi được số từ 1-9
3. Nếu kết quả là 11, 22, 33 thì giữ nguyên

Ví dụ: Ngày sinh 15/08/1990
1 + 5 + 0 + 8 + 1 + 9 + 9 + 0 = 33
Đường đời là 33

Ý nghĩa của đường đời:
1. Số 1: Con đường của người lãnh đạo
2. Số 2: Con đường của người hòa giải
3. Số 3: Con đường của người sáng tạo
4. Số 4: Con đường của người xây dựng
5. Số 5: Con đường của người phiêu lưu
6. Số 6: Con đường của người yêu thương
7. Số 7: Con đường của người tìm kiếm
8. Số 8: Con đường của người thành công
9. Số 9: Con đường của người phục vụ

Các giai đoạn của đường đời:
1. Giai đoạn đầu đời (0-30 tuổi)
2. Giai đoạn trung niên (30-60 tuổi)
3. Giai đoạn cuối đời (60+ tuổi)''',
      '''Đường đời là một trong những con số quan trọng nhất trong thần số học, cho thấy mục đích sống và con đường phát triển của bạn. Nó giúp bạn hiểu rõ về những thách thức và cơ hội trong cuộc đời.

Tác động của đường đời:

1. Nghề nghiệp:
   - Ngành nghề phù hợp
   - Môi trường làm việc
   - Phong cách lãnh đạo
   - Khả năng thăng tiến

2. Mối quan hệ:
   - Cách giao tiếp
   - Phong cách yêu đương
   - Tương tác xã hội
   - Khả năng hợp tác

3. Phát triển cá nhân:
   - Thách thức cần vượt qua
   - Bài học cần học
   - Con đường phát triển
   - Mục tiêu cuộc sống

4. Tương tác với các con số khác:
   - Kết hợp với số chủ đạo
   - Tương tác với biểu đồ ngày sinh
   - Ảnh hưởng đến linh hồn
   - Tác động đến biểu đạt''',
    ],
    'linh hồn': [
      '''Con số linh hồn thể hiện khát vọng sâu thẳm trong tâm hồn bạn. Nó được tính từ tổng các nguyên âm trong tên đầy đủ của bạn.

Cách tính linh hồn:
1. Xác định các nguyên âm trong tên đầy đủ (a, e, i, o, u)
2. Chuyển các nguyên âm thành số theo bảng:
   A = 1, E = 5, I = 9, O = 6, U = 3
3. Cộng tất cả các số lại
4. Nếu kết quả là số có 2 chữ số, tiếp tục cộng cho đến khi được số từ 1-9
5. Nếu kết quả là 11, 22, 33 thì giữ nguyên

Ví dụ: Tên NGUYỄN ANH ĐỨC
- NGUYỄN: U = 3, E = 5
- ANH: A = 1
- ĐỨC: U = 3
3 + 5 + 1 + 3 = 12
1 + 2 = 3
Linh hồn là 3

Ý nghĩa của linh hồn:
1. Số 1: Khát vọng độc lập và lãnh đạo
2. Số 2: Khát vọng hòa hợp và hợp tác
3. Số 3: Khát vọng sáng tạo và thể hiện
4. Số 4: Khát vọng ổn định và an toàn
5. Số 5: Khát vọng tự do và phiêu lưu
6. Số 6: Khát vọng yêu thương và hài hòa
7. Số 7: Khát vọng tìm hiểu và khám phá
8. Số 8: Khát vọng thành công và quyền lực
9. Số 9: Khát vọng phục vụ và đóng góp''',
      '''Con số linh hồn là một trong những con số quan trọng trong thần số học, cho thấy những khát vọng sâu thẳm và mong muốn thực sự của bạn. Nó giúp bạn hiểu rõ về những gì bạn thực sự muốn trong cuộc sống.

Tác động của linh hồn:

1. Tâm lý:
   - Mong muốn sâu thẳm
   - Động lực nội tại
   - Niềm vui thực sự
   - Hạnh phúc bền vững

2. Nghề nghiệp:
   - Công việc mơ ước
   - Môi trường lý tưởng
   - Thành tựu mong muốn
   - Sự thỏa mãn

3. Mối quan hệ:
   - Kiểu người bạn muốn
   - Mối quan hệ lý tưởng
   - Tương tác mong muốn
   - Sự kết nối

4. Phát triển:
   - Mục tiêu thực sự
   - Con đường hạnh phúc
   - Sự thỏa mãn
   - Ý nghĩa cuộc sống''',
    ],
    'biểu đạt': [
      '''Con số biểu đạt cho thấy cách bạn thể hiện bản thân ra bên ngoài. Nó được tính từ tổng các phụ âm trong tên đầy đủ của bạn.

Cách tính biểu đạt:
1. Xác định các phụ âm trong tên đầy đủ
2. Chuyển các phụ âm thành số theo bảng:
   B = 2, C = 3, D = 4, F = 6, G = 7, H = 8, J = 1, K = 2, L = 3, M = 4, N = 5, P = 7, Q = 8, R = 9, S = 1, T = 2, V = 4, W = 5, X = 6, Y = 7, Z = 8
3. Cộng tất cả các số lại
4. Nếu kết quả là số có 2 chữ số, tiếp tục cộng cho đến khi được số từ 1-9
5. Nếu kết quả là 11, 22, 33 thì giữ nguyên

Ví dụ: Tên NGUYỄN ANH ĐỨC
- NGUYỄN: N = 5, G = 7, Y = 7, N = 5
- ANH: N = 5, H = 8
- ĐỨC: Đ = 4, C = 3
5 + 7 + 7 + 5 + 5 + 8 + 4 + 3 = 44
4 + 4 = 8
Biểu đạt là 8

Ý nghĩa của biểu đạt:
1. Số 1: Thể hiện sự độc lập và lãnh đạo
2. Số 2: Thể hiện sự hòa hợp và hợp tác
3. Số 3: Thể hiện sự sáng tạo và vui vẻ
4. Số 4: Thể hiện sự ổn định và thực tế
5. Số 5: Thể hiện sự tự do và phiêu lưu
6. Số 6: Thể hiện sự yêu thương và trách nhiệm
7. Số 7: Thể hiện sự trí tuệ và phân tích
8. Số 8: Thể hiện sự quyền lực và thành công
9. Số 9: Thể hiện sự nhân đạo và bao dung''',
      '''Con số biểu đạt là một trong những con số quan trọng trong thần số học, cho thấy cách bạn thể hiện bản thân ra bên ngoài và cách người khác nhìn nhận về bạn. Nó giúp bạn hiểu rõ về cách bạn tương tác với thế giới xung quanh.

Tác động của biểu đạt:

1. Giao tiếp:
   - Phong cách nói chuyện
   - Cách thể hiện ý kiến
   - Khả năng thuyết phục
   - Tương tác xã hội

2. Hình ảnh:
   - Cách ăn mặc
   - Phong cách sống
   - Thái độ bên ngoài
   - Ấn tượng đầu tiên

3. Nghề nghiệp:
   - Phong cách làm việc
   - Khả năng thuyết trình
   - Tương tác đồng nghiệp
   - Xây dựng thương hiệu

4. Mối quan hệ:
   - Cách thể hiện tình cảm
   - Tương tác với người khác
   - Xây dựng mối quan hệ
   - Giải quyết xung đột''',
    ],
    'chức năng': [
      '''Ứng dụng Thần Số Học cung cấp các chức năng chính sau:

1. Tính toán các con số quan trọng:
   - Con số chủ đạo: Thể hiện bản chất cốt lõi
   - Biểu đồ ngày sinh: Phân tích chi tiết tính cách
   - Đường đời: Mục đích sống
   - Linh hồn: Khát vọng sâu thẳm
   - Biểu đạt: Cách thể hiện bản thân

2. Phân tích chi tiết:
   - Giải thích ý nghĩa của từng con số
   - Phân tích điểm mạnh và điểm yếu
   - Đưa ra gợi ý phát triển bản thân
   - Dự đoán xu hướng tương lai

3. Tương tác thông minh:
   - Chatbot AI trả lời thắc mắc
   - Hướng dẫn chi tiết cách tính
   - Giải thích các khái niệm
   - Tư vấn phát triển bản thân

4. Giao diện thân thiện:
   - Thiết kế đẹp mắt, dễ sử dụng
   - Biểu đồ trực quan
   - Hướng dẫn từng bước
   - Tương thích đa nền tảng''',
      '''Ứng dụng Thần Số Học là công cụ toàn diện giúp bạn khám phá bản thân thông qua các con số. Các chức năng chính bao gồm:

1. Khám phá bản thân:
   - Tính toán và phân tích các con số quan trọng
   - Hiểu rõ tính cách và tiềm năng
   - Khám phá mục đích sống
   - Tìm ra con đường phát triển phù hợp

2. Hỗ trợ phát triển:
   - Đưa ra gợi ý cải thiện bản thân
   - Phân tích các mối quan hệ
   - Dự đoán cơ hội và thách thức
   - Định hướng nghề nghiệp

3. Tương tác thông minh:
   - Chatbot AI 24/7
   - Hướng dẫn chi tiết
   - Giải đáp thắc mắc
   - Tư vấn cá nhân hóa

4. Tiện ích bổ sung:
   - Lưu trữ kết quả
   - So sánh các giai đoạn
   - Chia sẻ kết quả
   - Cập nhật thường xuyên''',
    ],
    'cách dùng': [
      '''Hướng dẫn sử dụng ứng dụng Thần Số Học:

1. Bắt đầu:
   - Nhấn nút "Bắt Đầu" trên màn hình chính
   - Nhập họ tên đầy đủ
   - Nhập ngày tháng năm sinh
   - Nhấn "Tính Toán"

2. Xem kết quả:
   - Con số chủ đạo: Số quan trọng nhất
   - Biểu đồ ngày sinh: Phân tích chi tiết
   - Đường đời: Mục đích sống
   - Linh hồn: Khát vọng sâu thẳm
   - Biểu đạt: Cách thể hiện bản thân

3. Tương tác với AI:
   - Nhấn nút "Hỏi đáp với AI"
   - Đặt câu hỏi về thần số học
   - Nhận giải thích chi tiết
   - Khám phá thêm kiến thức

4. Lưu ý:
   - Nhập thông tin chính xác
   - Đọc kỹ hướng dẫn
   - Tham khảo giải thích
   - Áp dụng vào cuộc sống''',
      '''Cách sử dụng ứng dụng Thần Số Học một cách hiệu quả:

1. Chuẩn bị thông tin:
   - Họ tên đầy đủ (không dấu)
   - Ngày tháng năm sinh chính xác
   - Mục đích tìm hiểu rõ ràng

2. Các bước thực hiện:
   a) Tính toán cơ bản:
      - Nhập thông tin cá nhân
      - Xem kết quả tổng quan
      - Đọc giải thích cơ bản

   b) Phân tích chi tiết:
      - Xem biểu đồ ngày sinh
      - Đọc phân tích từng con số
      - Hiểu ý nghĩa tổng thể

   c) Tương tác với AI:
      - Đặt câu hỏi cụ thể
      - Nhận tư vấn chi tiết
      - Khám phá thêm kiến thức

3. Áp dụng thực tế:
   - Ghi chú các điểm quan trọng
   - Áp dụng vào cuộc sống
   - Theo dõi sự thay đổi
   - Điều chỉnh khi cần thiết''',
    ],
    'tác giả': [
      '''Ứng dụng Thần Số Học được phát triển bởi Nguyễn Anh Đức, một lập trình viên và nhà nghiên cứu thần số học với nhiều năm kinh nghiệm.

Thông tin về tác giả:
- Tên: Nguyễn Anh Đức
- Năm sinh: 2005
- Chuyên môn: Lập trình và Thần số học
- Kinh nghiệm: 10+ năm nghiên cứu và phát triển

Mục tiêu phát triển:
- Tạo công cụ dễ sử dụng
- Cung cấp kiến thức chính xác
- Hỗ trợ người dùng hiệu quả
- Phát triển cộng đồng thần số học

Liên hệ:
- Email: nduc8215@gmail.com
- Website: https://github.com/DUC23001865
- Facebook: https://www.facebook.com/duc.nguyen.58278''',
      '''Nguyễn Anh Đức là tác giả và nhà phát triển chính của ứng dụng Thần Số Học. Với niềm đam mê về thần số học và công nghệ, anh đã dành nhiều năm nghiên cứu và phát triển để tạo ra một công cụ hữu ích cho cộng đồng.

Quá trình phát triển:
1. Nghiên cứu thần số học
2. Phát triển thuật toán
3. Thiết kế giao diện
4. Tích hợp AI
5. Kiểm thử và hoàn thiện

Cam kết:
- Cập nhật thường xuyên
- Hỗ trợ người dùng
- Bảo mật thông tin
- Chất lượng dịch vụ

Đóng góp:
- Phát triển cộng đồng
- Chia sẻ kiến thức
- Hỗ trợ người dùng
- Nghiên cứu chuyên sâu''',
    ],
    'hoạt động': [
      '''Cách thức hoạt động của ứng dụng Thần Số Học:

1. Thuật toán tính toán:
   - Phân tích ngày sinh
   - Tính toán các con số
   - Tạo biểu đồ ngày sinh
   - Phân tích chi tiết

2. Hệ thống AI:
   - Xử lý ngôn ngữ tự nhiên
   - Phân tích câu hỏi
   - Tìm câu trả lời phù hợp
   - Học hỏi từ tương tác

3. Cơ sở dữ liệu:
   - Lưu trữ kiến thức
   - Cập nhật thường xuyên
   - Bảo mật thông tin
   - Tối ưu hiệu suất

4. Giao diện người dùng:
   - Thiết kế trực quan
   - Tương tác dễ dàng
   - Hiển thị kết quả rõ ràng
   - Hỗ trợ đa nền tảng''',
      '''Ứng dụng Thần Số Học hoạt động dựa trên các nguyên lý sau:

1. Nguyên lý tính toán:
   - Dựa trên thần số học Pythagoras
   - Sử dụng các công thức chuẩn
   - Đảm bảo độ chính xác
   - Cập nhật liên tục

2. Hệ thống AI:
   - Machine Learning
   - Natural Language Processing
   - Pattern Recognition
   - Continuous Learning

3. Bảo mật và lưu trữ:
   - Mã hóa dữ liệu
   - Backup tự động
   - Kiểm soát truy cập
   - Tuân thủ quy định

4. Tối ưu hóa:
   - Tốc độ xử lý
   - Tiết kiệm tài nguyên
   - Trải nghiệm người dùng
   - Độ chính xác cao''',
    ],
  };

  // Câu trả lời cho các câu hỏi tổng quát
  final List<String> generalResponses = [
    'Tôi có thể giúp bạn tìm hiểu về thần số học. Bạn muốn biết thêm về điều gì?',
    'Thần số học là một môn khoa học thú vị. Bạn có câu hỏi cụ thể nào không?',
    'Tôi rất vui được trò chuyện với bạn về thần số học. Bạn muốn tìm hiểu về con số nào?',
    'Thần số học có thể giúp bạn hiểu rõ hơn về bản thân. Bạn muốn khám phá điều gì?',
    'Tôi có thể giải thích về các con số trong thần số học. Bạn quan tâm đến con số nào?',
  ];

  Future<String> getResponse(String message) async {
    message = message.toLowerCase();

    // Kiểm tra các câu hỏi cơ bản trước
    if (message.contains('xin chào') ||
        message.contains('hello') ||
        message.contains('hi') ||
        message.contains('chào') ||
        message.contains('hey')) {
      return 'Xin chào! Tôi là trợ lý thần số học. Tôi có thể giúp bạn tìm hiểu về thần số học, con số chủ đạo, biểu đồ ngày sinh, đường đời, linh hồn hoặc biểu đạt. Bạn muốn biết thêm về điều gì?';
    }

    if (message.contains('cảm ơn') ||
        message.contains('thanks') ||
        message.contains('thank you')) {
      return 'Không có gì! Tôi rất vui được giúp đỡ bạn. Bạn có câu hỏi nào khác không?';
    }

    if (message.contains('tạm biệt') ||
        message.contains('goodbye') ||
        message.contains('bye')) {
      return 'Tạm biệt! Hẹn gặp lại bạn. Nếu có thắc mắc gì, đừng ngại quay lại hỏi tôi nhé!';
    }

    // Kiểm tra các từ khóa đã định nghĩa
    for (String mainKeyword in keywords.keys) {
      for (String synonym in keywords[mainKeyword]!) {
        if (message.contains(synonym)) {
          final random = Random();
          final responsesList = responses[mainKeyword]!;
          return responsesList[random.nextInt(responsesList.length)];
        }
      }
    }

    // Nếu không tìm thấy câu trả lời phù hợp, trả về câu trả lời mặc định
    final random = Random();
    return generalResponses[random.nextInt(generalResponses.length)];
  }
}
