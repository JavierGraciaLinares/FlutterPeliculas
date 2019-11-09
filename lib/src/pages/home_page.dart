import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter_peliculas/src/search/search_delegate.dart';
import 'package:flutter_peliculas/src/widgets/card_swiper_widget.dart';
import 'package:flutter_peliculas/src/widgets/movies_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider
        .getPeliculasPopulares(); //Para cargar los 1os datos en StreamBuilder

    return Scaffold(
        appBar: AppBar(
          //centerTitle: true, //centrar título
          title: Text('Películas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                  //query: "Buscar", //Texto Precargado en la busqueda
                );
              },
            )
          ],
        ),
        // body: SafeArea(child: Text('HOLA MUNDOOOOOOOOOOOOOOOOOOOOO')), //Para controlar el Notch
        body: SafeArea(
            child: Container(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, //Separar elementos
            children: <Widget>[_swiperTarjetas(), _footer(context)],
          ),
        )));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: peliculasProvider.getPeliculasEnCine(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwipperWidget(lista: snapshot.data);
          } else {
            return Container(
                child: Center(child: CircularProgressIndicator()),
                height: 400.0);
          }
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Populares',
                    style: Theme.of(context).textTheme.subhead)),
            SizedBox(height: 5.0),
            StreamBuilder(
              //Se usa StreamBuilder porque Future solo se lanza 1 vez, sin embargo Stream cada vez que se actualiza
              //FutureBuilder(
              stream: peliculasProvider.peliculasPopularesStream,
              //future: peliculasProvider.getPeliculasPopulares(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  //return CardSwipperWidget(lista: snapshot.data);
                  return MovieHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina: peliculasProvider
                        .getPeliculasPopulares, //Sin paréntesis getPeliculasPopulares() porque es la definiciaon de la misma
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ));
  }
}
