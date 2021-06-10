import 'dart:async';
import 'dart:mirrors';

import 'package:liquidart/src/application/channel.dart';
import 'package:loner/loner.dart';
import 'package:replica/replica.dart';

class GetChannelExecutable extends Executable<String> {
  GetChannelExecutable(Map<String, dynamic> message) : super(message);

  @override
  Future<String> execute() async {
    final channels = RuntimeContext.current.replicas!.iterable.whereType<ChannelRuntime>();
    if (channels.length != 1) {
      throw StateError("No ApplicationChannel subclass was found for this project. "
        "Make sure it is imported in your application library file.");
    }
    ChannelRuntime? runtime = channels.first;

    return MirrorSystem.getName(reflectClass(runtime.channelType).simpleName);
  }

  static List<String> importsForPackage(String? packageName) => [
        "package:liquidart/liquidart.dart",
        "package:$packageName/$packageName.dart",
        "package:replica/replica.dart"
      ];
}
