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
        "accountCreated":
            MessageLookupByLibrary.simpleMessage("Account Created"),
        "addFingerprint":
            MessageLookupByLibrary.simpleMessage("Add Fingerprint"),
        "addRfid": MessageLookupByLibrary.simpleMessage("Add RFID"),
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "checkYourInternet":
            MessageLookupByLibrary.simpleMessage("Check Your Internet!"),
        "commandFailed": MessageLookupByLibrary.simpleMessage("Command Failed"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "confirmationRequired":
            MessageLookupByLibrary.simpleMessage("Confirmation required!"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Current Password"),
        "currentPasswordRequired":
            MessageLookupByLibrary.simpleMessage("Current Password required!"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteFingerprint":
            MessageLookupByLibrary.simpleMessage("Delete Fingerprint"),
        "deleteRfid": MessageLookupByLibrary.simpleMessage("Delete RFID"),
        "details": MessageLookupByLibrary.simpleMessage("Details"),
        "detailsRequired":
            MessageLookupByLibrary.simpleMessage("Details required!"),
        "dontHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t Have an account"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("Email required!"),
        "enterPassword": MessageLookupByLibrary.simpleMessage("Enter Password"),
        "errorSendingUnlockCommand": MessageLookupByLibrary.simpleMessage(
            "Error sending unlock command"),
        "fingerprint": MessageLookupByLibrary.simpleMessage("Fingerprint"),
        "fingerprintDeleteFailed":
            MessageLookupByLibrary.simpleMessage("Fingerprint Delete Failed"),
        "fingerprintDeleted":
            MessageLookupByLibrary.simpleMessage("Fingerprint Deleted"),
        "fingerprintStorageFailed":
            MessageLookupByLibrary.simpleMessage("Fingerprint Storage Failed"),
        "fingerprintStored":
            MessageLookupByLibrary.simpleMessage("Fingerprint Stored"),
        "fingerprints": MessageLookupByLibrary.simpleMessage("Fingerprints"),
        "forgetPassword":
            MessageLookupByLibrary.simpleMessage("Forget Password?"),
        "id": MessageLookupByLibrary.simpleMessage("ID"),
        "invalidCredentials":
            MessageLookupByLibrary.simpleMessage("Invalid Credentials!"),
        "invalidPassword":
            MessageLookupByLibrary.simpleMessage("Invalid Password"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "locked": MessageLookupByLibrary.simpleMessage("Locked"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "manageAccess": MessageLookupByLibrary.simpleMessage("Manage Access"),
        "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
        "newPasswordRequired":
            MessageLookupByLibrary.simpleMessage("New Password required!"),
        "notConnectedToSmartLock":
            MessageLookupByLibrary.simpleMessage("Not connected to smart lock"),
        "obtainingFingerprintsFailed": MessageLookupByLibrary.simpleMessage(
            "Obtaining Fingerprints Failed"),
        "obtainingRfidsFailed":
            MessageLookupByLibrary.simpleMessage("Obtaining RFIDs Failed"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordChangeFailed":
            MessageLookupByLibrary.simpleMessage("Password Change Failed"),
        "passwordChanged":
            MessageLookupByLibrary.simpleMessage("Password Changed"),
        "passwordRequired":
            MessageLookupByLibrary.simpleMessage("Password Required"),
        "pleaseTurnOnBluetooth":
            MessageLookupByLibrary.simpleMessage("Please turn on Bluetooth!"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "registrationFailed":
            MessageLookupByLibrary.simpleMessage("Registration Failed"),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "resetPasswordEmailSentToYourAccount":
            MessageLookupByLibrary.simpleMessage(
                "Reset password email sent to your account"),
        "resetPasswordFailed":
            MessageLookupByLibrary.simpleMessage("Reset Password Failed"),
        "rfid": MessageLookupByLibrary.simpleMessage("RFID"),
        "rfidDeleteFailed":
            MessageLookupByLibrary.simpleMessage("RFID Delete Failed"),
        "rfidDeleted": MessageLookupByLibrary.simpleMessage("RFID Deleted"),
        "rfidStorageFailed":
            MessageLookupByLibrary.simpleMessage("RFID Storage Failed"),
        "rfidStored": MessageLookupByLibrary.simpleMessage("RFID Stored"),
        "rfids": MessageLookupByLibrary.simpleMessage("RFIDs"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "theAccountAlreadyExistsForThatEmail":
            MessageLookupByLibrary.simpleMessage(
                "The account already exists for that email"),
        "thePasswordProvidedIsTooWeak": MessageLookupByLibrary.simpleMessage(
            "The password provided is too weak"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "thosePasswordDidntMatch": MessageLookupByLibrary.simpleMessage(
            "Those password didn\'t match"),
        "tooShort": MessageLookupByLibrary.simpleMessage("Too Short"),
        "uid": MessageLookupByLibrary.simpleMessage("UID"),
        "unlock": MessageLookupByLibrary.simpleMessage("Unlock"),
        "unlocked": MessageLookupByLibrary.simpleMessage("Unlocked"),
        "userName": MessageLookupByLibrary.simpleMessage("Username"),
        "usernameRequired":
            MessageLookupByLibrary.simpleMessage("Username required!"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome")
      };
}
