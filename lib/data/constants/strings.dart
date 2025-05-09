class Strings {
  Strings._();

  static const String appName = 'Finance News';

  // Sign Up Screen
  static const String legalNameTitle = 'Your legal name';
  static const String signUpSubtitle =
      'We need to know a bit about you so that we can create your account.';
  static const String firstNameHint = 'First name';
  static const String lastNameHint = 'Last name';
  static const String signUpErrorMessage =
      'Something went wrong. Please try again.';

  static const String couldNotLaunch = 'Could not launch';
  static const String fieldRequired = 'Field is required.';
  static const String onlyAlphabetAllowed =
      'Please enter only alphabetical characters.';

  // Exception prefixes
  static const String errorDuringCommunication = "Error During Communication: ";
  static const String invalidRequest = "Invalid Request: ";
  static const String unauthorised = "Unauthorised: ";
  static const String forbidden = "Forbidden: ";
  static const String notFound = "Not Found: ";
  static const String conflict = "Conflict: ";
  static const String invalidInput = "Invalid Input: ";

  // User credential messages
  static const String saveSuccess = 'Saved Successfully!';
  static const String saveFailed = 'Failed to save user credentials';
  static const String getFirstNameFailed = 'Failed to get First Name';

  // Network and API messages
  static const String noInternet = 'No Internet connection';
  static const String requestTimeout = 'Request timed out';
  static const String genericError = 'There was an Error!';
  static const String communicationError =
      'Error occurred while communicating with the server';

  // News fetch messages
  static const String loadingNews = 'Loading News';
  static const String newsLoaded = 'News Loaded Successfully';

  // AllowNotificationsScreen
  static const String allowNotifTitle = 'Get the most out of Blott ✅';
  static const String allowNotifSubtitle =
      'Allow notifications to stay in the loop with your payments, requests and groups.';
  static const String continueButton = 'Continue';
  static const String notifDialogTitle = 'Notification Permission';
  static const String notifDialogSubtitle =
      'Notification permission should be granted to use this feature. Would you like to go to app settings to allow notifications?';
  static const String permissionDeniedMessage =
      'Permission to send notifications denied!';

  // NewsDetailScreen
  static const String greeting = 'Hey';

  static const List<String> months = [
    '', // index 0 unused
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
}
