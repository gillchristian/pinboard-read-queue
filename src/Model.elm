module Model exposing (Item, Queue, Model)


type alias Item =
    { text : String
    , href : String
    }


type alias Queue =
    List Item


type alias Model =
    { newItem : Item
    , queue : Queue
    , error : Maybe String
    }
