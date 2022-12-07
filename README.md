
</br></br><p align = "center">
<img src="https://drive.google.com/uc?export=view&id=1QgJmD2O3J3OLhXgRkMqIvkjzDKJYcmfs" width="400">
</p>

<h2>🕹 Sobre o projeto</h2>
Raptor: Call of the USF é um jogo no estilo space shooter que tem como objetivo atingir naves inimigas que surgem de forma aleatória na tela.<br>

As balas saem da nave continuamente. O jogador controla a nave e desvia do inimigo utilizando a tela Touch Screen. Caso o inimigo encoste no avião, o jogador perde e a aeronave explode. Se o tiro acertar o inimigo, ele explode e você acumula pontos.

A quantidade de vidas do jogador é inexistente, caso a aeronave seja destruída você perde. O objetivo é destruir os inimigos até que algum encoste na aeronave e a destrua.<br>

Construído em Flutter e Flame, cada objeto da tela possui uma classe especifica.<br>

A imagem de fundo se move usando o efeito Parallax, que é um recurso nativo da biblioteca Flame.

## 🎨 Demo
<p align="center">
<img src="https://sadris.co/wp-content/uploads/2022/12/raptor-call.gif">
</p>

## ✒ Autores

- [Ricardo Piza](https://github.com/RicardoPiza)
- [Rickson Figueira](https://github.com/sadrisco)
- [Giovani Belgine](https://github.com/Gibelgini)
- [Thiago Matos](https://github.com/t997)

## 🕶 Professor Docente
- Jose Matias Lemes Filho

## 📐 Arquitetura

Desenvolvido em flutter na versão 3.3.9.<br>

- A linguagem de programação Dart.<br>
- Utilizado [flame engine framework](https://docs.flame-engine.org/1.5.0/) do flutter.<br>
- Utilizado [flame audio](https://docs.flame-engine.org/1.5.0/bridge_packages/flame_audio/audio.html?highlight=audio).<br>
- O protótipo de UI foi desenvolvido no Figma.

## ⚙️ Recursos

- Fullscreen mode
- Trilha sonora
- Som de efeito
- Background infinito

## 🛠 Tecnologias

  [![My Skills](https://skills.thijs.gg/icons?i=dart)](https://skills.thijs.gg)
- [Dart](https://dart.dev/)
    - [Flutter](https://flutter.dev/?gclid=Cj0KCQiAm5ycBhCXARIsAPldzoXhfw4qjHBQMD9DBtdRUYAh8qIX3F8dIQ7Z0z7Jee8iTdiKkAMnAksaAi_cEALw_wcB&gclsrc=aw.ds) 
    - [Framework - Flame Engine](https://flame-engine.org/)  


## 💻 Classes
Para cada objeto temos uma classe separada.

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
2. Acessar a pasta do repositório recém clonado

```
cd FlutterGame
```

3. Instalar as dependências do projeto. Pode ser feito dentro do projeto através do arquivo pubspec.yaml ou através do comando:

```
flutter pub get
```

4. Inicie o projeto
```
flutter run lib/main.dart
```

## 💡 Objetivo do Projeto

Desenvolvido para um projeto acadêmico, a ideia era exercitar o desenvolvimento de software mobile utilizando o framework multiplataformas Flutter, junto da linguagem Dart.

O Jogo é destinado a todas as idades, não possui classificação por idade ou gênero.

## 🔮 Trabalhos Futuros

- Corrigir o bug de limitação da tela de usuário
- Corrigir a implementação do recurso de vida do jogador
- Desenvolver um mecanismo de power-ups para o jogador
- Implementar um número maior de inimigos
- Implementar um Boss final
