import 'dart:io';             // لإدخال وإخراج البيانات من وإلى المستخدم (stdin, stdout)
import 'dart:math';           // لتوليد أرقام عشوائية

// تعريف كلاس اللعبة
class TicTacToe {
  List<String> board = List.filled(9, ' '); // مصفوفة تمثل اللوحة، بها 9 خلايا فارغة
  String humanPlayer = 'X';     // حرف اللاعب البشري، يتم تحديده لاحقًا
  String computerPlayer = 'O';  // حرف الكمبيوتر (العكس من اللاعب)
  String currentPlayer = 'X';   // من يبدأ أولًا (X دائمًا)
  bool gameOver = false;        // حالة انتهاء اللعبة
  bool vsComputer = false;      // هل نلعب ضد الكمبيوتر أم لاعب بشري آخر
  final Random random = Random(); // مولد أرقام عشوائية للكمبيوتر

  // بدء اللعبة
  void start() {
    print('🎮 Welcome to Tic Tac Toe!'); // ترحيب باللاعب

    // سؤال المستخدم: هل تريد اللعب ضد الكمبيوتر؟
    while (true) {
      stdout.write('Do you want to play against the computer? (y/n): ');
      String? choice = stdin.readLineSync();

      if (choice == null) continue;

      choice = choice.toLowerCase().trim();

      if (choice == 'y') {
        vsComputer = true;  // اللعب ضد الكمبيوتر
        break;
      } else if (choice == 'n') {
        vsComputer = false; // اللعب ضد لاعب آخر
        break;
      } else {
        print('❌ Please enter only y or n.'); // رسالة خطأ عند إدخال خاطئ
      }
    }

    // اختيار الرمز (X أو O)
    while (true) {
      stdout.write('Choose your symbol (X or O): ');
      String? symbol = stdin.readLineSync();

      if (symbol == null) continue;

      symbol = symbol.toUpperCase().trim();

      if (symbol == 'X' || symbol == 'O') {
        humanPlayer = symbol;
        computerPlayer = symbol == 'X' ? 'O' : 'X'; // الكمبيوتر يأخذ الحرف الآخر
        currentPlayer = 'X'; // دائمًا يبدأ بـ X
        break;
      } else {
        print('❌ Please enter only X or O.'); // تنبيه عند إدخال خاطئ
      }
    }

    // حلقة لتكرار اللعب في حال أراد اللاعب ذلك
    do {
      board = List.filled(9, ' ');  // إعادة تعيين اللوحة
      gameOver = false;             // إعادة تعيين حالة النهاية
      currentPlayer = 'X';          // إعادة تعيين الدور
      playGame();                   // تشغيل اللعبة

      stdout.write('Do you want to play again? (y/n): '); // إعادة اللعبة؟
    } while ((stdin.readLineSync() ?? '').toLowerCase().trim() == 'y');

    print('👋 Thanks for playing!'); // شكرًا على اللعب
  }

  // منطق اللعبة الكامل
  void playGame() {
    printInstructions(); // طباعة التعليمات مع أرقام الخانات

    while (!gameOver) {
      printBoard(); // طباعة الحالة الحالية للوحة

      if (vsComputer) {
        if (currentPlayer == humanPlayer) {
          playerMove(); // دور اللاعب
        } else {
          botMove();    // دور الكمبيوتر
        }
      } else {
        playerMove(); // كلا اللاعبين بشر
      }

      // التحقق من وجود فائز أو تعادل
      if (checkWinner(currentPlayer)) {
        printBoard(); // طباعة اللوحة النهائية
        print('🎉 Player $currentPlayer wins!'); // طباعة الفائز
        gameOver = true; // إنهاء اللعبة
      } else if (!board.contains(' ')) {
        printBoard(); // طباعة اللوحة النهائية
        print('🤝 It\'s a draw!'); // تعادل
        gameOver = true;
      } else {
        // تبديل الدور بين X و O
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    }
  }

  // طباعة أرقام المربعات
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

  // طباعة اللوحة الحالية
  void printBoard() {
    print('''
     ${board[0]} | ${board[1]} | ${board[2]} 
    ---+---+---
     ${board[3]} | ${board[4]} | ${board[5]} 
    ---+---+---
     ${board[6]} | ${board[7]} | ${board[8]} 
    ''');
  }

  // تحريك اللاعب (إدخال يدوي)
  void playerMove() {
    int? move;

    do {
      stdout.write('⬅️ Player $currentPlayer, choose a cell (0-8): ');
      move = int.tryParse(stdin.readLineSync() ?? ''); // قراءة الرقم

      // التحقق من صحة الرقم ومن أن الخلية فارغة
      if (move == null || move < 0 || move > 8 || board[move] != ' ') {
        print('❌ Invalid move or cell already taken.');
        move = null;
      }
    } while (move == null); // التكرار حتى إدخال صالح

    board[move] = currentPlayer; // تحديث الخلية
  }

  // حركة الكمبيوتر (عشوائية)
  void botMove() {
    print('🤖 Computer is making a move...');
    sleep(Duration(milliseconds: 800)); // تأخير بسيط لمحاكاة التفكير

    // جمع كل الخانات الفارغة
    List<int> empty = [];
    for (int i = 0; i < 9; i++) {
      if (board[i] == ' ') empty.add(i);
    }

    // اختيار خانة عشوائية من الفارغات
    int move = empty[random.nextInt(empty.length)];
    board[move] = currentPlayer; // وضع الحركة
  }

  // التحقق من الفوز
  bool checkWinner(String p) {
    // كل احتمالات الفوز (صفوف + أعمدة + أقطار)
    List<List<int>> win = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // صفوف
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // أعمدة
      [0, 4, 8], [2, 4, 6],            // أقطار
    ];
    
    // إذا تحققت أي مجموعة فوز يرجع true
    return win.any((line) =>
      board[line[0]] == p &&
      board[line[1]] == p &&
      board[line[2]] == p
    );
  }
}

// نقطة البدء في البرنامج
void main() {
  TicTacToe game = TicTacToe(); // إنشاء كائن اللعبة
  game.start();                 // بدء اللعبة
}
