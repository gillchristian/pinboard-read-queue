module Utils exposing (..)

import Regex exposing (Regex, regex, contains)
import Task as Task


-- local modules

import Model exposing (Item)


isNothing : Maybe a -> Bool
isNothing maybe =
    case maybe of
        Just _ ->
            False

        Nothing ->
            True


updateItemText : String -> Item -> Item
updateItemText text item =
    { item | text = text }


updateItemHref : String -> Item -> Item
updateItemHref href item =
    { item | href = href }


urlRgx : Regex
urlRgx =
    regex "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"


validateItemHref : Item -> Maybe String
validateItemHref { href } =
    if href == "" then
        Just "Link can't be empty"
    else if not <| contains urlRgx href then
        Just "Link has to be a valid URL"
    else
        Nothing


validateItemText : Item -> Maybe String
validateItemText { text } =
    if text /= "" then
        Nothing
    else
        Just "Link text can't be empty"


sendCmd : msg -> Cmd msg
sendCmd msg =
    Task.succeed msg
        |> Task.perform identity
