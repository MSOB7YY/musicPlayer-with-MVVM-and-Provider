// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'favorites_function.dart';

class Buttons extends StatefulWidget {
  Buttons({Key? key, this.id}) : super(key: key);
  dynamic id;
  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lastIndex = DbFav.favsong.indexWhere(
      (element) => element == widget.id,
    );
    final checkIndex = DbFav.favsong.contains(
      widget.id,
    );

    if (checkIndex == true) {
      return IconButton(
        onPressed: () async {
          await DbFav.deletion(lastIndex, context);
          setState(() {});
          const snackbar = SnackBar(
            content: Text(
              'remove from favourites',
            ),
          );
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        },
        icon: const Icon(
          Icons.favorite,
          color: Colors.amber,
        ),
      );
    }
    return IconButton(
      onPressed: () async {
        await DbFav.addSongs(widget.id, context);

        setState(() {});
        const snackBar = SnackBar(content: Text('add to favorites '));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      icon: const Icon(Icons.favorite_border_outlined, color: Colors.grey),
    );
  }
}
