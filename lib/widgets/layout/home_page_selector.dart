import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class HomePageSelector extends StatefulWidget {
  const HomePageSelector({Key? key}) : super(key: key);

  @override
  _HomePageSelectorState createState() => _HomePageSelectorState();
}

class _HomePageSelectorState extends State<HomePageSelector> {
  bool servicesSelected = true;
  bool demandesSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            child: TextButton(
              onPressed: () {
                setState(() {
                  servicesSelected = true;
                  demandesSelected = false;
                });
              },
              child: Text(
                "Services",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: servicesSelected
                      ? AppTheme.primaryColor
                      : AppTheme.secondaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextButton(
              onPressed: () {
                setState(() {
                  servicesSelected = false;
                  demandesSelected = true;
                });
              },
              child: Text(
                "Demandes",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: demandesSelected
                      ? AppTheme.primaryColor
                      : AppTheme.secondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
