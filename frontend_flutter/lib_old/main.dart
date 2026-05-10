import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: "https://unattired-jackson-undaughterly.ngrok-free.dev",
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {
      "Content-Type": "application/json",
      "ngrok-skip-browser-warning": "true",
    },
  ),
);

// final cookieJar = CookieJar();

// void setupDio() {
//   dio.interceptors.add(CookieManager(cookieJar));
// }

void main() {
  //setupDio();
  runApp(const MyApp());
}

Future<bool> logIn(String email, String password) async {
  //final url = Uri.parse('https://unattired-jackson-undaughterly.ngrok-free.dev/login');


  print('email: $email');
  print('pass: $password');

  // final response = await http.post(
  //   url,
  //   body: {
  //     'email':email,
  //     'password':password,
  //     }
  // ).timeout(const Duration(seconds: 10));

  final response = await dio.post(
    "/login",
    data: FormData.fromMap({
      "email": email,
      "password": password,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );
  

  print(response.data);
  if (response.statusCode == 200) { //got a response
    print("success");
    return true;
    
  } else { //401 - unauthorized
    print('Error: ${response.statusCode}');
    return false;
    
  }
}

Future<void> deleteUser(String email) async{
  final url = Uri.parse('http://127.0.0.1:5000/delete_user');

  final response = await dio.post(
    "/delete_user",
    data: FormData.fromMap({
      "email": email,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );


  if(response.statusCode == 200){ //valid
    return;
  }
}
//return if succeeded
Future<bool> signUp(String username, String age, String major, String email, String password, String discoverable) async {
  //final url = Uri.parse('http://127.0.0.1:5000/signup');
  print('username: $username');
  print('email: $email');
  print('pass: $password');

  final response = await dio.post(
    "/signup",
    data: FormData.fromMap({
      'username': username,
      'age':age,
      'major':major,
      'email':email,
      'password': password,
      'discoverable':discoverable,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );

  


  if (response.statusCode == 200) { //got a response
    print(response.data);
    return true;
  } else { //could not log in
    print('Error: ${response.statusCode}');
    return false;
  }
}

Future<void> getUserInfo(String email) async{
  final url = Uri.parse('http://127.0.0.1:5000/get_user_info');
  print("Email: $email");

  

  final response = await dio.post(
    "/get_user_info",
    data: FormData.fromMap({
      'email':email,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
    
  ),
  );
  

  
  if (response.statusCode == 200) { //got a response
    print(response.data);
  } else { //could not log in
    print('Error: ${response.statusCode}');
  }
}

Future<void> getPrivateUserInfo(String email) async{
  final url = Uri.parse('http://127.0.0.1:5000/get_private_user_info');
  print("Email: $email");

  final response = await dio.post(
    "/get_private_user_info",
    data: FormData.fromMap({
      'email':email,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );
  
  if(response.statusCode == 200){
    print(response.data);
  }
  else{
    print("Error: ${response.statusCode}");
  }
}
//we are email_sender
Future<bool> sendFriendRequest(String email_sender, String email_receiver) async{
  //final url = Uri.parse('http://127.0.0.1:5000/send_friend_request');

  final response = await dio.post(
    "/send_friend_request",
    data: FormData.fromMap({
      'email_sender':email_sender,
      'email_receiver':email_receiver,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );

  if(response.statusCode == 200){
    print(response.data);
    return true;
  }
  else{
    print("Error: ${response.statusCode}");
    return false;
  }
}
//we are email_receiver
Future<bool> acceptFriendRequest(String email_sender, String email_receiver) async{
  //final url = Uri.parse('http://127.0.0.1:5000/accept_friend_request');

  final response = await dio.post(
    "/accept_friend_request",
    data: FormData.fromMap({
      'email_sender':email_sender,
      'email_receiver':email_receiver,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );

  if(response.statusCode == 200){
    print(response.data);
    return true;
  }
  else{
    print("Error: ${response.statusCode}");
    return false;
  }
  
}
//we are email_receiver
Future<bool> declineFriendRequest(String email_sender, String email_receiver) async{
  final url = Uri.parse('http://127.0.0.1:5000/decline_friend_request');

  final response = await dio.post(
    "/decline_friend_request",
    data: FormData.fromMap({
      'email_sender':email_sender,
      'email_receiver':email_receiver,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );

  if(response.statusCode == 200){
    print(response.data);
    return true;
  }
  else{
    print("Error: ${response.statusCode}");
    return false;
  }
}

//it doesn't matter what is which but we're user
Future<bool> removeFriend(String email_user, String email_friend) async{
  //final url = Uri.parse('http://127.0.0.1:5000/remove_friend');

  final response = await dio.post(
    "/remove_friend",
    data: FormData.fromMap({
      'email_sender':email_user,
      'email_receiver':email_friend,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );

  if(response.statusCode == 200){
    print(response.data);
    return true;
  }
  else{
    print("Error: ${response.statusCode}");
    return false;
  }
}

Future<bool> updateUser(String email, String username, String major, String age, String private) async{
  final url = Uri.parse('http://127.0.0.1:5000/update_user');


  final response = await dio.post(
    "/update_user",
    data: FormData.fromMap({
      'email':email,
      'new_username':username,
      'new_major':major,
      'new_age':age,
      'new_private_bool':private,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );


  if(response.statusCode == 200){
    //print(response.body);
    return true;
  }
  else{
    print("Error: ${response.statusCode}");
    return false;
  }
}

Future<void> getAllFriends(String email) async{
  final url = Uri.parse('http://127.0.0.1:5000/get_all_friends');

  final response = await dio.post(
    "/get_all_friends",
    data: FormData.fromMap({
      'email':email,

    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );
}

Future<void> getAllFriendRequests(String email) async{
  //final url = Uri.parse('http://127.0.0.1:5000/get_all_friend_requests');

  final response = await dio.post(
    "/get_all_friend_requests",
    data: FormData.fromMap({
      'email':email,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cohort',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.blue, // Sets cursor color globally
          selectionColor: Colors.blueAccent, // Color of highlighted text
          selectionHandleColor: Colors.blue, // Color of selection bubbles
        ),
      ),
      home: const MyHomePage(title: 'Cohort'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isHidden = true;
  bool loggedIn = false;
  bool loginError = false;
  String resultText = '';
  var classes = ['class1', 'class2'];

//to use we can set void to a value and await logIn
  Future<void> localLogIn(String email, String password) async{
    if(await logIn(email, password)){
      Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
            ),
          );
      setState(() {
        loginError = false;
        loggedIn = true;
    });
    }
    else{
      setState(() {
        loginError = true;
        loggedIn = false;
    });
    }
  }





  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.amber,//Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login'),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: 400,
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 400,
                  child:             TextField(
                    obscureText: _isHidden,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                      icon: Icon(
                        _isHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        // Updates the UI instantly
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                    ),
                    ),
                  ),
                ),
                
            ],),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final username = userNameController.text;
                final password = passwordController.text; //Login
                localLogIn(username, password);
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final username = userNameController.text;
                final password = passwordController.text; //Login
                signUp(username, '18', 'CS', 'test@gmail.com', password, 'true');
              },
              child: const Text('Sign up'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final username = userNameController.text;
                getPrivateUserInfo(username);
              },
              child: const Text('Get info'),
            ),
            Visibility(
              visible: loggedIn,
              child: Text("Logged in"),
            ),
            Visibility(
              visible: loginError,
              child: Text("Error with credentials"),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            );
          },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body:  Center(
        child: Column(
          children: [
            Text('Home'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyHomePage(title: "Cohort"),
                  ),
                );
              },
              child: const Text('Click Me'),
            ),
            Text('Profile Page'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const tempScreen(),
                  ),
                );
              },
              child: const Text('Click Me'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final username = "temp@gmail.com";
                getUserInfo(username);
              },
              child: const Text('Get info'),
            ),
          ]
        )
        
      ),
    );
  }
}

class tempScreen extends StatelessWidget {
  const tempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temp 2'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('test2'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
              child: const Text('Click Me'),
            ),
          ]
        )
        
      ),
    );
  }
}