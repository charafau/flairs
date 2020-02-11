import 'package:args/args.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockInputModel extends Mock implements ArgResults {}

void main() {
  ArgResults args;
  setUp(() {
    args = MockInputModel();
  });

  test('should parse name for InputModel from arguments', () {
    when(args.arguments).thenReturn(['scaffold', 'Person', 'name:string', 'age:int']);

    final output = InputModel.fromCommand(args);

    expect(output.modelName, 'Person');
  });

  test('should parse fields for InputModel from arguments', () {
    when(args.arguments).thenReturn(['scaffold', 'Person', 'name:string', 'age:int']);

    final output = InputModel.fromCommand(args);

    expect(output.fields, {'name': 'string', 'age': 'int'});
  });
}
