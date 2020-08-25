import 'package:flutter/material.dart';
import 'package:wvs_warm_up/enums/warm_up_mode.dart';
import 'package:wvs_warm_up/enums/widget_state.dart';
import 'package:wvs_warm_up/models/exercise.dart';
import 'package:wvs_warm_up/providers/warm_up_provider.dart';
import 'package:wvs_warm_up/services/ui_services.dart';
import '../const.dart';

class WarmUpTab extends StatelessWidget {
  final Exercise exercise;
  final int exerciseLength;
  final WarmUpProvider provider;

  const WarmUpTab({Key key, this.exercise, this.exerciseLength, this.provider})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size actualDeviceSize = getActualDeviceSize(MediaQuery.of(context));
    final TextStyle secondaryTextStyle = TextStyle(
        color: cWHITE,
        fontSize: cH2(
          actualDeviceSize.width,
        ));
    final TextStyle tertiaryTextStyle = TextStyle(
        color: cWHITE,
        fontSize: cPAR(
          actualDeviceSize.width,
        ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerRight,
                  child: Text('${exercise.exerciseRepetition}',
                      style: secondaryTextStyle)),
              Text(
                '${exercise.exerciseName}',
                style: secondaryTextStyle,
              ),
              Container(
                width: actualDeviceSize.width,
                height: actualDeviceSize.height * 1 / 2.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('${exercise.exerciseGif}'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              provider.currentWarmUpMode == WarmUpMode.withTime
                  ? Container(
                      alignment: Alignment.centerLeft,
                      width: actualDeviceSize.width,
                      height: actualDeviceSize.height * 1 / 39,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: cWHITE),
                      child: Container(
                        width: actualDeviceSize.width * provider.timerBarLevel,
                        height: actualDeviceSize.height * 1 / 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: cSECONDARY_COLOR,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    ' Tips:',
                    style: secondaryTextStyle,
                  ),
                  IconButton(
                    icon: provider.tipsState == WidgetState.Default
                        ? Icon(
                            Icons.keyboard_arrow_down,
                            color: cWHITE,
                          )
                        : Icon(
                            Icons.keyboard_arrow_up,
                            color: cWHITE,
                          ),
                    onPressed: () => provider.onTipsStateChanged(),
                  ),
                ],
              ),
              provider.tipsState == WidgetState.Default
                  ? Column(
                      children: <Widget>[
                        for (var exerciseHint
                            in exercise.exerciseHint.split(',')) ...[
                          SizedBox(
                            height: 2.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ' - $exerciseHint',
                              style: tertiaryTextStyle,
                            ),
                          ),
                        ]
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
