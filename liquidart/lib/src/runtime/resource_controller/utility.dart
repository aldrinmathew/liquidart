import 'dart:mirrors';

import 'package:liquidart/src/auth/auth.dart';
import 'package:liquidart/src/http/http.dart';
import 'package:liquidart/src/http/resource_controller_bindings.dart';
import 'package:liquidart/src/http/resource_controller_scope.dart';

bool isOperation(DeclarationMirror m) {
  return getMethodOperationMetadata(m) != null;
}

List<AuthScope>? getMethodScopes(DeclarationMirror m) {
  if (!isOperation(m)) {
    return null;
  }

  final method = m as MethodMirror;
  Scope? metadata;
  final List<InstanceMirror?> metadataList = method.metadata;
  for (int i = 0; i < metadataList.length; i++) {
    if (metadataList[i] != null) {
      InstanceMirror im = metadataList[i]!;
      if (im.reflectee is Scope) {
        metadata = im.reflectee as Scope;
      }
    }
  }
  if (metadata != null) {
    return metadata.scopes.map((scope) => AuthScope(scope)).toList();
  } else {
    return null;
  }
}

Operation? getMethodOperationMetadata(DeclarationMirror m) {
  if (m is! MethodMirror) {
    return null;
  }

  final method = m;
  if (!method.isRegularMethod || method.isStatic) {
    return null;
  }
  Operation? metadata;
  final List<InstanceMirror?> metadataList = method.metadata;
  for(int i = 0; i < metadataList.length; i++) {
    if(metadataList[i]!= null) {
      InstanceMirror im = metadataList[i]!;
      if(im.reflectee is Operation) {
        metadata = im.reflectee as Operation;
      }
    }
  }
  return metadata;
}
