import '../../di/dependency_injection.dart';
import '../helpers/shared_preferences_helper.dart';

bool get currentLocaleIsArabic =>
    getIt<SharedPreferencesHelper>().getLanguageCode() == "ar";
