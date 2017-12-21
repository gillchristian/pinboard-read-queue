module Utils exposing (..)

import Regex exposing (Regex, HowMany(All), Match, regex, contains, replace)
import Task as Task


-- local modules

import Model exposing (Item)


sendCmd : msg -> Cmd msg
sendCmd msg =
    Task.succeed msg
        |> Task.perform identity


isNothing : Maybe a -> Bool
isNothing =
    Maybe.withDefault True << Maybe.map (\_ -> False)


updateItemText : String -> Item -> Item
updateItemText text item =
    { item | text = text }


updateItemHref : String -> Item -> Item
updateItemHref href item =
    { item | href = href }


validateItemText : Item -> Maybe String
validateItemText { text } =
    if contains (regex "^\\s+$") text then
        Just "Link text can't be only spaces"
    else
        Nothing


urlRgx : Regex
urlRgx =
    regex "([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"


httpsRgx : Regex
httpsRgx =
    regex "^https?:\\/\\/"


validateItemHref : Item -> Maybe String
validateItemHref { href } =
    if href == "" then
        Just "Link can't be empty"
    else if not <| contains urlRgx href then
        Just "Link has to be a valid URL"
    else
        Nothing


addHttp : String -> String
addHttp link =
    if contains httpsRgx link then
        link
    else
        "http://" ++ link


removeMatch : Regex -> String -> String
removeMatch regex =
    replace All regex (\_ -> "")


removeProtocol : String -> String
removeProtocol =
    removeMatch httpsRgx


removeWWW : String -> String
removeWWW =
    removeMatch (regex "^www\\.")


removeQuery : String -> String
removeQuery =
    removeMatch (regex "\\\\?(?=\\?).*")


removeTrailingSlash : String -> String
removeTrailingSlash =
    removeMatch (regex "\\/$")


truncate : Int -> String -> String
truncate max str =
    if String.length str >= max then
        (String.slice 0 (max - 3) str) ++ "..."
    else
        str


cleanLink : String -> String
cleanLink =
    truncate 30 << removeProtocol << removeWWW << removeQuery << removeTrailingSlash
