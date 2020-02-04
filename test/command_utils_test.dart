import 'package:flairs/utils/command_utils.dart';
import 'package:test/test.dart';

void main() {
  test('should valid resource name for "Person"', () {
    expect(CommandUtils.isResourceName('Person'), true);
  });

  test('should invalidate resource naem for name:string', () {
    expect(CommandUtils.isResourceName('name:string'), false);
  });
}
