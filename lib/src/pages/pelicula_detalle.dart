import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/actores_model.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter_peliculas/src/providers/peliculas_provider.dart'
    as prefix0;

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//Podría enviarse con un constructor, pero también así #V112
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      //Mentalizarse como si fuera lista, pero son Slivers
      slivers: <Widget>[
        _crearAppbar(pelicula),
        SliverList(
          //Como si fuera un ListView
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _posterTitulo(pelicula, context),
            _descripcion(pelicula),
            _crearActores(pelicula)
          ]),
        )
      ],
    ));
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      //AppBarAdaptable
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(pelicula.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            overflow: TextOverflow.ellipsis),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueIDHero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(pelicula.getPostedImg()),
                  height: 150.0,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text(
                    pelicula.title,
                    style: Theme.of(context).textTheme.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(pelicula.originalTitle,
                      style: Theme.of(context).textTheme.subhead,
                      overflow: TextOverflow.ellipsis),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star_border),
                      Text(
                        pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subhead,
                      )
                    ],
                  )
                ])),
          ],
        ));
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearActores(Pelicula pelicula) {
    final peliculasProvider = new prefix0.PeliculasProvider();

    return FutureBuilder(
      future: peliculasProvider.getActores(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, index) => _actorTarjeta(actores[index]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getFotoActor()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
