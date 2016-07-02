module AlgoliaClient exposing
  ( Client
  , Index
  , listIndexes
  , search
  )

import Http
import Maybe exposing (..)
import Task exposing (..)
import Json.Decode as Json
import Json.Encode exposing (encode, object, string)

type alias Client =
  { applicationId: String
  , apiKey: String
  }

type alias Index =
  { name: String
  }

type Verb
  = GET
  | POST
  | PUT
  | DELETE

type alias Method = String
type alias Body = String
type alias Results = List String

createQueryParams : String -> Http.Body
createQueryParams query =
  let
    uri = "query=" ++ Http.uriEncode query
  in
    object [("params", string uri)]
      |> encode 0
      |> Http.string

mapHttpVerb : Verb -> String
mapHttpVerb verb =
  case verb of
    GET    -> "GET"
    POST   -> "POST"
    PUT    -> "PUT"
    DELETE -> "DELETE"

algoliaRequest : Client -> Verb -> Method -> Maybe Http.Body -> Http.Request
algoliaRequest client verb method body =
  let
    url = "https://" ++ client.applicationId ++ "-dsn.algolia.net/1/" ++ method
  in
    { verb = mapHttpVerb verb
    , headers =
        [ ("X-Algolia-Application-Id", client.applicationId)
        , ("X-Algolia-API-Key", client.apiKey)
        ]
    , url = url
    , body = case body of
        Just body -> body
        Nothing -> Http.empty
    }

listIndexes : Client -> Task Http.Error Results
listIndexes client =
  let
    response =
      Http.send Http.defaultSettings (algoliaRequest client GET "indexes" Nothing)
    decodedJson =
      Json.at ["items"] <| Json.list <| Json.at ["name"] <| Json.string
  in
    response
      |> Http.fromJson decodedJson

search : Client -> Index -> String -> Task Http.Error Results
search client {name} query =
  let
    response =
      Just (createQueryParams query)
        |> algoliaRequest client POST ("indexes/" ++ name ++ "/query")
        |> Http.send Http.defaultSettings
    decodedJson =
      Json.at ["hits"] <| Json.list <| Json.at ["name"] <| Json.string
  in
    response
      |> Http.fromJson decodedJson
