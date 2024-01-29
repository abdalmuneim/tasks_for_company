// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(pass) =>
      "يجب أن تحتوي كلمة المرور على ${pass} حروف أو أرقام على الأقل";

  static String m1(liter) => "${liter} لتر";

  static String m2(role) => "${Intl.select(role, {
            'ar': 'English',
            'en': 'العربية',
            'other': 'اختيار',
          })}";

  static String m3(days, hours, minutes) =>
      "${days} يوم ${hours} ساعة ${minutes} دقيقة";

  static String m4(petrol) => "البنزين: ${petrol}";

  static String m5(liter) => "البنزين الأحمر: ${liter} - أخضر";

  static String m6(e) => "خطأ: ${e}";

  static String m7(sr) => "مرحبًا ${sr}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "a4DigitCodeWasSentToTheWhatsAppApplication":
            MessageLookupByLibrary.simpleMessage(
                "تم إرسال رمز مكون من 4 أرقام إلى تطبيق WhatsApp"),
        "allMyFills": MessageLookupByLibrary.simpleMessage("جميع تعبئاتي"),
        "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
        "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
        "changeNumber": MessageLookupByLibrary.simpleMessage("تغيير الرقم"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
        "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور"),
        "connectWithUs": MessageLookupByLibrary.simpleMessage("تواصل معنا"),
        "continuo": MessageLookupByLibrary.simpleMessage("متابعة"),
        "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "dailyBonus": MessageLookupByLibrary.simpleMessage("مكافأة يومية"),
        "date": MessageLookupByLibrary.simpleMessage("التاريخ"),
        "editProfile":
            MessageLookupByLibrary.simpleMessage("تعديل الملف الشخصي"),
        "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
        "english": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
        "enterAValidVerificationCode":
            MessageLookupByLibrary.simpleMessage("أدخل رمز التحقق الصحيح"),
        "enterNewPassword":
            MessageLookupByLibrary.simpleMessage("إدخال كلمة المرور الجديدة"),
        "enterPasswordTitle":
            MessageLookupByLibrary.simpleMessage("إدخال كلمة المرور"),
        "enterValidateEmail":
            MessageLookupByLibrary.simpleMessage("تأكد من بريدك الإلكتروني"),
        "enterValidatePassword": m0,
        "fifthGoal": MessageLookupByLibrary.simpleMessage("الهدف الخامس"),
        "fill": MessageLookupByLibrary.simpleMessage("تعبئة"),
        "firstGoal": MessageLookupByLibrary.simpleMessage("الهدف الأول"),
        "forgetPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور"),
        "forgetPasswordQ":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
        "fourthGoal": MessageLookupByLibrary.simpleMessage("الهدف الرابع"),
        "gallery": MessageLookupByLibrary.simpleMessage("المعرض"),
        "gasStation": MessageLookupByLibrary.simpleMessage("محطة الوقود"),
        "haveAccount": MessageLookupByLibrary.simpleMessage("هل لديك حساب؟"),
        "hintEmail": MessageLookupByLibrary.simpleMessage("الاسم@النطاق"),
        "hintPass": MessageLookupByLibrary.simpleMessage("**********"),
        "hintPhoneNo": MessageLookupByLibrary.simpleMessage("-- -- -- ---"),
        "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "language": MessageLookupByLibrary.simpleMessage("اللغة"),
        "literLiter": m1,
        "liters": MessageLookupByLibrary.simpleMessage("لتر"),
        "locale": m2,
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "main": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "makeSureEmailOrPassword": MessageLookupByLibrary.simpleMessage(
            "تأكد من البريد الإلكتروني أو كلمة المرور"),
        "makeSureYourEmailOrPassword": MessageLookupByLibrary.simpleMessage(
            "تأكد من بريدك الإلكتروني أو كلمة المرور"),
        "menu": MessageLookupByLibrary.simpleMessage("القائمة"),
        "modificationPeriodTime": m3,
        "monthlyBonus": MessageLookupByLibrary.simpleMessage("مكافأة شهرية"),
        "monthlyTarget": MessageLookupByLibrary.simpleMessage("الهدف الشهري"),
        "myQrCode": MessageLookupByLibrary.simpleMessage("رمزي الشخصي QR"),
        "name": MessageLookupByLibrary.simpleMessage("الاسم"),
        "newRegistration": MessageLookupByLibrary.simpleMessage("تسجيل جديد"),
        "next": MessageLookupByLibrary.simpleMessage("التالي"),
        "noInternetConnectionMakeSureOpenedWifi":
            MessageLookupByLibrary.simpleMessage("لا يوجد اتصال بالإنترنت"),
        "notFound": MessageLookupByLibrary.simpleMessage("لم يتم العثور"),
        "notHaveAccount": MessageLookupByLibrary.simpleMessage("لا تملك حساب؟"),
        "otpEnterSent":
            MessageLookupByLibrary.simpleMessage("(OTP) تم إرسال رمز التحقق"),
        "otpIsWrong": MessageLookupByLibrary.simpleMessage("(OTP) خاطئ!"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "passwordResetEmailSent": MessageLookupByLibrary.simpleMessage(
            "تم إرسال رسالة إعادة تعيين كلمة المرور"),
        "passwordRestEmailSent": MessageLookupByLibrary.simpleMessage(
            "تم إرسال رسالة إعادة تعيين كلمة المرور"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("كلمات المرور غير متطابقة"),
        "petrolPetrol": m4,
        "petrolType": MessageLookupByLibrary.simpleMessage("نوع البنزين"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
        "profile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
        "qrCode":
            MessageLookupByLibrary.simpleMessage("رمز الاستجابة السريعة QR"),
        "recoverPasswordTitle":
            MessageLookupByLibrary.simpleMessage("استرجاع كلمة المرور"),
        "redPetrolLiterGreen": m5,
        "remainingToAchieveGoal509Liter": MessageLookupByLibrary.simpleMessage(
            "المتبقي لتحقيق الهدف: -509 لتر"),
        "requiredField":
            MessageLookupByLibrary.simpleMessage("هذا الحقل مطلوب"),
        "resend": MessageLookupByLibrary.simpleMessage("إعادة الإرسال"),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "search": MessageLookupByLibrary.simpleMessage("بحث"),
        "secondGoal": MessageLookupByLibrary.simpleMessage("الهدف الثاني"),
        "selectYourPhoneCode":
            MessageLookupByLibrary.simpleMessage("حدد كود الهاتف"),
        "send": MessageLookupByLibrary.simpleMessage("إرسال"),
        "shareTheApp": MessageLookupByLibrary.simpleMessage("مشاركة التطبيق"),
        "show": MessageLookupByLibrary.simpleMessage("عرض"),
        "sixthGoal": MessageLookupByLibrary.simpleMessage("الهدف السادس"),
        "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
        "somethingErrorE": m6,
        "successfullyRegistered":
            MessageLookupByLibrary.simpleMessage("تم التسجيل بنجاح"),
        "termsOfUse": MessageLookupByLibrary.simpleMessage("شروط الاستخدام"),
        "theAccessCodeHasBeenSent":
            MessageLookupByLibrary.simpleMessage("تم إرسال رمز الوصول"),
        "thePasswordHasBeenChangedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم تغيير كلمة المرور بنجاح"),
        "thirdGoal": MessageLookupByLibrary.simpleMessage("الهدف الثالث"),
        "thisNumberAlreadyExists":
            MessageLookupByLibrary.simpleMessage("هذا الرقم موجود بالفعل"),
        "totalPayment": MessageLookupByLibrary.simpleMessage("المبلغ الإجمالي"),
        "validName": MessageLookupByLibrary.simpleMessage("اسمك مطلوب"),
        "validPhone": MessageLookupByLibrary.simpleMessage("رقم هاتفك مطلوب"),
        "weeklyBonus": MessageLookupByLibrary.simpleMessage("مكافأة أسبوعية"),
        "welcome": m7,
        "whatsappNoInstalled":
            MessageLookupByLibrary.simpleMessage("تطبيق WhatsApp غير مثبت"),
        "worker": MessageLookupByLibrary.simpleMessage("العامل"),
        "youHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("هل لديك حساب؟"),
        "yourAccountHasBeenCreatedSuccessful":
            MessageLookupByLibrary.simpleMessage("تم إنشاء حسابك بنجاح")
      };
}
