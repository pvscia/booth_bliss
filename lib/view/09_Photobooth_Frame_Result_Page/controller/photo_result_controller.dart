import 'package:firebase_storage/firebase_storage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

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
    final String? url = await fetchPhotoURl(filename);
    String username = 'boothbliss123@gmail.com';
    String password = 'phjq znwg vzxc yeke';
    final smtpServer = gmail(username, password);

    // Create the email message
    final message = Message()
      ..from = Address(username, 'BoothBliss')
      ..recipients.add(email) // Replace with the recipient's email
      ..subject = 'Booth Bliss Photo Result'
      ..text = 'Here is the result of your photo\n$url\nThank you for trusting BoothBliss!';

    try {
      // Send the email
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent. \n$e');
    }

  }
}