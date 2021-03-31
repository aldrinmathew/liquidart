import 'dart:async';

import 'package:liquid/src/cli/commands/auth.dart';
import 'package:liquid/src/cli/command.dart';
import 'package:liquid/src/cli/commands/build.dart';
import 'package:liquid/src/cli/commands/create.dart';
import 'package:liquid/src/cli/commands/db.dart';
import 'package:liquid/src/cli/commands/document.dart';
import 'package:liquid/src/cli/commands/serve.dart';
import 'package:liquid/src/cli/commands/setup.dart';

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
    return "liquid";
  }

  @override
  String get description {
    return "Liquid is a tool for managing Liquid applications.";
  }
}
