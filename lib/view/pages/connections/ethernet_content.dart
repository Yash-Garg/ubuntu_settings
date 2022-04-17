import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import '../../../constants.dart';
import 'models/ethernet_model.dart';

class EthernetContent extends StatelessWidget {
  const EthernetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ethernetModel = context.watch<EthernetModel>();

    return YaruPage(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: YaruRow(
            trailingWidget: Text(
              'Wired',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            actionWidget: YaruOptionButton(
              onPressed: () {},
              iconData: YaruIcons.plus,
            ),
            enabled: true,
          ),
        ),
        for (var device in ethernetModel.ethernetDevices)
          AnimatedBuilder(
            animation: device,
            builder: (_, __) {
              return YaruSection(
                width: kDefaultWidth,
                headline: 'Connected - ${device.speed} Mb/s',
                headerWidget: Row(
                  children: [
                    CupertinoSwitch(
                      activeColor: Theme.of(context).colorScheme.primary,
                      value: device.isActive,
                      onChanged: (_) => ethernetModel.toggleInterface(
                        device.networkDevice,
                        device.connection,
                      ),
                    ),
                    const SizedBox(width: 10),
                    YaruOptionButton(
                      onPressed: () {},
                      iconData: YaruIcons.settings,
                    )
                  ],
                ),
                children: const [],
              );
            },
          )
      ],
    );
  }
}
