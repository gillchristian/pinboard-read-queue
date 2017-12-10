module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onWithOptions)
import Json.Decode exposing (succeed)


-- local modules

import Utils exposing (isNothing)
import Model exposing (Item, ItemValidation, Queue, Model)
import Msgs exposing (Msg(AddItem, UpdateHref, UpdateText, ClearFirstItem))


view : Model -> Html Msg
view { newItem, queue, error } =
    div [ class "read-queue--app" ]
        [ hero
        , div [ class "read-queue--main container" ]
            [ div [ class "tile is-ancestor" ]
                [ div [ class "tile is-vertical is-parent" ]
                    [ div [ class "tile is-child box" ]
                        [ newItemForm newItem error
                        ]
                    ]
                , div [ class "tile is-parent" ]
                    [ div [ class "tile is-child box" ]
                        [ itemView queue
                        ]
                    ]
                ]
            ]
        , pageFooter
        ]


newItemForm : Item -> ItemValidation -> Html Msg
newItemForm item error =
    let
        options =
            { preventDefault = True, stopPropagation = True }

        event =
            onWithOptions "submit" options (succeed AddItem)
    in
        div [ class "" ]
            [ Html.form [ event ]
                [ field item.text "GitHub" "Text" error.text UpdateText
                , field item.href "https://github.com" "Link" error.href UpdateHref
                , submitBtn
                ]
            ]


field : String -> String -> String -> Maybe String -> (String -> Msg) -> Html Msg
field fieldValue placeholderText labelText maybeError msg =
    let
        inputClass =
            if isNothing maybeError then
                "input"
            else
                "input is-danger"
    in
        div [ class "field" ]
            [ label [ class "label" ] [ text labelText ]
            , div [ class "control" ]
                [ input
                    [ placeholder placeholderText
                    , class inputClass
                    , onInput msg
                    , value fieldValue
                    ]
                    []
                ]
            , case maybeError of
                Just message ->
                    p [ class "help is-danger" ] [ text message ]

                Nothing ->
                    span [] []
            ]


submitBtn : Html Msg
submitBtn =
    div [ class "field is-grouped is-grouped-right" ]
        [ div [ class "control" ]
            [ button [ class "button is-primary", type_ "submit" ] [ text "Add item" ]
            ]
        ]


itemView : Queue -> Html Msg
itemView queue =
    case List.head queue of
        Just item ->
            div []
                [ a [ href item.href, target "_blank" ] [ text item.text ]
                , button [ onClick ClearFirstItem, class "button" ] [ text "X" ]
                ]

        Nothing ->
            div []
                [ text "Try adding some items to read :D"
                ]


hero : Html Msg
hero =
    section [ class "read-queue--hero hero is-primary is-bold" ]
        [ div [ class "hero-body" ]
            [ div [ class "container" ]
                [ h1 [ class "title" ] [ text "Read queue" ]
                ]
            ]
        ]


pageFooter : Html Msg
pageFooter =
    footer [ class "read-queue--footer footer" ]
        [ div [ class "container" ]
            [ div [ class "content has-text-centered" ]
                [ p []
                    [ text "by "
                    , a [ href "http://gillchristian.xyz", target "_blank" ]
                        [ text "gillchristian" ]
                    ]
                ]
            ]
        ]
