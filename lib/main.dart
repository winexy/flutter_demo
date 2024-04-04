import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/user.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

Future<User> getUser(String login) async {
  // rate limit x_x
  
  // final dio = Dio();
  // final endpoint = 'https://api.github.com/users/$login';

  // final response = await dio.get(endpoint);

  return User.fromJson({
    'login': 'winexy',
    'avatar_url':
        'https://3.bp.blogspot.com/-QFwmVa5ggAQ/VCP2cXcqDmI/AAAAAAAAAG8/Gd8ihgeRNOo/s1600/Balloon_Parade_4_tx800.jpg'
  });
}

class MyApp extends HookWidget {
  final controller = TextEditingController();

  MyApp({super.key});

  // User user = const User(
  //   login: 'Test User',
  //   avatarUrl: 'https://i.imgflip.com/2lwtub.jpg',
  // );

  // @override
  // void initState() {
  //   super.initState();

  //   controller.addListener(() {
  //     _fetchUser(controller.text);
  //   });
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    final user = useState(const User(
      login: 'Test User',
      avatarUrl: 'https://i.imgflip.com/2lwtub.jpg',
    ));

    void _fetchUser(String login) async {
      final userData = await getUser(login);
      user.value = userData;
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter GitHub profile',
                ),
                onChanged: (value) {
                  _fetchUser(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: UserProfile(user: user.value),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final User user;

  const UserProfile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          user.avatarUrl,
          width: 240,
          height: 240,
        ),
        Text(user.login),
      ],
    );
  }
}
