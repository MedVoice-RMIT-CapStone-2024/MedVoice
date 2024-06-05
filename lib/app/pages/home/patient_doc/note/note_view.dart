import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/assets/icon_assets.dart';
import 'package:med_voice/app/pages/home/medical_archive/medical_archive_controller.dart';
import 'package:med_voice/app/pages/home/patient_doc/note/note_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';
import 'package:med_voice/data/repository_impl/audio_repository_impl.dart';

import '../../../../../domain/entities/recording/library_transcript/get_library_transcript_text_info.dart';
import '../../../../utils/global.dart';

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
      : super(NoteController(groupDateInfo, AudioRepositoryImpl()));

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
  Widget body(BuildContext context, BaseController controller) {
    _controller = controller as NoteController;
    return (_controller!.jsonData != null)
        ? (_controller!.jsonData!.mMessage!.isEmpty)
            ? _jsonTranscriptContent()
            : (_controller!.textData != null)
                ? _textTranscriptContent(
                    _controller!.textData!, widget.groupDateInfo)
                : const SizedBox()
        : const SizedBox();
  }

  Widget _textTranscriptContent(
      GetLibraryTranscriptTextInfo textData, DisplayArchive displayData) {
    return SingleChildScrollView(
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
                    SizedBox(height: toSize(80)),
                    const Text("Replay audio"),
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
                            color:
                            HexColor(Global.mColors['pink_1'].toString()),
                            borderRadius: BorderRadius.circular(50)),
                        child: _controller!.isPlaying
                            ? const Icon(
                          Icons.pause,
                          color: Colors.white,
                        )
                            : const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
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
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.grey)),
                              child: Image.asset(IconAssets.icBack,
                                  color: Colors.white)),
                        ),
                        SizedBox(height: toSize(130)),
                        Container(
                          height: toSize(28),
                          width: toSize(90),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                                  _controller!.convertDateTime(
                                      widget.groupDateInfo.dateCreated),
                                  style: TextStyle(fontSize: toSize(12)))),
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
                      const Text('Recording name'),
                      Text(displayData.dateCreated),
                    ],
                  ),
                  SizedBox(height: toSize(10)),
                  _libraryContainerContent(displayData.patientName, false),
                  SizedBox(height: toSize(20)),
                  const Text('Content'),
                  SizedBox(height: toSize(10)),
                  _libraryContainerContent(
                      (textData.mMessage!.isEmpty)
                          ? textData.mTranscript ?? ""
                          : "No file found with the given ID",
                      true),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _libraryContainerContent(String label, bool isTranscript) {
    return Container(
      width: double.infinity,
      height: (isTranscript) ? MediaQuery.of(context).size.height * 0.4 : null,
      padding: EdgeInsets.all(toSize(5)),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: toSize(0.5)),
          borderRadius: BorderRadius.circular(toSize(8)),
          color: Colors.white),
      child: Text(label,
          style: _customTextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
          )),
    );
  }

  Widget _jsonTranscriptContent() {
    return SingleChildScrollView(
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
                    SizedBox(height: toSize(80)),
                    const Text("Replay audio"),
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
                            color:
                                HexColor(Global.mColors['pink_1'].toString()),
                            borderRadius: BorderRadius.circular(50)),
                        child: _controller!.isPlaying
                            ? const Icon(
                                Icons.pause,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
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
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.grey)),
                              child: Image.asset(IconAssets.icBack,
                                  color: Colors.white)),
                        ),
                        SizedBox(height: toSize(130)),
                        Container(
                          height: toSize(28),
                          width: toSize(90),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                                  _controller!.convertDateTime(
                                      widget.groupDateInfo.dateCreated),
                                  style: TextStyle(fontSize: toSize(12)))),
                        )
                      ],
                    )),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _contentLabel("Patient Information"),
                SizedBox(height: toSize(5)),
                _basicContentRow(
                    'Name', _controller!.jsonData!.mPatientName, false),
                _basicContentRow(
                    'Age', _controller!.jsonData!.mPatientAge, false),
                _basicContentRow(
                    'Gender', _controller!.jsonData!.mPatientGender, true),
                SizedBox(height: toSize(10)),
                _contentLabel("Diagnosis"),
                _expansionTileDiagnosis(),
                _contentLabel("Treatment"),
                _expansionTileTreatment(),
                _contentLabel("Health Vitals"),
                _expansionTileVitals(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _expansionTileVitals() {
    return ExpansionTile(
      title: Text(
          'Vital count: ${_controller!.jsonData!.mHealthVitals?.length ?? 0}',
          style: TextStyle(fontSize: toSize(15))),
      children: [
        SizedBox(
          height: toSize(110),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: _controller!.jsonData!.mHealthVitals?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status: ${_controller!.jsonData!.mHealthVitals?[index].mStatus}",
                      style:
                          TextStyle(color: Colors.white, fontSize: toSize(15)),
                    ),
                    SizedBox(height: toSize(12)),
                    Text(
                      "Value: ${_controller!.jsonData!.mHealthVitals?[index].mValue}",
                      style:
                          TextStyle(color: Colors.white, fontSize: toSize(15)),
                    ),
                    SizedBox(height: toSize(12)),
                    Text(
                      "Units: ${_controller!.jsonData!.mHealthVitals?[index].mUnits}",
                      style:
                          TextStyle(color: Colors.white, fontSize: toSize(15)),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: toSize(10)),
                child: const Divider(color: Colors.grey),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _expansionTileTreatment() {
    return ExpansionTile(
      title: Text(
          'Treatment count: ${_controller!.jsonData!.mMedicalTreatment?.length ?? 0}',
          style: TextStyle(fontSize: toSize(15))),
      children: [
        SizedBox(
          height: toSize(80),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: _controller!.jsonData!.mMedicalTreatment?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${_controller!.jsonData!.mMedicalTreatment?[index].mName}",
                      style:
                          TextStyle(color: Colors.white, fontSize: toSize(15)),
                    ),
                    SizedBox(height: toSize(12)),
                    Text(
                      "Prescription: ${_controller!.jsonData!.mMedicalTreatment?[index].mPrescription}",
                      style:
                          TextStyle(color: Colors.white, fontSize: toSize(15)),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(color: Colors.grey);
            },
          ),
        ),
      ],
    );
  }

  Widget _expansionTileDiagnosis() {
    return ExpansionTile(
      title: Text(
          'Diagnosis count: ${_controller!.jsonData!.mMedicalDiagnosis?.length ?? 0}',
          style: TextStyle(fontSize: toSize(15))),
      children: [
        SizedBox(
          height: toSize(65),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: _controller!.jsonData!.mMedicalDiagnosis?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _controller!.jsonData!.mMedicalDiagnosis?[index].mName ??
                      "N/A",
                  style: TextStyle(color: Colors.white, fontSize: toSize(15)),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(color: Colors.grey);
            },
          ),
        ),
      ],
    );
  }

  Widget _contentLabel(String label) {
    return Container(
        width: double.infinity,
        height: toSize(50),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Colors.white.withOpacity(0.4), width: toSize(2)),
              bottom: BorderSide(
                  color: Colors.white.withOpacity(0.4), width: toSize(2))),
          color: Theme.of(context).colorScheme.primary,
        ),
        padding:
            EdgeInsets.symmetric(horizontal: toSize(15), vertical: toSize(7)),
        child: Row(children: [
          Text(label,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))
        ]));
  }

  Widget _basicContentRow(String label, dynamic value, bool isLastItem) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: toSize(15)),
          height: toSize(40),
          child: Row(
            children: [
              Text("$label:",
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              Text((value is String)
                  ? value
                  : (value is int)
                      ? value.toString()
                      : "N/A")
            ],
          ),
        ),
        (!isLastItem)
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: toSize(15)),
                child: const Divider(color: Colors.grey),
              )
            : const SizedBox(),
      ],
    );
  }
}
