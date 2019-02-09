module Bib exposing (main)

import Bibliopola exposing (..)
import Views.Basics.Spinner
import Views.Colors


main : Bibliopola.Program
main =
    fromShelf
        (emptyShelf "miyamog"
            |> addBook Views.Colors.book
            |> addBook Views.Basics.Spinner.book
        )
