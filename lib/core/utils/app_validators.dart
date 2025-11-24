class AppValidators {
  AppValidators._(); // Private constructor لمنع إنشاء instance من الكلاس

  // 1. Email Validator
  static String? validateEmail(String? val) {
    // Regex بسيط وشامل لأغلب الإيميلات
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (val == null || val.trim().isEmpty) {
      return 'this field is required';
    } else if (emailRegex.hasMatch(val) == false) {
      return 'Please enter a valid email address'; // رسالة أوضح
    }
    return null;
  }

  // 2. Password Validator
  static String? validatePassword(String? val) {
    // كلمة مرور تحتوي على حرف واحد ورقم واحد على الأقل
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');

    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else if (val.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!passwordRegex.hasMatch(val)) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  // 3. Confirm Password Validator
  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else if (val != password) {
      return 'Passwords do not match'; // رسالة أوضح من "same password"
    }
    return null;
  }

  // 4. Username Validator
  static String? validateUsername(String? val) {
    // يسمح بالحروف والأرقام والنقاط والشرط
    RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');

    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else if (!usernameRegex.hasMatch(val)) {
      return 'Invalid username (no special characters allowed)';
    }
    return null;
  }

  // 5. Full Name Validator
  static String? validateFullName(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'this field is required';
    } else if (val.trim().length < 3) {
      // إضافة تحقق بسيط من طول الاسم
      return 'Name is too short';
    }
    return null;
  }

  // 6. Phone Number Validator (Egyptian Standard) 🇪🇬
  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'this field is required';
    }

    // ✅ Regex للأرقام المصرية فقط (تبدأ بـ 010, 011, 012, 015 وتتكون من 11 رقم)
    RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');

    if (!phoneRegex.hasMatch(val.trim())) {
      return 'Enter a valid Egyptian phone number';
    }
    return null;
  }
}