port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onWithOptions)
import Json.Decode as Decode
import Regex as Regex
import Task as Task


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Item =
    { text : String
    , href : String
    }


type alias Queue =
    List Item


type alias Model =
    { newItem : Item
    , queue : Queue
    , error : Maybe String
    }


model : Model
model =
    { newItem = Item "" ""
    , queue = []
    , error = Nothing
    }


init : ( Model, Cmd Msg )
init =
    ( model, doLoadFromStorage () )



-- SUBSCRIPTIONS
-- Persist data to localStorage with Elm
-- @link: https://goo.gl/udiqCy


subscriptions : Model -> Sub Msg
subscriptions model =
    loadFromStorage LoadFromStorage


port saveToStorage : Queue -> Cmd msg


port loadFromStorage : (Maybe Queue -> msg) -> Sub msg


port doLoadFromStorage : () -> Cmd msg



-- UPDATE


type Msg
    = UpdateText String
    | UpdateHref String
    | AddItem
    | ClearFirstItem
    | LoadFromStorage (Maybe Queue)
    | SaveToStorage
    | DoLoadFromStorage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText text ->
            ( { model | newItem = updateItemText text model.newItem }, Cmd.none )

        UpdateHref href ->
            ( { model | newItem = updateItemHref href model.newItem }, Cmd.none )

        AddItem ->
            ( addItem model, sendCmd SaveToStorage )

        ClearFirstItem ->
            ( { model | queue = List.drop 1 model.queue }, sendCmd SaveToStorage )

        LoadFromStorage maybeQueue ->
            ( handleLoad model maybeQueue, Cmd.none )

        SaveToStorage ->
            ( model, saveToStorage model.queue )

        DoLoadFromStorage ->
            ( model, doLoadFromStorage () )


handleLoad : Model -> Maybe Queue -> Model
handleLoad model maybeQueue =
    case maybeQueue of
        Just queue ->
            { model | queue = queue }

        Nothing ->
            model


addItem : Model -> Model
addItem model =
    let
        error =
            validateItem model.newItem

        isValid =
            not <| isJust error
    in
        if isValid then
            { queue = model.queue ++ [ model.newItem ]
            , newItem = Item "" ""
            , error = error
            }
        else
            { model | error = error }



-- VIEW


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
        , button [] [ text "add item" ]
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



-- UTILITIES


isJust : Maybe a -> Bool
isJust maybe =
    case maybe of
        Just _ ->
            True

        Nothing ->
            False


updateItemText : String -> Item -> Item
updateItemText text item =
    { item | text = text }


updateItemHref : String -> Item -> Item
updateItemHref href item =
    { item | href = href }


urlRgx =
    Regex.regex "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"


validateItem : Item -> Maybe String
validateItem { href, text } =
    let
        urlIsValid =
            Regex.contains urlRgx href

        textIsValid =
            text /= ""
    in
        if not urlIsValid then
            Just "href has to be a valid URL"
        else if not textIsValid then
            Just "text cant be empty"
        else
            Nothing


sendCmd : msg -> Cmd msg
sendCmd msg =
    Task.succeed msg
        |> Task.perform identity
