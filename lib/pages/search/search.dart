import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/generic_search/generic_search_request.dart';
import 'package:profinder/models/generic_search/generic_search_response.dart';
import 'package:profinder/pages/authentication/login.dart';
import 'package:profinder/pages/home/service_detail.dart';
import 'package:profinder/pages/home/widgets/post/book_appointment.dart';
import 'package:profinder/pages/messages/chat_room.dart';
import 'package:profinder/services/generic_search/generic_search.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/cards/stated_avatar.dart';
import '../../utils/theme_data.dart';
import '../../widgets/inputs/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GenericSearch search = GenericSearch();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  GenericSearchResponse? response;
  List<String>? recentSearches;
  String? jwtToken;

  Future<void> _getCurrentUserToken() async {
    final String? token = await _secureStorage.read(key: 'jwtToken');
    jwtToken = token;
  }

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
    _getCurrentUserToken();
  }

  void _saveRecentSearch(String keyword) async {
    recentSearches!.insert(0, keyword);
    await _secureStorage.write(
        key: 'recentSearches', value: recentSearches!.join(','));
    setState(() {});
  }

  void _loadRecentSearches() async {
    String? storedSearches = await _secureStorage.read(key: 'recentSearches');
    setState(() {
      recentSearches = storedSearches != null && storedSearches != ''
          ? storedSearches.split(',')
          : [];
    });
  }

  void _removeRecentSearch(int index) async {
    await _secureStorage.write(key: 'recentSearches', value: '');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: SearchAppBar(
        onSubmitted: (keyword) async {
          GenericSearchRequest req = GenericSearchRequest(
            keyword: keyword,
          );
          try {
            response = await search.post(req);
            setState(() {
              _saveRecentSearch(keyword);
            });
          } catch (e) {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'An error has occured, try again$e',
                  ), // Confirmation message
                  duration:
                      Duration(seconds: 2), // Adjust the duration as needed
                ),
              );
            });
          }
        },
      ),
      body: response != null
          ? DefaultTabController(
              length: 3, // Number of tabs
              child: Column(
                children: <Widget>[
                  TabBar(
                    labelColor: AppTheme.textColor,
                    indicatorColor: AppTheme.primaryColor,
                    tabs: [
                      Tab(text: 'Services (${response!.services.length})'),
                      Tab(text: 'Professionals (${response!.artisans.length})'),
                      Tab(text: 'Customers (${response!.clients.length})'),
                    ],
                    labelPadding: EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildServicesTab(),
                        _buildArtisansTab(),
                        _buildClientsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : recentSearches != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Recent searches (${recentSearches!.length})',
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount: recentSearches!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                if (recentSearches != null &&
                                    recentSearches!.isNotEmpty) {
                                  setState(() {
                                    recentSearches!.removeAt(index);
                                    _removeRecentSearch(index);
                                  });
                                }
                              },
                            ),
                            title: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(recentSearches![index])),
                            onTap: () async {
                              GenericSearchRequest req = GenericSearchRequest(
                                keyword: recentSearches![index],
                              );
                              try {
                                response = await search.post(req);
                                setState(() {});
                              } catch (e) {
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'An error has occured, try again',
                                      ),
                                      duration: Duration(
                                        seconds: 2,
                                      ),
                                    ),
                                  );
                                });
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                )
              : Center(
                  child: Icon(Icons.format_list_bulleted),
                ),
    );
  }

  Widget _buildServicesTab() {
    return ListView.builder(
      itemCount: response!.services.length,
      itemBuilder: (context, index) {
        final service = response!.services[index];
        return GestureDetector(
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              StatedAvatar(
                                  imageUrl: service.user.profilePicture),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${service.user.firstname} ${service.user.lastname}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '@${service.user.username}',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => {
                              if (jwtToken != null)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CreateAppointmentPage(
                                        serviceId: service.serviceId,
                                        professionalId: service.user.userId,
                                      ),
                                    ),
                                  ),
                                }
                              else
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  ),
                                }
                            },
                            icon: Icon(
                              FluentIcons.calendar_12_regular,
                            ),
                          ),
                          IconButton(
                            onPressed: () => {
                              if (jwtToken != null)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatRoom(
                                        available: true,
                                        firstname: service.user.firstname,
                                        lastname: service.user.lastname,
                                        pictureUrl:
                                            service.user.profilePicture!,
                                        user_id: service.user.userId,
                                      ),
                                    ),
                                  ),
                                }
                              else
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  ),
                                }
                            },
                            icon: Icon(
                              FluentIcons.send_16_regular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Description: ${service.description.substring(0, 80)}...',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceDetail(
                  serviceId: service.serviceId,
                  loggedIn: (jwtToken != null) ? true : false,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildArtisansTab() {
    return ListView.builder(
      itemCount: response!.artisans.length,
      itemBuilder: (context, index) {
        final artisan = response!.artisans[index];
        return Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      artisan.profilePicture ??
                                          Constants.defaultAvatar),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  '${artisan.firstname} ${artisan.lastname}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '@${artisan.username}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 16),
                                FilledAppButton(
                                  icon: Icons.close,
                                  text: "Close",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              artisan.profilePicture ?? Constants.defaultAvatar,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${artisan.firstname} ${artisan.lastname}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              if (artisan.phoneNumber != '')
                                Row(
                                  children: [
                                    Icon(
                                      FluentIcons.phone_12_filled,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${artisan.phoneNumber}',
                                    ),
                                  ],
                                ),
                              SizedBox(height: 4),
                              if (artisan.address != null &&
                                  artisan.address != '')
                                Row(
                                  children: [
                                    Icon(
                                      FluentIcons.location_12_filled,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${artisan.address}',
                                    ),
                                  ],
                                ),
                              if (artisan.address == null ||
                                  artisan.address == '')
                                Text(
                                  'No Location Provided',
                                ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (jwtToken != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatRoom(
                                available: true,
                                firstname: artisan.firstname,
                                lastname: artisan.lastname,
                                pictureUrl: artisan.profilePicture,
                                user_id: artisan.userId,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                      },
                      icon: Icon(FluentIcons.send_16_regular),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildClientsTab() {
    return ListView.builder(
      itemCount: response!.clients.length,
      itemBuilder: (context, index) {
        final client = response!.clients[index];
        return Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      client.profilePicture ??
                                          Constants.defaultAvatar),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  '${client.firstname} ${client.lastname}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '@${client.username}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 16),
                                FilledAppButton(
                                  icon: Icons.close,
                                  text: "Close",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              client.profilePicture ?? Constants.defaultAvatar,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${client.firstname} ${client.lastname}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              if (client.phoneNumber != '')
                                Row(
                                  children: [
                                    Icon(
                                      FluentIcons.phone_12_filled,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${client.phoneNumber}',
                                    ),
                                  ],
                                ),
                              SizedBox(height: 4),
                              if (client.address != null &&
                                  client.address != '')
                                Row(
                                  children: [
                                    Icon(
                                      FluentIcons.location_12_filled,
                                      size: 18,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${client.address}',
                                    ),
                                  ],
                                ),
                              if (client.address == null ||
                                  client.address == '')
                                Text(
                                  'No Location Provided',
                                ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (jwtToken != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatRoom(
                                available: true,
                                firstname: client.firstname,
                                lastname: client.lastname,
                                pictureUrl: client.profilePicture,
                                user_id: client.userId,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                      },
                      icon: Icon(FluentIcons.send_16_regular),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
