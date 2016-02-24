abstract class HeritageTree {

  List   children = [];
  var    parent;
  String id;

  addChild(HeritageTree child) {
    child.parent = this;
    if(!children.contains(child)) {
      children.add(child);
    }
  }

  findChildById(String child_id) {
    return this.children.firstWhere((c) => c.id == child_id, orElse: () => null);
  }

  removeChild(String child_id) {
    this.children.removeWhere((c) => c.id == child_id);
  }

  findDescendantsById(String descendant_id) {
    List descendants = [];
    var d = this.findChildById(descendant_id);
    if(!(d is Null))
      descendants.add(d);
    this.children.forEach((c) {
      c.findDescendantsById(descendant_id).forEach((d) {
        descendants.add(d);
      });
    });
    return descendants;
  }

  findDescendantById(String descendant_id) {
    var descendant = this.findChildById(descendant_id);
    if(!(descendant is Null))
      return descendant;
    this.children.firstWhere((c) =>
      !((descendant = c.findDescendantById(descendant_id)) is Null)
    , orElse: () => null);
    return descendant;
  }

}
