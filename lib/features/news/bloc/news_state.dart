part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoadSuccess extends NewsState {
  NewsLoadSuccess({this.hasReachedMax = false, required this.newsList});
  final List<NewsModel> newsList;
  final bool hasReachedMax;

  @override
  List<Object?> get props => newsList;
}

class NewsLoadFailure extends NewsState {
  NewsLoadFailure({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
