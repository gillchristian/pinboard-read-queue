module Model exposing (Item, ItemValidation, Queue, Model)


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
    }
