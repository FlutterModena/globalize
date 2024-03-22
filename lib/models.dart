import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class TranslationKey {
  TranslationKey({
    required this.name,
    required this.description,
    required this.variables,
  });

  final String name;
  final String description;
  String value = "";
  final List<TranslationVariable> variables;

  factory TranslationKey.fromJson(Map<String, dynamic> json) =>
      _$TranslationKeyFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationKeyToJson(this);
}

enum VariableType { regular, gendered, plural }

@JsonSerializable()
class TranslationVariable {
  TranslationVariable(this.variableName, this.type);
  final String variableName;
  final VariableType type;

  (String?, String?, String?) strings = (null, null, null);

  factory TranslationVariable.fromJson(Map<String, dynamic> json) =>
      _$TranslationVariableFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationVariableToJson(this);
}
