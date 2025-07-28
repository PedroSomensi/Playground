import UIKit


@resultBuilder
struct StringBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: " ")
    }
}

func buildSentence(@StringBuilder _ content: () -> String) -> String {
    content()
}

let frase = buildSentence {
    "Olá,"
    "Mundo!"
}

print(frase)

struct User {
    var name: String
    var email: String
    var age: Int
}

struct ValidationResult {
    var errors: [String] = []
    
    mutating func add(_ error: String) {
        errors.append(error)
    }
}

@resultBuilder
struct ValidationBuilder<UserType> {
    static func buildBlock(_ components: (UserType) -> String?...) -> [(UserType) -> String?] {
        components
    }
}

func validate<UserType>(_ user: UserType, @ValidationBuilder<UserType> rules: () -> [(UserType) -> String?]) -> ValidationResult {
    let checks = rules()
    var result = ValidationResult()
    for check in checks {
        if let error = check(user) {
            result.add(error)
        }
    }
    return result
}

func require<T, V>(_ keyPath: KeyPath<T, V>) -> RuleBuilder<T, V> {
    RuleBuilder(keyPath: keyPath)
}

struct RuleBuilder<T, V> {
    let keyPath: KeyPath<T, V>

    func isNotEmpty(_ message: String) -> (T) -> String? where V == String {
        { user in
            user[keyPath: keyPath].isEmpty ? message : nil
        }
    }

    func isEmail(_ message: String) -> (T) -> String? where V == String {
        { user in
            user[keyPath: keyPath].contains("@") ? nil : message
        }
    }

    func isAtLeast(_ min: Int, _ message: String) -> (T) -> String? where V == Int {
        { user in
            user[keyPath: keyPath] >= min ? nil : message
        }
    }
}

let user = User(name: "", email: "email@errado", age: 16)

let result = validate(user as User) {
    require(\User.name).isNotEmpty("Nome é obrigatório")
    require(\User.email).isEmail("Email inválido")
    require(\User.age).isAtLeast(18, "Precisa ter 18 anos ou mais")
}

print(result.errors) // ["Nome é obrigatório", "Email inválido", "Precisa ter 18 anos ou mais"]

struct Product {
    var title: String
    var price: Double
}

let product = Product(title: "", price: 0)

let result1 = validate(product) {
    require(\Product.title).isNotEmpty("Título obrigatório")
}

print(result1.errors)


let keyPath = \User.email

let user2 = User(name: "Ana", email: "ana@email.com", age: 30)

print(user2[keyPath: keyPath]) // "Ana"
