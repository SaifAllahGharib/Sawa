import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_bottom_sheet.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_back_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_ink_well_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/settings/presentation/widgets/theme_bottom_sheet_widget.dart';

import '../widgets/language_bottom_sheet_widget.dart';
import '../widgets/setting_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showThemeBottomSheet(BuildContext context) {
    AppBottomSheet.showModal(
      context,
      (context) => const ThemeBottomSheetWidget(),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    AppBottomSheet.showModal(
      context,
      (context) => const LanguageBottomSheetWidget(),
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthCubit>().logout();
  }

  void _showDeleteAccountBottomSheet(BuildContext context) {}

  void _deleteAccount(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: AppPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBackButton(),
            24.verticalSpace,
            Text(context.tr.settings, style: AppStyles.s24WB),
            24.verticalSpace,
            SettingButton(text: context.tr.changeName, onTap: () {}),
            SettingButton(text: context.tr.changePassword, onTap: () {}),
            SettingButton(
              text: context.tr.theme,
              onTap: () => _showThemeBottomSheet(context),
            ),
            SettingButton(
              text: context.tr.language,
              onTap: () => _showLanguageBottomSheet(context),
            ),
            20.verticalSpace,
            AppInkWellButton(
              onTap: () => _logout(context),
              child: Text(
                context.tr.logout,
                style: AppStyles.s20W600.copyWith(color: Colors.red),
              ),
            ),
            15.verticalSpace,
            AppInkWellButton(
              onTap: () => _deleteAccount(context),
              child: Text(
                context.tr.deleteAccount,
                style: AppStyles.s20W600.copyWith(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
