import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapi_clean_architecture_cubit/app/presentation/home/cubit/articles_cubit.dart';
import 'package:newsapi_clean_architecture_cubit/di/injector.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector.resolve<ArticlesCubit>()..getArticles(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'NewsAPI x CleanArch',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder<ArticlesCubit, ArticlesState>(builder: (_, state) {
      if (state is ArticlesInitial || state is ArticlesIsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ArticlesIsLoaded) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    state.articles[i].urlToImage ??
                        state.articles[i].author.toString().substring(0, 1),
                  ),
                ),
                title: Text(state.articles[i].title ?? ''),
                subtitle: Text(state.articles[i].author ?? ''),
              ),
            );
          },
          separatorBuilder: (_, i) => const Divider(
            thickness: 1.4,
          ),
          itemCount: state.articles.length,
        );
      } else if (state is ArticlesOnError) {
        return Center(
          child: Text(state.failure.message),
        );
      } else {
        return Container();
      }
    });
  }
}
