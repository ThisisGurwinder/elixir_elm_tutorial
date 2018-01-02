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
gamesIndex = ul [ class "games-list" ] [ gamesList ]

gamesList : List String -> Html msg
gamesList = ul [ class "games-list" ] [ gamesListItem ]

gamesListItem : String -> Html msg
gamesListItem = li [] [ text "Platform Game" ]