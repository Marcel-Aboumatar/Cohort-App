class BackendService {

  // Friends
  static Future<bool> sendFriendRequest({
    required String fromUserId,
    required String toEmail,
  }) async {
    print('Sending friend request from $fromUserId to $toEmail');
    return true;
  }

  static Future<bool> acceptFriendRequest({
    required String requestId,
  }) async {
    print('Accepting request $requestId');
    return true;
  }

  static Future<bool> declineFriendRequest({
    required String requestId,
  }) async {
    print('Declining request $requestId');
    return true;
  }

  static Future<bool> removeFriend({
    required String userId,
    required String friendId,
  }) async {
    print('Removing friend $friendId for user $userId');
    return true;
  }

  // Get Friends Info
  static Future<List<Map<String, String>>> getIncomingFriendRequests({
    required String userId,
  }) async {
    print('Getting incoming friend requests');

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

    return [
      {
        'name': 'Alex Rivera',
        'email': 'alex.rivera@example.com',
        'age': '21',
        'major': 'Computer Science',
      }
    ];
  }

  // schedule import/export
  static Future<bool> importSchedule() async {
    print('Importing schedule from Webadvisor');
    return true;
  }

  static Future<bool> exportScheduleGoogle({
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

    return [
      {
        'name': 'Alex Rivera',
        'email': 'alex.rivera@example.com',
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

    return true;
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

    return true;
  }

  static Future<bool> updateProfile({
    required String userId,
    required String name,
    required String bio,
    required String major,
    required bool discoverable,
  }) async {
    print('Updating profile for $userId');
    return true;
  }

  static Future<bool> deleteProfile({
    required String userId,
  }) async {
    print('Deleted profile for $userId');
    return true;
  }

  // Extra
  static Future<List<Map<String, dynamic>>> getSharedClasses({
  required String userId,
  required String otherId,
  }) async {
    print('Getting shared classes info for $userId and $otherId');

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

    return {
      'name': 'Alex Rivera',
      'email': 'alex.rivera@example.com',
      'age': '21',
      'major': 'Computer Science',
      'bio': 'CS student who loves hiking and cooking!',
      'discoverable': true,
    };
  }

  static Future<List<Map<String, dynamic>>> getAllClasses({
    required String userId,
  }) async {
    print('Getting all classes for $userId');

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