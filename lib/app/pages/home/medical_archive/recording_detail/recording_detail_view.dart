import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/data/repository_impl/audio_repository_impl.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../../domain/entities/recording/recording_detail.dart';
import '../../../../widgets/recording_result_view.dart';
import 'recording_detail_controller.dart';

class RecordingDetailView extends clean.View {
  final String recordingId;

  const RecordingDetailView({Key? key, required this.recordingId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecordingDetailView(recordingId);
  }
}

class _RecordingDetailView
    extends BaseStateView<RecordingDetailView, RecordingDetailController> {
  _RecordingDetailView(String recordingId)
      : super(RecordingDetailController(recordingId, AudioRepositoryImpl()));

  RecordingDetailController? _controller;

  @override
  bool isInitialAppbar() {
    return false;
  }

  @override
  String appBarTitle() {
    return "Recording";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    _controller = controller as RecordingDetailController;
    final RecordingDetail? detail = _controller!.detail;

    return Scaffold(
      appBar: AppBar(title: const Text('Recording')),
      body: detail == null
          ? const Center(child: Text('Loading recording...'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(detail.patientName ?? detail.recordingId,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text('${detail.createdAt} - ${detail.language}'),
                Text('Status: ${detail.status}'),
                const SizedBox(height: 12),
                ...buildRecordingResult(context, detail),
                const SizedBox(height: 12),
                FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(
                      foregroundColor: Colors.red.shade900),
                  onPressed: () => _confirmDelete(context),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Delete recording'),
                ),
              ],
            ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete recording?'),
        content: const Text('This permanently removes the recording and its '
            'medical document.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      _controller!.onDeleteRecording();
    }
  }
}
