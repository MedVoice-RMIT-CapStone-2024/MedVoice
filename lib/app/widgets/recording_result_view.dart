import 'package:flutter/material.dart';

import '../../domain/entities/recording/medical_document.dart';
import '../../domain/entities/recording/recording_detail.dart';
import '../../domain/entities/recording/soap_note.dart';

/// Renders a [RecordingDetail] as a list of cards: transcript, SOAP note,
/// ICD-10 entities and the PHI banner. Shared by the recording screen (result
/// summary) and the recording detail screen.
List<Widget> buildRecordingResult(BuildContext context, RecordingDetail detail) {
  final MedicalDocument doc = detail.medicalDocument;
  return [
    _phiBanner(context, doc),
    if (detail.transcript.fullText.isNotEmpty)
      _section(context, 'Transcript', Text(detail.transcript.fullText)),
    ..._soapSections(context, doc.soap),
    if (doc.entities.isNotEmpty)
      _section(
        context,
        'Medical entities',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final e in doc.entities)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.code.isEmpty ? e.name : '${e.name} (${e.code})',
                      ),
                    ),
                    if (e.category.isNotEmpty)
                      Chip(
                        label: Text(e.category),
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
  ];
}

Widget _phiBanner(BuildContext context, MedicalDocument doc) {
  final bool detected = doc.phi.detected;
  return Card(
    color: detected ? Colors.red.shade100 : Colors.green.shade100,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(detected ? Icons.warning_amber : Icons.verified_user,
              color: detected ? Colors.red.shade900 : Colors.green.shade900),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              detected
                  ? 'PHI detected: ${doc.phi.entities.join(', ')}'
                  : 'No PHI detected',
              style: TextStyle(
                  color:
                      detected ? Colors.red.shade900 : Colors.green.shade900),
            ),
          ),
        ],
      ),
    ),
  );
}

List<Widget> _soapSections(BuildContext context, SoapNote soap) {
  if (soap.isEmpty) return const [];
  return [
    for (final entry in {
      'Subjective': soap.subjective,
      'Objective': soap.objective,
      'Assessment': soap.assessment,
      'Plan': soap.plan,
    }.entries)
      if (entry.value.isNotEmpty)
        _section(context, entry.key, Text(entry.value)),
  ];
}

Widget _section(BuildContext context, String title, Widget child) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          child,
        ],
      ),
    ),
  );
}
