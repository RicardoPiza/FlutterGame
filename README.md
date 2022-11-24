
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
class Bullet extends SpriteComponent with CollisionCallbacks {
  final double _speed = 650;

  Vector2 direction = Vector2(0, -1);

  Bullet({
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void onMount() {
    super.onMount();

    final shape = CircleHitbox.relative(
      0.4,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += direction * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
    }
  }
}
```

### Classe Inimigo Administrador

![image](https://user-images.githubusercontent.com/61169043/202529646-dbe168f7-9362-4f5f-9b1e-37e8f63d613e.png)

### Classe Inimigo

![image](https://user-images.githubusercontent.com/61169043/202529851-a5be1ad0-4f89-4a10-81b3-b23d551944d5.png)

### Classe Jogo

![image](https://user-images.githubusercontent.com/61169043/202530005-e29feb60-43f7-42a0-9d3e-5a1b72b01cac.png)


### Classe Jogador

![image](https://user-images.githubusercontent.com/61169043/202530123-b3e996f8-059b-4a94-8b65-c51207872ef0.png)


## Acesso e execução do código

O código do projeto encontra-se no github.

- [Código do Jogo](https://github.com/RicardoPiza/FlutterGame)

## Objetivo do Projeto

Publico Alvo

O Jogo é destinado a todas as idades, não possui classificação por idade ou gênero.

## Demo

Inserir Gif ou imagem do jogo para demonstração




