port module Subscriptions exposing (subscriptions, saveToStorage, doLoadFromStorage)

import Model exposing (Queue, Model)
import Msgs exposing (Msg(LoadFromStorage))


-- Persist data to localStorage with Elm
-- @link: https://goo.gl/udiqCy


subscriptions : Model -> Sub Msg
subscriptions model =
    loadFromStorage LoadFromStorage


port saveToStorage : Queue -> Cmd msg


port loadFromStorage : (Maybe Queue -> msg) -> Sub msg


port doLoadFromStorage : () -> Cmd msg
