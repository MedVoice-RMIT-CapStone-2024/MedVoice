import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:med_voice/app/assets/icon_assets.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:med_voice/data/repository_impl/ask_repository_impl.dart';
import 'package:provider/provider.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';

import '../../../../../domain/entities/ask/chat_info.dart';
import '../../../../assets/lottie_assets.dart';
import '../../../../utils/global.dart';
import 'chat_bot_controller.dart';

class ChatBotView extends clean.View {
  final ScrollController scrollController = ScrollController();
  ChatBotView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatBotView(scrollController);
}

class _ChatBotView extends BaseStateView<ChatBotView, ChatBotController>
    with TickerProviderStateMixin {
  _ChatBotView(scrollController)
      : super(ChatBotController(scrollController, AskRepositoryImpl()));

  ChatBotController? controller;
  bool isVisible = false;
  AnimationController? animationController;
  Animation<Offset>? offsetAnimation;
  Animation<double>? fadeAnimation;
  int previousMessageCount = 0;

  @override
  String appBarTitle() {
    return '';
  }

  @override
  bool isInitialAppbar() {
    return false;
  }

  @override
  void onStateCreated() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut,
    ));

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut,
    ));
    super.onStateCreated();
  }

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 200), () {
      animationController?.forward();
    });
  }

  void resetAnimation() {
    animationController?.reset();
  }

  void updateMessageCount(int count) {
    previousMessageCount = count;
  }

  @override
  void onStateDestroyed() {
    animationController?.dispose();
    super.onStateDestroyed();
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    controller = controller as ChatBotController;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: _appBarContent(theme),
      body: _bodyContent(context, controller, theme, isDarkMode),
      bottomNavigationBar: _typingField(theme, controller, isDarkMode),
      resizeToAvoidBottomInset: false,
    );
  }

  AppBar _appBarContent(ThemeData theme) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          SizedBox(width: toSize(20)),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(
              IconAssets.icMedvoiceBotLogo,
              width: toSize(50),
              height: toSize(50),
            ),
          ),
          SizedBox(width: toSize(12)),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "MVBot",
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: toSize(14),
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: toSize(6)),
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: toSize(8)),
                SizedBox(width: toSize(4)),
                Text("Always active",
                    style: TextStyle(fontFamily: 'Rubik', fontSize: toSize(12)))
              ],
            )
          ])
        ],
      ),
      leading: InkWell(
        onTap: () {
          onBack();
        },
        child: Container(
          margin: EdgeInsets.only(left: toSize(38)),
          child: Image.asset(IconAssets.icBackArrow,
              color: theme.colorScheme.primary,
              height: toSize(10),
              width: toSize(10)),
        ),
      ),
    );
  }

  Widget _bodyContent(BuildContext context, ChatBotController controller,
      ThemeData theme, bool isDarkMode) {
    return SafeArea(
      child: SingleChildScrollView(
        reverse: true,
        controller: widget.scrollController,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: toSize(20), right: toSize(20)),
              child: ListView.separated(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                shrinkWrap: true,
                itemCount: controller.messages.length,
                primary: false,
                itemBuilder: (context, index) {
                  ChatInfo chatItem = controller.messages[index];
                  return _listViewContent(
                      index, chatItem, context, theme, controller, isDarkMode);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: toSize(3),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listViewContent(int index, ChatInfo chatItem, BuildContext context,
      ThemeData theme, ChatBotController controller, bool isDarkMode) {
    if (index == controller.messages.length - 1) {
      startAnimation();
    }
    if (previousMessageCount != controller.messages.length) {
      resetAnimation();
      startAnimation();
      updateMessageCount(controller.messages.length);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (index == 0)
            ? Column(
                children: [
                  SizedBox(height: toSize(34)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      DateFormat('E h:mm a').format(DateTime.now()),
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: toSize(13),
                        color: HexColor(Global.mColors['gray_20'].toString()),
                      ),
                    ),
                  ),
                  SizedBox(height: toSize(36)),
                ],
              )
            : const SizedBox(),
        (chatItem.isMe)
            ? _userTextBubble(context, theme, chatItem.message)
            : _botTextBubble(context, theme, chatItem.message),
        (index == controller.messages.length - 1 && controller.compilingMessage)
            ? SizedBox(height: toSize(16))
            : (index == controller.messages.length - 1)
                ? FadeTransition(
                    opacity: fadeAnimation!,
                    child: SlideTransition(
                        position: offsetAnimation!,
                        child:
                            _buildInteractiveBubbles(controller, isDarkMode)),
                  )
                : SizedBox(height: toSize(16)),
        (controller.compilingMessage && index == controller.messages.length - 1)
            ? _botTypingBubble(context, theme, isDarkMode)
            : const SizedBox()
      ],
    );
  }

  Widget _buildInteractiveBubbles(
      ChatBotController controller, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.only(top: toSize(16)),
      child: Wrap(
        verticalDirection: VerticalDirection.down,
        spacing: 8,
        runSpacing: 8,
        children: [
          _buildBubble('Covid 19 symptoms',
              () => controller.sendMessage('Covid 19 symptoms'), isDarkMode),
          _buildBubble('Update information',
              () => controller.sendMessage('Update information'), isDarkMode),
          _buildBubble('Scan QR code',
              () => controller.sendMessage('Scan QR code'), isDarkMode),
          _buildBubble('Record interaction',
              () => controller.sendMessage('Record interaction'), isDarkMode),
        ],
      ),
    );
  }

  Widget _buildBubble(String text, Function() onTap, bool isDarkMode) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: (isDarkMode)
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.3))),
        child: Text(text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontFamily: 'Rubik')),
      ),
    );
  }

  Widget _botTextBubble(
      BuildContext context, ThemeData theme, String textContent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset(
            IconAssets.icMedvoiceBotLogo,
            width: toSize(32),
            height: toSize(32),
          ),
        ),
        SizedBox(
          width: toSize(8),
        ),
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          child: Container(
            padding: EdgeInsets.all(toSize(16)),
            decoration: BoxDecoration(
                color: HexColor(Global.mColors['white_2'].toString()),
                border: Border.all(color: theme.colorScheme.onSurface),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Text(textContent,
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: toSize(16),
                    color: Colors.black)),
          ),
        )
      ],
    );
  }

  Widget _botTypingBubble(
      BuildContext context, ThemeData theme, bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset(
            IconAssets.icMedvoiceBotLogo,
            width: toSize(32),
            height: toSize(32),
          ),
        ),
        SizedBox(
          width: toSize(8),
        ),
        Container(
          padding: EdgeInsets.all(toSize(10)),
          decoration: BoxDecoration(
              color: HexColor(Global.mColors['white_2'].toString()),
              border: Border.all(color: theme.colorScheme.onSurface),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Row(
            children: [
              Lottie.asset(
                (isDarkMode)
                    ? LottieAssets.loadingDarkTheme
                    : LottieAssets.loadingLightTheme,
                height: 30,
              ),
              SizedBox(width: toSize(10)),
              Text(
                'MVBot is typing',
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: toSize(14),
                    fontWeight: FontWeight.w500, color: Colors.black),
              )
            ],
          ),
        )
      ],
    );
  }

  Row _userTextBubble(
      BuildContext context, ThemeData theme, String textContent) {
    return Row(
      children: [
        const Spacer(),
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          child: Container(
            padding: EdgeInsets.all(toSize(16)),
            decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                border: Border.all(color: theme.colorScheme.onSurface),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Text(textContent,
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: toSize(16),
                    color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _typingField(
      ThemeData theme, ChatBotController controller, bool isDarkMode) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // TYPING STATUS BAR UNDER TYPING FIELD

          // (controller.compilingMessage)
          //     ? Container(
          //         width: MediaQuery.of(context).size.width,
          //         height: toSize(40),
          //         padding: EdgeInsets.symmetric(horizontal: toSize(10)),
          //         decoration: BoxDecoration(
          //             color: (isDarkMode)
          //                 ? Colors.black.withOpacity(0.5)
          //                 : Colors.white,
          //             border: Border(
          //                 top: BorderSide(
          //                     color: (isDarkMode)
          //                         ? Colors.white.withOpacity(0.5)
          //                         : Colors.black.withOpacity(0.5),
          //                     width: 0.5))),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Lottie.asset(
          //               (isDarkMode)
          //                   ? LottieAssets.loadingDarkTheme
          //                   : LottieAssets.loadingLightTheme,
          //               height: 50,
          //             ),
          //             SizedBox(width: toSize(5)),
          //             Text("MVBot is typing",
          //                 style: TextStyle(
          //                     fontFamily: 'Rubik', fontSize: toSize(14))),
          //           ],
          //         ),
          //       )
          //     : const SizedBox(),

          Container(
            width: double.infinity,
            height: toSize(90),
            margin: EdgeInsets.symmetric(horizontal: toSize(20)),
            decoration: BoxDecoration(color: theme.colorScheme.background),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: TextField(
                      controller: controller.textController,
                      onChanged: (value) {
                        controller.refreshUI();
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Type a message...',
                          labelStyle: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: toSize(16),
                              color: Colors.black.withOpacity(0.6)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: toSize(20))),
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: toSize(16),
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(width: toSize(16)),
                InkWell(
                  onTap: () {
                    if (controller.textController.text.isNotEmpty &&
                        !controller.compilingMessage) {
                      controller.sendMessage(controller.textController.text);
                      controller.textController.clear();
                      controller.refreshUI();
                    }
                  },
                  child: Container(
                    width: toSize(50),
                    height: toSize(50),
                    decoration: BoxDecoration(
                      color: (controller.textController.text.isNotEmpty &&
                              !controller.compilingMessage)
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Icon(Icons.near_me, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
