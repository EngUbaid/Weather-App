import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/MyScreens/controllers/main_controller.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("yMMMd").format(DateTime.now());
    var theme = Theme.of(context);
    var controler = Get.put(MainController());
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          date,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.normal,
              color: theme.primaryColor),
        ),
        actions: [
          Obx(
            () => IconButton(
                onPressed: () {
                  controler.changeTheme();
                },
                icon: Icon(
                  controler.isDark.value ? Icons.light_mode : Icons.dark_mode,
                  color: theme.iconTheme.color,
                )),
          ),
        ],
      ),
      body: Obx(
        () => controler.isloaded == true
            ? Container(
                padding: const EdgeInsets.all(12),
                child: FutureBuilder(
                  future: controler.currentWeatherData,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      );
                    } else {
                      var data = snapshot.data;
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                         
                            Text(
                              "${data!.name}",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryColor,
                                  letterSpacing: 3),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                    "asset/weather/${data.weather![0].icon}.png"),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "${data.main!.temp}°C ",
                                      style: TextStyle(
                                          fontSize: 64,
                                          color: theme.primaryColor)),
                                  TextSpan(
                                      text: " ${data.weather![0].main}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: theme.primaryColor))
                                ]))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.expand_less_rounded,
                                      color: theme.iconTheme.color,
                                    ),
                                    label: Text(
                                      "${data.main!.tempMin}",
                                      style: TextStyle(
                                        color: theme.primaryColor,
                                      ),
                                    )),
                                TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.expand_more_rounded,
                                      color: theme.iconTheme.color,
                                    ),
                                    label: Text(
                                      "${data.main!.tempMax}",
                                      style: TextStyle(
                                        color: theme.primaryColor,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(3, (index) {
                                var iconlist = [
                                  Image.asset("asset/icons/clouds.png"),
                                  Image.asset("asset/icons/humidity.png"),
                                  Image.asset("asset/icons/windspeed.png"),
                                ];
                                var values = [
                                  data.clouds!.all,
                                  data.main!.humidity,
                                  data.wind!.speed,
                                ];
                                var weathernames = [
                                  "clouds",
                                  "humidity",
                                  "windspeed",
                                ];
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.grey[200],
                                      padding: const EdgeInsets.all(8),
                                      child: iconlist[index],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      weathernames[index].toString(),
                                      style:
                                          TextStyle(color: theme.primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      values[index].toString(),
                                      style:
                                          TextStyle(color: theme.primaryColor),
                                    )
                                  ],
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: theme.primaryColor,
                              thickness: 1.0,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(
                              future: controler.hourlyWeatherData,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: theme.primaryColor,
                                    ),
                                  );
                                } else {
                                  var hourlydata = snapshot.data;
                                  return SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: hourlydata!.list!.length,
                                      itemBuilder: (context, index) {
                                        var time = DateFormat.jm().format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                hourlydata.list![index].dt!
                                                        .toInt() *
                                                    1000));
                                        return Container(
                                            padding: const EdgeInsets.all(8),
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(time),
                                                Image.asset(
                                                    "asset/weather/${hourlydata.list![index].weather![0].icon}.png"),
                                                Text(
                                                    "${hourlydata.list![index].main!.temp}°C"),
                                              ],
                                            ));
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(color: theme.primaryColor),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Next 7 Days",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                    onPressed: () {
                                      //  Get.to(const ViewallScreen());
                                    },
                                    child: Text(
                                      "View All",
                                      style:
                                          TextStyle(color: theme.primaryColor),
                                    ))
                              ],
                            ),
                            FutureBuilder(
                              future: controler.hourlyWeatherData,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  var weeklydataa = snapshot.data;
                                  return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: weeklydataa!.list!.length > 7
                                        ? 7
                                        : weeklydataa.list!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var dayWeather = weeklydataa.list![
                                          index]; // Get the weather data for the day

                                      // Extracting relevant information
                                      var day = DateFormat("EEEE").format(
                                          DateTime.now()
                                              .add(Duration(days: index)));

                                      var temperature = dayWeather.main!.temp!;
                                      // Example: converting temperature to whole number
                                      var weatherIcon =
                                          dayWeather.weather![0].icon;
                                      return Card(
                                        color: theme.cardColor,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  day,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          theme.primaryColor),
                                                ),
                                              ),
                                              Expanded(
                                                child: TextButton.icon(
                                                    onPressed: () {},
                                                    icon: Image.network(
                                                      'http://openweathermap.org/img/wn/$weatherIcon.png',
                                                      width: 32,
                                                      height: 32,
                                                    ),
                                                    label: Text(
                                                      "$temperature°C",
                                                      style: TextStyle(
                                                          color: theme
                                                              .primaryColor),
                                                    )),
                                              ),
                                              RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        '${dayWeather.main!.tempMin} / ',
                                                    style: TextStyle(
                                                        color: theme
                                                            .primaryColor)),
                                                TextSpan(
                                                    text:
                                                        '${dayWeather.main!.tempMax}',
                                                    style: TextStyle(
                                                        color: theme
                                                            .iconTheme.color))
                                              ]))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      );
                    }
                  },
                ))
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
