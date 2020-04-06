// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:unit_converter/unit.dart';

const _padding = EdgeInsets.all(16.0);
/// Converter screen where users can input amounts to convert.
///
/// Currently, it just displays a list of mock units.
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatefulWidget {
  /// Units for this [Category].
  final List<Unit> units;
  final Color color;
  /// This [ConverterRoute] requires the color and units to not be null.
  const ConverterRoute({
    @required this.color,
    @required this.units,
  }) : assert(units != null),
       assert(color != null);
      @override
      _ConverterRouteState createState() => _ConverterRouteState();
}
class _ConverterRouteState extends State<ConverterRoute> {
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertervalue ='';
  List <DropdownMenuItem> _unitMenuItems;
  bool _showValidationError = false;

  @override
  void initState() {
    super.initState();
    _createDropdownMenuItem();
    _setDefaults();
  }
  void _createDropdownMenuItem(){
    var newItem = <DropdownMenuItem>[];
    for (var unit in widget.units){
      newItem.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),),
      ));
    }
    setState(() {
      _unitMenuItems = newItem;
    });
  }
  void _setDefaults() {
    setState(() {
      _fromValue = widget.units[0];
      _toValue = widget.units[1];
    });
  }

  String _format(double conversion){
    var outputNum = conversion.toStringAsPrecision(7);
    if(outputNum.contains('.') && outputNum.endsWith('0'))
    {
      var i = outputNum.length - 1;
      while(outputNum[i] == '0')
      {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if(outputNum.endsWith('.'))
    {
        return outputNum.substring(0,outputNum.length - 1);
    }
    return outputNum;
  }

  void _updateConversion(){
    setState(() {
      _convertervalue = _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
    });
  }

  void _updateInputValue(String input)
  {
    setState(() {
      if (input == null || input.isEmpty) {
        _convertervalue ='';
      }
      else{
        try{
          final _inputDouble = double.parse(input);
          _showValidationError =false;
          _inputValue = _inputDouble;
          _updateConversion();
        } on Exception catch(e){
          print('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }

  Unit _getUnit(String unitName){
    return widget.units.firstWhere((Unit unit){
      return unit.name == unitName;
    },
    orElse: null,
    );
  }
  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if(_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });
    if(_inputValue != null){
      _updateConversion();
    }
  }
  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged)
  {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
           )
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child:DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child:DropdownButton(
              value:currentValue ,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.title,
                  )
                ),
              )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    final input = Padding(
      padding: _padding,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[TextField(
          style: Theme.of(context).textTheme.display1,
          decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.display1,
            errorText: _showValidationError ? 'Invalid number entered' : null,
            labelText: 'Input',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0)
            )
          ),
          keyboardType: TextInputType.number,
          onChanged: _updateInputValue,
        ),
        _createDropdown(_fromValue.name,_updateFromConversion),
        ],
      )
    );
  final arrows = RotatedBox(
    quarterTurns: 1,
    child: Icon(Icons.compare_arrows,
    size:40.0));

  
    final output = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          InputDecorator(
            child: Text(
              _convertervalue,
              style: Theme.of(context).textTheme.display1,
            ),
            decoration: InputDecoration(
              labelText:'Output',
              labelStyle: Theme.of(context).textTheme.display1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              )
          ),
        ),
        _createDropdown(_toValue.name, _updateToConversion)
      ],)
      );
      final converter = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          input,
          arrows,
          output,
        ],
      );
      return Padding(
        padding: _padding,
        child: converter,
        );
  }
}