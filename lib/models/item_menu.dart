import 'dart:convert';

class ItemMenu {
  // {"id":0,"name":"Chọn tỉnh thành"}
  final String key;

  final String value;

  ItemMenu({
    required this.key,
    required this.value,
  });

  factory ItemMenu.fromJson(Map<String, dynamic> json) => ItemMenu(
        key: json['key'].toString() as String? ?? '',
        value: json['value'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => _$ItemMenuToJson(this);

  Map<String, dynamic> _$ItemMenuToJson(ItemMenu instance) => <String, dynamic>{
        'key': instance.key,
        'value': instance.value,
      };
}
