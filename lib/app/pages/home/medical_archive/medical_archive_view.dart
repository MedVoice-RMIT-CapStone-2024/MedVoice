import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/assets/icon_assets.dart';
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/data/repository_impl/audio_repository_impl.dart';
import 'package:provider/provider.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../../domain/entities/recording/recording_summary.dart';
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
    extends BaseStateView<MedicalArchiveView, MedicalArchiveController> {
  _MedicalArchiveView()
      : super(MedicalArchiveController(AudioRepositoryImpl()));
  MedicalArchiveController? _controller;

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
  void onStateCreated() {}

  /// The detail screen pops `true` after a delete, so the list refetches.
  @override
  void onBackWithData(Object? data) {
    if (data == true) {
      _controller?.onLoadRecordings();
    }
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme =
        Provider.of<ThemeProvider>(context, listen: false).themeData;
    _controller = controller as MedicalArchiveController;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
          child: _controller!.recordings.isNotEmpty
              ? _recordContent(theme)
              : _emptyView(theme),
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
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: toSize(15)),
        Text("Your recordings and transcripts will appear here.",
            style: TextStyle(
                fontSize: toSize(17), color: theme.colorScheme.onBackground)),
        SizedBox(height: toSize(20)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: ListView.builder(
            itemCount: _controller!.recordings.length,
            itemBuilder: (context, index) =>
                _recordItem(_controller!.recordings[index], theme),
          ),
        )
      ],
    );
  }

  Widget _recordItem(RecordingSummary item, ThemeData theme) {
    return InkWell(
      onTap: () {
        pushScreen(Pages.recordingDetail,
            arguments: {recordingIdParam: item.recordingId});
      },
      child: Container(
        height: toSize(70),
        padding: EdgeInsets.symmetric(vertical: toSize(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(IconAssets.icRecordingMicrophone,
                color: theme.colorScheme.primary),
            SizedBox(width: toSize(15)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.patientName ?? item.recordingId,
                      maxLines: 1,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: toSize(16),
                          color: theme.colorScheme.onBackground)),
                  const Spacer(),
                  Text(_controller!.formatCreatedAt(item.createdAt),
                      style: TextStyle(
                          fontSize: toSize(14),
                          color: theme.colorScheme.onBackground)),
                ],
              ),
            ),
            if (item.hasMedicalDocument)
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: toSize(8)),
                  child: Chip(
                    label: Text("Doc", style: TextStyle(fontSize: toSize(11))),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
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
                style:
                    TextStyle(fontSize: 28, color: theme.colorScheme.primary)),
            SizedBox(height: toSize(8)),
            Text("Your recordings and transcripts will appear here.",
                style: TextStyle(
                    fontSize: 17, color: theme.colorScheme.onBackground))
          ],
        ),
      ),
    );
  }
}
