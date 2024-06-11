// CREACION DE SEGUNDA PANTALLA

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PantallasDoctor extends StatefulWidget {
  @override
  State<PantallasDoctor > createState() => _PantallaNuState();
}

class _PantallaNuState extends State<PantallasDoctor > {
  bool _atencionPrevia = false;
  bool _yaPagado = false;
  int _numeroCita = 1;
  double _montoActual = 200.0; // Inicializamos el monto para la primera cita
  double _montoTotal = 0;
  String _citaSeleccionada = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                'Consultorio Dr. Lorenzo T. Mata Lozano',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.green.shade600,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '¿Ha sido atendido antes?',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: _atencionPrevia,
                      onChanged: (value) {
                        setState(() {
                          _atencionPrevia = value;
                          _resetMontos();
                        });
                      },
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.grey.shade400,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              if (_atencionPrevia)
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      Text('Número de cita:'),
                      SizedBox(width: 8.0),
                      DropdownButton<int>(
                        value: _numeroCita,
                        items: List.generate(10, (index) => index + 1)
                            .map<DropdownMenuItem<int>>((value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _numeroCita = value!;
                            _citaSeleccionada = 'Cita N° $value';
                            _calcularMontoTotal();
                          });
                        },
                      ),
                      SizedBox(width: 16.0),
                      Text(_citaSeleccionada),
                    ],
                  ),
                ),
              if (_atencionPrevia)
                Row(
                  children: [
                    Text(
                      '¿Ya ha pagado las citas anteriores?',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: _yaPagado,
                        onChanged: (value) {
                          setState(() {
                            _yaPagado = value;
                            _calcularMontoTotal();
                          });
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.grey.shade400,
                        inactiveTrackColor: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Monto total acumulado: \$${_montoTotal.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total a pagar:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          '\$${_montoActual.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calcularMontoTotal() {
    double montoTotal = 0;
    double montoActual = 0;

    if (!_atencionPrevia) {
      montoTotal = montoActual = 200.0;
    } else {
      for (int i = 1; i <= _numeroCita; i++) {
        if (i <= 3) {
          montoTotal += 200.0;
        } else if (i <= 5) {
          montoTotal += 150.0;
        } else if (i <= 8) {
          montoTotal += 100.0;
        } else {
          montoTotal += 50.0;
        }
      }

      if (_numeroCita <= 3) {
        montoActual = 200.0;
      } else if (_numeroCita <= 5) {
        montoActual = 150.0;
      } else if (_numeroCita <= 8) {
        montoActual = 100.0;
      } else {
        montoActual = 50.0;
      }

      if (_yaPagado) {
        montoTotal = montoActual;
      }
    }

    setState(() {
      _montoTotal = montoTotal;
      _montoActual = montoActual;
    });
  }

  void _resetMontos() {
    setState(() {
      _numeroCita = 1;
      _montoTotal = 0;
      _montoActual = 200.0;
      _yaPagado = true;
      _citaSeleccionada = '';
    });
  }
}

