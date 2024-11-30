import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:lottie/lottie.dart';
import 'package:med_voice/app/assets/icon_assets.dart';
import 'package:med_voice/app/pages/home/medical_archive/medical_archive_controller.dart';
import 'package:med_voice/app/pages/home/patient_doc/note/note_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';
import 'package:med_voice/data/repository_impl/audio_repository_impl.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_text_info.dart';
import '../../../../assets/lottie_assets.dart';
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
    return (_controller!.finishedLoading)
        ? (_controller!.doesHaveJsonFile)
            ? _jsonTranscriptContent(theme)
            : _textTranscriptContent(
                _controller!.textData!, widget.groupDateInfo, theme)
        : _emptyView(theme);
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
                          style: TextStyle(
                              color: theme.colorScheme.onBackground,
                              fontFamily: 'Rubik')),
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
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Rubik'))),
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

  Widget _jsonTranscriptContent(ThemeData theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: toSize(270),
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
                padding: EdgeInsets.only(
                    top: toSize(50), left: toSize(23), right: toSize(23)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                        const Spacer(),

                        // Temporary disabling the PDF feature

                        // InkWell(
                        //   onTap: () async {
                        //     await PdfGeneratedView.generate(_controller!.jsonData!, context, widget.enhancedGroupDateInfoParam.patientName, widget.enhancedGroupDateInfoParam);
                        //   },
                        //   child: Image.asset(IconAssets.icPdfFilled,
                        //       color: theme.colorScheme.primary,
                        //       height: toSize(34),
                        //       width: toSize(34)),
                        // ),
                      ],
                    ),
                    SizedBox(height: toSize(150)),
                    Container(
                      height: toSize(27),
                      width: toSize(90),
                      decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          border: Border.all(
                              color:
                                  theme.colorScheme.surface.withOpacity(0.7)),
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
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _contentLabel("Patient Information", theme),
                SizedBox(height: toSize(5)),
                _basicContentRow(
                    'Name', _controller!.jsonData?.mPatientName, false, theme),
                _basicContentRow('Date Of Birth',
                    _controller!.jsonData?.mPatientDob, false, theme),
                _basicContentRow('Gender',
                    _controller!.jsonData?.mPatientGender, true, theme),
                SizedBox(height: toSize(10)),
                _contentLabel("Patient's demographics", theme),
                SizedBox(height: toSize(5)),
                _overflowContentRow(
                    'Marital status',
                    _controller!
                        .jsonData?.mPatientDemographicInfo?.mMaritalStatus,
                    false,
                    theme),
                _overflowContentRow(
                    'Ethnicity',
                    _controller!.jsonData?.mPatientDemographicInfo?.mEthnicity,
                    false,
                    theme),
                _overflowContentRow(
                    'Occupation',
                    _controller!.jsonData?.mPatientDemographicInfo?.mOccupation,
                    true,
                    theme),
                SizedBox(height: toSize(10)),
                _contentLabel("Past medical history", theme),
                SizedBox(height: toSize(5)),
                _overflowContentRow(
                    'Medical history',
                    _controller!.jsonData?.mPatientPastMedicalHistoryInfo
                        ?.mMedicalHistory,
                    false,
                    theme),
                _overflowContentRow(
                    'Surgical history',
                    _controller!.jsonData?.mPatientPastMedicalHistoryInfo
                        ?.mSurgicalHistory,
                    true,
                    theme),
                SizedBox(height: toSize(10)),
                _contentLabel("Current medications and drug allergies", theme),
                SizedBox(height: toSize(5)),
                _overflowContentRow(
                    'Drug allergy',
                    _controller!.jsonData?.mPatientCurrentMedAndDrugAllerInfo
                        ?.mDrugAllergy,
                    false,
                    theme),
                _overflowContentRow(
                    'Prescribed medications',
                    _controller!.jsonData?.mPatientCurrentMedAndDrugAllerInfo
                        ?.mPrescribedMedications,
                    false,
                    theme),
                _overflowContentRow(
                    'Recently prescribed medications',
                    _controller!.jsonData?.mPatientCurrentMedAndDrugAllerInfo
                        ?.mRecentlyPrescribedMedications,
                    true,
                    theme),
                SizedBox(height: toSize(10)),
                _contentLabel("Mental state examination", theme),
                SizedBox(height: toSize(5)),
                _overflowContentRow(
                    'Appearance and behavior',
                    _controller!.jsonData?.mPatientMentalStateExaminationInfo
                        ?.mAppearanceAndBehaviour,
                    false,
                    theme),
                _overflowContentRow(
                    'Speech and thoughts',
                    _controller!.jsonData?.mPatientMentalStateExaminationInfo
                        ?.mSpeechAndThoughts,
                    false,
                    theme),
                _overflowContentRow(
                    'Mood',
                    _controller!
                        .jsonData?.mPatientMentalStateExaminationInfo?.mMood,
                    false,
                    theme),
                _overflowContentRow(
                    'Thoughts',
                    _controller!.jsonData?.mPatientMentalStateExaminationInfo
                        ?.mThoughts,
                    true,
                    theme),
                SizedBox(height: toSize(10)),
                _contentLabel("Physical examination", theme),
                SizedBox(height: toSize(5)),
                _overflowContentRow(
                    'Blood pressure',
                    _controller!.jsonData?.mPatientPhysicalExaminationInfo
                        ?.mBloodPressure,
                    false,
                    theme),
                _overflowContentRow(
                    'Pulse rate',
                    _controller!
                        .jsonData?.mPatientPhysicalExaminationInfo?.mPulseRate,
                    false,
                    theme),
                _overflowContentRow(
                    'Temperature',
                    _controller!.jsonData?.mPatientPhysicalExaminationInfo
                        ?.mTemperature,
                    true,
                    theme),
                SizedBox(height: toSize(10)),
                _contentLabel("Additional notes", theme),
                SizedBox(height: toSize(5)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: toSize(20), vertical: toSize(10)),
                  child: Text(_controller!.jsonData?.mNote ?? "",
                      style: const TextStyle(fontFamily: 'Rubik')),
                )
              ],
            ),
          ),
          SizedBox(height: toSize(10))
        ],
      ),
    );
  }

  Widget _emptyView(ThemeData theme) {
    bool isDarkMode = theme.brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: toSize(270),
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
                padding: EdgeInsets.only(
                    top: toSize(50), left: toSize(23), right: toSize(23)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                        const Spacer(),

                        // Temporary disabling the PDF feature

                        // InkWell(
                        //   onTap: () async {
                        //     await PdfGeneratedView.generate(_controller!.jsonData!, context, widget.enhancedGroupDateInfoParam.patientName, widget.enhancedGroupDateInfoParam);
                        //   },
                        //   child: Image.asset(IconAssets.icPdfFilled,
                        //       color: theme.colorScheme.primary,
                        //       height: toSize(34),
                        //       width: toSize(34)),
                        // ),
                      ],
                    ),
                    SizedBox(height: toSize(150)),
                    Container(
                      height: toSize(27),
                      width: toSize(90),
                      decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          border: Border.all(
                              color:
                                  theme.colorScheme.surface.withOpacity(0.7)),
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
                ),
              )
            ],
          ),
          _contentLabel("Generating transcript . . .", theme, isCenter: true),
          (isDarkMode)
              ? Lottie.asset(LottieAssets.generatingTranscriptDark,
                  height: toSize(300))
              : Lottie.asset(LottieAssets.generatingTranscriptLight,
                  height: toSize(300))
        ],
      ),
    );
  }

  Widget _contentLabel(String label, ThemeData theme, {bool? isCenter}) {
    return Container(
        width: double.infinity,
        height: toSize(50),
        color: theme.colorScheme.surface,
        padding:
            EdgeInsets.symmetric(horizontal: toSize(20), vertical: toSize(7)),
        child: Row(
            mainAxisAlignment: (isCenter == null || isCenter == false)
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Rubik',
                ),
              )
            ]));
  }

  Widget _basicContentRow(
      String label, dynamic value, bool isLastItem, ThemeData theme) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
          height: toSize(40),
          child: Row(
            children: [
              Text("$label:",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                      fontFamily: 'Rubik')),
              const Spacer(),
              Text(
                  (value is String && value.isNotEmpty)
                      ? value
                      : (value is String && value.isEmpty)
                          ? "N/A"
                          : (value is int)
                              ? value.toString()
                              : "N/A",
                  style: TextStyle(
                      color: theme.colorScheme.onSurface, fontFamily: 'Rubik'))
            ],
          ),
        ),
        (!isLastItem)
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: toSize(15)),
                child: Divider(
                    color: theme.colorScheme.onSurface.withOpacity(0.4)),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _overflowContentRow(
      String label, dynamic value, bool isLastItem, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: toSize(20), vertical: toSize(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$label:",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                      fontSize: toSize(14),
                      fontFamily: 'Rubik')),
              SizedBox(height: toSize(10)),
              Text(
                  (value is String && value.isNotEmpty)
                      ? value
                      : (value is String && value.isEmpty)
                          ? "N/A"
                          : (value is int)
                              ? value.toString()
                              : "N/A",
                  style: TextStyle(
                      color: theme.colorScheme.onSurface, fontFamily: 'Rubik'))
            ],
          ),
        ),
        (!isLastItem)
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: toSize(15)),
                child: Divider(
                    color: theme.colorScheme.onSurface.withOpacity(0.4)),
              )
            : const SizedBox(),
      ],
    );
  }

  //
  // Future<File?> generateAndSavePdf() async {
  //   final pdf = pw.Document();
  //
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Text('Hello World!'),
  //         );
  //       },
  //     ),
  //   );
  //
  //   try {
  //     final output = await getExternalStorageDirectory();
  //     final file = File("${output!.path}/example.pdf");
  //     await file.writeAsBytes(await pdf.save());
  //     return file;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }
}
