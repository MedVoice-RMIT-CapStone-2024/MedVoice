import 'medical_entity.dart';
import 'phi_result.dart';
import 'soap_note.dart';

class MedicalDocument {
  final SoapNote soap;
  final List<MedicalEntity> entities;
  final PhiResult phi;

  MedicalDocument({required this.soap, required this.entities, required this.phi});

  factory MedicalDocument.fromJson(Map<String, dynamic> json) => MedicalDocument(
        soap: SoapNote.fromJson(Map<String, dynamic>.from((json['soap'] as Map?) ?? {})),
        entities: ((json['entities'] as List?) ?? [])
            .map((e) => MedicalEntity.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
        phi: PhiResult.fromJson(Map<String, dynamic>.from((json['phi'] as Map?) ?? {})),
      );
}
