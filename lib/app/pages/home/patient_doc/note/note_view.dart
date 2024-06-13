import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/assets/icon_assets.dart';
import 'package:med_voice/app/pages/home/medical_archive/medical_archive_controller.dart';
import 'package:med_voice/app/pages/home/patient_doc/note/note_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';
import 'package:med_voice/data/repository_impl/audio_repository_impl.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_text_info.dart';
import '../../../../widgets/theme_provider.dart';

const groupDateInfo = 'groupDateInfo';
const audioLink = 'audioLink';

class NoteView extends clean.View {
  final DisplayArchive groupDateInfo;
  final String audioLink;
  const NoteView(
      {Key? key, required this.groupDateInfo, required this.audioLink})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NoteViewState(groupDateInfo, audioLink);
  }
}

class _NoteViewState extends BaseStateView<NoteView, NoteController>
    with WidgetsBindingObserver {
  _NoteViewState(groupDateInfo, audioLink)
      : super(NoteController(groupDateInfo, audioLink, AudioRepositoryImpl()));

  final scrollController = ScrollController();
  NoteController? _controller;

  TextStyle _customTextStyle({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
  }) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize ?? 14,
      fontFamily: 'Poppins',
    );
  }

  @override
  bool isInitialAppbar() {
    return false;
  }

  @override
  String appBarTitle() {
    return widget.groupDateInfo.patientName;
  }

  @override
  void onStateDestroyed() {
    if (_controller != null) {
      _controller!.player.dispose();
    }
    super.onStateDestroyed();
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme =
        Provider.of<ThemeProvider>(context, listen: false).themeData;
    _controller = controller as NoteController;
    return (_controller!.textData != null)
        ? _textTranscriptContent(
            _controller!.textData!, widget.groupDateInfo, theme)
        : const SizedBox();
  }

  Widget _textTranscriptContent(GetLibraryTranscriptTextInfo textData,
      DisplayArchive displayData, ThemeData theme) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: toSize(250),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: toSize(60)),
                      Text("Replay audio",
                          style:
                              TextStyle(color: theme.colorScheme.onBackground)),
                      SizedBox(height: toSize(20)),
                      InkWell(
                        onTap: () {
                          if (!_controller!.isPlaying) {
                            _controller!.player.setUrl(widget.audioLink);
                            _controller!.player.play();
                          } else {
                            _controller!.player.stop();
                          }
                          _controller!.isPlaying = !_controller!.isPlaying;
                          _controller!.refreshUI();
                        },
                        child: Container(
                          height: toSize(45),
                          width: toSize(45),
                          decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(50)),
                          child: _controller!.isPlaying
                              ? Icon(
                                  Icons.pause,
                                  color: theme.colorScheme.background,
                                )
                              : Icon(
                                  Icons.play_arrow,
                                  color: theme.colorScheme.background,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: toSize(23), top: toSize(50)),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              onBack();
                            },
                            child: Container(
                                height: toSize(34),
                                width: toSize(34),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: theme.colorScheme.surface
                                            .withOpacity(0.7))),
                                child: Image.asset(IconAssets.icBack,
                                    color: theme.colorScheme.onPrimary)),
                          ),
                          SizedBox(height: toSize(150)),
                          Container(
                            height: toSize(27),
                            width: toSize(90),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                border: Border.all(
                                    color: theme.colorScheme.surface
                                        .withOpacity(0.7)),
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                                child: Text(
                                    _controller!.convertDateTime(
                                        widget.groupDateInfo.dateCreated),
                                    style: TextStyle(
                                        fontSize: toSize(12),
                                        color: theme.colorScheme.onPrimary,
                                        fontWeight: FontWeight.w700))),
                          )
                        ],
                      )),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: toSize(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: toSize(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recording name',
                          style:
                              TextStyle(color: theme.colorScheme.onBackground)),
                      Text(displayData.dateCreated),
                    ],
                  ),
                  SizedBox(height: toSize(10)),
                  _libraryContainerContent(
                      displayData.patientName, false, theme),
                  SizedBox(height: toSize(20)),
                  Text('Content',
                      style: TextStyle(color: theme.colorScheme.onBackground)),
                  SizedBox(height: toSize(10)),
                  _libraryContainerContent(
                      (textData.mMessage!.isEmpty)
                          ? textData.mTranscript ?? ""
                          : "No file found with the given ID",
                      true,
                      theme),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          _controller!.onInitializeEnhancement();
        },
        child: Container(
          width: double.infinity,
          height: toSize(53),
          margin: EdgeInsets.only(
              bottom: toSize(40), left: toSize(10), right: toSize(10)),
          decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(toSize(10))),
          child: Center(
            child: Text(
              'ENHANCE',
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _libraryContainerContent(
      String label, bool isTranscript, ThemeData theme) {
    return (isTranscript)
        ? Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.35,
          padding: EdgeInsets.all(toSize(10)),
          decoration: BoxDecoration(
              border: Border.all(
                  color: theme.colorScheme.onSurface, width: toSize(0.5)),
              borderRadius: BorderRadius.circular(toSize(8)),
              color: theme.colorScheme.surface),
          child: SingleChildScrollView(
            child: Text(label,
                style: _customTextStyle(
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSurface,
                )),
          ),
        )
        : Container(
            width: double.infinity,
            padding: EdgeInsets.all(toSize(10)),
            decoration: BoxDecoration(
                border: Border.all(
                    color: theme.colorScheme.onSurface, width: toSize(0.5)),
                borderRadius: BorderRadius.circular(toSize(8)),
                color: theme.colorScheme.surface),
            child: Text(label,
                style: _customTextStyle(
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSurface,
                )),
          );
  }
}
