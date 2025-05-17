import 'lib/linked_list.dart';

void main(){


 challengeOne();
  challengeTwo();
  challengeThree();
  challengeFour();

}

void challengeOne() {
  var list = LinkedList<int>();
  list.push(3);
  list.push(2);
  list.push(1);

  print('Original list: $list');
  print("Printing in reverse:");
  printListInReverse(list);
}

void printListInReverse<E>(LinkedList<E> list) {
  printNodesRecursively(list.head);
}

void printNodesRecursively<T>(Node<T>? node) {
  if (node == null) return;
  printNodesRecursively(node.next);
  print(node.value);
}

void challengeTwo() {
  var list = LinkedList<int>();
  list.push(3);
  list.push(2);
  list.push(1);
  print(list);

  final middleNode = getMiddle(list);
  print('Middle: ${middleNode?.value}');
}

Node<E>? getMiddle<E>(LinkedList<E> list) {
  var slow = list.head;
  var fast = list.head;

  while (fast?.next != null) {
    fast = fast?.next?.next;
    slow = slow?.next;
  }

  return slow;
}

void challengeThree() {
  var list = LinkedList<int>();
  list.push(3);
  list.push(2);
  list.push(1);

  print('Original list: $list');
  list.reverse();
  print('Reversed list: $list');
}

extension ReversibleLinkedList<E> on LinkedList<E> {
  
  void reverse() {
    tail = head;
    var previous = head;
    var current = head?.next;
    previous?.next = null;

    while (current != null) {
      final next = current.next;
      current.next = previous;
      previous = current;
      current = next;
    }

    head = previous;
  }
}

void challengeFour() {
  var list = LinkedList<int>();
  list.push(4);
  list.push(3);
  list.push(3);
  list.push(3);
  list.push(1);

  list.removeAll(3);
  print(list);
}

extension RemovableLinkedList<E> on LinkedList {
  void removeAll(E value) {
    while (head != null && head!.value == value) {
      head = head!.next;
    }
    var previous = head;
    var current = head?.next;
    while (current != null) {
      if (current.value == value) {
        previous?.next = current.next;
        current = previous?.next;
        continue;
      }
      previous = current;
      current = current.next;
    }
    tail = previous;
  }
}




