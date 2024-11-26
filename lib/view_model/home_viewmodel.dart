// view_models/home_view_model.dart
import '../models/home_model.dart';

class HomeViewModel {
  final HomeModel homeModel;

  HomeViewModel({required this.homeModel});

  String getTitle() {
    return homeModel.title;
  }
}
