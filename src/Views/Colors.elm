module Views.Colors exposing
    ( Colors, primary, secondary1, secondary2
    , Mono, dark, white
    , book
    )

{-|


# Color Pallet

[color pallet](http://paletton.com/#uid=50q0u0kiCFn8GVde7NVmtwSqXtg)


## Colors

@docs Colors, primary, secondary1, secondary2


## Mono

@docs Mono, dark, white


## How to Use

@docs book

-}

import Bibliopola exposing (..)
import Element exposing (..)
import Element.Background as Background


type alias Colors =
    { darker : Color
    , dark : Color
    , main : Color
    , bright : Color
    , brighter : Color
    }


primary : Colors
primary =
    { darker = rgba255 233 118 37 1
    , dark = rgba255 255 150 76 1
    , main = rgba255 255 168 107 1
    , bright = rgba255 255 189 143 1
    , brighter = rgba255 255 215 186 1
    }


secondary1 : Colors
secondary1 =
    { darker = rgba255 233 163 37 1
    , dark = rgba255 255 191 76 1
    , main = rgba255 255 202 107 1
    , bright = rgba255 255 215 143 1
    , brighter = rgba255 255 230 186 1
    }


secondary2 : Colors
secondary2 =
    { darker = rgba255 225 36 54 1
    , dark = rgba255 247 74 90 1
    , main = rgba255 249 104 118 1
    , bright = rgba255 252 141 151 1
    , brighter = rgba255 253 185 191 1
    }


type alias Mono =
    { darker : Color
    , dark : Color
    , bright : Color
    , brighter : Color
    }


dark : Mono
dark =
    { darker = rgba255 0 0 0 0.87
    , dark = rgba255 0 0 0 0.54
    , bright = rgba255 0 0 0 0.26
    , brighter = rgba255 0 0 0 0.12
    }


white : Mono
white =
    { darker = rgba255 255 255 255 0.12
    , dark = rgba255 255 255 255 0.3
    , bright = rgba255 255 255 255 0.7
    , brighter = rgba255 255 255 255 1.0
    }



-- view


monoToList : String -> Mono -> List ( String, Color )
monoToList prefix mono =
    [ ( prefix ++ "_brighter", mono.brighter )
    , ( prefix ++ "_bright", mono.bright )
    , ( prefix ++ "_dark", mono.dark )
    , ( prefix ++ "_darker", mono.darker )
    ]


colorsToList : String -> Colors -> List ( String, Color )
colorsToList prefix colors =
    [ ( prefix ++ "_brighter", colors.brighter )
    , ( prefix ++ "_bright", colors.bright )
    , ( prefix ++ "_main", colors.main )
    , ( prefix ++ "_dark", colors.dark )
    , ( prefix ++ "_darker", colors.darker )
    ]


box : Color -> Element msg
box color =
    el
        [ width <| px 80
        , height <| px 80
        , Background.color color
        ]
        none


monoBoxes : String -> Mono -> Element msg
monoBoxes label mono =
    column []
        [ text label
        , row [] <|
            List.map (Tuple.second >> box) <|
                monoToList label mono
        ]


colorBoxes : String -> Colors -> Element msg
colorBoxes label colors =
    column []
        [ text label
        , row [] <|
            List.map (Tuple.second >> box) <|
                colorsToList label colors
        ]


view : Color -> Element msg
view color =
    row
        [ Background.color color
        , width fill
        , padding 48
        , spacing 32
        ]
        [ column [ width fill, alignTop, spacing 32 ]
            [ monoBoxes "dark" dark
            , monoBoxes "white" white
            ]
        , column [ width fill, alignTop, spacing 32 ]
            [ colorBoxes "primary" primary
            , colorBoxes "secondary1" secondary1
            , colorBoxes "secondary2" secondary2
            ]
        ]


book : Book
book =
    intoBook "Colors" identity view
        |> addStory
            (Story "background" <|
                monoToList "white" white
                    ++ monoToList "dark" dark
                    ++ colorsToList "primary" primary
                    ++ colorsToList "secondary1" secondary1
                    ++ colorsToList "secondary2" secondary2
            )
        |> buildBook
        |> withFrontCover (view primary.bright)


main : Bibliopola.Program
main =
    fromBook book
