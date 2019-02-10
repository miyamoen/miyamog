module View exposing (document)

import Browser exposing (Document)
import Element exposing (..)
import Html exposing (Html)
import Types exposing (..)
import Url
import Views.Pages.Article
import Views.Pages.Home


document : Model -> Document Msg
document model =
    { title = toTitle model.route
    , body = [ toHtml <| routing model ]
    }


routing : Model -> Element Msg
routing model =
    case model.route of
        HomeRoute ->
            Views.Pages.Home.view model.articles

        NotFoundRoute url ->
            text <| "notfound : " ++ Url.toString url

        ArticleRoute id ->
            Views.Pages.Article.view id model.articles



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

        ArticleRoute id ->
            id ++ " - miyamog"
