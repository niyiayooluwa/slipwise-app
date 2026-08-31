import 'package:hive_flutter/hive_flutter.dart';
import 'package:slipwise/modules/tickets/data/models/history.dart';
import 'package:slipwise/modules/auth/data/models/user_model.dart';

class HistoryItemAdapter extends TypeAdapter<HistoryItem> {
  @override
  final int typeId = 0; // Use 0 for HistoryItem

  @override
  HistoryItem read(BinaryReader reader) {
    // Read the binary map and cast string keys
    final map = reader.readMap();
    final Map<String, dynamic> json = {};
    map.forEach((key, value) {
      json[key.toString()] = value;
    });
    return HistoryItem.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, HistoryItem obj) {
    // Write as map
    writer.writeMap(obj.toJson());
  }
}

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1; // Use 1 for UserModel

  @override
  UserModel read(BinaryReader reader) {
    final map = reader.readMap();
    final Map<String, dynamic> json = {};
    map.forEach((key, value) {
      json[key.toString()] = value;
    });
    return UserModel.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeMap(obj.toJson());
  }
}
