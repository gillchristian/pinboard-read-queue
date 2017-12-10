module Main exposing (..)

import Html exposing (program)


-- local modules

import Msgs exposing (Msg)
import Model exposing (Item, ItemValidation, Queue, Model)
import View exposing (view)
import Update exposing (update)
import Subscriptions exposing (subscriptions, doLoadFromStorage)


-- MAIN


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


model : Model
model =
    { newItem = Item "" ""
    , queue = []
    , error = ItemValidation Nothing Nothing
    }


init : ( Model, Cmd Msg )
init =
    ( model, doLoadFromStorage () )
