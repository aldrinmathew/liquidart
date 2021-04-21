import 'dart:mirrors';

Iterable<ClassMirror?> classHierarchyForClass(ClassMirror t) sync* {
  var tableDefinitionPtr = t;
  while (tableDefinitionPtr.superclass != null) {
    yield tableDefinitionPtr;
    tableDefinitionPtr = tableDefinitionPtr.superclass!;
  }
}

T? firstMetadataOfType<T>(DeclarationMirror dm, {TypeMirror? dynamicType}) {
  final tMirror = dynamicType ?? reflectType(T);
  List<InstanceMirror?> metadataList = dm.metadata;
  for (int i = 0; i < metadataList.length; i++) {
    if (metadataList[i] != null) {
      InstanceMirror im = metadataList[i]!;
      if(im.type.isSubtypeOf(tMirror)) {
        return im.reflectee as T;
      }
    }
  }
  return null;
}

List<T> allMetadataOfType<T>(DeclarationMirror dm) {
  var tMirror = reflectType(T);
  return dm.metadata
      .where((im) => im.type.isSubtypeOf(tMirror))
      .map((im) => im.reflectee)
      .toList()
      .cast<T>();
}

String getMethodAndClassName(VariableMirror mirror) {
  return "${MirrorSystem.getName(mirror.owner!.owner!.simpleName)}.${MirrorSystem.getName(mirror.owner!.simpleName)}";
}
