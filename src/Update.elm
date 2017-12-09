port module Update exposing (update)

import Msgs exposing (Msg(..))
import Model exposing (Item, Queue, Model)
import Utils exposing (updateItemHref, updateItemText, sendCmd, isJust, validateItem)
import Subscriptions exposing (saveToStorage, doLoadFromStorage)


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
