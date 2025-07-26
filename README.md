# 💱 Consulta de Cotações

Um aplicativo Flutter que exibe cotações de moedas com base em uma moeda selecionada. Ele consome uma API pública de câmbio em tempo real para converter valores entre diferentes moedas.

Esse desafio foi desenvolvido como parte do Desafio Talent Lab 2025 - Bemol Digital.

---

## 📋 Descrição

O **Aplicativo** permite:

- Selecionar a moeda base.
- Visualizar uma lista de moedas e suas taxas de câmbio.
- Converter valores entre pares de moedas.
- Interface moderna com Material 3 e Provider para gerenciamento de estado.

---

## 📱 Requisitos
- Flutter SDK 3.13 ou superior
- Dart 3.x
- Android Studio ou VSCode com Flutter plugin
- Dispositivo físico ou emulador configurado


## 🚀 Execução do projeto

### 💻 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/cotacoes_app.git
cd cotacoes_app
```

### 📦 2. Instalar dependências

```bash
flutter pub get
```

### 🔐 3. Adicionar chave da API
Crie o arquivo AppConfig.dart na pasta lib/config/ seguindo arquivo de exemplo AppConfigExample.dart

```dart
class AppConfig {
    static const String apiKey = 'SUA_CHAVE_DA_API';
    static const String apiBaseUrl = 'https://v6.exchangerate-api.com/v6/';
}
```

🔑 Obtenha sua chave gratuita em https://www.exchangerate-api.com/

### ▶️ 4. Executar o aplicativo

```bash
flutter run
```

## 🧪 Testes
Para executar os testes unitários:

```bash
flutter test
```

## 🌐 API Utilizada

- ExchangeRate API
  - URL Base: https://v6.exchangerate-api.com/v6/
  - Documentação: https://www.exchangerate-api.com/docs


## 🙋 Autor
***Desenvolvido por Lucas Matos***



