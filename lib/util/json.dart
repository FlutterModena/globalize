import 'dart:convert' show json;

import 'package:globalize/models.dart';

extension JsonGenerator on Iterable<TranslationKey> {
  String _getVariableString(TranslationVariable v) {
    switch (v.type) {
      case VariableType.gendered:
        var (zero, one, other) = v.strings;
        return "${v.variableName}, plural${zero != null ? ',zero{$zero}' : null}${one != null ? ',one{$one}' : null}${other != null ? ',other{$other}' : null}";
      case VariableType.regular:
        return v.variableName;
      case VariableType.plural:
        var (male, female, other) = v.strings;
        return "${v.variableName}, select${male != null ? ',male{$male}' : null}${female != null ? ',female{$female}' : null}${other != null ? ',other{$other}' : null}";
    }
  }

  Map<String, dynamic> getJson() {
    Map<String, dynamic> ret = {};
    for (var key in this) {
      ret[key.name] = key.value;
      String desc = key.description;

      for (var el in key.variables) {
        desc.replaceAll(el.variableName, _getVariableString(el));
      }

      ret["@${key.name}"] = {
        "description": desc,
        "placeholders": {
          for (var variable in key.variables) variable.variableName: {}
        }
      };
    }
    return ret;
  }
}
