import 'package:wildfire/wildfire.dart';
import 'package:liquid_test/liquid_test.dart';

export 'package:wildfire/wildfire.dart';
export 'package:liquid_test/liquid_test.dart';
export 'package:test/test.dart';
export 'package:liquid/liquid.dart';

/// A testing harness for wildfire.
///
/// A harness for testing an liquid application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<WildfireChannel> with TestHarnessORMMixin {
  @override
  ManagedContext get context => channel.context;

  @override
  Future onSetUp() async {
    await resetData();
  }

  @override
  Future onTearDown() async {

  }

  @override
  Future seed() async {
    // restore any static data. called by resetData.
  }
}