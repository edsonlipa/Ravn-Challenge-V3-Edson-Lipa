// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class PokemonQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Pokemon($pokemonId: Int!) {
      pokemon(id: $pokemonId) {
        __typename
        id
        name
        nat_dex_num
      }
    }
    """

  public let operationName: String = "Pokemon"

  public var pokemonId: Int

  public init(pokemonId: Int) {
    self.pokemonId = pokemonId
  }

  public var variables: GraphQLMap? {
    return ["pokemonId": pokemonId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pokemon", arguments: ["id": GraphQLVariable("pokemonId")], type: .object(Pokemon.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pokemon: Pokemon? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "pokemon": pokemon.flatMap { (value: Pokemon) -> ResultMap in value.resultMap }])
    }

    public var pokemon: Pokemon? {
      get {
        return (resultMap["pokemon"] as? ResultMap).flatMap { Pokemon(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "pokemon")
      }
    }

    public struct Pokemon: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pokemon"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("nat_dex_num", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int? = nil, name: String? = nil, natDexNum: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "Pokemon", "id": id, "name": name, "nat_dex_num": natDexNum])
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

      public var natDexNum: Int? {
        get {
          return resultMap["nat_dex_num"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "nat_dex_num")
        }
      }
    }
  }
}

public final class AllPokemonQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AllPokemon {
      allPokemon {
        __typename
        name
        id
      }
    }
    """

  public let operationName: String = "AllPokemon"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("allPokemon", type: .list(.object(AllPokemon.selections))),
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
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("id", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, id: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "Pokemon", "name": name, "id": id])
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
  }
}
