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
import 'package:storeapp/app/user/presentation/pages/users_page.dart';
import 'package:storeapp/app/util/log.util.dart';

const String _tag = 'HomePage';

class HomePage extends StatelessWidget {
  static const String name = 'HomePage';
  static const String link = '/$name';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependencyInjection.serviceLocator.get<HomeBloc>(),
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                60.0,
              ),
              child: AppBarWidget(),
            ),
            body: ProductListWidget(),
            floatingActionButton: FabWidget()),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return AppBar(
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
          onPressed: () async {
            GoRouter.of(context).push(UsersPage.link);
          },
          icon: Icon(
            Icons.people,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        IconButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Cerrar Sesión',
                ),
                content: Text(
                  '¿Estás seguro de cerrar sesión?',
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
                      bloc.add(LogoutEvent());
                    },
                    child: const Text('Cerrar Sesión'),
                  )
                ],
              ),
            );
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
      child: Icon(
        Icons.add,
        size: 40,
      ),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.read<HomeBloc>();
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
            break;
          case LogoutState():
            GoRouter.of(context).go(LoginPage.link);
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20.0,
                children: [
                  CircularProgressIndicator(),
                  Text('Cargando productos...'),
                ],
              ),
            );
          case EmptyState():
            return const Center(
              child: Text('No hay productos'),
            );
          case LoadDataState():
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: state.model.products.length,
              itemBuilder: (context, index) => ProductItemWidget(
                index: index,
                product: state.model.products[index],
              ),
            );
          default:
            return const Center(child: Text("no hay productos"));
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final int index;
  final ProductModel product;

  const ProductItemWidget(
      {super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return InkWell(
      onTap: () {
        GoRouter.of(context).pushNamed(
          FormProductPage.nameUpdate,
          pathParameters: {
            FormProductPage.idKey: product.id,
          },
        );
      },
      onLongPress: () {
        //showDialog
        _buildShowDialog(context, bloc);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(product.urlImage, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '\$ ${product.price}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    _buildShowDialog(context, bloc);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(
                      FormProductPage.nameUpdate,
                      pathParameters: {
                        FormProductPage.idKey: product.id,
                      },
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _buildShowDialog(BuildContext context, HomeBloc bloc) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Desea eliminar el producto ${product.name}?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              bloc.add(DeleteProductEvent(id: product.id));
              Navigator.of(context).pop();
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
