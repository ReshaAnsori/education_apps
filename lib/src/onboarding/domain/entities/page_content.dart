import 'package:education_apps/core/utils/media_res.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          image: MediaRes.casualReading,
          title: 'Brand new curriculum',
          description:
              "this is the first online education platform designed by the world's top professor",
        );

  const PageContent.second()
      : this(
          image: MediaRes.casualLife,
          title: 'Brand new fun atmosphere',
          description:
              "this is the first online education platform designed by the world's top professor",
        );

  const PageContent.third()
      : this(
          image: MediaRes.casualMeditationScience,
          title: 'Easy to join lesson',
          description:
              "this is the first online education platform designed by the world's top professor",
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object> get props => [image, title, description];
}
