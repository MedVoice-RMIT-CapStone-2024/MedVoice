import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/assets/icon_assets.dart';
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/pages/home/medical_archive/audio_playback/audio_playback_view.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/data/repository_impl/audio_repository_impl.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/pages.dart';
import 'medical_archive_controller.dart';

class MedicalArchiveView extends clean.View {
  const MedicalArchiveView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MedicalArchiveView();
  }
}

class _MedicalArchiveView
    extends BaseStateView<MedicalArchiveView, MedicalArchiveController> {
  _MedicalArchiveView()
      : super(MedicalArchiveController(AudioRepositoryImpl()));
  MedicalArchiveController? _controller;
  Map<String, bool> expandedTiles = {};
  bool toggleDeleteLetter = false;

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
    if (_controller != null) {
      for (var group in _controller!.filteredMappedData) {
        expandedTiles[group.date] = false;
      }
    }
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    _controller = controller as MedicalArchiveController;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
          child: (_controller!.dataLinks != null) ? _recordContent() : _emptyView(),
        ),
      ),
    );
  }

  Widget _recordContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: toSize(38)),
        Text(
          "Voices Library",
          style: TextStyle(
            fontSize: toSize(40),
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(height: toSize(15)),
        Text("Your recordings and transcripts will appear here.",
            style: TextStyle(
                fontSize: toSize(17),
                color: Theme.of(context).colorScheme.onSecondary)),
        SizedBox(height: toSize(20)),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: _listViewWithGroupedItems(_controller!.filteredMappedData)
        )
      ],
    );
  }

  Widget _listViewWithGroupedItems(List<GroupedDate> filteredMappedData) {
    return ListView.builder(
      itemCount: filteredMappedData.length,
      itemBuilder: (context, index) {
        return _dateListContent(filteredMappedData, index);
      },
    );
  }

  Widget _dateListContent(List<GroupedDate> filteredMappedData, int index) {
    return ExpansionTile(
      key: PageStorageKey<String>(filteredMappedData[index].date),
      tilePadding: EdgeInsets.symmetric(horizontal: toSize(5)),
      visualDensity: VisualDensity.compact,
      initiallyExpanded: expandedTiles[filteredMappedData[index].date] ?? false,
      onExpansionChanged: (bool expanded) {
        onExpansionChanged(filteredMappedData[index].date, expanded);
      },
      title: _dateTitle(filteredMappedData[index].date),
      children: filteredMappedData[index].items!.map((item) {
        return ListTile(
          title: _recordItems(item),
        );
      }).toList(),
    );
  }

  Widget _dateTitle(String item) {
    return Text(
      (_controller != null)
          ? _controller!.reformatDateString(item, true, false)
          : item,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: toSize(18),
          color: Theme.of(context).colorScheme.onSecondary),
    );
  }

  Widget _recordItems(DisplayArchive item) {
    return InkWell(
      onTap: () {
        pushScreen(Pages.audioPlayback,
            arguments: {recordingInfo: item.patientName});
      },
      child: Container(
        height: toSize(70),
        padding: EdgeInsets.symmetric(vertical: toSize(10)),
        margin: EdgeInsets.only(left: toSize(0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(IconAssets.icRecordingMicrophone),
            SizedBox(width: toSize(6)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(item.patientName,
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: toSize(16),
                        color: Theme.of(context).colorScheme.onSecondary)),
                const Spacer(),
                Text(
                    _controller!.reformatDateString(item.dateCreated, true, true),
                    style: TextStyle(
                        fontSize: toSize(14),
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withOpacity(0.8))),
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
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _emptyView() {
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
            const Text("Voices Library", style: TextStyle(fontSize: 28)),
            SizedBox(height: toSize(8)),
            const Text("MedVoice's recorded files saved will appear here.")
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