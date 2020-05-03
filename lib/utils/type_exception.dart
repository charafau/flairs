import 'package:flairs/utils/command_utils.dart';

class TypeException implements Exception {
  final String name;
  final String type;

  TypeException(this.name, this.type);

  @override
  String toString() {
    return 'Could not parse type: $type for name: $name. Valid types are ${CommandUtils.types.toString()}';
  }
}
