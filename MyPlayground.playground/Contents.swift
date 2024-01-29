import UIKit

var greeting = "Hello, playground"
let divisor = "\n"

extension String.StringInterpolation {
    
    /// resolves warning about printing optional values
    mutating func appendInterpolation<T: CustomStringConvertible>(_ value: T?) {
        appendInterpolation(value ?? "nil" as CustomStringConvertible)
    }
    
    /// makes it possible to print data's that will be converted to json directly in print
    mutating func appendInterpolation(_ json: Data) {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: json, options: []),
              let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
            return appendInterpolation("\nINVALID JSON - INTERPOLATION \n")
        }
        appendInterpolation("\n\(String(decoding: jsonData, as: UTF8.self))")
    }
    
    /// makes it possible to print URLRequest more informations
    mutating func appendInterpolation(_ request: URLRequest) {
        appendInterpolation("\(request.url) | \(request.httpMethod)")
    }
    
}

var value: String? = "values"
print("improve interpolation to dont show warning about optionals \(value)")
print(divisor)

let jsonData = """
    {
        "balance": "R$ 9.99"
    }
""".data(using: .utf8)!

let jsonInvalid = """
{
    name: "John Doe",
    age 30,
    "country": "Neverland",
}
""".data(using: .utf8)!

print("JSON: \(jsonData)")
print("JSON: \(jsonInvalid)")
print(divisor)

/*
 improve interpolation to dont show warning about optionals values


 JSON:
 {
   "balance" : "R$ 9.99"
 }
 JSON:
 INVALID JSON - INTERPOLATION
*/
