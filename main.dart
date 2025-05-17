import 'dart:io';
import 'dart:math';

class TicTacToe {
  List<String> board = List.filled(9, ' ');
  String humanPlayer = 'X';     // سيتم تعيينها من اختيار المستخدم
  String computerPlayer = 'O';  // الحرف الآخر للخصم
  String currentPlayer = 'X';   // من يبدأ أولاً
  bool gameOver = false;
  bool vsComputer = false;
  final Random random = Random();

  void start() {
    print('🎮 Welcome to Tic Tac Toe!');

    // اختيار اللعب ضد الكمبيوتر أو لاعب آخر
    while (true) {
      stdout.write('Do you want to play against the computer? (y/n): ');
      String? choice = stdin.readLineSync();

      if (choice == null) continue;

      choice = choice.toLowerCase().trim();

      if (choice == 'y') {
        vsComputer = true;
        break;
      } else if (choice == 'n') {
        vsComputer = false;
        break;
      } else {
        print('❌ Please enter only y or n.');
      }
    }

    // السماح باختيار الحرف (X أو O)
    while (true) {
      stdout.write('Choose your symbol (X or O): ');
      String? symbol = stdin.readLineSync();

      if (symbol == null) continue;

      symbol = symbol.toUpperCase().trim();

      if (symbol == 'X' || symbol == 'O') {
        humanPlayer = symbol;
        computerPlayer = symbol == 'X' ? 'O' : 'X';
        currentPlayer = 'X'; // X always starts
        break;
      } else {
        print('❌ Please enter only X or O.');
      }
    }

    // بدء اللعب مع إمكانية الإعادة
    do {
      board = List.filled(9, ' ');
      gameOver = false;
      currentPlayer = 'X'; // X يبدأ دائماً حسب القواعد
      playGame();

      stdout.write('Do you want to play again? (y/n): ');
    } while ((stdin.readLineSync() ?? '').toLowerCase().trim() == 'y');

    print('👋 Thanks for playing!');
  }

  void playGame() {
    printInstructions();

    while (!gameOver) {
      printBoard();

      // تحديد من يلعب (كمبيوتر أو بشر)
      if (vsComputer) {
        if (currentPlayer == humanPlayer) {
          playerMove();
        } else {
          botMove();
        }
      } else {
        playerMove(); // كلا اللاعبين بشر
      }

      // التحقق من الفوز أو التعادل
      if (checkWinner(currentPlayer)) {
        printBoard();
        print('🎉 Player $currentPlayer wins!');
        gameOver = true;
      } else if (!board.contains(' ')) {
        printBoard();
        print('🤝 It\'s a draw!');
        gameOver = true;
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    }
  }

  void printInstructions() {
    print('The board positions are numbered from 0 to 8:');
    print('''
     0 | 1 | 2
    ---+---+---
     3 | 4 | 5
    ---+---+---
     6 | 7 | 8
    ''');
  }

  void printBoard() {
    print('''
     ${board[0]} | ${board[1]} | ${board[2]} 
    ---+---+---
     ${board[3]} | ${board[4]} | ${board[5]} 
    ---+---+---
     ${board[6]} | ${board[7]} | ${board[8]} 
    ''');
  }

  void playerMove() {
    int? move;

    do {
      stdout.write('⬅️ Player $currentPlayer, choose a cell (0-8): ');
      move = int.tryParse(stdin.readLineSync() ?? '');

      if (move == null || move < 0 || move > 8 || board[move] != ' ') {
        print('❌ Invalid move or cell already taken.');
        move = null;
      }
    } while (move == null);

    board[move] = currentPlayer;
  }

  void botMove() {
    print('🤖 Computer is making a move...');
    sleep(Duration(milliseconds: 800));

    List<int> empty = [];
    for (int i = 0; i < 9; i++) {
      if (board[i] == ' ') empty.add(i);
    }

    int move = empty[random.nextInt(empty.length)];
    board[move] = currentPlayer;
  }

  bool checkWinner(String p) {
    List<List<int>> win = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6],
    ];
    return win.any((line) =>
      board[line[0]] == p &&
      board[line[1]] == p &&
      board[line[2]] == p
    );
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.start();
}
