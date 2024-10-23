import 'package:equatable/equatable.dart';
import '../models/book_model.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookListLoaded extends BookState {
  final List<Book> books;

  const BookListLoaded(this.books);

  @override
  List<Object> get props => [books];
}