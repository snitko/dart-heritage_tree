import "package:test/test.dart";
import 'dart:mirrors';
import '../lib/heritage_tree.dart';

class Heritable extends Object with HeritageTree {}

void main() {

  Heritable parent;
  List      children_level_1 = [];
  List      children_level_2 = [];

  setUp(() {
    parent = new Heritable() ;
    for(var i=0; i < 5; i++) {
      children_level_1.add(new Heritable());
      children_level_1[i].id = "l1_child${i+1}";
    }
    for(var i=0; i < 5; i++) {
      children_level_2.add(new Heritable());
      children_level_2[i].id = "l2_child${i+1}";
    }
  });


  test("adds child and sets its parent to self", () {
    parent.addChild(children_level_1[0]);
    expect(parent.children, contains(children_level_1[0]));
    expect(parent.children.first.parent, equals(parent));
  });

  test("finds child by id", () {
    parent.addChild(children_level_1[0]);
    parent.addChild(children_level_1[1]);
    expect(parent.findChildById('l1_child1'), equals(children_level_1[0]));
  });

  test("returns Null if child with such an id is not found", () {
    parent.addChild(children_level_1[0]);
    expect(parent.findChildById('no_such_id'), equals(null));
  });

  test("doesn't add the same child twice", () {
    parent.addChild(children_level_1[0]);
    parent.addChild(children_level_1[0]);
    expect(parent.children, hasLength(1));
  });

  test("removes the child by its id", () {
    parent.addChild(children_level_1[0]);
    parent.addChild(children_level_1[1]);
    parent.removeChild('l1_child2');
    expect(parent.children, hasLength(1));
  });

  test("finds descendants by id", () {
    for(var i=0; i < 5; i++) {
      parent.addChild(children_level_1[i]);
      parent.children[i].addChild(children_level_2[i]);
    }
    expect(parent.findDescendantsById('l2_child1').first, equals(children_level_2[0]));
  });

  test("finds first descendant by id", () {
    for(var i=0; i < 5; i++) {
      parent.addChild(children_level_1[i]);
      parent.children[i].addChild(children_level_2[i]);
    }
    expect(parent.findDescendantById('l2_child1'), equals(children_level_2[0]));
  });

  test("finds descendant by fullpath", () {});

}
