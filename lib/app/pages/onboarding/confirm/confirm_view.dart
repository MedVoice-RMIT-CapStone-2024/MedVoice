import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/widgets/background_set.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../assets/icon_assets.dart';
import '../../../utils/global.dart';
import '../../../utils/module_utils.dart';
import 'confirm_controller.dart';

class ConfirmView extends clean.View {
  ConfirmView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ConfirmView();
  }
}

class _ConfirmView extends BaseStateView<ConfirmView, ConfirmController> {
  _ConfirmView() : super(ConfirmController());
  @override
  bool isInitialAppbar() {
    return false;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ConfirmController _controller = controller as ConfirmController;
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: toSize(250)),
                  Image.asset(ImageAssets.imgEmail,
                      width: toSize(190),
                      height: toSize(190),
                      fit: BoxFit.fill),
                  Text("Check your Inbox",
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontSize: toSize(30),
                        fontWeight: FontWeight.w800,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 10),
                    child: Text(
                      "An email containing instructions to reset your password has been sent to @dudu.com",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontSize: toSize(13),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(toSize(10)),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        fixedSize: Size(size.width * 0.6, toSize(50)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Open email app",
                        style: TextStyle(
                          color: theme.colorScheme.surface,
                          fontSize: toSize(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: toSize(10)),
                  Text("Resend email",
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontSize: toSize(14),
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Positioned(
                top: toSize(60),
                child: InkWell(
                  onTap: () {
                    onBack();
                  },
                  child: Image.asset(
                    IconAssets.icBack,
                    width: toSize(20),
                    height: toSize(20),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
