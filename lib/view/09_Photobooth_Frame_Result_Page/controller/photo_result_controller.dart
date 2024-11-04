import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PhotoResultController{
  Future<String?> fetchPhotoURl(String? filename) async {
    String imagePath = 'photos/$filename.png';
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error fetching image URL: $e');
      return null;
    }
  }

  Future<void> sendEmail(String email, String filename)async{
    final String? urlPhoto = await fetchPhotoURl(filename);
    // String username = 'boothbliss123@gmail.com';
    // String password = 'phjq znwg vzxc yeke';
    // final smtpServer = gmail(username, password);
    //
    // // Create the email message
    // final message = Message()
    //   ..from = Address(username, 'BoothBliss')
    //   ..recipients.add(email) // Replace with the recipient's email
    //   ..subject = 'Booth Bliss Photo Result'
    //   ..text = 'Here is the result of your photo\n$url\nThank you for trusting BoothBliss!\n*Link expires in 7 days';
    //
    // try {
    //   // Send the email
    //   final sendReport = await send(message, smtpServer);
    //   print('Message sent: $sendReport');
    // } on MailerException catch (e) {
    //   print('Message not sent. \n$e');
    // }

    const String serviceId = 'service_n2p8g5v';
    const String templateId = 'template_eloqk0j';
    const String userId = 'MKpuXgCtkJGkUCnDY';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_email': email,
          'url': urlPhoto,
        },
      }),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully!');
    } else {
      print('Failed to send email: ${response.body}');
    }





  }
}