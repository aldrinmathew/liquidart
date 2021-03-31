import 'dart:async';

import 'package:liquidart/src/cli/commands/auth.dart';
import 'package:liquidart/src/cli/command.dart';
import 'package:liquidart/src/cli/commands/build.dart';
import 'package:liquidart/src/cli/commands/create.dart';
import 'package:liquidart/src/cli/commands/db.dart';
import 'package:liquidart/src/cli/commands/document.dart';
import 'package:liquidart/src/cli/commands/serve.dart';
import 'package:liquidart/src/cli/commands/setup.dart';

class Runner extends CLICommand {
  Runner() {
    registerCommand(CLITemplateCreator());
    registerCommand(CLIDatabase());
    registerCommand(CLIServer());
    registerCommand(CLISetup());
    registerCommand(CLIAuth());
    registerCommand(CLIDocument());
    registerCommand(CLIBuild());
  }

  @override
  Future<int> handle() async {
    printHelp();
    return 0;
  }

  @override
  String get name {
    return "liquidart";
  }

  @override
  String get description {
    return "Liquidart is a tool for managing Liquidart applications.";
  }
}
