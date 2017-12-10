module Routing
    exposing
        ( matchers
        , parseLocation
        , homePath
        , aboutPath
        , settingsPath
        , pinboardPath
        , pocketPath
        )

import Navigation exposing (Location)
import Model exposing (Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map AboutRoute (s "about")
        , map SettingsRoute (s "settings")
        , map PinboardRoute (s "pinboard")
        , map PocketRoute (s "pocket")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


homePath : String
homePath =
    "#"


aboutPath : String
aboutPath =
    "#about"


settingsPath : String
settingsPath =
    "#settings"


pinboardPath : String
pinboardPath =
    "#pinboard"


pocketPath : String
pocketPath =
    "#pocket"
