import 'package:flutter/material.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';


class HeaderHome extends StatefulWidget {
  const HeaderHome({super.key});

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  bool obscureAmount = true;
  final AuthenticationBloc _authenticationBloc = CoreBinding.get();
  changeObscureAmount() {
    obscureAmount = !obscureAmount;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _authenticationBloc.add(AuthenticationCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getWidth(context),
      height: ScreenSize.getHeight(context) * 0.15,
      decoration:  BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: colorsDS.primary900),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: ScreenSize.getWidth(context) * 0.4,
            height: ScreenSize.getHeight(context) * 0.05,
            decoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                color: colorsDS.primary900),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "@MarceloSilva341",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 24,
              ),
              const Text(
                "R\$",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 16,
              ),
              Builder(builder: (context) {
                if (obscureAmount) {
                  return const Text(
                    "****",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  );
                }
                return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  bloc: _authenticationBloc,
                  builder: (context, state) {
                    if (state.status.user == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Text(
                      state.status.user!.balance
                          .toDouble()
                          .toStringAsFixed(2)
                          .replaceAll('.', ','),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    );
                  },
                );
              }),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: GestureDetector(
                  onTap: () {
                    changeObscureAmount();
                  },
                  child: Icon(
                    obscureAmount
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
