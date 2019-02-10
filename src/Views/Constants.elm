module Views.Constants exposing (fontSize, padding, spacing)

import Element exposing (modular)


fontSize : Int -> Int
fontSize =
    modular 16 1.75 >> round


padding : Int -> Int
padding =
    modular 24 2 >> round


spacing : Int -> Int
spacing =
    modular 16 2 >> round
