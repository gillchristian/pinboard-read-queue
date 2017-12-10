module Msgs exposing (Msg(..))

import Model exposing (Queue)
import Navigation exposing (Location)


type Msg
    = UpdateText String
    | UpdateHref String
    | AddItem
    | ClearFirstItem
    | LoadFromStorage (Maybe Queue)
    | SaveToStorage
    | DoLoadFromStorage
    | OnLocationChange Location
