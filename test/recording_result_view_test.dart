import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:med_voice/app/widgets/recording_result_view.dart';
import 'package:med_voice/domain/entities/recording/recording_detail.dart';

Future<void> _pump(WidgetTester tester, RecordingDetail detail) {
  return tester.pumpWidget(MaterialApp(
    home: Builder(
      builder: (context) =>
          ListView(children: buildRecordingResult(context, detail)),
    ),
  ));
}

void main() {
  testWidgets('renders transcript, SOAP sections, entities and PHI warning',
      (tester) async {
    await _pump(
      tester,
      RecordingDetail.fromJson({
        'recording_id': 'rec_1',
        'status': 'completed',
        'created_at': 't',
        'patient_name': 'Jane Doe',
        'language': 'en',
        'transcript': {'full_text': 'Patient reports chest pain', 'segments': []},
        'medical_document': {
          'soap': {'subjective': 'chest pain', 'objective': '', 'assessment': 'angina', 'plan': ''},
          'entities': [
            {'name': 'Hypertension', 'code': 'I10', 'category': 'diagnosis', 'speaker': 'SPEAKER_00'}
          ],
          'phi': {'detected': true, 'entities': ['Jane Doe']},
        },
      }),
    );

    expect(find.text('Patient reports chest pain'), findsOneWidget);
    expect(find.text('Subjective'), findsOneWidget);
    expect(find.text('Assessment'), findsOneWidget);
    // Empty SOAP sections are hidden, not rendered blank.
    expect(find.text('Objective'), findsNothing);
    expect(find.text('Plan'), findsNothing);
    expect(find.text('Hypertension (I10)'), findsOneWidget);
    expect(find.text('diagnosis'), findsOneWidget);
    expect(find.text('PHI detected: Jane Doe'), findsOneWidget);
  });

  testWidgets('renders the clear banner and no SOAP card when document is empty',
      (tester) async {
    await _pump(
      tester,
      RecordingDetail.fromJson({
        'recording_id': 'rec_2',
        'status': 'completed',
        'created_at': 't',
        'patient_name': null,
        'language': 'en',
        'transcript': {'full_text': '', 'segments': []},
        'medical_document': {
          'soap': {},
          'entities': [],
          'phi': {'detected': false, 'entities': []},
        },
      }),
    );

    expect(find.text('No PHI detected'), findsOneWidget);
    expect(find.text('Transcript'), findsNothing);
    expect(find.text('Subjective'), findsNothing);
    expect(find.text('Medical entities'), findsNothing);
  });
}
