import 'package:demo_bloc/utils/auth_exception.dart';

import '../model/user.dart';

class Repository {
  static Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (password.length < 6) {
      throw AuthException('Password is too short', AuthSource.password);
    } else if (email != 'nam@gmail.com') {
      throw AuthException('Email does not exist', AuthSource.email);
    }
    return User('nam@gmail.com', 'PNam');
  }

  static Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email != 'nam@gmail.com') {
      throw AuthException('Email does not exist', AuthSource.email);
    }
  }

  static Future<List<String>> searchMobileMember(String keyword) async {
    await Future.delayed(const Duration(seconds: 1));

    List<String> mobileTeam = [
      'Le Van Tu',
      'Phan Quoc Hoa',
      'Tran Van An',
      'Pham Nhat Vu',
      'Phan Tuan Kiet',
      'Nguyen Duc Manh',
      'Le Cong Binh',
      'Dang Phuong Nam',
    ];

    return mobileTeam
        .where((e) => e.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }
}
