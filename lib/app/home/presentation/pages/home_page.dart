import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class HomePage extends StatelessWidget {
  static const String name = 'homePage';
  static const String _tag = name;
  static const String link = '/$name';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependencyInjection.serviceLocator.get<HomeBloc>(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              "Listado de Productos",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Icon(
                Icons.logout,
                color: Colors.white,
              ),
              SizedBox(
                width: 16.0,
              ),
            ],
          ),
          body: ProductsListWidget(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orangeAccent,
            onPressed: () => GoRouter.of(context).pushNamed("form-product"),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class ProductsListWidget extends StatefulWidget {
  const ProductsListWidget({
    super.key,
  });

  @override
  State<ProductsListWidget> createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends State<ProductsListWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    bloc.add(GetProductsEvent());
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state) {
          case LoadingState() || EmptyState() || LoadDataState():
            break;
          case HomeErrorState():
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(state.message),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            bloc.add(GetProductsEvent());
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ));
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(state.message)
                  ],
                ),
              ),
            );
          case EmptyState():
            return Center(child: Text("No se encontraron productos"));
          case LoadDataState():
            return ListView.builder(
              itemCount: state.model.products.length,
              itemBuilder: (context, index) =>
                  ProductItemWidget(state.model.products[index]),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductItemWidget(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return InkWell(
      onTap: () => GoRouter.of(context)
          .pushNamed("form-product-u", pathParameters: {"id": product.id}),
      onLongPress: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Eliminación de Producto'),
                content: Text(
                    "Está seguro de eliminar este producto?: ${product.name}"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                      bloc.add(DeleteProductEvent(id: product.id));
                    },
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancelar'),
                    child: const Text('Cancelar'),
                  ),
                ],
              )),
      child: Card(
          child: Row(
        children: [
          Image.network(
            product.urlImage,
            width: 150.0,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: SizedBox(
              height: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(product.name),
                  Text("\$${product.price}"),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
