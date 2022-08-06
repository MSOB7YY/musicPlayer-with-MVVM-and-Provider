import 'package:flutter/material.dart';
import 'package:music_player_app/search/view_model/search_provider.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String? value) {
        context.read<SearchProvider>().onChangeFunction(value, context);
      },
      style: TextStyle(
        color: kWhite,
      ),
      controller: context.read<SearchProvider>().searchController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            Icons.close,
            color: kWhite,
          ),
          onPressed: () {
            context.read<SearchProvider>().searchController.clear();
          },
        ),
        filled: true,
        fillColor: const Color.fromARGB(55, 255, 255, 255),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: 'Search Library',
        hintStyle: const TextStyle(
          height: 0.5,
          color: Color.fromARGB(213, 255, 255, 255),
        ),
      ),
    );
  }
}
