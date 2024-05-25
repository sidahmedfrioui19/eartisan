import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/user/user.dart';
import 'package:profinder/pages/user/customer_appointements.dart';
import 'package:profinder/pages/user/professional_appointments.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/top_bar.dart';
import 'package:profinder/widgets/cards/snapshot_error.dart';
import 'package:profinder/widgets/navigation/burger_menu.dart';
import 'package:profinder/widgets/progress/loader.dart';

class AppointementsPage extends StatefulWidget {
  const AppointementsPage({super.key});

  @override
  State<AppointementsPage> createState() => _AppointementsPageState();
}

class _AppointementsPageState extends State<AppointementsPage>
    with SingleTickerProviderStateMixin {
  late Future<UserEntity> _userFuture;
  late TabController _tabController;

  final AuthenticationService auth = AuthenticationService();

  late String? userRole = '';

  Future<void> getCurrentUserRole() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? role = await secureStorage.read(key: 'role');

    userRole = role;
    setState(() {
      print(role);
      _tabController = TabController(
        length: userRole == 'customer' ? 1 : 2,
        vsync: this,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
    getCurrentUserRole();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<UserEntity> _loadUser() async {
    try {
      final UserEntity user = await auth.fetchUserData();
      return user;
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: BurgerMenu(),
      appBar: TopBar(
        title: "Appointements",
      ),
      body: FutureBuilder<UserEntity>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoading();
          } else if (snapshot.hasError) {
            return SnapshotErrorWidget(error: snapshot.error);
          } else if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  if (userRole != 'customer')
                    TabBar(
                      indicatorColor: AppTheme.primaryColor,
                      labelColor: AppTheme.primaryColor,
                      unselectedLabelColor: Colors.black,
                      controller: _tabController,
                      tabs: [
                        if (userRole != 'customer')
                          Tab(
                            text: 'Customers',
                          ),
                        Tab(
                          text: 'Professionals',
                        ),
                      ],
                      labelPadding: EdgeInsets.symmetric(horizontal: 0),
                      labelStyle: TextStyle(fontSize: 12),
                    ),
                  if (userRole != 'customer') SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        if (userRole != 'customer') ProfessionalAppointments(),
                        CustomerAppointments(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('No user data available.'),
            );
          }
        },
      ),
    );
  }
}
