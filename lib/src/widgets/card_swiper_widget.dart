import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwipperWidget extends StatelessWidget {
  final List<Pelicula> lista;
//test
  CardSwipperWidget({@required this.lista});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          lista[index].uniqueIDHero = '${lista[index].id}-big';

          return Hero(
            tag: lista[index].uniqueIDHero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalle',
                    arguments: lista[index]),
                child: FadeInImage(
                  image: NetworkImage(
                    lista[index].getPostedImg(),
                  ),
                  placeholder: AssetImage('asset/img/no-image-jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: lista.length,
        //pagination: new SwiperPagination(), //Puntitos de abajo
        //control: new SwiperControl(), //Flechitas laterales
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
