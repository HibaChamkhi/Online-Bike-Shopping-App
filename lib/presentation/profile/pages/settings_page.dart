import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_bike_shopping_appuntitled/presentation/profile/widgets/settings.dart';
import '../../../core/di/injection.dart';
import '../bloc/profile_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()
        ..add(GetCurrentUserEvent()),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
      if (state.profileStatus == ProfileStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.messages),
          ),
        );
      } else if (state.profileStatus == ProfileStatus.loading) {
        Center(
          child: SizedBox(
            height: 60.h,
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFC67C4E),
              ),
            ),
          ),
        );
      }
    }, builder: (context, state) {
      return SettingsScreen(
        state: state,
      );
    });
  }

// Future<void> _onRefresh(BuildContext context) async {
//   BlocProvider.of<ProfileBloc>(context)
//       .add(const GetAllProfilesEvent());
// }
}
