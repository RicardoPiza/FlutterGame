
# Raptor: Call of the USF

O Raptor Call of the USF é um jogo spaceshooter que tem como objetivo atingir o inimigo que irá surgir na tela, as balas saem da nave continuamente o jogador apenas move a nave e desvia do inimigo se o inimigo encostar no avião, você perde e a aeronave explode se o tiro acertar o inimigo ele explode e você acumula pontos.

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

## ⚙️ Recursos

- Fullscreen mode
- Trilha sonora
- Som de efeito

## 🛠 Tecnologias

  [![My Skills](https://skills.thijs.gg/icons?i=dart)](https://skills.thijs.gg)
- [Flutter](https://flutter.dev/?gclid=Cj0KCQiAm5ycBhCXARIsAPldzoXhfw4qjHBQMD9DBtdRUYAh8qIX3F8dIQ7Z0z7Jee8iTdiKkAMnAksaAi_cEALw_wcB&gclsrc=aw.ds)
    - [Dart](https://dart.dev/)
- [Framework - Flame Engine](https://flame-engine.org/)  


## 💻 Classes
Para cada objeto é uma classe separada.

### Classe Bala

```
class Bullet extends SpriteComponent
    
```
### Classe Jogador
```
class Player extends SpriteAnimationComponent
    
```

### Classe Inimigo

```
class Enemy extends SpriteAnimationComponent
  
```


### Classe Jogo

```
class Raptor extends Component with HasGameRef<GameManager> 
  
```

## 🚀 Acesso e execução do código

Para executar esse jogo é necessário as seguintes depedências:

- Flutter 
- Android studio para emular o smartphone (opcional)
- Uma IDE compatível (ex. VScode)

Etapas para a execução em ambiente local:

1. Clonar o repositório
```
git clone https://github.com/RicardoPiza/FlutterGame/

```
2. Acessar a pasta

```
cd FlutterGame

```

3. Instalar as dependências do projeto. Pode ser feito através do arquivo pubspec.yaml dentro do projeto ou através do comando:

```
flutter pub get

```

4. Inicie o projeto
```
flutter run lib/main.dart

```

## 💡 Objetivo do Projeto

Desenvolvido para um projeto acadêmico, a ideia era exercitar a linguagem dart com o framework flutter.

O Jogo é destinado a todas as idades, não possui classificação por idade ou gênero.

## 🎨 Demo

Inserir Gif ou imagem do jogo para demonstração




