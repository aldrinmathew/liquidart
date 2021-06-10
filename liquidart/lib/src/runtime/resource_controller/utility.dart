import 'dart:mirrors';

import 'package:liquidart/src/auth/auth.dart';
import 'package:liquidart/src/http/http.dart';
import 'package:liquidart/src/http/resource_controller_bindings.dart';
import 'package:liquidart/src/http/resource_controller_scope.dart';
import 'package:collection/collection.dart' show IterableExtension;

bool isOperation(DeclarationMirror m) {
  return getMethodOperationMetadata(m) != null;
}

List<AuthScope>? getMethodScopes(DeclarationMirror m) {
  if (!isOperation(m)) {
    return null;
  }

  final method = m as MethodMirror;
  final metadata = method.metadata
      .firstWhereOrNull((im) => im.reflectee is Scope)
      ?.reflectee as Scope?;

  return metadata?.scopes.map((scope) => AuthScope(scope)).toList();
}

Operation? getMethodOperationMetadata(DeclarationMirror m) {
  if (m is! MethodMirror) {
    return null;
  }

  final method = m;
  if (!method.isRegularMethod || method.isStatic) {
    return null;
  }

  final metadata = method.metadata
      .firstWhereOrNull((im) => im.reflectee is Operation)
      ?.reflectee as Operation?;

  return metadata;
}
