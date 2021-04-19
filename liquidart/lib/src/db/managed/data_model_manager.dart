import 'package:liquidart/src/db/managed/data_model.dart';
import 'package:liquidart/src/db/managed/entity.dart';
import 'package:liquidart/src/utilities/reference_counting_list.dart';

class ManagedDataModelManager {
  static ReferenceCountingList<ManagedDataModel> dataModels =
      ReferenceCountingList<ManagedDataModel>();

  static ManagedEntity? findEntity(Type type,
      {required ManagedEntity? orElse()}) {
    for (final d in ManagedDataModelManager.dataModels) {
      final ManagedEntity? entity = d.entityForType(type);
      if (entity != null) {
        return entity;
      }
    }

    dynamic orElseCheck = orElse;

    if (orElseCheck == null) {
      throw StateError(
          "No entity found for '$type. Did you forget to create a 'ManagedContext'?");
    }

    return orElse();
  }

  static void add(ManagedDataModel model) {
    final idx = dataModels.indexOf(model);
    if (idx == -1) {
      dataModels.add(model);
    }

    model.retain();
  }
}
