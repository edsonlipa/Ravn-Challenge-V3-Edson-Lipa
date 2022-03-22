// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AllPokemonQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AllPokemon($limit: Int) {
      allPokemon(limit: $limit) {
        __typename
        id
        name
        types {
          __typename
          name
          id
        }
        sprites {
          __typename
          front_default
          front_shiny
        }
        generation
        dominant_color {
          __typename
          light
          dark
          original
          r
          g
          b
        }
      }
    }
    """

  public let operationName: String = "AllPokemon"

  public var limit: Int?

  public init(limit: Int? = nil) {
    self.limit = limit
  }

  public var variables: GraphQLMap? {
    return ["limit": limit]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("allPokemon", arguments: ["limit": GraphQLVariable("limit")], type: .list(.object(AllPokemon.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allPokemon: [AllPokemon?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allPokemon": allPokemon.flatMap { (value: [AllPokemon?]) -> [ResultMap?] in value.map { (value: AllPokemon?) -> ResultMap? in value.flatMap { (value: AllPokemon) -> ResultMap in value.resultMap } } }])
    }

    /// get range of Pokemon starting from start variable
    public var allPokemon: [AllPokemon?]? {
      get {
        return (resultMap["allPokemon"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AllPokemon?] in value.map { (value: ResultMap?) -> AllPokemon? in value.flatMap { (value: ResultMap) -> AllPokemon in AllPokemon(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllPokemon?]) -> [ResultMap?] in value.map { (value: AllPokemon?) -> ResultMap? in value.flatMap { (value: AllPokemon) -> ResultMap in value.resultMap } } }, forKey: "allPokemon")
      }
    }

    public struct AllPokemon: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pokemon"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("types", type: .list(.object(`Type`.selections))),
          GraphQLField("sprites", type: .object(Sprite.selections)),
          GraphQLField("generation", type: .scalar(String.self)),
          GraphQLField("dominant_color", type: .object(DominantColor.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int? = nil, name: String? = nil, types: [`Type`?]? = nil, sprites: Sprite? = nil, generation: String? = nil, dominantColor: DominantColor? = nil) {
        self.init(unsafeResultMap: ["__typename": "Pokemon", "id": id, "name": name, "types": types.flatMap { (value: [`Type`?]) -> [ResultMap?] in value.map { (value: `Type`?) -> ResultMap? in value.flatMap { (value: `Type`) -> ResultMap in value.resultMap } } }, "sprites": sprites.flatMap { (value: Sprite) -> ResultMap in value.resultMap }, "generation": generation, "dominant_color": dominantColor.flatMap { (value: DominantColor) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int? {
        get {
          return resultMap["id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// array of all the different Types of the queried Pokemon
      public var types: [`Type`?]? {
        get {
          return (resultMap["types"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [`Type`?] in value.map { (value: ResultMap?) -> `Type`? in value.flatMap { (value: ResultMap) -> `Type` in `Type`(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [`Type`?]) -> [ResultMap?] in value.map { (value: `Type`?) -> ResultMap? in value.flatMap { (value: `Type`) -> ResultMap in value.resultMap } } }, forKey: "types")
        }
      }

      /// array of Sprite objects
      public var sprites: Sprite? {
        get {
          return (resultMap["sprites"] as? ResultMap).flatMap { Sprite(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "sprites")
        }
      }

      /// which generation the queried Pokemon debuted in
      public var generation: String? {
        get {
          return resultMap["generation"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "generation")
        }
      }

      /// dominant color of the queried Pokemon's image
      public var dominantColor: DominantColor? {
        get {
          return (resultMap["dominant_color"] as? ResultMap).flatMap { DominantColor(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "dominant_color")
        }
      }

      public struct `Type`: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Type"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("id", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, id: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "Type", "name": name, "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }

      public struct Sprite: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Sprites"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("front_default", type: .scalar(String.self)),
            GraphQLField("front_shiny", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(frontDefault: String? = nil, frontShiny: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Sprites", "front_default": frontDefault, "front_shiny": frontShiny])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var frontDefault: String? {
          get {
            return resultMap["front_default"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "front_default")
          }
        }

        public var frontShiny: String? {
          get {
            return resultMap["front_shiny"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "front_shiny")
          }
        }
      }

      public struct DominantColor: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Dominant_Color"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("light", type: .scalar(String.self)),
            GraphQLField("dark", type: .scalar(String.self)),
            GraphQLField("original", type: .scalar(String.self)),
            GraphQLField("r", type: .scalar(Int.self)),
            GraphQLField("g", type: .scalar(Int.self)),
            GraphQLField("b", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(light: String? = nil, dark: String? = nil, original: String? = nil, r: Int? = nil, g: Int? = nil, b: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "Dominant_Color", "light": light, "dark": dark, "original": original, "r": r, "g": g, "b": b])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var light: String? {
          get {
            return resultMap["light"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "light")
          }
        }

        public var dark: String? {
          get {
            return resultMap["dark"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "dark")
          }
        }

        public var original: String? {
          get {
            return resultMap["original"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "original")
          }
        }

        public var r: Int? {
          get {
            return resultMap["r"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "r")
          }
        }

        public var g: Int? {
          get {
            return resultMap["g"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "g")
          }
        }

        public var b: Int? {
          get {
            return resultMap["b"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "b")
          }
        }
      }
    }
  }
}
