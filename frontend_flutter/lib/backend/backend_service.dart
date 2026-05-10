import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: "https://unattired-jackson-undaughterly.ngrok-free.dev",
    connectTimeout: Duration(seconds: 40),
    receiveTimeout: Duration(seconds: 40),
    headers: {
      "Content-Type": "application/json",
      "ngrok-skip-browser-warning": "true",
    },
  ),
);


class BackendService {

  // Friends
  static Future<bool> sendFriendRequest({ //MAYBE one of these is implied
    required String fromUserId,
    required String toEmail,
  }) async {
    print('Sending friend request from $fromUserId to $toEmail');

    final response = await dio.post(
      "/send_friend_request",
      data: FormData.fromMap({
        'email_sender':fromUserId,
        'email_receiver':toEmail,
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

  static Future<bool> acceptFriendRequest({
    required String requestId,
  }) async {
    print('Accepting request $requestId');

    final response = await dio.post( //TODO: to and from with session
      "/accept_friend_request",
      data: FormData.fromMap({
        'email_sender':requestId,
        //'email_receiver':requestId, //implied by session
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

  static Future<bool> declineFriendRequest({ 
    required String requestId,
  }) async {
    print('Declining request $requestId');

    try{

    }
    on DioException catch (e){
      print("request failed");
    }
    final response = await dio.post(
      "/decline_friend_request",
      data: FormData.fromMap({
        'email_sender':requestId,
        //'email_receiver':email_receiver, //implied by session ID
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

  static Future<bool> removeFriend({
    required String userId,
    required String friendId,
  }) async {
    print('Removing friend $friendId for user $userId');

    final response = await dio.post(
      "/remove_friend",
      data: FormData.fromMap({
        'email_sender':userId,
        'email_receiver':friendId,
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

  // Get Friends Info
  static Future<List<Map<String, String>>> getIncomingFriendRequests({
    required String userId,
  }) async {
    print('Getting incoming friend requests');

    final response = await dio.post(
      "/get_all_friend_requests",
      data: FormData.fromMap({
        'email':userId,
      }),
      options: Options(
      extra: {
        'withCredentials': true,
      },
    ),
    );

    List<Map<String, String>> requests = [];
    //print(response.data);
    if(response.data['success']){
      var friends = response.data['friends'];
      for(String email in friends){
        Map<String, String> user = {};
        user['email'] = email;
        user['name'] = 'Andrew S';
        requests.add(user);
      }
    }
    print(requests);
    return requests;
    print([
      {
        'name': 'Maya Patel',
        'email': 'maya.patel@example.com',
      },
      {
        'name': 'Daniel Kim',
        'email': 'daniel.kim@example.com',
      },
    ]);
    //return requests;

    return [
      {
        'name': 'Maya Patel',
        'email': 'maya.patel@example.com',
      },
      {
        'name': 'Daniel Kim',
        'email': 'daniel.kim@example.com',
      },
    ];
  } 

  static Future<List<Map<String, String>>> getAllFriends({
    required String userId,
  }) async {
    print('Getting friends info for $userId');

    final response = await dio.post(
      "/get_all_friends",
      data: FormData.fromMap({
        'email':userId,

      }),
      options: Options(
      extra: {
        'withCredentials': true,
      },
    ),
    );
    print("Info:");
      if(response.data['success']){
        List<Map<String, String>> requests = [];
      //print(response.data);
      if(response.data['success']){
        var friends = response.data['friends'];
        for(String email in friends){
          
          Map<String, String> user = await getFriendProfile(email);
          requests.add(user);
        }
      }
      print(requests);
      return requests;
    }

    return [
      {
        'name': 'Alex Rivera',
        'email': 'alex.rivera@example.com',
        'age': '21',
        'major': 'Computer Science',
      }
    ];
  }

  static Future<Map<String, String>> getFriendProfile(String email) async{
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
    //print("data:");
    //print(response.data);
    var userInfo = response.data['user'];
    print("UserInfo:");
    print(userInfo);

    Map<String, String> user = {};
    user['email'] = email;
    user['name'] = userInfo['username'];
    user['age'] = userInfo['age'];
    user['major'] = userInfo['major'];

    print("user1");
    print(user);
    print("user2");
    return user;

    return 
      {
        'name': 'Alex Rivera',
        'email': 'alex.rivera@example.com',
        'age': '21',
        'major': 'Computer Science',
      }
    ;
    
  }

  // schedule import/export
  static Future<bool> importSchedule() async { //TODO: these don't exist
    print('Importing schedule from Webadvisor');

    final response = await dio.post(
      "/load_schedule",
      data: FormData.fromMap({
        'email':"should",

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

  static Future<bool> importScheduleWithLogin({
    required String email,
    required String password,
    required String code,
  }) async {
    print('Importing schedule with fake login');
    print('Email: $email');
    print('Password entered: ${password.isNotEmpty}');
    print('Code: $code');

    return true;
  }

  static Future<bool> sendSchoolLoginCode({
    required String email,
    required String password,
  }) async {
    print('Sending fake verification code');
    print('Email: $email');
    print('Password entered: ${password.isNotEmpty}');

    return true;
  }

  static Future<bool> exportScheduleGoogle({ //TODO: these don't exist
    required String fromUserId,
    required String toEmail,
  }) async {
    print('exporting to google');
    return true;
  }

  static Future<bool> exportScheduleOutlook({
    required String fromUserId,
    required String toEmail,
  }) async {
    print('exporting to outlook');
    return true;
  }

  //Discovery Tab
  static Future<List<Map<String, dynamic>>> getRandomShared({
    required String userId,
  }) async {
    print('Getting random person who shares classes with $userId');

    final response = await dio.post(
    "/find_random_in_shared_class",
    data: FormData.fromMap({
      //'email':email,
    }),
    options: Options(
    extra: {
      'withCredentials': true,
    },
  ),
  );



    return [
      {
        'name': 'Daniel E',
        'email': 'daniel.e@example.com',
        'age': '21',
        'major': 'Computer Science',
        'shared': ['CS101', 'MATH201'],
      }
    ];
  } 

  

  // Profile
  static Future<bool> logIn({
    required String email,
    required String password,
  }) async {
    print('Logging in...');

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

    if (response.statusCode == 200) { //got a response
      print("success");
      return true;
      
    } else { //401 - unauthorized
      print('Error: ${response.statusCode}');
      return false;
    }

  }

  static Future<bool> signUp({
    required String name,
    required String age,
    required String major,
    required String email,
    required String password,
    required bool discoverable,
  }) async {
    print('Signing up...');

    final response = await dio.post(
      "/signup",
      data: FormData.fromMap({
        'username': name,
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

  static Future<bool> updateProfile({ //TODO: age/bio working
    required String userId,
    required String name,
    required String bio,
    required String major,
    required bool discoverable,
  }) async {
    print('Updating profile for $userId');

    final response = await dio.post(
      "/update_user",
      data: FormData.fromMap({
        'email':userId,
        'new_username':name,
        'new_major':major,
        'new_age':bio,
        'new_private_bool':discoverable,
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

  static Future<bool> deleteProfile({
    required String userId,
  }) async {
    print('Deleted profile for $userId');
    return true;
  }

  // Extra
  static Future<List<Map<String, dynamic>>> getSharedClasses({ //TODO: convert response to data
  required String userId,
  required String otherId,
  }) async {
    print('Getting shared classes info for $userId and $otherId');

  //   final response = await dio.post(
  //     "/update_user",
  //     data: FormData.fromMap({
  //       'email':userId,
  //       'new_username':name,
  //     }),
  //     options: Options(
  //     extra: {
  //       'withCredentials': true,
  //     },
  //   ),
  // );

    //print()


    return [
      {
        'code': 'CS101',
        'name': 'Intro to Computer Science',
        'days': ['M', 'W', 'F'],
        'startTime': '10:00AM',
        'endTime': '11:20AM',
      }
    ];
  }

  static Future<List<Map<String, String>>> getFriendsInClass({
    required String userId,
    required String courseCode,
  }) async {
    print('Getting friends in $courseCode for $userId');

    

    return [
      {
        'name': 'Alex Rivera',
      }
    ];
  }

  static Future<Map<String, dynamic>> getUserProfile({
    required String userId,
  }) async {
    print('Getting profile info for $userId');

    final response = await dio.post(
      "/get_user_info",
      data: FormData.fromMap({
        'email':userId,
      }),
      options: Options(
      extra: {
        'withCredentials': true,
      },
    ),
    );
    print(response.data);
    var user = response.data['user'];
    print("formatted:");
    return {
      'name': user['username'],
      'email': user['email'],
      'age': user['age'],
      'major': user['major'],
      'bio': 'CS student who loves hiking and cooking!',
      'discoverable': user['discoverable'],
    };

    return {
      'name': 'Alex Rivera',
      'email': 'alex.rivera@example.com',
      'age': '21',
      'major': 'Computer Science',
      'bio': 'CS student who loves hiking and cooking!',
      'discoverable': true,
    };
    

    return {
      'name': response.data['username'],
      'email': user['email'],
      'age': user['age'],
      'major': response.data['major'],
      'bio': 'CS student who loves hiking and cooking!',
      'discoverable': user['discoverable'],
    };
  }



  static Future<List<Map<String, dynamic>>> getAllClasses({
    required String userId,
  }) async {
    var test = await getUserProfile(userId: userId);

    print('Getting all classes for $userId');
    final response = await dio.post(
      "/get_user_info",
      data: FormData.fromMap({
        'email':userId,
      }),
      options: Options(
      extra: {
        'withCredentials': true,
      },
    ),
    );
    print(response.data);
    List<Map<String, String>> all = [];
      //print(response.data);
    if(response.data['success']){
      var user = response.data['user'];
      var courses = user['courses'];
      for(String course in courses){
        Map<String, String> c = {};
        c['code'] = 'code';
        c['name'] = 'name';
        c['days'] = 'days';
        c['startTime'] = 'start';
        c['endTime'] = 'end';
        all.add(user);
      }
    }

    print(all);

    return [
      {
        'code': 'CS101',
        'name': 'Intro to Computer Science',
        'days': ['M', 'W', 'F'],
        'startTime': '10:00AM',
        'endTime': '11:20AM',
      },
      {
        'code': 'MATH201',
        'name': 'Calculus II',
        'days': ['T', 'Th'],
        'startTime': '1:00PM',
        'endTime': '2:15PM',
      },
    ];
  }
}