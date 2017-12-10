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
view model =
    div [ class "read-queue--app" ]
        [ pageHero
        , pageMain model
        , pageFooter
        ]


pageMain : Model -> Html Msg
pageMain { newItem, queue, error } =
    div [ class "read-queue--main container" ]
        [ section [ class "section" ]
            [ div [ class "tile is-ancestor" ]
                [ div [ class "tile is-parent" ]
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
                [ h2 [ class "subtitle" ] [ text "Your next item is:" ]
                , div [ class "is-flex", style [ ( "align-items", "center" ) ] ]
                    [ a [ class "button is-text", href item.href, target "_blank" ] [ text item.text ]
                    , button [ onClick ClearFirstItem, class "delete" ] [ text "X" ]
                    ]
                ]

        Nothing ->
            div []
                [ h2 [ class "subtitle" ] [ text "Your reading queue is empty!" ]
                ]


pageHero : Html Msg
pageHero =
    section [ class "read-queue--hero hero is-primary is-bold" ]
        [ div [ class "hero-head" ]
            [ nav [ class "navbar" ]
                [ div [ class "container" ]
                    [ div [ class "navbar-brand" ]
                        [ h1 [ class "navbar-item title" ] [ text "Read queue" ]
                        ]
                    , div [ class "navbar-menu" ]
                        [ div [ class "navbar-end" ]
                            [ a [ class "navbar-item is-active" ]
                                [ text "Home" ]
                            , a [ class "navbar-item" ]
                                [ text "About" ]
                            , a [ class "navbar-item" ]
                                [ text "Settings" ]
                            ]
                        ]
                    ]
                ]
            ]
        , div [ class "hero-body" ]
            [ div [ class "container has-text-centered" ]
                [ h2 [ class "subtitle" ]
                    [ text "Your reading queue" ]
                ]
            ]
        , div [ class "hero-foot" ]
            [ nav [ class "tabs is-centered is-medium is-boxed" ]
                [ div [ class "container" ]
                    [ ul []
                        [ li [ class "is-active" ]
                            [ a []
                                [ span [ class "icon is-small" ] [ i [ class "far fa-hand-point-down" ] [] ]
                                , span [] [ text "Local" ]
                                ]
                            ]
                        , li []
                            [ a []
                                [ span [ class "icon is-small" ] [ i [ class "fa fa-thumbtack" ] [] ]
                                , span [] [ text "Pinboard" ]
                                ]
                            ]
                        , li []
                            [ a []
                                [ span [ class "icon is-small" ] [ i [ class "fab fa-get-pocket" ] [] ]
                                , span [] [ text "Pocket" ]
                                ]
                            ]
                        ]
                    ]
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
