import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactsSection extends StatelessWidget {
  const ContactsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Contact me',
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: () =>
                        launchUrlString('mailto:rizalhadiyansah@gmail.com'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: const Icon(Icons.email),
                    label: const Text('rizalhadiyansah@gmail.com'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () =>
                        launchUrlString('https://wa.me/6289660952861'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: Icon(MdiIcons.whatsapp),
                    label: const Text('+62 896-6095-2861'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () => launchUrlString('sms:6289660952861'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: const Icon(Icons.chat),
                    label: const Text('+62 896-6095-2861'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () => launchUrlString('tel:6289660952861'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    icon: const Icon(Icons.phone),
                    label: const Text('+62 896-6095-2861'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
