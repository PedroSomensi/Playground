import UIKit

var greeting = "Hello, playground"

var messages = ["msg1", "msg2", "msg3"]

for message in messages {
    if message == "msg2" {
        print("i found: \(message)")
    }
}

messages.filter { $0 == "msg2" }.forEach { msg in print("i found: \(msg)") }

for message in messages where message == "msg2" {
    print("i found: \(message)")
}


struct User {
    var nickname: String
}

struct Users {
    var list: [User?] = [User(nickname: "1"), nil, User(nickname: "2")]
}

for case let user? in Users().list {
    print("nickname: \(user.nickname)")
}

enum LoadingState {
    /* case none -- ao invés de adicionar um novo case utilizar o opcional */
    case loading
    case failed(Error)
}

var state: LoadingState?

switch state {
case nil:
    print("state is nil")
case .loading?:
    print("state is loading")
case .failed(let error):
    print("state is failed: \(error)")
}

let points = [(10, 0), (30, -30), (-20, 0)]


for (x, y) in points {
    if y == 0 {
        print("Found a point on the x-axis at \(x)")
    }
}

for case (let x, 0) in points {
    print("Found a point on the x-axis at \(x)")
}

for case let (x, y) in points where x == y || x == -y  {
    print("Found (\(x), \(y)) along a line through the origin")
}


let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        print("teste1")
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        print("teste2")
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        print("teste3")
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")


func chooseBestColor() -> String {
    guard #available(macOS 10.12, *) else {
        return "gray"
    }
    
    return "white"
}

print(chooseBestColor())


if #unavailable(iOS 10) {
    // Fallback code
}

if #available(iOS 10, *) {
    print("#available")
} else {
    // Fallback code
}
