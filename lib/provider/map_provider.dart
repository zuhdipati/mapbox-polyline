import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mappbox_app/api/call_api.dart';
import 'package:mappbox_app/api/endpoint.dart';
import 'package:mappbox_app/models/suggest_retrieve_model.dart';
import 'package:mappbox_app/models/suggest_search_model.dart';
import 'package:mappbox_app/widgets/debouncer.dart';
import 'package:uuid/uuid.dart';

class MapProvider extends ChangeNotifier {
  MapboxMap? _mapboxMap;

  MapboxMap? get mapboxMap => _mapboxMap;

  set mapboxMap(MapboxMap? mapController) {
    _mapboxMap = mapController;
    notifyListeners();
  }

  TextEditingController searchTextEditingController = TextEditingController();
  PointAnnotationManager? _pointAnnotationManager;
  PolylineAnnotationManager? _polylineAnnotationManager;
  final Map<String, PointAnnotation> _pointAnnotation = {};
  final Map<String, PolylineAnnotation> _polyLineAnnotation = {};
  final List<Position> _polyLine = [];
  final List<Position> _markers = [];
  late Uint8List _markerImage;
  bool _hideMarkerList = false;
  List<dynamic> _geometry = [];
  String _directionUrl = '';

  bool loadSearch = false;
  List<SuggestionModel> suggestions = [];
  List<FeatureModel> retrieve = [];

  final debouncer = Debouncer(milliseconds: 500);

  final CameraOptions camera = CameraOptions(
    center: Point(coordinates: Position(106.82717, -6.17511)),
    zoom: 12,
  );

  bool get hideMarkerList => _hideMarkerList;
  List<Position> get markers => _markers;

  Future<void> initialize() async {
    if (_mapboxMap == null) return;

    _pointAnnotationManager =
        await _mapboxMap!.annotations.createPointAnnotationManager();
    _polylineAnnotationManager =
        await _mapboxMap!.annotations.createPolylineAnnotationManager();

    final ByteData bytes = await rootBundle.load('assets/icon/marker.png');
    _markerImage = bytes.buffer.asUint8List();

    await addMarker(Position(106.82717, -6.17511));
  }

  Future<void> addMarker(Position position) async {
    if (_markers.length < 5) {
      _markers.add(Position(position.lng, position.lat));

      await _updateUrl(_markers);

      PointAnnotationOptions pointAnnotationOptions = PointAnnotationOptions(
        geometry: Point(coordinates: position),
        image: _markerImage,
        iconSize: 0.2,
      );

      PointAnnotation? annotation =
          await _pointAnnotationManager?.create(pointAnnotationOptions);
      if (annotation != null) {
        _pointAnnotation[annotation.id] = annotation;
      }
      notifyListeners();
    }
  }

  Future<void> deleteMarker(Point position) async {
    _markers.removeWhere(
      (element) =>
          element.lat == position.coordinates.lat &&
          element.lng == position.coordinates.lng,
    );
    await _updateUrl(_markers);

    final annotationId = _pointAnnotation.keys.firstWhere(
      (id) =>
          _pointAnnotation[id]!.geometry.coordinates == position.coordinates,
    );

    if (annotationId.isNotEmpty) {
      await _pointAnnotationManager?.delete(_pointAnnotation[annotationId]!);
      _pointAnnotation.remove(annotationId);
      notifyListeners();
    }
  }

  Future<void> addPolyline(List<dynamic> geometry) async {
    if (_markers.length > 1) {
      _polyLine.clear();
      for (var coord in geometry) {
        _polyLine.add(Position(coord[0], coord[1]));
      }

      PolylineAnnotationOptions polylineAnnotationOptions =
          PolylineAnnotationOptions(
        geometry: LineString(coordinates: _polyLine),
        lineWidth: 5,
      );

      if (_polylineAnnotationManager != null) {
        PolylineAnnotation annotation =
            await _polylineAnnotationManager!.create(polylineAnnotationOptions);
        _polyLineAnnotation[annotation.id] = annotation;
      }
      notifyListeners();
    }
  }

  Future<void> deleteAllPolylines() async {
    if (_polylineAnnotationManager != null) {
      await _polylineAnnotationManager!.deleteAll();
      _polyLineAnnotation.clear();
      notifyListeners();
    }
  }

  Future<void> getDirections(String url) async {
    await API.get(
      url,
      onSuccess: (value) async {
        final routes = value['routes'];
        await deleteAllPolylines();
        if (routes.isNotEmpty) {
          _geometry = routes[0]['geometry']['coordinates'];
          await addPolyline(_geometry);
        }
      },
      onError: (error) {
        debugPrint("Error get directions: $error");
      },
    );
  }

  Future<void> getSuggestionSearch(String q) async {
    Uuid uuid = const Uuid();
    String sessionToken = uuid.v4();
    String url = urlSearchSuggest(q, sessionToken);

    loadSearch = true;
    notifyListeners();
    await API.get(
      url,
      onSuccess: (value) async {
        suggestions = (value['suggestions'] as List)
            .map((item) => SuggestionModel.fromJson(item))
            .toList();
      },
      onError: (error) {
        debugPrint("Error get suggestion: $error");
      },
    );

    loadSearch = false;
    notifyListeners();
  }

  Future<void> retrieveSuggestion(String id) async {
    Uuid uuid = const Uuid();
    String sessionToken = uuid.v4();
    String url = urlRetrieveSuggest(id, sessionToken);

    await API.get(
      url,
      onSuccess: (value) async {
        retrieve = (value['features'] as List)
            .map((item) => FeatureModel.fromJson(item))
            .toList();

        setCamera(CameraOptions(
            center: Point(
                coordinates: Position(retrieve[0].geometry.coordinates![0],
                    retrieve[0].geometry.coordinates![1]))));
      },
      onError: (error) {
        debugPrint("Error get suggestion: $error");
      },
    );
  }

  Future<void> _updateUrl(List<Position> markers) async {
    String url = urlDriving(
        markers.map((position) => '${position.lng},${position.lat}').join(';'));
    _directionUrl = url;
    debugPrint("URL: $_directionUrl");

    if (_markers.length > 1) {
      await getDirections(_directionUrl);
    } else {
      await deleteAllPolylines();
    }
  }

  void setCamera(CameraOptions cameraOptions) {
    _mapboxMap?.setCamera(cameraOptions);

    searchTextEditingController.clear();
    notifyListeners();
  }

  void onTapMarkerList() {
    _hideMarkerList = !_hideMarkerList;
    notifyListeners();
  }
}
