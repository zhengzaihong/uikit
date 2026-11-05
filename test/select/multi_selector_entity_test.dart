import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_plus/select/bean/multi_selector_entity.dart';

void main() {
  test('fromJson parses nullable fields and nested children safely', () {
    final entity = MultiSelectorEntity.fromJson({
      'id': 1,
      'name': 'root',
      'children': [
        {'id': 2, 'name': 'child', 'isSelected': true},
        {'id': 3, 'name': 'child2'},
      ],
    });

    expect(entity.id, '1');
    expect(entity.name, 'root');
    expect(entity.isSelected, isFalse);
    expect(entity.children, hasLength(2));
    expect(entity.children!.first.id, '2');
    expect(entity.children!.first.isSelected, isTrue);
    expect(entity.children!.last.isSelected, isFalse);
  });

  test('fromJson returns null children when input is not a list', () {
    final entity = MultiSelectorEntity.fromJson({
      'id': '1',
      'children': 'invalid',
    });

    expect(entity.children, isNull);
  });
}