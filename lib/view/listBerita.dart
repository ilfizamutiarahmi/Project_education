// import 'package:flutter/material.dart';
// import 'package:project_education/view/login.dart';
// import 'package:project_education/view/user_profile.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:project_education/model/api_service.dart';
//
//
// Future<String?> getUserName() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString('user_name');
// }
//
// Future<String?> getUserEmail() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString('user_email');
// }
//
// class ListBerita extends StatefulWidget {
//   final int userId;
//   final ApiService apiService;
//
//   const ListBerita({Key? key, required this.userId, required this.apiService}) : super(key: key);
//
//   @override
//   State<ListBerita> createState() => _ListBeritaState();
// }
//
// class _ListBeritaState extends State<ListBerita> {
//   String? userName;
//   String? userEmail;
//
//
//   @override
//   void initState() {
//     _loadUserInfo();
//     super.initState();
//   }
//
//   Future<void> _loadUserInfo() async {
//     userName = await getUserName();
//     userEmail = await getUserEmail();
//     setState(() {});
//   }
//
//   // void _goToUserProfile() {
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => UserProfile(
//   //         userId: widget.userId,
//   //         userName: userName!,
//   //         userEmail: userEmail!,
//   //         apiService: ApiService(baseUrl: 'http://127.0.0.1:8000/api'),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome to List News Page'),
//         backgroundColor: Colors.blue,
//         actions: [
//           InkWell(
//             onTap: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()));
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset("image/logout.png", height: 50),
//             ),
//           ),
//           InkWell(
//             // onTap: _goToUserProfile,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset("image/avatar.png", height: 50),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(widget.userId.toString())
//           ],
//         ),
//       ),
//     );
//   }
// }
