import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mappbox_app/models/suggest_search_model.dart';
import 'package:mappbox_app/provider/map_provider.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(
      builder: (context, mapProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              MapWidget(
                key: const ValueKey("mapWidget"),
                cameraOptions: mapProvider.camera,
                onMapCreated: (mapboxMap) async {
                  mapProvider.mapboxMap = mapboxMap;
                  await mapProvider.initialize();
                },
                onTapListener: (context) {
                  mapProvider.addMarker(context.point.coordinates);
                },
              ),
              AnimatedPositioned(
                bottom: mapProvider.hideMarkerList
                    ? -30 * mapProvider.markers.length.toDouble()
                    : 0,
                right: 0,
                left: 0,
                duration: const Duration(milliseconds: 500),
                child: GestureDetector(
                  onTap: mapProvider.onTapMarkerList,
                  child: Container(
                    color: Colors.white.withOpacity(1),
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: List.generate(
                        mapProvider.markers.length,
                        (index) {
                          final markers = mapProvider.markers[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Marker ${index + 1}"),
                                Text(" ${markers.lat}\n${markers.lng}"),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () => mapProvider.deleteMarker(Point(
                                    coordinates:
                                        Position(markers.lng, markers.lat),
                                  )),
                                  child: const Icon(Icons.close,
                                      size: 20, color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 10,
                left: 10,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SafeArea(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: mapProvider.searchTextEditingController,
                          decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Cari Lokasi',
                          ),
                          onChanged: (value) {
                            mapProvider.debouncer.run(
                                () => mapProvider.getSuggestionSearch(value));
                          },
                        ),
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: mapProvider.loadSearch
                              ? const Center(
                                  child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator.adaptive(),
                                ))
                              : mapProvider
                                      .searchTextEditingController.text.isEmpty
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                          mapProvider.suggestions.length,
                                          (index) {
                                        SuggestionModel data =
                                            mapProvider.suggestions[index];
                                        return InkWell(
                                          onTap: () {
                                            mapProvider.retrieveSuggestion(
                                                data.mapboxId ?? '');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child:
                                                Text("${data.placeFormatted}"),
                                          ),
                                        );
                                      }),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
