import 'package:flutter/material.dart';
import 'package:unit_converter/unit.dart';
import 'category.dart';
final _backgroundColor = Colors.green[100];

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();
  @override
  _CategoryRouteState createState() => _CategoryRouteState();

}

class _CategoryRouteState extends State<CategoryRoute> {
  static const _categoryName = <String> [
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency'
  ];
  static const _baseColors = <Color> [
     ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ];
  Widget _buidlCategoryWidget(List<Widget> categories) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) => categories[index],
    itemCount: categories.length,);
  }
  List<Unit>_retrieveUnitLIst(String categoryName) {
    return List.generate(10, (int i){
      i += 1;
      return Unit(
        name: '$categoryName Unit $i',
        conversion: i.toDouble(),
      );
    });
  }
  @override
  Widget build(BuildContext context)
  {
    final categories = <Category>[];
    for(var i=0; i < _categoryName.length; i++){
      categories.add(Category(
        name:_categoryName[i],
        color: _baseColors[i],
        iconLocation: Icons.cake,
        units: _retrieveUnitLIst(_categoryName[i]),
        ));
    }
    final listview = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal:  8.0),
      child: _buidlCategoryWidget(categories),
    );
    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'Unit_Conveter',
        style: TextStyle(
          color:Colors.black,
          fontSize: 30.0,
          ),
      ),
      centerTitle: true,
      backgroundColor: _backgroundColor,
    );
    return Scaffold(appBar: appBar,
    body: listview,);
  }

  void colors() => Colors;
}