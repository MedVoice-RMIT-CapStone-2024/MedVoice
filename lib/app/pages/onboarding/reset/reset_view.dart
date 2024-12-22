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
import '../../../utils/module_utils.dart';
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
  ResetController? _controller;

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
    _controller = controller as ResetController;
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _controller?.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: toSize(20)),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: toSize(120)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(ImageAssets.medVoiceCroppedLogo,
                                  height: toSize(55)),
                              SizedBox(height: toSize(25)),
                              Text("Forgot Password?",
                                  style: TextStyle(
                                      color: theme.colorScheme.onBackground,
                                      fontSize: toSize(35),
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Montserrat')),
                              SizedBox(height: toSize(10)),
                              Text(
                                "Please provide us with your email address,\nwe will send you a link to regain access to your account.",
                                style: TextStyle(
                                    color: theme.colorScheme.onBackground,
                                    fontSize: toSize(14),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Montserrat'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: toSize(30)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: toSize(10)),
                          child: TextFormField(
                            controller: _controller!.emailController,
                            validator: _controller?.validateEmail,
                            decoration: InputDecoration(
                              icon: Container(
                                padding: EdgeInsets.all(toSize(8)),
                                decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2,
                                        color: theme.colorScheme.primary)),
                                child: Icon(
                                  Icons.email_rounded,
                                  color: Colors.white,
                                  size:
                                      MediaQuery.of(context).size.width * 0.08,
                                ),
                              ),
                              fillColor: theme.colorScheme.onPrimary,
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black)),
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
                        SizedBox(height: toSize(30)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: toSize(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    onBack();
                                  },
                                  child: Container(
                                    height: toSize(50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: theme.colorScheme.onSurface
                                                .withOpacity(0.7)),
                                        color: theme.colorScheme.onPrimary),
                                    child: Center(
                                      child: Text("Return to Login",
                                          style: TextStyle(
                                              color: theme.colorScheme.onSurface
                                                  .withOpacity(0.8),
                                              fontSize: toSize(14),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Montserrat')),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: toSize(30)),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _controller!.submitForm();
                                  },
                                  child: Container(
                                    height: toSize(50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: theme.colorScheme.primary),
                                    child: Center(
                                        child: Text("Send",
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: toSize(17),
                                                fontWeight: FontWeight.w700,
                                                color: theme
                                                    .colorScheme.onPrimary
                                                    .withOpacity(0.9)))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: toSize(60),
                      left: toSize(12),
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
              ),
            ),
          ),
        ));
  }
}
