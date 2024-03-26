import 'package:flutter/material.dart';

class HorizontalList<T> extends StatelessWidget {
  final Future<List<T>> future;
  final Widget Function(T item) itemBuilder;
  final String errorMessage;

  const HorizontalList({
    Key? key,
    required this.future,
    required this.itemBuilder,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 100, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return itemBuilder(snapshot.data![index]);
              },
            ),
          );
        } else {
          return Center(child: Text(errorMessage));
        }
      },
    );
  }
}
