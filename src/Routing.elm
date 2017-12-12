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
        , map
        , s
        , (</>)
        )


-- local modules

import Msgs exposing (Msg(ChangeLocation))


{-
   TODO: change HomeRoute to UrlParser.top and remove s baseUrl
         when hosting in a root domain
-}


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute (s baseUrl)
        , map AboutRoute (s baseUrl </> s "about")
        , map SettingsRoute (s baseUrl </> s "settings")
        , map PinboardRoute (s baseUrl </> s "queue" </> s "pinboard")
        , map PocketRoute (s baseUrl </> s "queue" </> s "pocket")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute



{-
   This prevents the reload when clicking on internal links
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



{- TODO: remove when hosting in a root domain -}


baseUrl : String
baseUrl =
    "pinboard-read-queue"


homePath : String
homePath =
    "/" ++ baseUrl ++ "/"


toHome : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toHome =
    link homePath


aboutPath : String
aboutPath =
    "/" ++ baseUrl ++ "/about"


toAbout : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toAbout =
    link aboutPath


settingsPath : String
settingsPath =
    "/" ++ baseUrl ++ "/settings"


toSettings : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toSettings =
    link settingsPath


pinboardPath : String
pinboardPath =
    "/" ++ baseUrl ++ "/queue/pinboard"


toPinboardQueue : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toPinboardQueue =
    link pinboardPath


pocketPath : String
pocketPath =
    "/" ++ baseUrl ++ "/queue/pocket"


toPocketQueue : List (Attribute Msg) -> List (Html Msg) -> Html Msg
toPocketQueue =
    link pocketPath
