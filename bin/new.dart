import 'class_object.dart';

void exampleMethod() {
  //Use 'cmd' + '.' to easy import
  final x = Example(1, 2);
  //Private property is not accessible outside of the module where the class is defined
  // x._private;
  // final a = NonInstantiatable._(3);
}
