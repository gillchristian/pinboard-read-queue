module Main exposing (..)

import Navigation exposing (Location, program)


-- local modules

import Msgs exposing (Msg(OnLocationChange))
import Model exposing (Item, ItemValidation, Queue, Model, Route(..))
import View exposing (view)
import Update exposing (update)
import Routing exposing (parseLocation)
import Subscriptions exposing (subscriptions, doLoadFromStorage)


-- MAIN


main =
    program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


model : Route -> Model
model route =
    { newItem = Item "" ""
    , queue = []
    , error = ItemValidation Nothing Nothing
    , route = route
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation location
    in
        ( model currentRoute, doLoadFromStorage () )
