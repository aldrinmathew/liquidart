import 'dart:convert';
import 'dart:io';
import 'dart:mirrors';
import 'package:liquidart/liquidart.dart';
import 'package:liquidart/src/application/channel.dart';
import 'package:liquidart/src/runtime/orm/data_model_compiler.dart';

import 'package:liquidart/src/runtime/impl.dart';
import 'package:replica/replica.dart';

class LiquidartCompiler extends Compiler {
  @override
  Map<String, dynamic> compile(MirrorContext context) {
    final m = <String, dynamic>{};

    m.addEntries(context.getSubclassesOf(ApplicationChannel)
      .map((t) => MapEntry(_getClassName(t), ChannelRuntimeImpl(t))));
    m.addEntries(context.getSubclassesOf(Serializable)
      .map((t) => MapEntry(_getClassName(t), SerializableRuntimeImpl(t))));
    m.addEntries(context.getSubclassesOf(Controller)
      .map((t) => MapEntry(_getClassName(t), ControllerRuntimeImpl(t))));

    m.addAll(DataModelCompiler().compile(context));

    return m;
  }

  String _getClassName(ClassMirror mirror) {
    return MirrorSystem.getName(mirror.simpleName);
  }


  @override
  List<Uri> getUrisToResolve(BuildContext context) {
    return context.context.getSubclassesOf(ManagedObject).map((c) => c.location!.sourceUri).toList();
  }

  @override
  void deflectPackage(Directory destinationDirectory) {
    final libFile = File.fromUri(
      destinationDirectory.uri.resolve("lib/").resolve("liquidart.dart"));
    final contents = libFile.readAsStringSync();
    libFile.writeAsStringSync(
      contents.replaceFirst("export 'package:liquidart/src/runtime/compiler.dart';", ""));
  }

  @override
  void didFinishPackageGeneration(BuildContext context) {
    if (context.forTests) {
      print("Copying liquidart_test...");
      copyDirectory(src: context.sourceApplicationDirectory.uri.resolve("../").resolve("liquidart_test/"), 
        dst: context.buildPackagesDirectory.uri.resolve("liquidart_test/"));
      final targetPubspecFile = File.fromUri(context.buildDirectoryUri.resolve("pubspec.yaml"));
      final pubspecContents = json.decode(targetPubspecFile.readAsStringSync());
      pubspecContents["dev_dependencies"]["liquidart_test"]["path"] = "packages/liquidart_test";
      pubspecContents["dependency_overrides"]["liquidart"] = pubspecContents["dependencies"]["liquidart"];
      targetPubspecFile.writeAsStringSync(json.encode(pubspecContents));
    }
  }
}
