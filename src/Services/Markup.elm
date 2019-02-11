module Services.Markup exposing (Content, parse)

import Mark exposing (..)
import Parser.Advanced exposing (DeadEnd)


type alias Content =
    { title : String, lines : List String }


parse : String -> Result (List (DeadEnd Context Problem)) Content
parse raw =
    Mark.parse document raw


document : Document Content
document =
    Mark.document identity <|
        startWith Content
            title
            (manyOf [ line ])


title : Block String
title =
    block "Title" identity string


line : Block String
line =
    text
        { view = \(Text styles string) -> string
        , inlines = []
        , replacements = []
        }
        |> map (String.join "/")
