import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ShowLanguage extends StatelessWidget{
  const ShowLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      height: 500,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    translate('common.select_language'),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.close,color: Colors.white,))
                ],
              ),
            ),
            languageCard("English", "🇺🇸", "en"),
            const Divider(
              endIndent: 10,
              indent: 10,
              height: 1,
              color: Colors.white30,
            ),
            languageCard("русский", "🇷🇺", "ru"),
            const Divider(
              endIndent: 10,
              indent: 10,
              height: 1,
              color: Colors.white30,
            ),
            languageCard("Española", "🇪🇸", "es"),
            const Divider(
              endIndent: 10,
              indent: 10,
              height: 1,
              color: Colors.white30,
            ),
            languageCard("فارسی", "🇮🇷", "fa"),
            const Divider(
              endIndent: 10,
              indent: 10,
              height: 1,
              color: Colors.white30,
            ),
            languageCard("हिंदी", "🇮🇳", "in"),
            const Divider(
              endIndent: 10,
              indent: 10,
              height: 1,
              color: Colors.white30,
            ),
            languageCard("Deutsch", "🇩🇪", "de"),
            const Divider(
              endIndent: 10,
              indent: 10,
              height: 1,
              color: Colors.white30,
            ),
            languageCard("Français", "🇫🇷", "fr"),
            const Divider(
              endIndent: 10,
              indent: 10,
              height: 1,
              color: Colors.white30,
            ),
            languageCard("नेपाली", "🇳🇵", "ne"),
            const Divider(
              endIndent: 10,
              indent: 10,
              height: 1,
              color: Colors.white30,
            ),
            languageCard("عربي", "🇦🇪", "ar"),
            const Divider(
              endIndent: 10,
              indent: 10,
              height: 1,
              color: Colors.white30,
            ),
            languageCard("Português", "🇵🇹", "pt"),
          ],
        ),
      ),
    );
  }

  Widget languageCard(String title, String flag, String language) {
    final storage = GetStorage();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      dense: false,
      visualDensity: VisualDensity.compact,
      leading: Text(
        flag,
        style: const TextStyle(fontSize: 20),
      ),
      trailing: language == storage.read("language")
          ? const Icon(
        Icons.check,
        color: Colors.white,
      )
          : const SizedBox.shrink(),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        final storage = GetStorage();
        storage.write("language", language);
        Get.updateLocale(Locale(language));
      },
    );
  }
  
}