import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/login/presentation/page/login_page.dart';

class HomePage extends StatelessWidget {
  static const String name = 'HomePage';
  static const String _tag = name;
  static const String link = '/$name';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Productos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).pushReplacement(LoginPage.link);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 4,
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) => ProductItemWidget(
            index: index,
          ),
        ),
      ),
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final int index;

  const ProductItemWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: SizedBox(
        height: 150.0,
        child: Row(
          children: [
            Image.network(
              'https://picsum.photos/600/700?random=$index',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Expanded(
              child: SizedBox(
                width: 150.0,
                child: Column(
                  spacing: 8.0,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Producto $index',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '\$ ${3000}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
