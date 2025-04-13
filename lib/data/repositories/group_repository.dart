import '../../domain/models/group.dart';

class GroupRepository {
  List<Group> getMyGroups() {
    return [
      Group(
        id: '1',
        name: '20-Somethings',
        imageUrl: 'https://images.unsplash.com/photo-1529333166437-7750a6dd5a70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGZyaWVuZHN8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        members: 1161908,
        isMember: true,
      ),
      Group(
        id: '2',
        name: 'Diet Basic Calorie Counting',
        imageUrl: 'https://images.unsplash.com/photo-1511688878353-3a2f5be94cd7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
        members: 3314539,
        isMember: true,
      ),
      Group(
        id: '3',
        name: 'Low-Carb Diet',
        imageUrl: 'https://images.unsplash.com/photo-1609167830220-7164aa360951?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bG93JTIwY2FyYnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
        members: 18533,
        isMember: true,
      ),
    ];
  }

  List<Group> getSuggestedGroups() {
    return [
      Group(
        id: '4',
        name: 'Recipes & Meals',
        imageUrl: 'https://images.unsplash.com/photo-1548940740-204726a19be3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y29va2luZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
        members: 10811,
      ),
      Group(
        id: '5',
        name: 'Healthy Cooks',
        imageUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGhlYWx0aHklMjBmb29kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
        members: 6704,
      ),
      Group(
        id: '6',
        name: 'Losing 50 to 100 Pounds',
        imageUrl: 'https://via.placeholder.com/150/FF6F61/FFFFFF/?text=50-100',
        members: 6005,
      ),
      Group(
        id: '7',
        name: 'Exercising Everyday',
        imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZXhlcmNpc2V8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        members: 5385,
      ),
      Group(
        id: '8',
        name: 'Losing 25 to 50 Pounds',
        imageUrl: 'https://via.placeholder.com/150/4FB0C6/FFFFFF/?text=25-50',
        members: 4412,
      ),
      Group(
        id: '9',
        name: 'Losing 10 to 25 Pounds',
        imageUrl: 'https://via.placeholder.com/150/96E1F2/000000/?text=10-25',
        members: 3714,
      ),
      Group(
        id: '10',
        name: 'Motivation seekers',
        imageUrl: 'https://images.unsplash.com/photo-1533228876829-65c94e7b5025?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8bW90aXZhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
        members: 3631,
      ),
      Group(
        id: '11',
        name: 'MyNetDiary Beginners',
        imageUrl: 'https://via.placeholder.com/150/FFDE59/000000/?text=MND',
        members: 3531,
      ),
    ];
  }

  List<GroupCategory> getGroupCategories() {
    return [
      GroupCategory(
        id: '1',
        name: 'ACTIVITY',
        icon: '🧘',
        description: 'Find your fit, no matter the activity',
      ),
      GroupCategory(
        id: '2',
        name: 'AGE',
        icon: '👵',
        description: 'Connect with those in your same age group',
      ),
      GroupCategory(
        id: '3',
        name: 'DIET',
        icon: '🥗',
        description: 'Advice & support from others on your eating plan',
      ),
      GroupCategory(
        id: '4',
        name: 'FOOD',
        icon: '🍳',
        description: 'Explore and share recipes with others',
      ),
    ];
  }
} 