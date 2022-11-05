import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'game/game.dart';
import 'main/main_screen.dart';

class GameManager extends FlameGame with HasCollisionDetection, PanDetector {
  late Raptor _raptor;
  late MainScreen _mainScreen;

  GameManager() {
    _mainScreen = MainScreen(() {
      remove(_mainScreen);
      _raptor = Raptor();
      add(_raptor);
    });
  }

  @override
  Future<void>? onLoad() {
    add(_mainScreen);
  }

  @override
  void onPanStart(DragStartInfo info) {
    super.onPanStart(info);
    _mainScreen.onPanStart(info);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);
    _raptor.onPanUpdate(info);
  }

  void endGame(int score) {
    remove(_raptor.gameRef);
    _mainScreen.setScore(score);
    add(_mainScreen);
  }
}
