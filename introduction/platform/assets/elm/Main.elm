module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

main : Html msg
main =
  div []
        [ h1 [] [ text "Games"]
        , gamesIndex model
        ]

model : List String
model =
      [ "Platform Game",
       "Adventure Game"
      ]

gamesIndex : List String -> Html msg
gamesIndex = ul [ class "games-list" ] [ gamesList gameTitles ]

gamesList : List String -> Html msg
gamesList gameTitles = ul [ class "games-list" ] (List.map gamesListItem gameTitles)

gamesListItem : String -> Html msg
gamesListItem gameTitle = li [] [ text gameTitle ]