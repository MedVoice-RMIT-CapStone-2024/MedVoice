import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/assets/icon_assets.dart';
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/pages/home/patient_doc/note/note_view.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/data/repository_impl/audio_repository_impl.dart';
import 'package:provider/provider.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/pages.dart';
import '../../../widgets/theme_provider.dart';
import 'medical_archive_controller.dart';

class MedicalArchiveView extends clean.View {
  const MedicalArchiveView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MedicalArchiveView();
  }
}

class _MedicalArchiveView
    extends BaseStateView<MedicalArchiveView, MedicalArchiveController>
    with TickerProviderStateMixin {
  _MedicalArchiveView()
      : super(MedicalArchiveController(AudioRepositoryImpl()));
  MedicalArchiveController? _controller;
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  Map<String, bool> expandedTiles = {};
  bool toggleDeleteLetter = false;
  bool showChatBubble = false;

  @override
  bool isInitialAppbar() {
    return false;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  bool isHideBackButton() {
    return true;
  }

  @override
  bool isShowBackground() {
    return true;
  }

  @override
  void onStateCreated() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );
    startCountdown();
    super.onStateCreated();
  }

  void startCountdown() {
    Timer(const Duration(milliseconds: 3500), () {
      setState(() {
        showChatBubble = true;
        animationController.forward();
      });
      Timer(const Duration(seconds: 3), () {
        animationController.reverse().then((_) {
          showChatBubble = false;
          _controller!.refreshUI();
        });
      });
    });
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme =
        Provider.of<ThemeProvider>(context, listen: false).themeData;
    _controller = controller as MedicalArchiveController;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: toSize(20)),
              child: (_controller!.dataLinks != null)
                  ? _recordContent(theme)
                  : _emptyView(theme),
            ),
            Padding(
              padding: EdgeInsets.only(top: toSize(35), right: toSize(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  showChatBubble
                      ? AnimatedBuilder(
                          animation: scaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: scaleAnimation.value,
                              alignment: Alignment.centerRight,
                              child: child,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(toSize(10)),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(15)),
                            child: const Text(
                              'Need an assistant?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(width: toSize(5)),
                  Container(
                    height: toSize(60),
                    width: toSize(60),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.colorScheme.primary),
                      boxShadow: [
                        BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.4),
                            offset: const Offset(0, 3),
                            blurRadius: 6)
                      ],
                    ),
                    child: InkWell(
                        onTap: () {
                          pushScreen(Pages.chatBot);
                        },
                        child: Image.asset(IconAssets.icMedvoiceBotLogo)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recordContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: toSize(38)),
        Text(
          "Voices Library",
          style: TextStyle(
              fontSize: toSize(40),
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
              fontFamily: 'Rubik'),
        ),
        SizedBox(height: toSize(15)),
        Text("Your recordings and transcripts will appear here.",
            style: TextStyle(
                fontSize: toSize(17),
                color: theme.colorScheme.onBackground,
                fontFamily: 'Rubik')),
        SizedBox(height: toSize(20)),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: _listViewWithGroupedItems(
                _controller!.filteredMappedData, theme))
      ],
    );
  }

  Widget _listViewWithGroupedItems(
      List<GroupedDate> filteredMappedData, ThemeData theme) {
    return ListView.builder(
      itemCount: filteredMappedData.length,
      itemBuilder: (context, index) {
        return _dateListContent(filteredMappedData, index, theme);
      },
    );
  }

  Widget _dateListContent(
      List<GroupedDate> filteredMappedData, int index, ThemeData theme) {
    return ExpansionTile(
      key: PageStorageKey<String>(filteredMappedData[index].date),
      tilePadding: EdgeInsets.symmetric(horizontal: toSize(5)),
      visualDensity: VisualDensity.compact,
      collapsedIconColor: theme.colorScheme.onBackground,
      collapsedTextColor: theme.colorScheme.onBackground,
      textColor: theme.colorScheme.primary,
      initiallyExpanded: expandedTiles[filteredMappedData[index].date] ?? false,
      onExpansionChanged: (bool expanded) {
        onExpansionChanged(filteredMappedData[index].date, expanded);
      },
      title: _dateTitle(filteredMappedData[index].date, theme),
      children: List.generate(
        filteredMappedData[index].items!.length,
        (itemIndex) {
          return _recordItems(
              filteredMappedData[index].items![itemIndex], itemIndex, theme);
        },
      ),
    );
  }

  Widget _dateTitle(String item, ThemeData theme) {
    return Text(
      (_controller != null)
          ? _controller!.reformatDateString(item, true, false)
          : item,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: toSize(18),
          fontFamily: 'Rubik'),
    );
  }

  Widget _recordItems(DisplayArchive item, int index, ThemeData theme) {
    return InkWell(
      onTap: () {
        pushScreen(Pages.noteArchiveDetails, arguments: {
          groupDateInfo: item,
          audioLink: _controller!.dataLinks!.mUrls[index]
        });
      },
      child: Container(
        height: toSize(70),
        padding: EdgeInsets.symmetric(vertical: toSize(10)),
        margin: EdgeInsets.only(left: toSize(0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(IconAssets.icRecordingMicrophone,
                color: theme.colorScheme.primary),
            SizedBox(width: toSize(15)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(item.patientName,
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: toSize(16),
                        color: theme.colorScheme.onBackground,
                        fontFamily: 'Rubik')),
                const Spacer(),
                Text(
                    _controller!
                        .reformatDateString(item.dateCreated, true, true),
                    style: TextStyle(
                        fontSize: toSize(14),
                        color: theme.colorScheme.onBackground,
                        fontFamily: 'Rubik')),
              ],
            ),
            const Spacer(),
            Center(
              child: RotatedBox(
                quarterTurns: 2,
                child: SizedBox(
                  height: toSize(14),
                  width: toSize(14),
                  child: Image.asset(IconAssets.icBack,
                      color: theme.colorScheme.onBackground),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _emptyView(ThemeData theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: toSize(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: toSize(133)),
            SizedBox(
                height: toSize(200),
                width: toSize(200),
                child: Image.asset(ImageAssets.imgEmptyRecording)),
            SizedBox(height: toSize(16)),
            Text("Voices Library",
                style: TextStyle(
                    fontSize: 28,
                    color: theme.colorScheme.primary,
                    fontFamily: 'Rubik')),
            SizedBox(height: toSize(10)),
            Text("Your recordings and transcripts will appear here.",
                style: TextStyle(
                    fontSize: 17,
                    color: theme.colorScheme.onBackground,
                    fontFamily: 'Rubik'))
          ],
        ),
      ),
    );
  }

  void onExpansionChanged(String date, bool expanded) {
    setState(() {
      expandedTiles[date] = expanded;
    });
  }
}
