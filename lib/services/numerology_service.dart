import 'package:flutter/material.dart';

class NumerologyService {
  // Tính số đường đời (Life Path Number)
  static int calculateLifePathNumber(DateTime birthDate) {
    int sum = birthDate.day + birthDate.month + birthDate.year;
    while (sum > 9) {
      sum = sum
          .toString()
          .split('')
          .map((e) => int.parse(e))
          .reduce((a, b) => a + b);
    }
    return sum;
  }

  // Tính số sứ mệnh (Destiny Number)
  static int calculateDestinyNumber(String fullName) {
    // Chuyển tên thành số theo bảng chữ cái
    Map<String, int> letterValues = {
      'a': 1,
      'b': 2,
      'c': 3,
      'd': 4,
      'e': 5,
      'f': 6,
      'g': 7,
      'h': 8,
      'i': 9,
      'j': 1,
      'k': 2,
      'l': 3,
      'm': 4,
      'n': 5,
      'o': 6,
      'p': 7,
      'q': 8,
      'r': 9,
      's': 1,
      't': 2,
      'u': 3,
      'v': 4,
      'w': 5,
      'x': 6,
      'y': 7,
      'z': 8,
    };

    int sum = 0;
    for (int i = 0; i < fullName.length; i++) {
      String char = fullName[i].toLowerCase();
      if (letterValues.containsKey(char)) {
        sum += letterValues[char]!;
      }
    }

    while (sum > 9) {
      sum = sum
          .toString()
          .split('')
          .map((e) => int.parse(e))
          .reduce((a, b) => a + b);
    }
    return sum;
  }

  // Tính số thái độ (Attitude Number)
  static int calculateAttitudeNumber(DateTime birthDate) {
    int sum = birthDate.day + birthDate.month;
    while (sum > 9) {
      sum = sum
          .toString()
          .split('')
          .map((e) => int.parse(e))
          .reduce((a, b) => a + b);
    }
    return sum;
  }

  // Tính số linh hồn (Soul Number)
  static int calculateSoulNumber(String fullName) {
    // Chỉ tính tổng các nguyên âm
    List<String> vowels = ['a', 'e', 'i', 'o', 'u'];
    Map<String, int> letterValues = {'a': 1, 'e': 5, 'i': 9, 'o': 6, 'u': 3};

    int sum = 0;
    for (int i = 0; i < fullName.length; i++) {
      String char = fullName[i].toLowerCase();
      if (vowels.contains(char) && letterValues.containsKey(char)) {
        sum += letterValues[char]!;
      }
    }

    while (sum > 9) {
      sum = sum
          .toString()
          .split('')
          .map((e) => int.parse(e))
          .reduce((a, b) => a + b);
    }
    return sum;
  }

  // Tính số nhân cách (Personality Number)
  static int calculatePersonalityNumber(String fullName) {
    // Chỉ tính tổng các phụ âm
    List<String> vowels = ['a', 'e', 'i', 'o', 'u'];
    Map<String, int> letterValues = {
      'b': 2,
      'c': 3,
      'd': 4,
      'f': 6,
      'g': 7,
      'h': 8,
      'j': 1,
      'k': 2,
      'l': 3,
      'm': 4,
      'n': 5,
      'p': 7,
      'q': 8,
      'r': 9,
      's': 1,
      't': 2,
      'v': 4,
      'w': 5,
      'x': 6,
      'y': 7,
      'z': 8,
    };

    int sum = 0;
    for (int i = 0; i < fullName.length; i++) {
      String char = fullName[i].toLowerCase();
      if (!vowels.contains(char) && letterValues.containsKey(char)) {
        sum += letterValues[char]!;
      }
    }

    while (sum > 9) {
      sum = sum
          .toString()
          .split('')
          .map((e) => int.parse(e))
          .reduce((a, b) => a + b);
    }
    return sum;
  }
}
