import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/utils/shared_preferences.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/base_controller.dart';
import '../../../../../../common/base_state_view.dart';
import '../../../../../utils/global.dart';
import '../../../../../utils/module_utils.dart';
import 'language_controller.dart';

class LanguageView extends clean.View {
  const LanguageView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LanguageView();
  }
}

class _LanguageView extends BaseStateView<LanguageView, LanguageController> {
  _LanguageView() : super(LanguageController());

  ThemeData? theme;

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return toText("languageTitle");
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    LanguageController languageController = controller as LanguageController;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: toSize(20), vertical: toSize(18)),
        child: Container(
          height: toSize(120),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7),
              bottomLeft: Radius.circular(7),
              bottomRight: Radius.circular(7),
            ),
            color: theme.colorScheme.surface,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: toSize(20), vertical: toSize(1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (Global.mLanguageConfig.mLang != "en") {
                      showPopupWithAction(toText("languageChange"),
                          toText("languageChangeConfirm"), () async {
                        SharedPreferencesHelper().setStringValue(
                            SharedData.APP_LANGUAGE.toString(), "en");
                        Global.mLanguageConfig.mLang =
                            await SharedPreferencesHelper().getStringValue(
                                SharedData.APP_LANGUAGE.toString(),
                                defaultValue: "en");
                        restartApp();
                      }, toText("languageChangeTitle"),
                          toText("languageChangeCancel"), () {});
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: toSize(50),
                        child: Center(
                          child: Text(
                            toText("languageEn"),
                          ),
                        ),
                      ),
                      (Global.mLanguageConfig.mLang == "en")
                          ? const Icon(Icons.check)
                          : const SizedBox()
                    ],
                  ),
                ),
                Divider(color: theme.colorScheme.background.withOpacity(0.5)),
                InkWell(
                  onTap: () {
                    if (Global.mLanguageConfig.mLang != "vi") {
                      showPopupWithAction(toText("languageChange"),
                          toText("languageChangeConfirm"), () async {
                        SharedPreferencesHelper().setStringValue(
                            SharedData.APP_LANGUAGE.toString(), "vi");
                        Global.mLanguageConfig.mLang =
                            await SharedPreferencesHelper().getStringValue(
                                SharedData.APP_LANGUAGE.toString(),
                                defaultValue: "en");
                        restartApp();
                      }, toText("languageChangeTitle"),
                          toText("languageChangeCancel"), () {});
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: toSize(50),
                        child: Center(
                          child: Text(
                            toText("languageVi"),
                          ),
                        ),
                      ),
                      (Global.mLanguageConfig.mLang == "vi")
                          ? const Icon(Icons.check)
                          : const SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
