module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onWithOptions)
import Json.Decode as Decode


-- local modules

import Model exposing (Item, Queue, Model)
import Msgs exposing (Msg(AddItem, UpdateHref, UpdateText, ClearFirstItem))


view : Model -> Html Msg
view { newItem, queue, error } =
    div []
        [ newItemForm newItem error
        , br [] []
        , itemView queue
        ]


newItemForm : Item -> Maybe String -> Html Msg
newItemForm item error =
    Html.form [ onWithOptions "submit" { preventDefault = True, stopPropagation = True } (Decode.succeed AddItem) ]
        [ input [ placeholder "text", onInput UpdateText, value item.text ] []
        , input [ placeholder "href", onInput UpdateHref, value item.href ] []
        , button [] [ text "Add item" ]
        , br [] []
        , case error of
            Just errorMsg ->
                text errorMsg

            Nothing ->
                text ""
        ]


itemView : Queue -> Html Msg
itemView queue =
    case List.head queue of
        Just item ->
            div []
                [ a [ href item.href, target "_blank" ] [ text item.text ]
                , button [ onClick ClearFirstItem ] [ text "X" ]
                ]

        Nothing ->
            div []
                [ text "Try adding some items to read :D"
                ]
