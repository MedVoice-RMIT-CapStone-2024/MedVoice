import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../assets/image_assets.dart';
import '../../../../utils/global.dart';
import '../../../../utils/module_utils.dart';
import '../../../../widgets/theme_provider.dart';
import 'my_qr_controller.dart';

class MyQRView extends clean.View {
  MyQRView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyQRView();
  }
}

class _MyQRView extends BaseStateView<MyQRView, MyQRController> {
  _MyQRView() : super(MyQRController());
  double circleRadius = 120;
  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    MyQRController _controller = controller as MyQRController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: toSize(20), vertical: toSize(20)),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: circleRadius / 2.0,
                      left: circleRadius / 4.0,
                      right: circleRadius / 4.0,
                    ),

                    ///here we create space for the circle avatar to get out of the box
                    child: Container(
                      height: toSize(430),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: theme.colorScheme.surface,
                      ),
                      width: double.infinity,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: toSize(15), bottom: toSize(15)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: toSize(90),
                              ),
                              Text(
                                'Maria Elliot',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: toSize(25),
                                    color: theme.colorScheme.onBackground,
                                    fontFamily: 'Rubik'),
                              ),
                              Text("04 - 04 - 2001",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: toSize(15),
                                    color: theme.colorScheme.onBackground,
                                    fontFamily: 'Rubik'
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: toSize(60),
                                    right: toSize(60),
                                    top: toSize(30)),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(toSize(15)),
                                  child: QrImageView(
                                    data: 'testing',
                                    size: toSize(165),
                                    eyeStyle: QrEyeStyle(
                                        color: theme.colorScheme.primary),
                                    dataModuleStyle: QrDataModuleStyle(
                                      color: theme.colorScheme.primary,
                                    ),
                                    backgroundColor: theme.colorScheme.surface,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),

                  ///Image Avatar
                  Container(
                    width: toSize(160),
                    height: toSize(160),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: toSize(8),
                            offset: const Offset(0.0, 5.0),
                          ),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(toSize(8.0)),
                      child: const Center(
                        child: CircleAvatar(
                            radius: 70, // Image radius
                            backgroundImage:
                                AssetImage(ImageAssets.imgAvatarSample)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              controller.scanQRCode();
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Scan QR Code",
              style: TextStyle(
                color: theme.colorScheme.background,
                fontSize: toSize(18),
                fontFamily: 'Rubik'
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
