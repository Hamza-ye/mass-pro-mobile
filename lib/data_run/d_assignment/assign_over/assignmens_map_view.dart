import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';

class AssignmentMapPage extends ConsumerWidget {
  AssignmentMapPage({super.key, this.scope});
  final EntityScope? scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider(scope));
    final searchQuery = ref.watch(filterQueryProvider).searchQuery;

    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (List<AssignmentModel> assignments) {
        return FlutterMap(
          options: MapOptions(
            center: LatLng(0, 0), // Center the map at an initial position
            zoom: 2.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: _buildMarkers(assignments),
            ),
          ],
        );
      },
    );
  }

  List<Marker> _buildMarkers(List<AssignmentModel> assignments) {
    var markers = assignments.map<Marker?>((assignment) {
      final latitude = assignment.allocatedResources['latitude'];
      final longitude = assignment.allocatedResources['longitude'];
      final status = assignment.status;

      if (latitude != null && longitude != null) {
        return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(latitude, longitude),
          builder: (ctx) => Container(
            child: Icon(
              Icons.location_on,
              color: _getStatusColor(status),
              size: 40.0,
            ),
          ),
        );
      }
      return null;
    });
    return markers.where((m) => m != null).toList().cast<Marker>();
  }

  Color _getStatusColor(AssignmentStatus status) {
    switch (status) {
      case AssignmentStatus.NOT_STARTED:
        return Colors.red;
      case AssignmentStatus.IN_PROGRESS:
        return Colors.orange;
      case AssignmentStatus.DONE:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
