import 'package:flutter/material.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Responsive.dart';
import 'package:s_a_m_s/SharedComponent.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    var SizeScreenW = MediaQuery.of(context).size.width;
    var SizeScreenH = MediaQuery.of(context).size.height;

    return DeskDash(
        SizeScreenWidht: SizeScreenW, SizeScreenHeight: SizeScreenH);

    // return ResponsiveLayout(
    //   Mobile: MobDash(
    //     SizeScreenHeight: SizeScreenH,
    //     SizeScreenWidht: SizeScreenW,
    //   ),
    //   Desktop: DeskDash(
    //     SizeScreenHeight: SizeScreenH,
    //     SizeScreenWidht: SizeScreenW,
    //   ),
    //   Tablet: TabDash(
    //     SizeScreenHeight: SizeScreenH,
    //     SizeScreenWidht: SizeScreenW,
    //   ),
    // );
  }
}

class DeskDash extends StatelessWidget {
  const DeskDash({
    super.key,
    required this.SizeScreenWidht,
    required this.SizeScreenHeight,
  });

  final double SizeScreenWidht, SizeScreenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 1400,
                height: 700,
                //  decoration: BoxDecoration(color: Colors.red),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   flex: 2,
                    //   child: Billing_Packages_Info(
                    //     SizeScreenw: SizeScreenWidht,
                    //     SizeScreenh: SizeScreenHeight,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    Main_Info(
                      Sh: SizeScreenHeight,
                      Sw: SizeScreenWidht,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Expanded(
                        child: Activity_Info(
                            sh: SizeScreenHeight, Sw: SizeScreenWidht))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MobDash extends StatelessWidget {
  const MobDash({
    super.key,
    required this.SizeScreenWidht,
    required this.SizeScreenHeight,
  });

  final double SizeScreenWidht;
  final double SizeScreenHeight;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeScreenWidht < 630
                  ? SizeScreenWidht < 400
                      ? 5
                      : 20
                  : 30,
            ),
            Expanded(
                child: Main_Info(
              Sh: SizeScreenHeight,
              Sw: SizeScreenWidht,
            )),
            SizedBox(
              width: SizeScreenWidht < 630
                  ? SizeScreenWidht < 400
                      ? 5
                      : 20
                  : 30,
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Billing_Packages_Info(
                SizeScreenw: SizeScreenWidht,
                SizeScreenh: SizeScreenHeight,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 600,
              child: Activity_Info(
                sh: SizeScreenHeight,
                Sw: SizeScreenWidht,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TabDash extends StatelessWidget {
  const TabDash({
    super.key,
    required this.SizeScreenHeight,
    required this.SizeScreenWidht,
  });

  final double SizeScreenHeight;
  final double SizeScreenWidht;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 900 - NavSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 30,
              ),
              Expanded(
                  child: Main_Info(
                Sh: SizeScreenHeight,
                Sw: SizeScreenWidht,
              )),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Billing_Packages_Info(
                SizeScreenw: SizeScreenWidht,
                SizeScreenh: SizeScreenHeight,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
                child:
                    Activity_Info(sh: SizeScreenHeight, Sw: SizeScreenWidht)),
          ],
        ),
      ],
    );
  }
}
