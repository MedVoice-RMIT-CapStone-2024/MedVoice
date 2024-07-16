import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../assets/icon_assets.dart';
import '../../../assets/image_assets.dart';
import '../../../utils/global.dart';
import '../../../utils/module_utils.dart';
import '../../../utils/pages.dart';
import 'reset_controller.dart';

class ResetView extends clean.View {
  ResetView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ResetView();
  }
}

class _ResetView extends BaseStateView<ResetView, ResetController> {
  _ResetView() : super(ResetController());
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
    ResetController _controller = controller as ResetController;
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: toSize(300)),
                  Text("Forgot Password?",
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontSize: toSize(35),
                        fontWeight: FontWeight.w900,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 10),
                    child: Text(
                      "Please provide us with your email address, and we will send you a link to regain access to your account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontSize: toSize(13),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: toSize(10)),
                    padding: EdgeInsets.symmetric(
                        horizontal: toSize(20), vertical: toSize(8)),
                    width: size.width * 0.9,
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 2, color: theme.colorScheme.primary)),
                          child: Icon(
                            Icons.email_rounded,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                        fillColor: theme.colorScheme.onPrimary,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                toSize(20)), // Adjusted size
                            borderSide: BorderSide(color: Colors.black)),
                        isDense: true,
                        hintText: "hello@reallygreatsite.com",
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onBackground,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        focusColor: HexColor("F2509C"),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          // pushScreen(Pages.signIn);
                          onBack();
                        },
                        child: Text("Return to Login",
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: toSize(14),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          pushScreen(Pages.confirm);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          fixedSize: Size(size.width * 0.3, toSize(30)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Send",
                          style: TextStyle(
                            color: theme.colorScheme.surface,
                            fontSize: toSize(14),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
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
