
# Raptor: Call of the USF

O Raptor Call of the USF é um jogo de avião que tem como objetivo atingir o inimigo que irá surgindo no decorrer do jogo, as balas saem da nave continuamente o jogador apenas move a nave e desvia do inimigo se o inimigo encostar no avião, você perde e a aeronave explode se o tiro acertar o inimigo ele explode e você ganha o jogo.

O jogo não tem numero de vidas, caso a aeronave seja destruída você perde, o objetivo é ir destruindo os inimigos até que algum encoste na aeronave e a destrua.

O jogo é construído no flutter cada objeto da tela possui uma classe especifica, a imagem de fundo se move e o jogador tambem consegue mover a aeronave pela tela clicando em cima da nave e arrastando.

## Autores

- [Ricardo Piza](https://github.com/RicardoPiza)
- [Rickson Figueira](https://github.com/sadrisco)
- [Giovani Belgine](https://github.com/Gibelgini)
- [Thiago Matos](https://github.com/t997)

## Arquitetura

Desenvolvido é feito em flutter versão " ".
A linguagem de programação DART.
Utilizado flame framework do flutter.
Utilizado flame audio.
As imagens foram trabalhadas no Figma.
Bibliotecas do flame

## Recursos

- Fullscreen mode
- Trilha sonora
- Som de efeito


## Classes
Para cada objeto é uma classe separada.

### Classe Bala

```
class Bullet extends SpriteComponent
    with CollisionCallbacks, GestureHitboxes, HasGameRef<GameManager> {
  final double _speed = 400;
  var shape = RectangleHitbox();

  Vector2 direction = Vector2(0, -1);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('shot4_5.png');
    width = 80;
    height = 120;
    FlameAudio.play('shot.mp3');

    anchor = Anchor.center;
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      removeFromParent();
      remove(shape);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direction * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
      remove(shape);
    }
  }
}
```
### Classe Jogador
```
class Player extends SpriteAnimationComponent
    with HasGameRef<GameManager>, GestureHitboxes, CollisionCallbacks {
  final VoidCallback onTouch;

  Player(this.onTouch);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var spriteSheet = SpriteSheet(
      image: await Images().load('player_original.png'),
      srcSize: Vector2(32.0, 48.0),
    );
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1);

    position = gameRef.size / 2;
    width = 50;
    height = 62;
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      gameRef.camera.shake(duration: .05, intensity: 10);
      // onTouch.call();
    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}

```

### Classe Inimigo

```
class Enemy extends SpriteAnimationComponent
    with HasGameRef<GameManager>, GestureHitboxes, CollisionCallbacks {
  final double _speed = 250;

  final Function(Vector2) onTouch;
  var rectanglehitbox = RectangleHitbox();

  Enemy(this.onTouch);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var spriteSheet = SpriteSheet(
        image: await Images().load('enemy.png'), srcSize: Vector2(16.0, 16));
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2);
    var size = 35.0;
    position = Vector2(
        Random()
            .nextInt((gameRef.size.toRect().width - size).toInt())
            .toDouble(),
        size);
    width = size;
    height = size;
    anchor = Anchor.center;

    add(rectanglehitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet) {
      removeFromParent();
      remove(rectanglehitbox);
      onTouch.call(other.position);
    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;
    if (position.y > gameRef.size.y) {
      removeFromParent();
      remove(rectanglehitbox);
    }
  }
}
```


### Classe Jogo

```
class Raptor extends Component with HasGameRef<GameManager> {
  late Player _player;
  late TextComponent _playerScore;
  static const int playerLevelByScore = 20;
  late Timer enemySpawner;
  late Timer bulletSpawner;
  int score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    enemySpawner = Timer(.5, onTick: _spawnEnemy, repeat: true);
    bulletSpawner = Timer(.3, onTick: _spawnBullet, repeat: true);
    add(Background());

    _playerScore = TextComponent(
        text: "Score : 0",
        position: Vector2(gameRef.size.toRect().width / 2, 10),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 32.0,
            color: Colors.white,
          ),
        ));
    add(_playerScore);

    _player = Player(_onPlayerTouch);
    add(_player);
  }

  void _spawnBullet() {
    var bullet = Bullet();
    var bullet2 = Bullet();
    bullet.position = _player.position.clone() + Vector2(15, -10);
    bullet2.position = _player.position.clone() + Vector2(-15, -10);
    add(bullet);
    add(bullet2);
  }

  void _spawnEnemy() {
    for (int i = 0; i <= min(score ~/ playerLevelByScore, 1); i++) {
      add(Enemy(_onEnemyTouch));
    }
  }

  void _onPlayerTouch() {
    gameRef.endGame(score);
  }

  void _onEnemyTouch(Vector2 position) {
    var explosion = Explosion();
    explosion.position = position;
    add(explosion);
    score++;
    _playerScore.text = "Score : $score";

    // if (score % playerLevelByScore == 0) {
    //   bulletSpawner.stop();
    //   bulletSpawner = Timer(
    //       min(1 / (score ~/ playerLevelByScore), 1).toDouble(),
    //       onTick: _spawnBullet,
    //       repeat: true);
    // }
  }

  void onPanUpdate(DragUpdateInfo info) {
    if (isMounted) {
      _player.move(info.delta.game);
    }
  }

  @override
  void onMount() {
    super.onMount();
    enemySpawner.start();
    bulletSpawner.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    enemySpawner.update(dt);
    bulletSpawner.update(dt);
  }

  @override
  void onRemove() {
    super.onRemove();
    enemySpawner.stop();
    bulletSpawner.stop();
  }
}
```

## Acesso e execução do código

O código do projeto encontra-se no github.

- [Código do Jogo](https://github.com/RicardoPiza/FlutterGame)

## Objetivo do Projeto

Publico Alvo

O Jogo é destinado a todas as idades, não possui classificação por idade ou gênero.

## Demo

Inserir Gif ou imagem do jogo para demonstração




