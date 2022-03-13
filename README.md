# dukkantek
### Empowering your business through digital transformation
#### A technology partner that improves your business.

...
## Getting Started

This project consists of mainly 3 screens:
1. Splash Screen
2. Login Screen (bottomsheet)
3. Launch Screen (Home - the webview and the Profile - to login and see personal information, Search and About Us, use the same home view)

## About the project:

1. The project is using VIPER architecture where as VIPER stand for 
    1. V = View (where the ui part is handled)
    2. I = Interactor (where all the interactions i.e. clicks are handled)
    3. P = Presenter (Where the presenter is hablded for all the business logics)
    4. E = Entity (Where the models linked to the view and presenter are being handled)
    5. R = Routes (Where the route/navigation of individual screen are being handled)
    
2. For state management its using Flutter Riverpod along with Flutter Hooks, there is combined package called as hooks_riverpod

3. For API call its using dio: 
    1. rest_service.dart file has all the API call methods, and also before calling an API it used the connectivity plugin to check the network availibity. 

    2. currently for this the API response are mocked, the mock the api resonse, in the reset_service method, have to pass the path for the mock resposne json file. Currentlty all the mock response are added to the assets/mock_response folder. 

4. The color combination is taken from the website (https://www.dukkantek.com/)

5. For font Google fonts plugin is used and soraTextTheme() is used. The whole app textTheme / font family can be easily cahnged from text_styles.dart file 

    `TextTheme get theme => GoogleFonts.soraTextTheme();`

5. Credentials for login:
    1. To check the success part use email = km@dukkantek.com and password = 123456

    2. Apart from the above mentioned combination every other will give failure response. 

6. Google login works for Android and iOS. (For Android it wont be running on other devices as its in debug mode and requires the development machines SHA1 and SHA256 keys to authenticate). 

7. The login details (email and name) are stored in shared preference and on App start the stoage is checked, if the login details are present, it skips the login section and directly goes to the Launch Screen. 

8. Most resulable UI(s) are created as seperate components which can be found in global_components folders. 

9. String and Widget extensions are used to make the UI creation faster and easier and also to maintain the App style guide.

10. For the bottom navigation bar Cuberto bottom bar is used. (This is my personal package in pub.dev)
- [Cuberto bottom bar](https://pub.dev/packages/cuberto_bottom_bar)

11. Screen recording of the flow
- [iOS simulator screen recording](https://drive.google.com/file/d/1YBqbaeI6XvZavvNmDV5nvOZz41QJ2heg/view?usp=sharing)

- [Android emulator screen recording](https://drive.google.com/file/d/1i_MGGgV9L5nuIX2wKi5GC1NZ74c63C8-/view?usp=sharing)