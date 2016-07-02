module Client exposing (..)

import Http
import Task
import Debug
import Html exposing (..)
import Html.App as App
import Json.Decode as Json
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import AlgoliaClient exposing (Client, Index, listIndexes, search)

type alias Model = {
  indexes: List String,
  searchResults: List String
}

type Msg
  = FetchIndexes
  | FetchSuccess (List String)
  | Search String
  | SearchSuccess (List String)
  | FetchFail Http.Error

init : (Model, Cmd Msg)
init =
  (Model [] [], fetch)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    FetchIndexes ->
      Debug.log "FetchIndexes:"
      (model, fetch)

    FetchSuccess indexes ->
      Debug.log "FetchSuccess:"
      ({ model | indexes = indexes}, Cmd.none)

    Search query ->
      Debug.log "Search:"
      (model, searchTeam query)

    SearchSuccess results ->
      Debug.log "SearchSuccess:"
      ({ model | searchResults = results}, Cmd.none)

    FetchFail _ ->
      Debug.log "FetchFail:"
      (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

fetch : (Cmd Msg)
fetch =
  let
    client = Client "1LFL2RS6YM" "6f51e46323dc6a5d0f00c297ca8e0c26"
  in
    Task.perform FetchFail FetchSuccess (listIndexes client)

searchTeam : String -> (Cmd Msg)
searchTeam value =
  let
    index = Index "team_members"
    client = Client "1LFL2RS6YM" "6f51e46323dc6a5d0f00c297ca8e0c26"
  in
    Task.perform FetchFail SearchSuccess (search client index value)


view : Model -> Html Msg
view {indexes, searchResults} =
  div [] [
    h1 [] [text "List of indexes"]
  , ul [] (List.map (\i -> li [] [text i]) indexes)
  , h1 [] [text "Search"]
  , input [type' "text", placeholder "Search here your term", onInput Search] []
  , ul [] (List.map (\i -> li [] [text i]) searchResults)
  ]

main : Program Never
main = App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }
