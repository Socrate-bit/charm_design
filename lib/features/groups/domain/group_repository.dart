import 'group.dart';

class GroupRepository {
  List<Group> getMyGroups() {
    return [
      Group(
        id: '1',
        name: 'Daily Mindfulness Practice',
        imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG1lZGl0YXRpb258ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        members: 161908,
        isMember: true,
      ),
      Group(
        id: '2',
        name: 'Productivity Masterminds',
        imageUrl: 'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZHVjdGl2aXR5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
        members: 314539,
        isMember: true,
      ),
      Group(
        id: '3',
        name: 'Personal Finance Growth',
        imageUrl: 'https://images.unsplash.com/photo-1579621970588-a35d0e7ab9b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8ZmluYW5jZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
        members: 88533,
        isMember: true,
      ),
    ];
  }

  List<Group> getSuggestedGroups() {
    return [
      Group(
        id: '4',
        name: 'Morning Routines',
        imageUrl: 'https://images.unsplash.com/photo-1506968430777-bf7784a87f23?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bW9ybmluZyUyMHJvdXRpbmV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        members: 110811,
      ),
      Group(
        id: '5',
        name: 'Habit Builders',
        imageUrl: 'https://images.unsplash.com/photo-1608501078713-8e445a709b39?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
        members: 76704,
      ),
      Group(
        id: '6',
        name: 'Journal Enthusiasts',
        imageUrl: 'https://images.unsplash.com/photo-1517842645767-c639042777db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8am91cm5hbGluZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
        members: 56005,
      ),
      Group(
        id: '7',
        name: 'Book Reading Challenge',
        imageUrl: 'https://images.unsplash.com/photo-1513001900722-370f803f498d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cmVhZGluZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
        members: 45385,
      ),
      Group(
        id: '8',
        name: 'Positive Psychology',
        imageUrl: 'https://images.unsplash.com/photo-1522199710521-72d69614c702?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cG9zaXRpdmUlMjBwc3ljaG9sb2d5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
        members: 34412,
      ),
      Group(
        id: '9',
        name: 'Digital Minimalism',
        imageUrl: 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWluaW1hbGlzbXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
        members: 33714,
      ),
      Group(
        id: '10',
        name: 'Motivation Seekers',
        imageUrl: 'https://images.unsplash.com/photo-1533228876829-65c94e7b5025?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8bW90aXZhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
        members: 33631,
      ),
      Group(
        id: '11',
        name: 'Stoicism in Modern Life',
        imageUrl: 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3RvaWNpc218ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        members: 23531,
      ),
    ];
  }

  List<GroupCategory> getGroupCategories() {
    return [
      GroupCategory(
        id: '1',
        name: 'MINDFULNESS',
        icon: '🧘',
        description: 'Practice meditation and mindful living',
      ),
      GroupCategory(
        id: '2',
        name: 'PRODUCTIVITY',
        icon: '⏱️',
        description: 'Systems and techniques to achieve more',
      ),
      GroupCategory(
        id: '3',
        name: 'PERSONAL GROWTH',
        icon: '🌱',
        description: 'Resources for continuous improvement',
      ),
      GroupCategory(
        id: '4',
        name: 'SKILLS',
        icon: '🎯',
        description: 'Learn and master new abilities',
      ),
      GroupCategory(
        id: '5',
        name: 'FINANCE',
        icon: '💰',
        description: 'Build wealth and financial intelligence',
      ),
      GroupCategory(
        id: '6',
        name: 'HABITS',
        icon: '🔄',
        description: 'Creating positive routines and breaking bad ones',
      ),
    ];
  }
} 