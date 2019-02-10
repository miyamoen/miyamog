module Views.Basics.Header exposing (book, view)

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Services.Route as Route
import Views.Colors as Colors
import Views.Constants as Constants
import Views.Utils exposing (class)


view : Element msg
view =
    row
        [ width fill
        , padding <| Constants.padding 2
        , Font.size <| Constants.fontSize 4
        , Background.color Colors.primary.main
        , Font.color Colors.white.bright
        ]
        [ link [] { url = Route.homeUrl, label = text "miyamog" } ]


book : Book
book =
    bookWithFrontCover "Header" view
