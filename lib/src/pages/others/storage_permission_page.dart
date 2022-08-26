import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes/route_constants.dart';

class StoragePermissionPage extends StatelessWidget {
  final bool isPermanent;

  const StoragePermissionPage({Key? key, required this.isPermanent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'storage_permission.title'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  isPermanent
                      ? 'storage_permission.desc2'.tr()
                      : 'storage_permission.desc'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25.0),
              NeumorphicButton(
                onPressed: () async {
                  if (isPermanent) {
                    if (await Permission.storage.isGranted) {
                      Navigator.pushReplacementNamed(context, mainRoute);
                    } else {
                      await openAppSettings();
                    }
                  } else {
                    if (await Permission.storage.request().isGranted) {
                      Navigator.pushReplacementNamed(context, mainRoute);
                    }
                  }
                },
                child: Text(
                  isPermanent
                      ? 'storage_permission.open_settings'.tr()
                      : 'storage_permission.allow_access'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
