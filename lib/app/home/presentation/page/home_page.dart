import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
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
        value: DependencyInjection.serviceLocator<HomeBloc>(),
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
        //getProducts
        final HomeBloc bloc = context.read<HomeBloc>();
        //bloc.add(GetProductsEvent());
      },
    );
  }
}

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({
    super.key,
  });

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  void initState() {
    super.initState();
    //getProducts
    final HomeBloc bloc = context.read<HomeBloc>();
    bloc.add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.read<HomeBloc>();
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state) {
          case EmptyState() || LoadingState() || DataLoadedState():
            Log.d(_tag, 'Empty or loading or data loaded');
            break;
          case ErrorState():
            Log.d(_tag, 'product error');
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Error',
                      ),
                      content: Text(
                        state.errorMessage.toString(),
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
          case DataLoadedState():
            return ListView.builder(
              itemCount: state.model.products.length,
              itemBuilder: (context, index) => ProductItemWidget(
                bloc: bloc,
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
  final HomeBloc bloc;

  const ProductItemWidget({
    super.key,
    required this.index,
    required this.product,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        //showDialog
        showDialog(
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
                  bloc.add(DeleteProductEvent(productId: product.id));
                  Navigator.of(context).pop();
                },
                child: const Text('Eliminar'),
              )
            ],
          ),
        );
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
            ],
          ),
        ),
      ),
    );
  }
}
