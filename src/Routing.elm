module Routing
    exposing
        ( matchers
        , parseLocation
        , homePath
        , aboutPath
        , settingsPath
        , pinboardPath
        , pocketPath
        , onLinkClick
        , link
        , toHome
        , toAbout
        , toSettings
        , toPocketQueue
        , toPinboardQueue
        )

import Html exposing (Html, Attribute, a)
import Html.Attributes exposing (href)
import Html.Events exposing (onWithOptions)
import Navigation exposing (Location)
import Model exposing (Route(..))
import Json.Decode as Decode
import UrlParser
    exposing
        ( Parser
        , oneOf
        , parsePath
        , top
        , map
        , s
        , (</>)
        )


-- local modules

import Msgs exposing (Msg(ChangeLocation))


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map AboutRoute (s "about")
        , map SettingsRoute (s "settings")
        , map PinboardRoute (s "queue" </> s "pinboard")
        , map PocketRoute (s "queue" </> s "pocket")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


{-| This prevent the reload when clicking on internal links
@link: <https://github.com/sporto/elm-navigation-pushstate-example>
-}
onLinkClick : msg -> Attribute msg
onLinkClick message =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed message)


link : String -> List (Attribute Msg) -> List (Html Msg) -> Html Msg
link path attributes children =
    a ([ href path, onLinkClick (ChangeLocation path) ] ++ attributes) children


homePath : String
homePath =
    "/"


toHome : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toHome =
    link homePath


aboutPath : String
aboutPath =
    "/about"


toAbout : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toAbout =
    link aboutPath


settingsPath : String
settingsPath =
    "/settings"


toSettings : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toSettings =
    link settingsPath


pinboardPath : String
pinboardPath =
    "/queue/pinboard"


toPinboardQueue : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toPinboardQueue =
    link pinboardPath


pocketPath : String
pocketPath =
    "/queue/pocket"


toPocketQueue : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toPocketQueue =
    link pocketPath
