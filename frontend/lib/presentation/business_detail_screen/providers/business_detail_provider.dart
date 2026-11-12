import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BusinessDetailTab {
  services,
  about,
  reviews;

  bool get isServices => this == BusinessDetailTab.services;
  bool get isAbout => this == BusinessDetailTab.about;
  bool get isReviews => this == BusinessDetailTab.reviews;
}

class BusinessDetailTabNotifier extends Notifier<BusinessDetailTab> {
  @override
  BusinessDetailTab build() => BusinessDetailTab.services;

  void selectTab(BusinessDetailTab tab) {
    state = tab;
  }
}

final businessDetailTabProvider =
    NotifierProvider<BusinessDetailTabNotifier, BusinessDetailTab>(
  BusinessDetailTabNotifier.new,
);

class FavoriteNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
    // TODO: Sync favorite/bookmark state with backend user preferences API
  }
}

final businessFavoriteProvider = NotifierProvider<FavoriteNotifier, bool>(
  FavoriteNotifier.new,
);

