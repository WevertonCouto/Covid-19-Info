import 'package:covid_19/animations/NumberIncrementAnimation.dart';
import 'package:covid_19/data/api.dart';
import 'package:covid_19/models/Country.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({this.title});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selected = 'Brazil';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: _selectWidget(),
            flex: 1,
          ),
          Flexible(
            flex: 9,
            child: FutureBuilder(
              initialData: null,
              future: Api.getByCountry(selected),
              builder: (_, AsyncSnapshot data) {
                if (data.data == null || (data.data != null && data.data.name != selected)) {
                  return Center(child: _loading());
                } else if(data.error != null){
                  return Center(child: _error());
                } else {
                  return _items(data.data);
                }
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: Text('Made with ♥ CoutoDev', style: TextStyle(color: Colors.red),),
          )
        ],
      ),
    );
  }

  /// Dropdown Widget
  Widget _selectWidget() {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: FutureBuilder<List<Country>>(
          future: Api.getCountries(),
          builder: (_, AsyncSnapshot<List<Country>> data) {
            if (data.data != null) {
              return DropdownButton(
                items: data.data
                    .map((v) => DropdownMenuItem(
                          value: v.name,
                          child: Text(v.name),
                        ))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    selected = v;
                  });
                },
                value: selected,
                isExpanded: true,
              );
            } else
              return Container();
          },
        ));
  }

  /// List of Items
  Widget _items(Country country) {
    return Column(
      children: <Widget>[
        Flexible(
          child: _itemWidget('Confirmed', country.confirmed, Color(0xff005b96)),
          flex: 1,
        ),
        Flexible(
          child: _itemWidget('Recovered', country.recovered, Colors.green),
          flex: 1,
        ),
        Flexible(
          child: _itemWidget('Deaths', country.deaths, Color(0xffD32D41)),
          flex: 1,
        ),
      ],
    );
  }
  
  /// Item Widget
  Widget _itemWidget(String title, int value, Color color) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 30, color: color, fontFamily: 'Jennifer'),
            ),
          )),
           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              value == 0 ? Text('...') :
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IncrementNumber(value, color),
              )
            ],
          )
        ],
      ),
    );
  }

  /// Error message
  Widget _error () {
    return Text('An error has occurred, try again later');
  }

  /// Loading Widget
  Widget _loading() {
    return CircularProgressIndicator();
  }
}
