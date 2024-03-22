import 'package:flutter/material.dart';
import '../utils/theme_data.dart';
import '../widgets/layout/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor, appBar: SearchAppBar());
  }
}
