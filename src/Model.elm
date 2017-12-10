module Model exposing (Item, ItemValidation, Queue, Model, Route(..))


type Route
    = HomeRoute
    | AboutRoute
    | SettingsRoute
    | PinboardRoute
    | PocketRoute
    | NotFoundRoute


type alias Item =
    { text : String
    , href : String
    }


type alias ItemValidation =
    { text : Maybe String
    , href : Maybe String
    }


type alias Queue =
    List Item


type alias Model =
    { newItem : Item
    , queue : Queue
    , error : ItemValidation
    , route : Route
    }
