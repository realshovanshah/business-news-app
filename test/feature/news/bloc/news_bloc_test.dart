import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:business_news/features/news/bloc/news_bloc.dart';
import 'package:business_news/features/news/models/news_model.dart';
import 'package:business_news/features/news/repository/news_repository.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  group('NewsBloc', () {
    late MockNewsRepository mockNewsRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockNewsRepo = MockNewsRepository();
    });
    test('initial state is NewsInitial', () {
      expect(NewsBloc(newsRepository: mockNewsRepo).state, NewsInitial());
    });

    blocTest<NewsBloc, NewsState>(
      'emits [NewsLoading , NewsLoadSuccess] states for successful news loads',
      setUp: () => when(() => mockNewsRepo.getNewsDetails(page: 1)).thenAnswer(
        (_) async => const [
          NewsModel(
            source: 'test',
            author: 'test',
            description: 'test',
            title: 'test',
          )
        ],
      ),
      build: () => NewsBloc(newsRepository: mockNewsRepo),
      act: (bloc) => bloc.add(GetNewsEvent()),
      expect: () => [
        NewsLoading(),
        NewsLoadSuccess(
          newsList: const [
            NewsModel(
              source: 'test',
              author: 'test',
              description: 'test',
              title: 'test',
            )
          ],
        )
      ],
    );

    blocTest<NewsBloc, NewsState>(
      'emits [NewsLoadSuccess] states for successful next news load',
      setUp: () => when(() => mockNewsRepo.getNewsDetails(page: 2)).thenAnswer(
        (_) async => const [
          NewsModel(
            source: 'test',
            author: 'test',
            description: 'test',
            title: 'test',
          )
        ],
      ),
      build: () => NewsBloc(newsRepository: mockNewsRepo)..add(GetNewsEvent()),
      act: (bloc) => bloc.add(LoadMoreNewsEvent()),
      expect: () => [
        NewsLoadSuccess(
          newsList: const [
            NewsModel(
              source: 'test',
              author: 'test',
              description: 'test',
              title: 'test',
            )
          ],
        )
      ],
    );
  });
}
