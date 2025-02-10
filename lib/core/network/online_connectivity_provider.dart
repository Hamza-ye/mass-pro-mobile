import 'package:datarun/core/network/connectivy_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'online_connectivity_provider.g.dart';

@riverpod
class IsOnline extends _$IsOnline {
  @override
  Future<bool> build() {
    return ConnectivityService.instance.checkInternetConnection();
  }

  void check() async {
    await future;
    state =
        AsyncData(await ConnectivityService.instance.checkInternetConnection());
  }
}
