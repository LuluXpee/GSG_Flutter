import 'lib/stack.dart';

void main(){
  /*
final stack = Stack<int>();
stack.push(1);
stack.push(2);
stack.push(3);
stack.push(4);
print(stack);

final element = stack.pop();
print('Popped: $element');
*/

const list = ['S', 'M', 'O', 'K', 'E'];
final smokeStack = Stack.of(list);
print(smokeStack);
smokeStack.pop();




String areParenthesesBalanced(String input) {
 // List<String> stack = [];
  var stack = Stack<String>();

  for (int i = 0; i < input.length; i++) {
    String char = input[i];

    if (char == '(') {
      stack.push(char); // push
    } else if (char == ')') {
      if (stack.isEmpty) {
        return "Unmatched closing parenthesis"; // Unmatched closing parenthesis
      }
      stack.pop(); // pop
    }
  }

  return " parentheses are balanced"; // If stack is empty,
}
  print(areParenthesesBalanced('h((e))llo(world)'));

}
