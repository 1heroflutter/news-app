import '../../core/configs/assets/app_images.dart';
import '../../domain/news/entities/topics_entity.dart';

final List<TopicsEntity> listTopics = [
  TopicsEntity(
    id: "1",
    name: 'Health',
    description:
    'Stay informed with the latest updates in health and wellness, medical breakthroughs, fitness tips, and healthy living advice.',
    img: AppImages.health,
  ),
  TopicsEntity(
    id: "2",
    name: 'Science',
    description:
    'Explore the wonders of the universe with discoveries, research, and innovations across physics, biology, space, and more.',
    img: AppImages.science,
  ),
  TopicsEntity(
    id: "3",
    name: 'Business',
    description:
    'Catch up on global markets, startups, finance trends, and the economy to stay ahead in the business world.',
    img: AppImages.business,
  ),
  TopicsEntity(
    id: "4",
    name: 'Entertainment',
    description:
    'Dive into the world of movies, TV shows, celebrities, music, and everything that keeps you entertained.',
    img: AppImages.entertainment,
  ),
  TopicsEntity(
    id: "5",
    name: 'Sports',
    description:
    'Follow scores, highlights, and news from your favorite teams, players, and major sporting events around the world.',
    img: AppImages.sport,
  ),
  TopicsEntity(
    id: "6",
    name: 'Technology',
    description:
    'Stay updated with the latest in tech, from gadgets and apps to AI, cybersecurity, and industry innovations.',
    img: AppImages.technology,
  ),
];
