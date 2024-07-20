import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';
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

  const ConfirmView(
      {Key? key,
        required this.title,
        required this.message,
        required this.titleButton,
        this.titleSecondButton,
        required this.onPressEvent,
        this.onPressSecondEvent,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context, listen: false).themeData;

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
                    color:theme.colorScheme.background,
                  ),
                  child: Column(children: [
                    const SizedBox(height: 18),
                    (title != null)
                        ? Padding(
                        padding: const EdgeInsets.fromLTRB(19, 0, 19, 15),
                        child: Text(
                          title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontFamily: 'Rubik',
                              fontSize: 16,
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
                              theme.colorScheme.onSurface,
                              fontFamily: 'Rubik',
                              fontSize: 12,
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
                                      color: theme.colorScheme.background,
                                      border: Border.all(
                                        color: theme.colorScheme.primary,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                          titleSecondButton!.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: theme.colorScheme.primary,
                                              fontFamily: 'Rubik',
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
                                      color: theme.colorScheme.primary,
                                      border: Border.all(
                                        color: theme.colorScheme.surface,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                          titleButton.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Rubik',
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
