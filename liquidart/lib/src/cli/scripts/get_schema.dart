import 'dart:async';

import 'package:liquidart/liquidart.dart';
import 'package:liquidart/src/cli/command.dart';
import 'package:liquidart/src/cli/mixins/project.dart';
import 'package:loner/loner.dart';

class GetSchemaExecutable extends Executable<Map<String, dynamic>> {
  GetSchemaExecutable(Map<String, dynamic> message) : super(message);

  @override
  Future<Map<String, dynamic>> execute() async {
    try {
      var dataModel = ManagedDataModel.fromCurrentMirrorSystem();
      var schema = Schema.fromDataModel(dataModel);
      return schema.asMap();
    } on SchemaException catch (e) {
      return {"error": e.message};
    } on ManagedDataModelError catch (e) {
      return {"error": e.message};
    }
  }

  static List<String> importsForPackage(String packageName) => [
        "package:liquidart/liquidart.dart",
        "package:$packageName/$packageName.dart",
        "package:replica/replica.dart"
      ];
}

Future<Schema> getProjectSchema(CLIProject project) async {
  final response = await Loner.run(GetSchemaExecutable({}),
      imports: GetSchemaExecutable.importsForPackage(project.libraryName),
      packageConfigURI: project.packageConfigUri,
      logHandler: project.displayProgress);

  if (response.containsKey("error")) {
    throw CLIException(response["error"] as String);
  }

  return Schema.fromMap(response);
}
