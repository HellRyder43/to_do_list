import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/screens/ToDoListForm.dart';

void main() {
  test('empty title returns an error string', () {
    var result = FieldValidator.validateTitle('');
    expect(result, 'Title can\'t be empty');
  });

  test('non-empty title returns null', () {
    var result = FieldValidator.validateTitle('value');
    expect(result, null);
  });
}
