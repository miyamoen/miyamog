module Views.Utils exposing (class)

import Element exposing (..)
import Html.Attributes


class : String -> Attribute msg
class value =
    htmlAttribute <| Html.Attributes.class value
