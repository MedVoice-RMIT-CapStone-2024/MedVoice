import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/widgets/pdf_creation/pdf_open.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/health_vital_info.dart';
import 'package:med_voice/domain/entities/recording/library_transcript/medical_treatment_info.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../domain/entities/recording/library_transcript/get_library_transcript_json_info.dart';
import '../../../domain/entities/recording/library_transcript/medical_diagnosis_info.dart';
import '../../pages/home/medical_archive/medical_archive_controller.dart';

class PdfGeneratedView {
  static Future generate(
      GetLibraryTranscriptJsonInfo patientDocument,
      BuildContext context,
      String fileName,
      DisplayArchive displayArchive) async {
    final pdf = Document();
    final Uint8List imageBytes = await loadImage(ImageAssets.imgMedVoice);
    final pw.ImageProvider imageProvider = pw.MemoryImage(imageBytes);

    pdf.addPage(pw.MultiPage(
      margin: pw.EdgeInsets.symmetric(horizontal: toSize(50)),
      header: (context) => buildHeader(patientDocument, imageProvider),
      build: (context) => [
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text("Patient Medical Records",
                style: pw.TextStyle(
                    fontSize: toSize(24), fontWeight: pw.FontWeight.bold)),
            pw.Text(displayArchive.dateCreated,
                style: pw.TextStyle(fontSize: toSize(16))),
          ]),
          pw.Spacer(),
          pw.Container(
            height: toSize(60),
            width: toSize(60),
            child: pw.BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: displayArchive.userId,
            ),
          ),
        ]),
        pw.SizedBox(height: toSize(2) * PdfPageFormat.cm),
        pw.Divider(),
        pw.SizedBox(height: toSize(1) * PdfPageFormat.cm),
        pw.Container(
          width: PdfPageFormat.a4.width * 0.7,
          child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Patient Information",
                          style: pw.TextStyle(
                              fontSize: toSize(18),
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: toSize(5)),
                      pw.Text(
                          (patientDocument.mPatientName != null &&
                                  patientDocument.mPatientName!.isNotEmpty)
                              ? patientDocument.mPatientName!
                              : "N/A",
                          style: pw.TextStyle(fontSize: toSize(18))),
                      pw.SizedBox(height: toSize(1) * PdfPageFormat.cm),
                      pw.Text("Gender",
                          style: pw.TextStyle(
                              fontSize: toSize(18),
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: toSize(5)),
                      pw.Text(
                          (patientDocument.mPatientGender != null &&
                                  patientDocument.mPatientGender!.isNotEmpty)
                              ? patientDocument.mPatientGender!
                              : "N/A",
                          style: pw.TextStyle(fontSize: toSize(18))),
                    ]),
                pw.Spacer(),
                pw.SizedBox(
                  width: toSize(3) * PdfPageFormat.cm,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Age",
                            style: pw.TextStyle(
                                fontSize: toSize(18),
                                fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: toSize(5)),
                        pw.Text(
                            (patientDocument.mPatientAge != null &&
                                    patientDocument.mPatientAge != 0)
                                ? patientDocument.mPatientAge.toString()
                                : "N/A",
                            style: pw.TextStyle(fontSize: toSize(18))),
                      ]),
                ),
              ]),
        ),
        pw.SizedBox(height: toSize(1) * PdfPageFormat.cm),
        pw.Divider(),
        pw.SizedBox(height: toSize(1) * PdfPageFormat.cm),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text("Medical Diagnosis",
                style: pw.TextStyle(
                    fontSize: toSize(20), fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: toSize(5)),
            buildDiagnosisContent(patientDocument.mMedicalDiagnosis!),
          ]),
          pw.Spacer(),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text("Medical Treatment",
                style: pw.TextStyle(
                    fontSize: toSize(20), fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: toSize(5)),
            buildTreatmentContent(patientDocument.mMedicalTreatment!),
          ]),
        ]),
        pw.SizedBox(height: toSize(1) * PdfPageFormat.cm),
        pw.Divider(),
        pw.SizedBox(height: toSize(1) * PdfPageFormat.cm),
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text("Medical Vitals",
              style: pw.TextStyle(
                  fontSize: toSize(20), fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: toSize(5)),
          buildVitalsContent(patientDocument.mHealthVitals!),
        ]),
      ],
      footer: (context) => buildFooter(patientDocument),
    ));

    PdfOpen.saveDocument(name: "$fileName.pdf", pdf: pdf, context: context);
  }

  static pw.Widget buildHeader(GetLibraryTranscriptJsonInfo patientDocument,
          pw.ImageProvider imageProvider) =>
      pw.Column(children: [
        pw.Image(imageProvider,
            height: toSize(5) * PdfPageFormat.cm,
            width: toSize(5) * PdfPageFormat.cm),
      ]);

  static pw.Widget buildFooter(GetLibraryTranscriptJsonInfo patientDocument) =>
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Divider(),
          pw.SizedBox(height: toSize(2) * PdfPageFormat.mm),
          buildSimpleText(title: 'MedVoice', value: ""),
          pw.SizedBox(height: toSize(10) * PdfPageFormat.mm),
        ],
      );

  static pw.Widget buildSimpleText({
    required String title,
    required String value,
  }) {
    final style =
        pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: toSize(16));

    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(title, style: style),
        pw.SizedBox(width: toSize(2) * PdfPageFormat.mm),
        pw.Text(value),
      ],
    );
  }

  static pw.Widget buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static Future<Uint8List> loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  static pw.Widget buildDiagnosisContent(
      List<MedicalDiagnosisInfo> patientDiagnosis) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        for (var item in patientDiagnosis) diagnosisItem(item.mName),
      ],
    );
  }

  static pw.Widget diagnosisItem(String? diagnosis) {
    return pw.Column(
      children: [
        pw.Text((diagnosis != null && diagnosis.isNotEmpty) ? diagnosis : "N/A", style: pw.TextStyle(fontSize: toSize(18))),
        pw.SizedBox(height: toSize(5))
      ],
    );
  }

  static pw.Widget buildTreatmentContent(
      List<MedicalTreatmentInfo> patientTreatment) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        for (var item in patientTreatment) treatmentItem(item.mName),
      ],
    );
  }

  static pw.Widget treatmentItem(String? treatments) {
    return pw.Column(
      children: [
        pw.Text((treatments != null && treatments.isNotEmpty) ? treatments : "N/A", style: pw.TextStyle(fontSize: toSize(18))),
        pw.SizedBox(height: toSize(5))
      ],
    );
  }

  static pw.Widget buildVitalsContent(List<HealthVitalInfo> patientDiagnosis) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        for (var item in patientDiagnosis) vitalItem(item.mStatus),
      ],
    );
  }

  static pw.Widget vitalItem(String? vitals) {
    return pw.Column(
      children: [
        pw.Text((vitals != null && vitals.isNotEmpty) ? vitals : "N/A", style: pw.TextStyle(fontSize: toSize(18))),
        pw.SizedBox(height: toSize(5))
      ],
    );
  }
}
