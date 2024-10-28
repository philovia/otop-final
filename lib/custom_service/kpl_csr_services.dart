// import 'dart:convert';
// import 'dart:core';

// import 'package:otop_front/custom_service/otop_request_handler.dart';

// // import '../../../shared/sesionmanagement/gettoken/gettoken.dart';

// class CSRServices {
//   final token = getToken();

//   Future<ResponseModel> getOutgoingCalls({
//     String? dateTime,
//     String? phone,
//     String? callStatus,
//     String? product,
//     String? caller,
//     String? status,
//   }) async {
//     return await requestMidleware1(
//       url:
//           'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/add/outgoing/call',
//       headers: <String, String>{
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'dateTime': dateTime,
//         'phone': phone,
//         'callStatus': callStatus,
//         'product': product,
//         'caller': caller,
//         'status': status,
//       }),
//       failedCode: 400,
//     );
//   }

//   Future<ResponseModel> getCallStatus() async {
//     return await requestMidleware1(
//         url:
//             'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/call/status/summary',
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json; UTF-8'
//         },
//         failedCode: 400);
//   }

//   Future<ResponseModel> getAllNetworks() async {
//     return await requestMidleware1(
//       url:
//           'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/all/network',
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       },
//       failedCode: 400,
//     );
//   }

//   Future<ResponseModel> getAllCalls(
//       {int page = 1, String perPage = '10'}) async {
//     return await requestMidleware1(
//       url:
//           'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/all/call?perPage=$perPage&page=$page',
//       headers: <String, String>{
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json; charset=UTF-8'
//       },
//       failedCode: 400,
//     );
//   }

//   Future<ResponseModel> getAllStatus() async {
//     return await requestMidleware1(
//       url:
//           'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/all/status',
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       },
//       failedCode: 400,
//     );
//   }

//   Future<ResponseModel> getAllConcerns() async {
//     return await requestMidleware1(
//         url:
//             'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/all/concern',
//         headers: <String, String>{'Content-Type': 'application/json; UTF-8'},
//         failedCode: 400);
//   }

//   Future<ResponseModel> getSummaryWeekly() async {
//     return await requestMidleware1(
//         url:
//             'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/call/weekly/summary',
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json; UTF-8'
//         },
//         failedCode: 400);
//   }

//   Future<ResponseModel> getSummaryTicketStatus() async {
//     return await requestMidleware1(
//         url:
//             'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/ticket/summary?filter=all',
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json; UTF-8'
//         },
//         failedCode: 400);
//   }

//   Future<ResponseModel> getSummaryChannels() async {
//     return await requestMidleware1(
//         url:
//             'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/ticket/channel/summary?filter=all',
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json; UTF-8'
//         },
//         failedCode: 400);
//   }

//   Future<ResponseModel> getSummaryCallLogs() async {
//     return await requestMidleware1(
//         url:
//             'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/call/summary?filter=all',
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json; UTF-8'
//         },
//         failedCode: 400);
//   }

//   Future<ResponseModel> addUser({
//     String? firstname,
//     String? middlename,
//     String? lastname,
//     String? address,
//     String? birthdate,
//     String? contact,
//     String? email,
//     String? username,
//     String? password,
//     String? role,
//   }) async {
//     return await requestMidleware(
//       url:
//           'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/add/user',
//       headers: <String, String>{
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'firstname': firstname,
//         'middlename': middlename,
//         'lastname': lastname,
//         'address': address,
//         'dateofbirth': birthdate,
//         'contact': contact,
//         'email': email,
//         'username': username,
//         'password': password,
//         'role': role,
//       }),
//       failedCode: 400,
//     );
//   }

//   Future<ResponseModel> getAllUser() async {
//     return requestMidleware1(
//         url:
//             'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/all/user',
//         headers: <String, String>{
//           'Authorization': '$token',
//           'Content-Type': 'application/json; UTF-8'
//         },
//         failedCode: 400);
//   }

//   Future<ResponseModel> fetchUser(String userId) async {
//     return requestMidleware1(
//       url:
//           'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/user?id=$userId',
//       headers: <String, String>{
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       failedCode: 400,
//     );
//   }

//   Future<ResponseModel> fetchUserProfile() async {
//     final String? userId = getID();
//     return requestMidleware1(
//       url:
//           'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/user?id=$userId',
//       headers: <String, String>{
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       failedCode: 400,
//     );
//   }

//   Future<ResponseModel> updateUserStatus(String userId, String status) async {
//     return await requestMidleware2(
//         url:
//             'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/update/status/user?Id=$userId',
//         headers: <String, String>{
//           'Authorization': '$token',
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//         body: jsonEncode(<String, dynamic>{'status': status}),
//         failedCode: 400);
//   }

//   Future<ResponseModel> updateTicket(
//     String ticketId,
//     String status,
//     String detail,
//     String received,
//     String forEscalation,
//     String escalatedTo,
//     String feedback,
//     String assessment,
//     String remarks,
//   ) async {
//     return await requestMidleware2(
//         // url: 'http://127.0.0.1:8000/api/public/v1/update/ticket?id=$ticketId',
//         url:
//             'https://dev-api-janus.fortress-asya.com:18002/api/public/v1/update/ticket?id=$ticketId',
//         headers: <String, String>{
//           'Authorization': '$token',
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//         body: jsonEncode(<String, dynamic>{
//           'status': status,
//           'detail': detail,
//           'received': received,
//           'forEscalation': forEscalation,
//           'escalationTo': escalatedTo,
//           'feedback': feedback,
//           'assessment': assessment,
//           'remarks': remarks
//         }),
//         failedCode: 400);
//   }
// }
