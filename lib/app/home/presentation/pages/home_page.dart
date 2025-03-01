import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_page.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';
import 'package:storeapp/app/login/presentation/page/login_page.dart';
import 'package:storeapp/app/util/log.util.dart';

const String _tag = 'HomePage';

class HomePage extends StatelessWidget {
  static const String name = 'HomePage';
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
            body: ProductListWidget(),
            floatingActionButton: FabWidget()),
      ),
    );
  }
}

class FabWidget extends StatelessWidget {
  const FabWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        GoRouter.of(context).push(FormProductPage.link);
      },
      backgroundColor: Colors.green,
      child: Icon(Icons.add),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.read<HomeBloc>();
    //getProducts
    bloc.add(GetProductsEvent());
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state) {
          case EmptyState() || LoadingState() || LoadDataState():
            Log.d(_tag, 'Empty or loading or data loaded');
            break;
          case HomeErrorState():
            Log.d(_tag, 'product error');
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Error',
                      ),
                      content: Text(
                        state.message.toString(),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20.0,
                children: [
                  CircularProgressIndicator(),
                  Text(state.message),
                ],
              ),
            );
          case EmptyState():
            return Center(
              child: Text('No hay productos'),
            );
          case LoadDataState():
            return ListView.builder(
              itemCount: state.model.products.length,
              itemBuilder: (context, index) => ProductItemWidget(
                index: index,
                product: state.model.products[index],
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final int index;
  final ProductModel product;

  const ProductItemWidget({
    super.key,
    required this.index,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return InkWell(
      onLongPress: () {
        //showDialog
        _buildShowDialog(context, bloc);
      },
      child: Card(
        color: Colors.blue,
        child: SizedBox(
          height: 150.0,
          child: Row(
            children: [
              Image.network(
                product.urlImage,
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
                        product.name,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '\$ ${product.price}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      //showDialog
                      _buildShowDialog(context, bloc);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).push(
                        FormProductPage.link,
                        extra: product.id,
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _buildShowDialog(BuildContext context, HomeBloc bloc) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Eliminar producto',
        ),
        content: Text(
          '¿Desea eliminar el producto ${product.name}?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              //TODO: VALIDATE WITH ORIGINAL CODE
              bloc.add(DeleteProductEvent(id: product.id));
              Navigator.of(context).pop();
            },
            child: const Text('Eliminar'),
          )
        ],
      ),
    );
  }
}
