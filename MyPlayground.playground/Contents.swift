import UIKit

var greeting = "Hello, playground"

enum NetworkError: Error, Equatable {
    var message: String {
        switch self {
        case .unavailable:
            return "This is not Available"
        case .status(let int):
            return "The code is \(int)"
        case .custom:
            return "Any custom Stuff"
        }
    }
    
    case unavailable
    case status(Int)
    case custom

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.unavailable, .unavailable):
            return true
        case let (.status(code1), .status(code2)):
            return code1 == code2
        case (.custom, .custom):
            return true
        default:
            return false
        }
    }
}


func fetchUserName() throws -> String {
    throw NetworkError.status(404)
}

// Catching Any Swift Error
do {
    try fetchUserName()
} catch {
    print("Operation doesn't Succeed \(error)")
}

// Catching specific type error
do {
    try fetchUserName()
} catch is NetworkError {
    print("is a network error")
} catch {
    print("all other errors")
}

// Specific catching types of error cases
do {
    try fetchUserName()
} catch NetworkError.custom, NetworkError.unavailable {
    print("This is a custom Error")
} catch {
    print("all other errors")
}

// catching specific type error with associated values
do {
    try fetchUserName()
} catch NetworkError.status(let status) {
    print("This error is status \(status)")
} catch {
    print("all other errors")
}

// with filters
do {
    try fetchUserName()
} catch NetworkError.status(let status) where status < 50 {
    print("This error is status code less than 50. Status: \(status) ")
} catch let error as NetworkError where error == .unavailable && error.message.count > 5 {
    print("The error message was: \(error.message)")
} catch let error as NetworkError where error == .status(20) && error.message.count > 10 {
    print("The error message was: \(error.message)")
} catch {
    print("all other errors")
}


do {
    try fetchUserName()
} catch let error as NetworkError where error == .status(20) && error.message.count > 5 {
    print("The most specific. Not only Checking if is the right case with a very specific value, but also checking if one of the error properties is the one we are looking for. The error message was: \(error.message) ")
} catch NetworkError.status(let status) where status < 50 {
    print("Checking if it is a Network Error of case .status and filtering some status from the result, printing the code = [\(status)]")
} catch NetworkError.status(let status) {
    print("Only checking if it is a Network Error of case .status and print status code = [\(status)]")
} catch is NetworkError {
    print("Just checking if is a Network Error")
} catch {
    print("All other errors, most generic one")
}





