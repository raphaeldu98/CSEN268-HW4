import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/book_cubit.dart';
import '../cubit/book_state.dart';

class BookListScreen extends StatefulWidget {
  final bool byAuthor;

  BookListScreen({required this.byAuthor});

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  @override
  void initState() {
    super.initState();

    final bookCubit = context.read<BookCubit>();

    if (widget.byAuthor) {
      // print('Sorting by author...');
      bookCubit.sortByAuthor(); 
    } else {
      // print('Sorting by title...'); 
      bookCubit.sortByTitle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.byAuthor ? 'Books Sorted by Author' : 'Books Sorted by Title'),
      ),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return Center(child: CircularProgressIndicator()); 
          } else if (state is BookListLoaded) {
            final books = state.books;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () {
                    context.go('/byAuthor/detail', extra: book);
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}