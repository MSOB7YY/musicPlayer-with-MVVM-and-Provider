// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../utilities/colors.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({Key? key}) : super(key: key);

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ArtistModel>>(
        future: _audioQuery.queryArtists(
          sortType: ArtistSortType.ARTIST,
          orderType: OrderType.ASC_OR_SMALLER,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.bottomRight,
                    colors: [
                      background1,
                      background2,
                    ],
                  ),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (item.data!.isEmpty) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.bottomRight,
                  colors: [
                    background1,
                    background2,
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  "Nothing found!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.bottomRight,
                  colors: [
                    background1,
                    background2,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: ListView.separated(
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      leading: QueryArtworkWidget(
                        artworkBorder: const BorderRadius.all(
                          Radius.zero,
                        ),
                        artworkHeight: 60,
                        artworkWidth: 60,
                        artworkFit: BoxFit.fill,
                        nullArtworkWidget: Image.asset(
                          "assets/artist4.jpg",
                          width: 60,
                          fit: BoxFit.fitWidth,
                        ),
                        id: item.data![index].id,
                        type: ArtworkType.ARTIST,
                      ),
                      title: Text(
                        item.data![index].artist,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        "${item.data![index].numberOfAlbums.toString()} Albums | ${item.data![index].numberOfTracks.toString()} Tracks",
                        style: const TextStyle(
                          color: Color.fromARGB(151, 255, 255, 255),
                        ),
                      ),
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ArtistHomeScreen(
                                artistModel: item.data![index]),
                          ),
                        ),
                      },
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider(
                      color: Colors.white,
                    );
                  },
                  itemCount: item.data!.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
