import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../assets/icon_assets.dart';
import '../utils/global.dart';
import '../utils/module_utils.dart';

class ConfirmView extends StatelessWidget {
  final String? title;
  final String message;
  final String titleButton;
  final String? titleSecondButton;
  final VoidCallback? onPressEvent;
  final VoidCallback? onPressSecondEvent;
  final bool? acceptByRequester;

  const ConfirmView(
      {Key? key,
        required this.title,
        required this.message,
        required this.titleButton,
        this.titleSecondButton,
        required this.onPressEvent,
        this.onPressSecondEvent,
        this.acceptByRequester
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(toSize(8))),
        insetPadding: EdgeInsets.symmetric(horizontal: toSize(38)),
        child: Container(
            color: Colors.transparent,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                          color: HexColor(Global.mColors['black_4'].toString()),
                          offset: const Offset(0, 3),
                          blurRadius: 6)
                    ],
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    acceptByRequester != null && acceptByRequester == true
                        ? Padding(
                        padding: EdgeInsets.only(bottom: toSize(22),top: toSize(24)),
                        child: Image.asset(
                            IconAssets.icAcceptByRequester, width: toSize(68),height: toSize(49)))
                        : const SizedBox(height: 18),
                    (title != null)
                        ? Padding(
                        padding: const EdgeInsets.fromLTRB(19, 0, 19, 15),
                        child: Text(
                          title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: HexColor(
                                  Global.mColors["blue_1"].toString()),
                              fontFamily: 'NunitoSans',
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        ))
                        : Container(),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                              HexColor(Global.mColors["blue_1"].toString()),
                              fontFamily: 'NunitoSans',
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        )),
                    const SizedBox(height: 26),
                    Row(children: [
                      (titleSecondButton != null)
                          ? Expanded(
                          flex: 1,
                          child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(19, 0, 3, 0),
                              child: InkWell(
                                  onTap: onPressSecondEvent,
                                  child: Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: HexColor(Global
                                                .mColors['black_4']
                                                .toString()),
                                            offset: const Offset(0, 3),
                                            blurRadius: 6)
                                      ],
                                      color: HexColor(Global
                                          .mColors['gray_3']
                                          .toString()),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                          titleSecondButton!.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NunitoSans',
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ))))
                          : Container(),
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  titleSecondButton != null ? 3 : 19, 0, 19, 0),
                              child: InkWell(
                                  onTap: onPressEvent,
                                  child: Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: HexColor(Global
                                                .mColors['black_4']
                                                .toString()),
                                            offset: const Offset(0, 3),
                                            blurRadius: 6)
                                      ],
                                      color: HexColor(
                                          Global.mColors['blue_3'].toString()),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                          titleButton.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NunitoSans',
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  )))),
                    ]),
                    const SizedBox(height: 14),
                  ])),
            ])));
  }
}
