import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gwslib/widgets/table.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

class MyMap extends StatefulWidget {
  final bool enableFindLocation;
  final Position centerLocation;
  final bool rectangle;

  LatLng get centerLocationLatLng {
    return centerLocation == null
        ? null
        : LatLng(centerLocation.latitude, centerLocation.longitude);
  }

  MyMap(this.enableFindLocation, this.centerLocation, {this.rectangle = true});

  BehaviorSubject<Placemark> _placemark;
  BehaviorSubject<Position> _position;

  List<MyLocation> locations;

  _State state;

  void setPlacemarkSubject(BehaviorSubject<Placemark> placemark) {
    this._placemark = placemark;
  }

  void setPositionSubject(BehaviorSubject<Position> position) {
    this._position = position;
  }

  void setMyLocations(List<MyLocation> list) {
    this.locations = list;
  }

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MyMap> {
  BehaviorSubject<Position> _position = BehaviorSubject.seeded(null);
  BehaviorSubject<Placemark> _placemark = BehaviorSubject.seeded(null);

  MyCircleLayerOptions _circleLayerOptions = MyCircleLayerOptions();
  MyMarkerLayerOptions _markerOption = MyMarkerLayerOptions();
  Geolocator _geolocator;
  MapController _controler = MapController();

  @override
  void initState() {
    super.initState();

    widget.state = this;

    if (widget.enableFindLocation) {
      _geolocator = Geolocator()..forceAndroidLocationManager;
      _getCurrentLocation();
    }

    if (widget._position != null) {
      widget._position.stream.listen((event) {
        if (event == null) {
          _getCurrentLocation();
        }
      });
    }

    _position.listen(_getAddressFromLatLng);
    _position.listen((location) {
      if (location != null) {
        _controler.move(LatLng(location.latitude, location.longitude), 15);

        _markerOption.setUserLocation(MyLocation(
            Icon(Icons.person_pin_circle, size: 28, color: Color(0xFF2ca189)), location));

        if (widget._position != null) {
          widget._position.add(location);
        }
      }
    });

    _placemark.listen((value) {
      if (value != null && widget._placemark != null) {
        widget._placemark.add(value);
      }
    });
  }

  void appendPositionList(List<MyLocation> list) {
    _markerOption.appendLocationList(list);
  }

  void _getCurrentLocation() async {
    try {
      Position position =
          await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      if (position != null) {
        _position.add(position);
      } else {
        _getCurrentLocation();
      }
    } catch (e) {
      print(e);
    }
  }

  void _getAddressFromLatLng(Position position) async {
    if (position == null) return;
    try {
      List<Placemark> p = await _geolocator.placemarkFromPosition(position);
      if (p != null && p.isNotEmpty) {
        _placemark.add(p[0]);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _position.close();
    _placemark.close();
    _markerOption.onDestroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _markerOption.setCircleLayerOptions(_circleLayerOptions);

    final mapSize = MediaQuery.of(context).size.width;

    if (widget.centerLocation != null) {
      _markerOption.setUserLocation(MyLocation(
          Icon(
            Icons.person_pin_circle,
            size: 28,
            color: Color(0xFF2ca189),
          ),
          widget.centerLocation));
    }

    if (widget.locations != null && widget.locations.isNotEmpty) {
      appendPositionList(widget.locations);
    }

    Widget widgetMap = FlutterMap(
      mapController: _controler,
      options: new MapOptions(
        center: widget.centerLocationLatLng ?? LatLng(42, 61),
        zoom: widget.centerLocation == null ? 2 : 16.5,
        maxZoom: 18,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://map.greenwhite.uz/osm/{z}/{x}/{y}.png",
        ),
        _markerOption,
        _circleLayerOptions,
      ],
    );

    if (widget.rectangle) {
      return MyTable(
        [
          ClipRRect(
            child: widgetMap,
            borderRadius: BorderRadius.circular(12),
          )
        ],
        width: mapSize,
        height: mapSize,
      );
    } else {
      return MyTable([widgetMap]);
    }
  }
}

class MyMarkerLayerOptions extends MarkerLayerOptions {
  BehaviorSubject<Null> _rebuildStream = BehaviorSubject.seeded(null);

  MyLocation userLocation;
  List<MyLocation> locations = [];

  void setUserLocation(MyLocation userLocation) {
    this._circleLayerOptions?.setUserLocation(userLocation);
    this.userLocation = userLocation;
    notify();
  }

  void appendLocationList(List<MyLocation> locations) {
    this._circleLayerOptions?.appendLocationList(locations);
    this.locations.addAll(locations);
    notify();
  }

  void appendLocation(MyLocation location) {
    this._circleLayerOptions?.appendLocation(location);
    this.locations.add(location);
    notify();
  }

  void clear() {
    this._circleLayerOptions?.clear();
    this.locations.clear();
    notify();
  }

  MyCircleLayerOptions _circleLayerOptions;

  MyMarkerLayerOptions() : super(markers: []) {
    this.rebuild = _rebuildStream.stream;
  }

  void setCircleLayerOptions(MyCircleLayerOptions circleLayerOptions) {
    this._circleLayerOptions = circleLayerOptions;
  }

  void notify() {
    this.markers.clear();
    if (userLocation != null) {
      this.markers.add(userLocation.toMarker());
    }

    locations.forEach((item) {
      this.markers.add(item.toMarker());
    });
    _rebuildStream.add(null);
  }

  void onDestroy() {
    this._rebuildStream.close();
  }
}

class MyCircleLayerOptions extends CircleLayerOptions {
  BehaviorSubject<Null> _rebuildStream = BehaviorSubject.seeded(null);

  MyLocation userLocation;
  List<MyLocation> locations = [];

  void setUserLocation(MyLocation userLocation) {
    this.userLocation = userLocation;
    notify();
  }

  void appendLocationList(List<MyLocation> locations) {
    this.locations.addAll(locations);
    notify();
  }

  void appendLocation(MyLocation location) {
    this.locations.add(location);
    notify();
  }

  void clear() {
    this.locations.clear();
    notify();
  }

  MyCircleLayerOptions() : super(circles: []) {
    this.rebuild = _rebuildStream.stream;
  }

  void notify() {
    this.circles.clear();
    if (userLocation != null) {
      this.circles.add(userLocation.toCircleMarker());
    }

    locations.forEach((item) {
      this.circles.add(item.toCircleMarker());
    });
    _rebuildStream.add(null);
  }

  void onDestroy() {
    this._rebuildStream.close();
  }
}

class MyLocation {
  final Widget icon;
  final Position position;

  MyLocation(this.icon, this.position);

  CircleMarker toCircleMarker() {
    return new CircleMarker(
      point: new LatLng(position.latitude, position.longitude),
      color: Color(0xFF18A0FB).withOpacity(0.1),
      borderStrokeWidth: 1.0,
      borderColor: Color(0xFF18A0FB).withOpacity(0.5),
      useRadiusInMeter: true,
      radius: position.accuracy, //radius
    );
  }

  Marker toMarker() {
    return new Marker(
      point: new LatLng(position.latitude, position.longitude),
      builder: (ctx) {
        return Container(child: icon);
      },
    );
  }
}
