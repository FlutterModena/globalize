// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationKey _$TranslationKeyFromJson(Map<String, dynamic> json) =>
    TranslationKey(
      name: json['name'] as String,
      description: json['description'] as String,
      variables: (json['variables'] as List<dynamic>)
          .map((e) => TranslationVariable.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..value = json['value'] as String;

Map<String, dynamic> _$TranslationKeyToJson(TranslationKey instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'variables': instance.variables,
    };

TranslationVariable _$TranslationVariableFromJson(Map<String, dynamic> json) =>
    TranslationVariable(
      json['variableName'] as String,
      $enumDecode(_$VariableTypeEnumMap, json['type']),
    )..strings = _$recordConvert(
        json['strings'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as String?,
          $jsonValue[r'$2'] as String?,
          $jsonValue[r'$3'] as String?,
        ),
      );

Map<String, dynamic> _$TranslationVariableToJson(
        TranslationVariable instance) =>
    <String, dynamic>{
      'variableName': instance.variableName,
      'type': _$VariableTypeEnumMap[instance.type]!,
      'strings': {
        r'$1': instance.strings.$1,
        r'$2': instance.strings.$2,
        r'$3': instance.strings.$3,
      },
    };

const _$VariableTypeEnumMap = {
  VariableType.regular: 'regular',
  VariableType.gendered: 'gendered',
  VariableType.plural: 'plural',
};

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
