import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/provider/preferences_provider.dart';
import 'package:restaurant/provider/schedulling_provider.dart';

class Setting extends StatelessWidget {
  static const routeName = '/setting';

  const Setting({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Setting"),
      ),
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Daily reminder'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: provider.isDailyReminderActive,
                        onChanged: (value) async {
                          scheduled.scheduledRestaurant(value);
                          provider.enableDailyReminder(value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
