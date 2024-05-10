import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/usage_condition/usage_condition.dart';
import 'package:profinder/services/usage_conditions/usage_conditions.dart';
import 'package:profinder/widgets/cards/snapshot_error.dart';

import '../../utils/theme_data.dart';
import '../../widgets/appbar/overlay_top_bar.dart';

class ConditionsOverlay extends StatefulWidget {
  const ConditionsOverlay({Key? key}) : super(key: key);

  @override
  State<ConditionsOverlay> createState() => _ConditionsOverlayState();
}

class _ConditionsOverlayState extends State<ConditionsOverlay> {
  late Future<List<UsageCondition>> _conditions;

  final UsagConditionsService _conditionsService = UsagConditionsService();

  Future<void> _loadConditions() async {
    _conditions = _conditionsService.fetch();
  }

  @override
  void initState() {
    super.initState();
    _loadConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: "Terms and usage conditions",
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<UsageCondition>>(
          future: _conditions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: SnapshotErrorWidget(error: snapshot.error),
              );
            } else if (snapshot.hasData) {
              final conditions = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Welcome to E-Artisan.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "The following terms of use govern the use of this application. By accessing this application, we assume that you accept these terms of use in full. Do not continue to use the application if you do not accept all the terms and conditions stated on this page.",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "The following terminology applies to these terms of use, the privacy statement, and the disclaimer, and all agreements: ‘Client’, ‘You’, and ‘Your’ refer to you, the person accessing this application and accepting the Company’s terms and conditions. " +
                          "‘The Company’, ‘Ourselves’, ‘We’, ‘Our’, and ‘Us’, refer to our company. ‘Party’, ‘Parties’, or ‘Us’, refers to both the Client and ourselves. All terms refer to the offer, acceptance, and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner, whether by formal meetings of a fixed duration, or otherwise, for the express purpose of meeting the Client’s needs in respect of the provision of the Company’s stated services/products, in accordance with and subject to the law of France.",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "The use of this application is subject to French laws and regulations.",
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: conditions.length,
                      itemBuilder: (context, index) {
                        final condition = conditions[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              condition.content,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
