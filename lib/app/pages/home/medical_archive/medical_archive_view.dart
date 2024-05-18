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
import '../../../utils/global.dart';
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
  _MedicalArchiveView() : super(MedicalArchiveController(AudioRepositoryImpl()));
  MedicalArchiveController? _controller;
  bool toggleDeleteLetter = false;

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "Your library";
  }

  @override
  bool isHideBackButton() {
    return true;
  }

  @override
  bool isShowBackground() {
    return true;
  }

  // TODO: Will re-implement it once the feature has an API

  // @override
  // List<Widget>? rightMenu() {
  //   return [
  //     Row(
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             if (_controller != null) {
  //               if (_controller!.resetToggle) {
  //                 if (_controller!.handleDeleteItems()) {
  //                   showPopupWithAction(
  //                       'You sure you want to delete these files', 'Yes', () {
  //                     _controller!.onDeleteRecordings();
  //                     toggleDeleteLetter = !toggleDeleteLetter;
  //                     _controller!.refreshUI();
  //                   }, 'Deleting these files?', 'No');
  //                 } else {
  //                   _controller!.resetToggle = !_controller!.resetToggle;
  //                   toggleDeleteLetter = !toggleDeleteLetter;
  //                   _controller!.refreshUI();
  //                 }
  //               } else {
  //                 _controller!.resetToggle = !_controller!.resetToggle;
  //                 toggleDeleteLetter = !toggleDeleteLetter;
  //                 _controller!.refreshUI();
  //               }
  //             }
  //           },
  //           child: (!toggleDeleteLetter)
  //               ? Container(
  //                   margin: EdgeInsets.only(right: toSize(20)),
  //                   height: toSize(24),
  //                   width: toSize(22),
  //                   child: Image.asset(IconAssets.icDeleteBin))
  //               : Container(
  //                   margin: EdgeInsets.only(right: toSize(20)),
  //                   child: const Text('Delete',
  //                       style: TextStyle(color: Colors.red))),
  //         ),
  //       ],
  //     )
  //   ];
  // }

  @override
  Widget body(BuildContext context, BaseController controller) {
    _controller = controller as MedicalArchiveController;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: toSize(20)),
        child:
            (_controller!.dataLinks != null) ? _recordList() : _emptyView(),
      ),
    );
  }

  Column _recordList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: toSize(25)),
        Text(
          "Voices Library",
          style: TextStyle(
            fontSize: toSize(30),
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: toSize(20)),
        Text("MedVoice's recorded files saved will appear here.",
            style: TextStyle(
                fontSize: toSize(17),
                color: Theme.of(context).colorScheme.onSecondary)),
        SizedBox(height: toSize(35)),
        SizedBox(
          height: toSize(500),
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: _controller!.mappedData.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _recordItems(index, _controller!.mappedData.length, _controller!.mappedData[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
          ),
        )
      ],
    );
  }

  Widget _recordItems(int index, int length, DisplayArchive item) {
    return InkWell(
      onTap: (){
        pushScreen(Pages.audioPlayback, arguments: {recordingInfo: item.patientName});
      },
      child: Container(
        height: toSize(75),
        padding: EdgeInsets.symmetric(vertical: toSize(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (_controller!.resetToggle)
                ? Center(
                    child: InkWell(
                    onTap: () {
                      _controller!.onChooseRecord(index);
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: toSize(12)),
                        height: toSize(20),
                        width: toSize(20),
                        child: (!Global.sampleData[index].isToggle!)
                            ? Image.asset(IconAssets.icCheckBoxEmpty)
                            : Image.asset(IconAssets.icCheckBoxFilled)),
                  ))
                : const SizedBox(),
            Image.asset(IconAssets.icRecordingMicrophone),
            SizedBox(width: toSize(12)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: (!_controller!.resetToggle)
                      ? MediaQuery.of(context).size.width * 0.7
                      : MediaQuery.of(context).size.width * 0.63,
                  child: Text(item.patientName,
                      maxLines: 1,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis, fontSize: toSize(17), color: Theme.of(context).colorScheme.onSecondary)),
                ),
                SizedBox(height: toSize(5)),
                Text(
                    item.dateCreated,
                    style: TextStyle(fontSize: toSize(15), color: Theme.of(context)
                        .colorScheme
                        .onSecondary
                        .withOpacity(0.8))),
              ],
            ),
            const Spacer(),
            SizedBox(
                height: toSize(24),
                width: toSize(24),
                child: Image.asset(IconAssets.icRecordingPlayButton,
                    color: Theme.of(context).colorScheme.primary))
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
}
