import 'package:meta/meta.dart';

void main(List<String> arguments) {
  //Using const for the better performance.
  //If two const User instances have the same values, they're treated as the same so only consumes 1 object memory.
  //If const keywords are not present, they will be identical and consume as much memory as number of instances.
  //Instead of using const, 'extends Object' can be used to inherit this equality feature
  User myUser = const User(firstName: 'John', lastName: 'Doe', photoUrl: 'http://www.example.com/abc');
  final myUser2 = const User(photoUrl: 'http://www.example.com/def', firstName: 'Jihyuk', lastName: 'Lee');

  //Gets error because of the final keyword in name doesn't allow update
  // myUser.name = 'Jane Doe';

  print(myUser2.name);
  print(myUser2.hasLongName());
  print(User(firstName: 'abc', lastName: 'def', photoUrl: 'fff').hasLongName());

  //Call static methods
  print(User.myMethod());

  final x = Example(1, 2);
  //Still can access private property because it's called in the same file where the class is defined
  print(x._private);
  final a = NonInstantiatable._(3);
  print(a.something);

  final person = Person(firstName: 'Jihyuk', lastName: 'Lee', email: 'dean@example.com');
  print(person.email);

  final admin = Admin(specialAdminField: 3.22, firstName: 'firstName', lastName: 'lastName');
  final user = admin as User;
}

class User {
  //Use late keyword to initialize name after executing the constructor body
  //But not good practice cuz it could still return null.
  // late String name;

  //final keyword on fields to not allow update.
  final String name;
  final String photoUrl;
  final String area = 'Melbourne';

  //After assigning final to fields, then const can be assigned to constructor
  //const have better performance than final
  const User({
    required String firstName,
    required String lastName,
    required this.photoUrl,
    //Assigning value to name
  }) : name = '$firstName $lastName';
  // {
  //   // Adding optional constructor body to concatenate firstName and lastName
  //   // This method needs late keyword in name property above.
  //   // For better practice, use ':' after constructor params list.
  //   name = '$firstName $lastName';
  // }

  //class property
  String get information => '$name $photoUrl $area';

  // class method
  bool hasLongName() {
    return name.length > 10;
  }

  static String myMethod() {
    return 'This available without initiating User';
  }

  static const minNameLength = 3;
}

class Example {
  int public;
  //'_'indicates private field
  int _private;

  Example(this.public, this._private);
  Example.namedConstructor({
    required this.public,
    //'_'is not allowed to be used in named constructor use ':' and another constructor above to solve this problem
    required int privateParameter,
  }) : _private = privateParameter;
}

class NonInstantiatable {
  int something;
  // Use '._' constructor to make the class private.
  //Instance won't be created outside of the current module.
  NonInstantiatable._(this.something);
}

class Person {
  final String firstName;
  final String lastName;
  String? _email;

  Person({
    required this.firstName,
    required this.lastName,
    required String email,
  }) {
    this.email = email;
  }

  //class property
  String get fullName => '$firstName $lastName';

  //To set email we can define a method
  // void setEmail(String value) {
  //   if (value.contains('@')) {
  //     _email = value;
  //   } else {
  //     _email = null;
  //   }
  // }

  //Or we can define a setter property instead of using method
  set email(String value) {
    if (value.contains('@')) {
      _email = value;
    } else {
      _email = null;
    }
  }

  //Return _email if it's not null else return 'Email not present'
  String get email => _email ?? 'Email not present';
}

class User2 {
  final String _firstName;
  final String _lastName;

  User2(this._firstName, this._lastName);

  String get fullName => '$_firstName $_lastName';

  //'meta' library to add err underline when child class's method doesn't call super method.
  @mustCallSuper
  void signOut() {
    print('Signing out');
  }
}

class Admin extends User2 {
  final double specialAdminField;

  Admin({required this.specialAdminField, required String firstName, required String lastName}) : super(firstName, lastName);

  @override
  String get fullName => 'Admin: ${super.fullName}';

  @override
  void signOut() {
    print('Admin specific sign out');
    super.signOut();
  }
}
