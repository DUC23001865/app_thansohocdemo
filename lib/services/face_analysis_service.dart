import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img; // Import the image package
import 'dart:typed_data'; // Import typed_data for Uint8List

// TODO: Replace with your actual Face++ API Key and API Secret
// These should ideally be stored securely, not directly in code.
const String _facePlusPlusApiKey = 'yFWYXua0r5iewyCvLj6Y7ibLtO2-knlT';
const String _facePlusPlusApiSecret = 'c6pC4e1j6lkDT8rFvCygGlt-0C5nP5eN';
const String _facePlusPlusDetectUrl =
    'https://api-us.faceplusplus.com/facepp/v3/detect'; // Verify with Face++ docs

class FaceAnalysisResult {
  final String analysisText;
  final Map<String, dynamic>? faceRectangle;

  FaceAnalysisResult({required this.analysisText, this.faceRectangle});
}

Future<FaceAnalysisResult> analyzeFace(
    File imageFile, DateTime birthDate) async {
  try {
    // Read image bytes
    List<int> originalImageBytes = await imageFile.readAsBytes();

    // Decode image
    img.Image? image = img.decodeImage(Uint8List.fromList(
        originalImageBytes)); // Convert List<int> to Uint8List

    if (image == null) {
      return FaceAnalysisResult(analysisText: 'Lỗi: Không thể giải mã ảnh.');
    }

    // Resize image while maintaining aspect ratio
    // Set a maximum width (e.g., 800 pixels) and let the height adjust automatically
    img.Image resizedImage = img.copyResize(image, width: 800);

    // Encode resized image to JPEG with a specific quality (e.g., 80%)
    List<int> resizedImageBytes = img.encodeJpg(resizedImage, quality: 80);

    var uri = Uri.parse(_facePlusPlusDetectUrl);
    var request = http.MultipartRequest('POST', uri)
      ..fields['api_key'] = _facePlusPlusApiKey
      ..fields['api_secret'] = _facePlusPlusApiSecret
      ..fields['return_attributes'] =
          'gender,age,emotion,blur'; // Add blur for image quality

    request.files.add(await http.MultipartFile.fromBytes(
      'image_file',
      resizedImageBytes, // Use resized image bytes
      filename: 'face_image.jpg',
    ));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print('Face++ API Response: $jsonResponse');

      String analysis = 'Kết quả phân tích khuôn mặt:\n\n';
      Map<String, dynamic>? faceRect = null;

      if (jsonResponse['faces'] != null && jsonResponse['faces'].isNotEmpty) {
        var face = jsonResponse['faces'][0];

        // Extract face rectangle
        faceRect = face['face_rectangle'];

        // Add original image dimensions to faceRect for scaling in UI
        if (jsonResponse['image_width'] != null &&
            jsonResponse['image_height'] != null) {
          faceRect?['image_width'] = jsonResponse['image_width'];
          faceRect?['image_height'] = jsonResponse['image_height'];
        }

        // Add text description of face location
        if (faceRect != null) {
          final double top = faceRect['top']?.toDouble() ?? 0.0;
          final double left = faceRect['left']?.toDouble() ?? 0.0;
          final double width = faceRect['width']?.toDouble() ?? 0.0;
          final double height = faceRect['height']?.toDouble() ?? 0.0;
          analysis +=
              '- Vị trí khuôn mặt: Tọa độ ($left, $top), Kích thước ($width x $height)\n';
        }

        if (face['attributes'] != null) {
          var attributes = face['attributes'];

          if (attributes['age'] != null) {
            final estimatedAge = attributes['age']['value'];
            analysis += '- Tuổi ước lượng (AI): $estimatedAge\n';
          }
          if (attributes['gender'] != null &&
              attributes['gender']['value'] != null) {
            analysis +=
                '- Giới tính (AI nhận diện): ${attributes['gender']['value'] == 'Male' ? 'Nam' : 'Nữ'}\n';
          }

          if (attributes['emotion'] != null) {
            analysis += '- Cảm xúc (AI nhận diện): \n';
            var emotions = attributes['emotion'];

            // Find the dominant emotion manually
            String dominantEmotionKey = '';
            double maxConfidence = -1.0;
            emotions.forEach((key, value) {
              // Ensure value is treated as a double for comparison
              if (value is num && value.toDouble() > maxConfidence) {
                maxConfidence = value.toDouble();
                dominantEmotionKey = key;
              }
            });

            if (dominantEmotionKey.isNotEmpty) {
              analysis +=
                  '  ${_translateEmotion(dominantEmotionKey)} (${(maxConfidence).toStringAsFixed(1)}%)\n';

              // Add advice based on dominant emotion
              analysis += _getEmotionAdvice(dominantEmotionKey) + '\n';
            } else {
              analysis += '  Không xác định được cảm xúc.\n';
            }
          }

          if (attributes['smile'] != null &&
              attributes['smile']['value'] != null) {
            analysis +=
                '- Nụ cười (cường độ): ${(attributes['smile']['value']).toStringAsFixed(1)}%\n';
          }

          // Check for blur (image quality)
          if (attributes['blur'] != null &&
              attributes['blur']['value'] != null) {
            final blurValue = attributes['blur']['value']
                .toStringAsFixed(2); // Get numerical blur value, formatted
            analysis += '- Mức độ mờ (ảnh): $blurValue\n';
          }

          // Add other attributes here as needed:
          // if (attributes['headpose'] != null) { ... }
          // if (attributes['beauty'] != null) { ... } // Check if supported by your plan
          // ... and so on for facialhair, makeup, occlusion, accessories, blur, exposure, noise
        }
      } else {
        analysis += 'Không phát hiện khuôn mặt nào trong ảnh.';
      }

      return FaceAnalysisResult(
          analysisText: analysis, faceRectangle: faceRect);
    } else {
      String errorMessage = 'Lỗi khi gọi Face++ API: ${response.statusCode}';
      try {
        var errorResponse = json.decode(response.body);
        if (errorResponse != null && errorResponse['error_message'] != null) {
          errorMessage += '\nThông báo: ${errorResponse['error_message']}';
        }
      } catch (e) {
        print('Error parsing error response: $e');
      }
      print(errorMessage);
      return FaceAnalysisResult(
          analysisText:
              'Đã xảy ra lỗi trong quá trình phân tích: $errorMessage');
    }
  } catch (e) {
    print('Error analyzing face: $e');
    return FaceAnalysisResult(
        analysisText: 'Đã xảy ra lỗi trong quá trình phân tích: $e');
  }
}

String _translateEmotion(String emotion) {
  switch (emotion) {
    case 'anger':
      return 'Tức giận';
    case 'contempt':
      return 'Khinh bỉ';
    case 'disgust':
      return 'Ghê tởm';
    case 'fear':
      return 'Sợ hãi';
    case 'happiness':
      return 'Hạnh phúc';
    case 'neutral':
      return 'Bình thường';
    case 'sadness':
      return 'Buồn bã';
    case 'surprise':
      return 'Ngạc nhiên';
    default:
      return emotion;
  }
}

String _translateGlasses(String glasses) {
  switch (glasses) {
    case 'NoGlasses':
      return 'Không đeo kính';
    case 'CommonGlasses':
      return 'Kính thường';
    case 'SunGlasses':
      return 'Kính râm';
    default:
      return glasses;
  }
}

String _getEmotionAdvice(String emotionKey) {
  switch (emotionKey) {
    case 'anger':
      return 'Lời khuyên: Hãy thử hít thở sâu, tập thể dục nhẹ nhàng hoặc trò chuyện với người tin cậy để giải tỏa căng thẳng.';
    case 'contempt':
      return 'Lời khuyên: Cố gắng nhìn nhận vấn đề từ nhiều phía và tìm cách xây dựng sự thấu hiểu.';
    case 'disgust':
      return 'Lời khuyên: Nếu có thể, hãy tránh xa hoặc thay đổi những gì khiến bạn cảm thấy khó chịu.';
    case 'fear':
      return 'Lời khuyên: Đối mặt với nỗi sợ hãi từng chút một, tìm kiếm sự hỗ trợ từ bạn bè, gia đình hoặc chuyên gia.';
    case 'happiness':
      return 'Lời khuyên: Tận hưởng khoảnh khắc này! Chia sẻ niềm vui với người khác hoặc thử các hoạt động yêu thích.';
    case 'neutral':
      return 'Lời khuyên: Một tâm trạng ổn định. Bạn có thể duy trì trạng thái này bằng cách cân bằng công việc và nghỉ ngơi.';
    case 'sadness':
      return 'Lời khuyên: Cho phép bản thân buồn bã, tìm kiếm sự an ủi từ người thân yêu hoặc thử viết nhật ký.';
    case 'surprise':
      return 'Lời khuyên: Đón nhận những điều bất ngờ với tâm thế cởi mở. Tìm hiểu thêm về điều đó có thể thú vị.';
    default:
      return ''; // No specific advice for unknown emotions
  }
}

// Note: calculateAge and getAgeAdvice are kept in result_screen for now
// unless needed elsewhere.
