import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/text_constants.dart';

class ProfileState {
  final String name;
  final String email;
  final String avatarInitial;

  const ProfileState({
    this.name = TextConstants.sampleUserName,
    this.email = TextConstants.sampleUserEmail,
    this.avatarInitial = 'D',
  });
}

class ProfileNotifier extends Notifier<ProfileState> {
  @override
  ProfileState build() => const ProfileState();

  // TODO: Fetch user profile data from Auth/User service
}

final profileProvider = NotifierProvider<ProfileNotifier, ProfileState>(
  ProfileNotifier.new,
);

