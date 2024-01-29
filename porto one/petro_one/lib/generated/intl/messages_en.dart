// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(pass) =>
      "Password should contain at least ${pass} characters or numbers";

  static String m1(liter) => "${liter} Liter";

  static String m2(role) => "${Intl.select(role, {
            'ar': 'English',
            'en': 'العربية',
            'other': 'اختيار',
          })}";

  static String m3(days, hours, minutes) =>
      "${days} Day ${hours} Hours ${minutes} minutes";

  static String m4(petrol) => "Petrol: ${petrol}";

  static String m5(liter) => "Red Petrol: ${liter} - Green";

  static String m6(e) => "Something Error: ${e}";

  static String m7(sr) => "Welcome ${sr}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "a4DigitCodeWasSentToTheWhatsAppApplication":
            MessageLookupByLibrary.simpleMessage(
                "A 4-digit code was sent to the WhatsApp application"),
        "allMyFills": MessageLookupByLibrary.simpleMessage("All my fills"),
        "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "changeNumber": MessageLookupByLibrary.simpleMessage("Change Number"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "connectWithUs":
            MessageLookupByLibrary.simpleMessage("Connect with us"),
        "continuo": MessageLookupByLibrary.simpleMessage("Continue"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
        "dailyBonus": MessageLookupByLibrary.simpleMessage("Daily Bonus"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "enterAValidVerificationCode": MessageLookupByLibrary.simpleMessage(
            "Enter a valid verification code"),
        "enterNewPassword":
            MessageLookupByLibrary.simpleMessage("Enter New Password"),
        "enterPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Enter Password"),
        "enterValidateEmail":
            MessageLookupByLibrary.simpleMessage("Make sure of your email"),
        "enterValidatePassword": m0,
        "fifthGoal": MessageLookupByLibrary.simpleMessage("Fifth Goal"),
        "fill": MessageLookupByLibrary.simpleMessage("Fill"),
        "firstGoal": MessageLookupByLibrary.simpleMessage("First Goal"),
        "forgetPassword":
            MessageLookupByLibrary.simpleMessage("Forget password"),
        "forgetPasswordQ":
            MessageLookupByLibrary.simpleMessage("Forget password?"),
        "fourthGoal": MessageLookupByLibrary.simpleMessage("Fourth Goal"),
        "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "gasStation": MessageLookupByLibrary.simpleMessage("Gas Station"),
        "haveAccount": MessageLookupByLibrary.simpleMessage("Have an account?"),
        "hintEmail": MessageLookupByLibrary.simpleMessage("name@domain"),
        "hintPass": MessageLookupByLibrary.simpleMessage("**********"),
        "hintPhoneNo": MessageLookupByLibrary.simpleMessage("-- -- -- ---"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "literLiter": m1,
        "liters": MessageLookupByLibrary.simpleMessage("Liters"),
        "locale": m2,
        "login": MessageLookupByLibrary.simpleMessage("Log in"),
        "logout": MessageLookupByLibrary.simpleMessage("Log Out"),
        "main": MessageLookupByLibrary.simpleMessage("Main"),
        "makeSureEmailOrPassword":
            MessageLookupByLibrary.simpleMessage("Make sure email or password"),
        "makeSureYourEmailOrPassword": MessageLookupByLibrary.simpleMessage(
            "Make sure your email or password"),
        "menu": MessageLookupByLibrary.simpleMessage("Menu"),
        "modificationPeriodTime": m3,
        "monthlyBonus": MessageLookupByLibrary.simpleMessage("Monthly Bonus"),
        "monthlyTarget": MessageLookupByLibrary.simpleMessage("Monthly target"),
        "myQrCode": MessageLookupByLibrary.simpleMessage("My QR code"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "newRegistration":
            MessageLookupByLibrary.simpleMessage("New registration"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "noInternetConnectionMakeSureOpenedWifi":
            MessageLookupByLibrary.simpleMessage("No Internet Connection"),
        "notFound": MessageLookupByLibrary.simpleMessage("Not Found"),
        "notHaveAccount":
            MessageLookupByLibrary.simpleMessage("Not have account?"),
        "otpEnterSent":
            MessageLookupByLibrary.simpleMessage("(OTP) Enter Sent"),
        "otpIsWrong": MessageLookupByLibrary.simpleMessage("(OTP) is wrong!"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordResetEmailSent": MessageLookupByLibrary.simpleMessage(
            "A password reset email has been sent"),
        "passwordRestEmailSent":
            MessageLookupByLibrary.simpleMessage("Password rest email sent"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "petrolPetrol": m4,
        "petrolType": MessageLookupByLibrary.simpleMessage("Petrol Type"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone number"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "qrCode": MessageLookupByLibrary.simpleMessage("QR Code"),
        "recoverPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Recover Password"),
        "redPetrolLiterGreen": m5,
        "remainingToAchieveGoal509Liter": MessageLookupByLibrary.simpleMessage(
            "Remaining to achieve goal: -509 Liter"),
        "requiredField":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "resend": MessageLookupByLibrary.simpleMessage("Resend"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "secondGoal": MessageLookupByLibrary.simpleMessage("Second Goal"),
        "selectYourPhoneCode":
            MessageLookupByLibrary.simpleMessage("Select your phone code"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "shareTheApp": MessageLookupByLibrary.simpleMessage("Share the app"),
        "show": MessageLookupByLibrary.simpleMessage("Show"),
        "sixthGoal": MessageLookupByLibrary.simpleMessage("Sixth Goal"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "somethingErrorE": m6,
        "successfullyRegistered":
            MessageLookupByLibrary.simpleMessage("Successfully registered"),
        "termsOfUse": MessageLookupByLibrary.simpleMessage("Terms of use"),
        "theAccessCodeHasBeenSent": MessageLookupByLibrary.simpleMessage(
            "The access code has been sent"),
        "thePasswordHasBeenChangedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "The password has been changed successfully"),
        "thirdGoal": MessageLookupByLibrary.simpleMessage("Third Goal"),
        "thisNumberAlreadyExists":
            MessageLookupByLibrary.simpleMessage("This number already exists"),
        "totalPayment": MessageLookupByLibrary.simpleMessage("Total Payment"),
        "validName":
            MessageLookupByLibrary.simpleMessage("Your name is required"),
        "validPhone": MessageLookupByLibrary.simpleMessage(
            "Your phone number is required"),
        "weeklyBonus": MessageLookupByLibrary.simpleMessage("Weekly Bonus"),
        "welcome": m7,
        "whatsappNoInstalled":
            MessageLookupByLibrary.simpleMessage("Whats app No Installed"),
        "worker": MessageLookupByLibrary.simpleMessage("Worker"),
        "youHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("You have an account?"),
        "yourAccountHasBeenCreatedSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Your account has been created successfully")
      };
}
