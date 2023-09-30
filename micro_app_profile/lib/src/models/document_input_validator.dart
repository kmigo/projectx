import 'package:micro_core/micro_core.dart';

class DocumentInputValidator {
  final String? type;
  final MultiTypeFile? frontDocument;
  final MultiTypeFile? backDocument;
  const DocumentInputValidator({
     this.type,
     this.frontDocument ,
     this.backDocument ,
  });
  

  DocumentInputValidator copyWith({
    String? type,
    MultiTypeFile? frontDocument,
    MultiTypeFile? backDocument,
  }) {
    return DocumentInputValidator(
      type: type ?? this.type,
      frontDocument: frontDocument ?? this.frontDocument,
      backDocument: backDocument ?? this.backDocument,
    );
  }
}