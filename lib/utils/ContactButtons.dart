import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtons extends StatelessWidget {
  final String whatsappNumber;
  final String callNumber;
  final String initialMessage;

  const ContactButtons({
    super.key,
    required this.whatsappNumber,
    required this.callNumber,
     required this.initialMessage,
  });

  Future<void> _launchWhatsApp() async {
    final encodedMessage = Uri.encodeComponent(initialMessage);
    final uri = Uri.parse(
      'https://wa.me/$whatsappNumber?text=$encodedMessage',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  Future<void> _makePhoneCall() async {
    final uri = Uri.parse('tel:$callNumber');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch phone dialer';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // WhatsApp Button
        if(whatsappNumber.isNotEmpty)
        ElevatedButton.icon(
          icon: SvgPicture.asset(
            'assets/icons/WhatsApp.svg',
            width: 24,
            height: 24,
            // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), // Ensure white color if needed
          ),
          label: const Text('WhatsApp', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            try {
              await _launchWhatsApp();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $e')),
              );
            }
            // const url = "https://wa.me/1234567890"; // Replace with your number
            // if (await canLaunchUrl(Uri.parse(url))) {
            //   await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
            // } else {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text('Could not launch WhatsApp')),
            //   );
            // }
          },
        ),


        // Phone Call Button
        if(callNumber.isNotEmpty)
        Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.phone, color: Colors.white),
              label: const Text('Call Now', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                try {
                  await _makePhoneCall();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
            ),
            // const Text('Hello',  style: TextStyle(color: Colors.white))
          ],
        ),
      ],
    );
  }
}