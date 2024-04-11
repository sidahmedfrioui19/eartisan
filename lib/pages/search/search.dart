import 'package:flutter/material.dart';
import 'package:profinder/models/generic_search/generic_search_request.dart';
import 'package:profinder/models/generic_search/generic_search_response.dart';
import 'package:profinder/services/generic_search/generic_search.dart';
import '../../utils/theme_data.dart';
import '../../widgets/inputs/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GenericSearch search = GenericSearch();
  GenericSearchResponse? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: SearchAppBar(
        onSubmitted: (keyword) async {
          GenericSearchRequest req = GenericSearchRequest(
            keyword: keyword,
          );
          response = await search.post(req);
          setState(() {});
        },
      ),
      body: response != null
          ? SingleChildScrollView(
              child: Column(children: [
                // Display Artisans
                if (response!.artisans.isNotEmpty)
                  Text(
                    'Artisans',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (response!.artisans.isNotEmpty)
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: response!.artisans.length,
                      itemBuilder: (context, index) {
                        Artisan artisan = response!.artisans[index];
                        // Display Artisan details here (username, firstname, lastname, etc.)
                        return ListTile(
                          title: Text(artisan.username),
                          subtitle: Text(
                              '${artisan.firstname} <span class="math-inline">\{artisan\.lastname\}'),
                        );
                      }),
              ]),
            )
          : Container(),
    );
  }
}
