module Utils exposing (..)

import Regex exposing (Regex, regex, contains)
import Task as Task


-- local modules

import Model exposing (Item)


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


urlRgx : Regex
urlRgx =
    regex "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"


validateItem : Item -> Maybe String
validateItem { href, text } =
    let
        urlIsValid =
            contains urlRgx href

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
