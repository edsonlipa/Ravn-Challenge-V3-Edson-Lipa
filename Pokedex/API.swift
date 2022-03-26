// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class PokemonsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query pokemons($first: Int!) {
      pokemons(first: $first) {
        __typename
        id
        number
        name
        weight {
          __typename
          minimum
          maximum
        }
        height {
          __typename
          minimum
          maximum
        }
        classification
        types
        resistant
        weaknesses
        fleeRate
        maxCP
        maxHP
        image
      }
    }
    """

  public let operationName: String = "pokemons"

  public var first: Int

  public init(first: Int) {
    self.first = first
  }

  public var variables: GraphQLMap? {
    return ["first": first]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pokemons", arguments: ["first": GraphQLVariable("first")], type: .list(.object(Pokemon.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pokemons: [Pokemon?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "pokemons": pokemons.flatMap { (value: [Pokemon?]) -> [ResultMap?] in value.map { (value: Pokemon?) -> ResultMap? in value.flatMap { (value: Pokemon) -> ResultMap in value.resultMap } } }])
    }

    public var pokemons: [Pokemon?]? {
      get {
        return (resultMap["pokemons"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Pokemon?] in value.map { (value: ResultMap?) -> Pokemon? in value.flatMap { (value: ResultMap) -> Pokemon in Pokemon(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Pokemon?]) -> [ResultMap?] in value.map { (value: Pokemon?) -> ResultMap? in value.flatMap { (value: Pokemon) -> ResultMap in value.resultMap } } }, forKey: "pokemons")
      }
    }

    public struct Pokemon: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pokemon"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("number", type: .scalar(String.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("weight", type: .object(Weight.selections)),
          GraphQLField("height", type: .object(Height.selections)),
          GraphQLField("classification", type: .scalar(String.self)),
          GraphQLField("types", type: .list(.scalar(String.self))),
          GraphQLField("resistant", type: .list(.scalar(String.self))),
          GraphQLField("weaknesses", type: .list(.scalar(String.self))),
          GraphQLField("fleeRate", type: .scalar(Double.self)),
          GraphQLField("maxCP", type: .scalar(Int.self)),
          GraphQLField("maxHP", type: .scalar(Int.self)),
          GraphQLField("image", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, number: String? = nil, name: String? = nil, weight: Weight? = nil, height: Height? = nil, classification: String? = nil, types: [String?]? = nil, resistant: [String?]? = nil, weaknesses: [String?]? = nil, fleeRate: Double? = nil, maxCp: Int? = nil, maxHp: Int? = nil, image: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Pokemon", "id": id, "number": number, "name": name, "weight": weight.flatMap { (value: Weight) -> ResultMap in value.resultMap }, "height": height.flatMap { (value: Height) -> ResultMap in value.resultMap }, "classification": classification, "types": types, "resistant": resistant, "weaknesses": weaknesses, "fleeRate": fleeRate, "maxCP": maxCp, "maxHP": maxHp, "image": image])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The ID of an object
      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// The identifier of this Pokémon
      public var number: String? {
        get {
          return resultMap["number"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "number")
        }
      }

      /// The name of this Pokémon
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The minimum and maximum weight of this Pokémon
      public var weight: Weight? {
        get {
          return (resultMap["weight"] as? ResultMap).flatMap { Weight(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "weight")
        }
      }

      /// The minimum and maximum weight of this Pokémon
      public var height: Height? {
        get {
          return (resultMap["height"] as? ResultMap).flatMap { Height(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "height")
        }
      }

      /// The classification of this Pokémon
      public var classification: String? {
        get {
          return resultMap["classification"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "classification")
        }
      }

      /// The type(s) of this Pokémon
      public var types: [String?]? {
        get {
          return resultMap["types"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "types")
        }
      }

      /// The type(s) of Pokémons that this Pokémon is resistant to
      public var resistant: [String?]? {
        get {
          return resultMap["resistant"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "resistant")
        }
      }

      /// The type(s) of Pokémons that this Pokémon weak to
      public var weaknesses: [String?]? {
        get {
          return resultMap["weaknesses"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "weaknesses")
        }
      }

      public var fleeRate: Double? {
        get {
          return resultMap["fleeRate"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "fleeRate")
        }
      }

      /// The maximum CP of this Pokémon
      public var maxCp: Int? {
        get {
          return resultMap["maxCP"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "maxCP")
        }
      }

      /// The maximum HP of this Pokémon
      public var maxHp: Int? {
        get {
          return resultMap["maxHP"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "maxHP")
        }
      }

      public var image: String? {
        get {
          return resultMap["image"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image")
        }
      }

      public struct Weight: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PokemonDimension"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("minimum", type: .scalar(String.self)),
            GraphQLField("maximum", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(minimum: String? = nil, maximum: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "PokemonDimension", "minimum": minimum, "maximum": maximum])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The minimum value of this dimension
        public var minimum: String? {
          get {
            return resultMap["minimum"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "minimum")
          }
        }

        /// The maximum value of this dimension
        public var maximum: String? {
          get {
            return resultMap["maximum"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "maximum")
          }
        }
      }

      public struct Height: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PokemonDimension"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("minimum", type: .scalar(String.self)),
            GraphQLField("maximum", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(minimum: String? = nil, maximum: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "PokemonDimension", "minimum": minimum, "maximum": maximum])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The minimum value of this dimension
        public var minimum: String? {
          get {
            return resultMap["minimum"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "minimum")
          }
        }

        /// The maximum value of this dimension
        public var maximum: String? {
          get {
            return resultMap["maximum"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "maximum")
          }
        }
      }
    }
  }
}
