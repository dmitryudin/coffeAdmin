# Класс Auth()

## Назначение

Предоставляет интерфейс для авторизациии в мобильном и веб приложении с использованием JWT-токенов. Предствавляет собой класс-одиночку и может быть вызван в любом месте приложения

## Зависимости

- hive: ^2.0.6
- hive_flutter: ^1.1.0

## Поля класса

- bool isAuthFlag - отображает текущее состояние авторизации пользователя
- String _login - содержит пользовательский логин, доступно только для записи (setter login)
- String _password - содержит пароль, доступно только для записи (setter password)
- String _refreshToken - не доступно за пределами класса

## Методы класса

- void init(void Function (bool isAuthFlag) callback, String authUrl, refreshTokenUrl) - метод вызвается в конструкторе метода виджета, создаваемого в функции main()

  ```dart

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatefulWidget {
    @override
    State<StatefulWidget> createState(){
      return _MyAppState();
      }
    }

  class _MyAppState extends State<MyApp> {

    _MyAppState() {
      Auth().init(callback: (bool isAuthFlag, String authUrl, refreshTokenUrl) {}
    }

    @override
    Widget build(BuildContext context) {
      return  MaterialApp(
            title: 'Flutter Demo',
            home: page);
    }
  }

    ```
Функция callback вызывается при изменении состояния авторизации и должна приводить к rebuld приложения


