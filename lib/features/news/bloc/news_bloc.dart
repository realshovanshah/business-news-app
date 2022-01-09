import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:business_news/app/exceptions/app_exceptions.dart';
import 'package:business_news/features/news/models/news_model.dart';
import 'package:business_news/features/news/repository/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

/// {@template news_bloc}
/// Bloc which manages the current [NewsState]
/// and depends on a [NewsRepository] instance.
/// {@endtemplate}
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  /// {@macro news_bloc}
  NewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(NewsInitial()) {
    on<GetNewsEvent>(_handleGetNewsEvent);
    on<LoadMoreNewsEvent>(_handleLoadMoreNewsEvent);
  }

  final NewsRepository _newsRepository;
  int _page = 2;

  FutureOr<void> _handleGetNewsEvent(
    GetNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());
    try {
      final result = await _newsRepository.getNewsDetails(page: 1);
      if (result != null) {
        emit(NewsLoadSuccess(newsList: result));
      } else {
        emit(NewsLoadFailure(errorMessage: 'Data could not be loaded'));
      }
    } on RateLimitException {
      emit(NewsLoadFailure(errorMessage: 'Woah! go slow. Please wait now!'));
    } catch (e, stk) {
      log(
        'Error in GetNewsEvent: $e',
        name: 'NewsBloc',
        error: e,
        stackTrace: stk,
      );
      emit(NewsLoadFailure(errorMessage: 'Unknown error occured'));
    }
  }

  FutureOr<void> _handleLoadMoreNewsEvent(
    LoadMoreNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    try {
      if (state is NewsLoadSuccess) {
        final currentNewsList = state as NewsLoadSuccess;
        final result = await _newsRepository.getNewsDetails(page: _page);
        if (result != null) {
          emit(
            NewsLoadSuccess(newsList: [...currentNewsList.newsList, ...result]),
          );
          _page++;
        } else {
          emit(NewsLoadFailure(errorMessage: 'Data could not be loaded.'));
        }
      }
    } on RateLimitException {
      emit(NewsLoadFailure(errorMessage: 'Woah! go slow. Please wait now!'));
    } catch (e, stk) {
      log(
        'Error in LoadMoreNewsEvent: $e',
        name: 'NewsBloc',
        error: e,
        stackTrace: stk,
      );
      emit(NewsLoadFailure(errorMessage: 'An unknown error occured'));
    }
  }
}
