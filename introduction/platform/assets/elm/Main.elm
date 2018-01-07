module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode

type alias Model =
    { gamesList : List Game,
      playersList : List Player
    }

type alias Game =
    { title : String.
      description : String,
      id : Int,
      thumbnail : String,
      title : String
    }

type alias Player =
    { displayName : String,
      id : Int,
      score : Int,
      username : String
    }

initialModel : Model
initialModel =
    { gamesList = [],
      playersList = []}

initialCommand : Cmd Msg
initialCommand =
    Cmd.batch
    [ fetchGamesList,
      fetchPlayersList ]

update : Msg -> Model -> Model
update msg model =
    model

type Msg
    = FetchGamesList (Result Http.Error (List Game))
    | FetchPlayersList (Result Http.Error (List Player))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FetchGamesList result ->
            case result of
                Ok games ->
                    ({ model | gameList = games }, Cmd.none)
                Err _ ->
                    ( model, Cmd.none )
        fetchPlayersList result ->
            case result of
                Ok players ->
                    ({ model | playersList = players }, Cmd.none)
                Err _ ->
                    ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

view : Model -> Html Msg
view model =
    div []
        [ gamesIndex model
        , playersIndex model
    ]

gamesIndex : Model -> Html msg
gamesIndex model =
    div [ class "games-index" ] [ gamesList model.gamesList ]

gamesList : List Game -> Html msg
gamesList games =
    ul [ class "games-list" ] (List.map gamesListItem games)

gamesListItem : Game -> Html msg
gamesListItem game =
    li [ class "game-item" ]
        [ strong [] [ text game.gameTitle ]
        , p [] [ text game.gameDescription ]
        ]

playersIndex : Model -> Html msg
playersIndex model =
    if List.isEmpty model.playersList then
        div [] []
    else
        div [ class "playes-index" ]
            [ h1 [ class "players-section" ] [ text "Players" ]
            , playersList model.playersList
            ]

playersList : List Player -> Html msg
playersList players =
    ul [ class "players-list" ] (List.map playersListItem players)

playersListItem : Player -> Html msg
playersListItem player = 
    li [ class "player-item" ]
        [ strong [] [ text player.displayName ]
        , p [] [ text (toString player.score) ]
    ]

init : ( Model, Cmd Msg )
init = 
    ( initialModel, initialCommand )

fetchGamesList =
    Http.get "/api/games" decodeGamesList
    |> Http.send FetchGamesList

decodeGame : Decode.Decoder Game
decodeGame =
    Decode.map5 Game
        (Decode.field "title" Decode.string)
        (Decode.field "description" Decode.string)
        (Decode.field "id" Decode.int)
        (Decode.field "thumbnail" Decode.string)
        (Decode.field "title" Decode.string)

decodeGamesList : Decode.Decoder (List Game)
decodeGamesList =
    decodeGame
    |> Decode.list
    |> Decode.at [ "data" ]

fetchPlayersList =
    Http.get "/api/players" decodePlayersList
    |> Http.send FetchPlayersList

decodePlayer : Decode.Decoder Player
decodePlayer =
    Decode.map4 Player
        (Decode.field "display_name" Decode.string)
        (Decode.field "id" Decode.int)
        (Decode.field "score" Decode.int)
        (Decode.field "username" Decode.string)

decodePlayersList : Decode.Decoder (List Player)
decodePlayersList = 
    decodePlayer
    |> Decode.List
    |> Decode.at [ "data" ]

main : Program Never Model Msg
main = 
    Html.program
        { init = init
          , view = view
          , update = update
          , subscriptions = subscriptions }