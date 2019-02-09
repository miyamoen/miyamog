module Views.Basics.Spinner exposing (book, view)

import Bibliopola exposing (..)
import Element exposing (..)
import Views.Utils exposing (class)


view : Element msg
view =
    column [ width <| px 50, height <| px 50 ]
        [ el
            [ class "spinner"
            , width <| px 7
            , height <| px 7
            , centerX
            , centerY
            ]
            none
        ]


book : Book
book =
    bookWithFrontCover "Spinner" view
