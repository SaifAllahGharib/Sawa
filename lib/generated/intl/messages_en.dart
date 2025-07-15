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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountExistsWithDifferentMethod": MessageLookupByLibrary.simpleMessage(
      "Account exists with different method",
    ),
    "codeSendNotSuccess": MessageLookupByLibrary.simpleMessage(
      "Code not sent successfully",
    ),
    "codeSendSuccess": MessageLookupByLibrary.simpleMessage(
      "Code sent successfully",
    ),
    "doNotHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account",
    ),
    "emailNotValid": MessageLookupByLibrary.simpleMessage("email not valid"),
    "email_already_used": MessageLookupByLibrary.simpleMessage(
      "Email already used",
    ),
    "errorToConnectTheNetwork": MessageLookupByLibrary.simpleMessage(
      "Error to connect the network",
    ),
    "hintEmail": MessageLookupByLibrary.simpleMessage("example@ex.ex"),
    "hintName": MessageLookupByLibrary.simpleMessage("Saif Allah"),
    "hintPassword": MessageLookupByLibrary.simpleMessage("************"),
    "ifYouHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "If you have an account",
    ),
    "labelEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "labelName": MessageLookupByLibrary.simpleMessage("Name"),
    "labelPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "passwordValidationMsg": MessageLookupByLibrary.simpleMessage(
      "Must be 8+ chars with uppercase, number & symbol",
    ),
    "required": MessageLookupByLibrary.simpleMessage("Required"),
    "resendEmail": MessageLookupByLibrary.simpleMessage("Resend Email"),
    "sendLinkVerificationYourEmailTo": MessageLookupByLibrary.simpleMessage(
      "Verification Link Sent to",
    ),
    "signup": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "thisAccountIsDisabled": MessageLookupByLibrary.simpleMessage(
      "This account is disabled",
    ),
    "unknownError": MessageLookupByLibrary.simpleMessage("Unknown error"),
    "userNotFound": MessageLookupByLibrary.simpleMessage(
      "User not exists or email or password incorrect",
    ),
    "weakPassword": MessageLookupByLibrary.simpleMessage("Password Weak"),
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back"),
  };
}
