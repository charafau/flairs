import 'package:flairs/utils/type_exception.dart';

class CommandUtils {
  static RegExp resNameRegEx = RegExp('^[a-zA-Z]\$');

  static bool isResourceName(String input) {
    if (input != null && input.isNotEmpty && !resNameRegEx.hasMatch(input)) {
      return true;
    }
    return false;
  }

  static const List<String> types = ['string', 'int', 'double', 'bool'];

  static List<String> inputFieldsToClassFields(Map<String, String> fields) {
    final typedFields = <String>[];
    var index = 0;
    fields.forEach((name, type) {
      if (!types.contains(type.toLowerCase())) {
        throw TypeException(name, type);
      }

      if (type.toLowerCase() == 'string') {
        typedFields.add('@HiveField($index)\nString $name;');
      } else {
        typedFields.add('@HiveField($index)\n${type.toLowerCase()} $name;');
      }

      index++;
    });

    return typedFields;
  }


  static List<String> inputFieldsToHiveClassFields(Map<String, String> fields) {
    final typedFields = <String>[];

    fields.forEach((name, type) {
      if (!types.contains(type.toLowerCase())) {
        throw TypeException(name, type);
      }

      if (type.toLowerCase() == 'string') {
        typedFields.add('final String $name;');
      } else {
        typedFields.add('final ${type.toLowerCase()} $name;');
      }
    });

    return typedFields;
  }

  static String inputFieldsToNamedParams(Map<String, String> fields) {
    return fields.keys.map((name) => 'this.$name').toList().join(',').toString();
  }

  static String classFieldsToString(List<String> fields) {
    return fields.join('\n');
  }

  static String copyFields(Map<String, String> fields, {String from}){
    return fields.keys.map((name) => '$name: ${from ?? 'this'}.$name').toList().join(',').toString();
  }

  
  static String toStringFields(Map<String, String> fields){
    return fields.keys.map((name) => '$name: \$$name').toList().join(', ').toString();
  }
}
