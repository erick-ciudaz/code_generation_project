import 'dart:async';
import 'package:build/build.dart';
import 'package:glob/glob.dart';

class CustomBuilder extends Builder {
  static final _scope = Glob('**/*.dart');

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    await _findFilesAndBuild(buildStep);
    log.info("1.- ASSETS FOUND");
    await writeInFile(buildStep);
    log.info("2.- FILE WRITE SUCCESSFULL");
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$package$': [".custom.gen.temp"]
      };

  _findFilesAndBuild(BuildStep buildStep) async {
    await for (var fileAsset in buildStep.findAssets(_scope)) {
      log.info("CUSTOM BUILDER: file path ${fileAsset.path}");
      await _buildForFile(fileAsset, buildStep);
    }
  }

  _buildForFile(AssetId fileAsset, BuildStep buildStep) async {
    // logic for fileAsset
  }

  writeInFile(BuildStep buildStep) {}
}
