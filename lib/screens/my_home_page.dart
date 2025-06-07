import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Column(
            children: [
              Container(
                height: 38,
                margin: EdgeInsets.only(left : 20, top: 32, right: 20, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/menu.png'),
                    Text('Tap 2025',style: TextStyle (fontSize: 32, fontWeight: FontWeight.w800)),
                    Image.asset('assets/bag.png')
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child:ListView.builder(
                    padding: EdgeInsets.only(left:20, top:20, right: 20, bottom: 100),
                    itemBuilder: (context, index){
                      final shoe = shoeList[index];
                      return ShoeWidget(
                        shoe,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShoeDetailsPage(shoe),
                          ));
                        }
                      );
                    },
                    itemCount: shoeList.length,
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(24), topRight: Radius.circular(24)),
              child:Container(
                color: Colors.white.withOpacity(0.2),
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical:12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/Home.png'),
                      Image.asset('assets/Search.png'),
                      Image.asset('assets/Heart.png'),
                      Image.asset('assets/account.png'),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

class ShoeWidget extends StatelessWidget {
  final ShoeEntity shoe;
  final VoidCallback? onTap;

  const ShoeWidget(this.shoe, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    return AspectRatio(
      aspectRatio: 1.25,
      child: LayoutBuilder(
        builder:(context, constraints){
          final topPadding = constraints.maxHeight * 0.2;
          final imageWidth = constraints.maxWidth * 0.35;
          final leftPadding = constraints.maxWidth * 0.1;
          return GestureDetector(
            onTap: onTap,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: topPadding),
                  decoration: BoxDecoration(
                    color: shoe.color,
                    borderRadius: BorderRadius.circular(24)
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: topPadding,
                          left: leftPadding,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shoe.name,
                              style: textStyle.copyWith(fontSize: 20),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "\$",
                                    style: textStyle.copyWith(fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: shoe.price.toStringAsFixed(2),
                                    style: textStyle.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 32,
                              width: 80,
                              child: MyButton(
                                text: "Buy Now",
                                textColor: shoe.color,
                                bgColor: Colors.white,
                                // Cambia aquí: navega a ShoeDetailsPage al presionar el botón
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ShoeDetailsPage(shoe),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: imageWidth,
                      child: Image.network(
                        shoe.image,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }, 
      ),
    );
  }
}

// Modifica MyButton para aceptar onPressed
class MyButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final VoidCallback? onPressed;

  const MyButton({
    super.key,
    required this.text,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        backgroundColor: bgColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ShoeEntity{
  final String name;
  final String image;
  final double price;
  final Color color;
  final String description;

  ShoeEntity({
    required this.name,
    required this.image,
    required this.price,
    required this.color,
    required this.description,
  });
}

final shoeList = [
  ShoeEntity(
    name: "Nike Air Jordan 1 Low SE",
    image: "https://99store.mx/cdn/shop/files/AURORA_FJ3459-160_PHSLH000-2000.png?v=1748383111&width=823",
    price: 3200.00,
    color: Color.fromARGB(255, 182, 8, 8),
    description: "Un clásico moderno con detalles premium y gran comodidad."
  ),
  ShoeEntity(
    name: "Nike 1 Retro High OG PSG",
    image: "https://99store.mx/cdn/shop/files/AURORA_FD1412-100_PHSLH000-2000.png?v=1746832806&width=823",
    price: 3200.00,
    color: Color.fromARGB(255, 0, 0, 255),
    description: "Inspirado en el Paris Saint-Germain, combina estilo y rendimiento."
  ),
  ShoeEntity(
    name: "Nike Air Jordan 1 low black",
    image: "https://99store.mx/cdn/shop/files/AURORA_553558-132_PHSLH000-2000.png?v=1738707840&width=823",
    price: 2900.00,
    color: Color.fromARGB(255, 0, 0, 0),
    description: "Un elegante en negro para cualquier ocasión.",
  ),
];

class ShoeDetailsPage extends StatefulWidget{
  final ShoeEntity shoe;
  
  const ShoeDetailsPage(this.shoe, {super.key});

  @override
  _ShoeDetailsPageState createState() => _ShoeDetailsPageState();
}

class SimpleRatingBar extends StatelessWidget{
  const SimpleRatingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          color: Color(0xFFFFBA00),
          size: 18,
        ),
      ),
    );
  }
}

final List<String> reviewImages= [
  'assets/1.png',
  'assets/2.png',
  'assets/3.png',
  'assets/4.png',
];
final addImageUrl =   'assets/add.png';

class ReviewList extends StatelessWidget{
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, index) => SizedBox(width: 18),
        itemBuilder: (_, index) {
          if (index == reviewImages.length) {
            return Image.asset(addImageUrl);
          }
          return Image.asset(reviewImages[index]);
        },
        itemCount: reviewImages.length + 1, // +1 for the add image
      ),
    );
  }
}

class _ShoeDetailsPageState extends State<ShoeDetailsPage> {
  var count = 0;
  double bottomSectionHeight = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: bottomSectionHeight),
            children: [
              AspectRatio(
                aspectRatio: 0.86,
                child: LayoutBuilder(
                  builder: (context, constraints){
                    final imageHeight = constraints.maxHeight * 0.7;
                    final imageHorizontalMargin = constraints.maxWidth * 0.15;
                    final imageBottomMargin = constraints.maxHeight * 0.07;
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: widget.shoe.color,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: imageHorizontalMargin,
                                right: imageHorizontalMargin,
                                bottom: imageBottomMargin,
                              ),
                              child: Image.network(
                                widget.shoe.image,
                                height: imageHeight,
                              ),
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 26),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CounterWidget(
                            currentCount: count,
                            color: widget.shoe.color,
                            onIncreaseClicked: () {
                              setState(() {
                                count++;
                              });
                            },
                            onDecreaseClicked: () {
                              setState(() {
                                if (count > 0) count--;
                              });
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tap 2025',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SimpleRatingBar(),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.shoe.description,
                      style: TextStyle(color: Color(0XFFB0B1B4), fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xFFB0B1B4),
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    ReviewList(),
                  ],
                ),
              )
            ],
          ),
          Container(
            color: widget.shoe.color,
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Image.asset('assets/back.png', width: 32,),
                ),
                Text(
                  widget.shoe.name,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Image.asset('assets/shop_white.png', width: 32,),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: bottomSectionHeight,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "\$",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: widget.shoe.price.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 120,
                    height: 48,
                    child: MyButton(
                      text: "Buy Now",
                      textColor: widget.shoe.color,
                      bgColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CounterWidget extends StatelessWidget{
  final int currentCount;
  final Color color;
  final VoidCallback? onIncreaseClicked;
  final VoidCallback? onDecreaseClicked;
  final textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18);

  CounterWidget({super.key, 
    required this.currentCount,
    required this.color,
    this.onIncreaseClicked,
    this.onDecreaseClicked,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 16),
          GestureDetector(
            onTap: onDecreaseClicked,
            child: Icon(Icons.remove, color: Colors.white)
          ),
          SizedBox(width: 10),
          SizedBox(
          width: 30,
          child: Text(
            currentCount.toString(),
            style: textStyle,
            textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: onIncreaseClicked,
            child: Icon(Icons.add, color: Colors.white)
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

