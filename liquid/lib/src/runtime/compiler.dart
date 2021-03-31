import 'dart:convert';
import 'dart:io';
import 'dart:mirrors';
import 'package:liquid/liquid.dart';
import 'package:liquid/src/application/channel.dart';
import 'package:liquid/src/runtime/orm/data_model_compiler.dart';

import 'package:liquid/src/runtime/impl.dart';
import 'package:runtime/runtime.dart';

class LiquidCompiler extends Compiler {
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
    return context.context.getSubclassesOf(ManagedObject).map((c) => c.location.sourceUri).toList();
  }

  @override
  void deflectPackage(Directory destinationDirectory) {
    final libFile = File.fromUri(
      destinationDirectory.uri.resolve("lib/").resolve("liquid.dart"));
    final contents = libFile.readAsStringSync();
    libFile.writeAsStringSync(
      contents.replaceFirst("export 'package:liquid/src/runtime/compiler.dart';", ""));
  }

  @override
  void didFinishPackageGeneration(BuildContext context) {
    if (context.forTests) {
      print("Copying liquid_test...");
      copyDirectory(src: context.sourceApplicationDirectory.uri.resolve("../").resolve("liquid_test/"), 
        dst: context.buildPackagesDirectory.uri.resolve("liquid_test/"));
      final targetPubspecFile = File.fromUri(context.buildDirectoryUri.resolve("pubspec.yaml"));
      final pubspecContents = json.decode(targetPubspecFile.readAsStringSync());
      pubspecContents["dev_dependencies"]["liquid_test"]["path"] = "packages/liquid_test";
      pubspecContents["dependency_overrides"]["liquid"] = pubspecContents["dependencies"]["liquid"];
      targetPubspecFile.writeAsStringSync(json.encode(pubspecContents));
    }
  }
}
