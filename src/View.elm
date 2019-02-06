module View exposing (document, toTitle)

import Browser exposing (Document)
import Element exposing (..)
import Html exposing (Html)
import Types exposing (..)


document : Model -> Document Msg
document model =
    { title = toTitle model.route
    , body = [ toHtml <| text "hello" ]
    }


routing : Model -> Element Msg
routing model =
    case model.route of
        HomeRoute ->
            text "home"

        NotFoundRoute url ->
            text "notfound"

        ArticleRoute title ->
            text "article"



-- helper


options : List Option
options =
    [ focusStyle
        { borderColor = Nothing
        , backgroundColor = Nothing
        , shadow = Nothing
        }
    ]


toHtml : Element msg -> Html msg
toHtml element =
    layoutWith { options = options } [] element


toTitle : Route -> String
toTitle route =
    case route of
        HomeRoute ->
            "miyamog"

        NotFoundRoute _ ->
            "notfound - miyamog"

        ArticleRoute title ->
            title ++ " - miyamog"
