import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_weather/Controller/WeatherController.dart';
import 'package:weather/weather.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherController controller = WeatherController();

  @override
  void initState() {
    super.initState();
    controller.onInit();
  }

  Widget contentFinishedDownload() {
    return Center(
      child: ListView.separated(
        itemCount: controller.data.length,
        itemBuilder: (context, index) {
          return Obx(() => Card(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: HexColor('#FFD947'), width: 5),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              elevation: 20,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/vacancy/detail', arguments: "");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 28.w,
                                child: Text(
                                  "Посада:",
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                  softWrap: true,
                                )),
                          ),
                          Container(
                              width: 52.w,
                              child: Text(
                                controller.data[index].weatherMain.toString(),
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                                softWrap: true,
                              )),
                        ]),
                        Divider(),
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 28.w,
                                child: Text(
                                  'Заробітна плата',
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                  softWrap: true,
                                )),
                          ),
                          Container(
                              width: 47.w,
                              child: Text(
                                controller.data[index].tempFeelsLike.toString(),
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                                softWrap: true,
                              )),
                          Container(
                              width: 5.w,
                              child: Icon(Icons.arrow_forward_rounded)),
                        ]),
                      ],
                    ),
                  ),
                ),
              )));

          /* ListTile(
            title: Text(_data[index].toString()),
          );*/
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(children: [
        Text(
          'Fetching Weather...',
          style: TextStyle(fontSize: 20),
        ),
        Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Press the button to download the Weather forecast',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => controller.state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : controller.state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();

  Widget _coordinateInputs() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: EdgeInsets.all(5),
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter latitude'),
                  keyboardType: TextInputType.number,
                  onChanged: controller.saveLat,
                  onSubmitted: controller.saveLat)),
        ),
        Expanded(
            child: Container(
                margin: EdgeInsets.all(5),
                child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter longitude'),
                    keyboardType: TextInputType.number,
                    onChanged: controller.saveLon,
                    onSubmitted: controller.saveLon))),
        Expanded(
          child: Container(
              margin: EdgeInsets.all(5),
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter cityName'),
                  keyboardType: TextInputType.text,
                  onChanged: controller.saveCity,
                  onSubmitted: controller.saveCity)),
        ),
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child: TextButton(
            child: Text(
              'Fetch weather',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              controller.queryWeatherCity(controller.cityName);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: TextButton(
            child: Text(
              'Fetch forecast',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              controller.queryForecastCity(controller.cityName);
              print('press ${controller.cityName}');
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveSizer(builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Weather Example App'),
          ),
          body: Column(
            children: <Widget>[
              _coordinateInputs(),
              _buttons(),
              Text(
                'Output:',
                style: TextStyle(fontSize: 20),
              ),
              Divider(
                height: 20.0,
                thickness: 2.0,
              ),
              Container(child: _resultView())
            ],
          ),
        );
      }),
    );
  }
}
