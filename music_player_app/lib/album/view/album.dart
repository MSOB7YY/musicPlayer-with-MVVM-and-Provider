// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../utilities/colors.dart';
import 'album_home_screen.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);
  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 42, 11, 99),
              Color.fromARGB(235, 48, 14, 34),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: FutureBuilder<List<AlbumModel>>(
            future: audioQuery.queryAlbums(
              sortType: AlbumSortType.NUM_OF_SONGS,
              orderType: OrderType.DESC_OR_GREATER,
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
                padding: const EdgeInsets.only(top: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: item.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        height: MediaQuery.of(context).size.height / 6,
                        color: const Color.fromARGB(57, 253, 253, 251),
                        child: QueryArtworkWidget(
                          artworkBorder: const BorderRadius.all(
                            Radius.zero,
                          ),
                          artworkHeight: double.infinity,
                          artworkWidth: double.infinity,
                          artworkFit: BoxFit.fill,
                          nullArtworkWidget: Image.asset(
                            "assets/album.jpg",
                            fit: BoxFit.fitWidth,
                          ),
                          id: item.data![index].id,
                          type: ArtworkType.ALBUM,
                        ),
                      ),
                      subtitle: Container(
                        height: MediaQuery.of(context).size.height / 12,
                        color: const Color.fromARGB(162, 168, 167, 162),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: ListTile(
                            title: Text(
                              item.data![index].album,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "songs: ${item.data![index].numOfSongs.toString()}",
                            ),
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => AlbumHomeScreen(
                              albumModel: item.data![index],
                            ),
                          ),
                        ),
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
