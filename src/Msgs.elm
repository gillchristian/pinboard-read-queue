module Msgs exposing (Msg(..))

import Model exposing (Queue)


type Msg
    = UpdateText String
    | UpdateHref String
    | AddItem
    | ClearFirstItem
    | LoadFromStorage (Maybe Queue)
    | SaveToStorage
    | DoLoadFromStorage
