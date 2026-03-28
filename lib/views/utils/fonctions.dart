import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';





log(dynamic x)
{
  if(kDebugMode)
  {
    print(x);
  }
}




String decimail_format(int a)
{
  switch(a)
  {
    case 0:
      return "00";
    case 1:
      return "01";
    case 2:
      return "02";
    case 3:
      return "03";
    case 4:
      return "04";
    case 5:
      return "05";
    case 6:
      return "06";
    case 7:
      return "07";
    case 8:
      return "08";
    case 9:
      return "09";
    default:
      return a.toString();
  }
}
String date_time_now()
{
  DateTime now=DateTime.now();
  return "${decimail_format(now.day)}/${decimail_format(now.month)}/${now.year} - ${decimail_format(now.hour)} : ${decimail_format(now.minute)}";
}



String truncateText(String text, {int maxLength = 12}) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return "${text.substring(0, maxLength)}...";
  }
}


Future<void> openWebsite({required String lien}) async {
  final Uri url = Uri.parse(lien);
  //  final Uri url = Uri.parse('https://www.google.com');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Impossible d’ouvrir $url');
  }
}

Future<void> launchPhone({required String tel }) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: tel);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    // Affichez un message d'erreur ou un SnackBar si l'appel ne peut pas être lancé
    print('Impossible de lancer l\'appel.');
  }
}

Future<void> callNumber({required phoneNumber}) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (!await launchUrl(launchUri)) {
    throw Exception('Impossible de lancer l\'appel vers $phoneNumber');
  }
}


Future<void> launchEmail({required mail}) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: mail,
    queryParameters: {
      'subject': 'Demande l\'information',
      'body': '',
    },
  );
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    print('Impossible de lancer l\'e-mail.');
  }
}


Future<void> sendMail({required String email}) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query: Uri.encodeFull('subject=Demande d\'informations&body=Salut, '),
  );

  if (!await launchUrl(emailUri)) {
    throw Exception('Impossible d\'ouvrir le client mail');
  }
}