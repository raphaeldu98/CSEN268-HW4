import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_state.dart';
import '../models/book_model.dart';

class BookCubit extends Cubit<BookState> {
  List<Book> _initialBooks = [];

  BookCubit() : super(BookInitial());

  void initBooks() {
    final books = [
      Book(
        title: 'The Da Vinci Code',
        author: 'Dan Brown',
        description: 'A mystery thriller novel.',
      ),
      Book(
        title: 'Angels & Demons',
        author: 'Dan Brown',
        description: 'A symbologist races to solve a murder mystery.',
      ),
      Book(
        title: 'The Hobbit',
        author: 'J.R.R. Tolkien',
        description: 'A fantasy adventure of Bilbo Baggins.',
      ),
      Book(
        title: 'The Lord of the Rings',
        author: 'J.R.R. Tolkien',
        description: 'The epic journey of Frodo and the Fellowship.',
      ),
    ];

    _initialBooks = books;
    emit(BookListLoaded(_initialBooks));
  }

  void sortByAuthor() {
    // print('Sorting by Author...');
    emit(BookLoading());
    // print('Loading state emitted');
    Future.delayed(Duration(milliseconds: 400), () {  
      final sortedBooks = List<Book>.from(_initialBooks);
      sortedBooks.sort((a, b) => a.author.compareTo(b.author));
      emit(BookListLoaded(sortedBooks)); 
      // print('Books sorted by Author and emitted');
    });
  }

  void sortByTitle() {
    // print('Sorting by title...');
    emit(BookLoading());
    // print('Loading state emitted');
    Future.delayed(Duration(milliseconds: 400), () {
      final sortedBooks = List<Book>.from(_initialBooks); 
      sortedBooks.sort((a, b) => a.title.compareTo(b.title));
      // print(sortedBooks[0].title);
      emit(BookListLoaded(sortedBooks));
      // print('Books sorted by title and emitted');
    });
  }
}