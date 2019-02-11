module View exposing (document)

import Browser exposing (Document)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)
import Services.Article as Article
import Types exposing (..)
import Url
import Views.Basics.Header as Header
import Views.Colors as Colors
import Views.Constants as Constants
import Views.Pages.Article
import Views.Pages.Home


document : Model -> Document Msg
document model =
    { title = toTitle model
    , body = [ toHtml <| routing model ]
    }


routing : Model -> Element Msg
routing model =
    column [ width fill ]
        [ Header.view
        , el [ padding <| Constants.padding 2 ] <|
            case model.route of
                HomeRoute ->
                    Views.Pages.Home.view model.articles

                NotFoundRoute url ->
                    text <| "notfound : " ++ Url.toString url

                ArticleRoute id ->
                    Views.Pages.Article.view id model.articles
        ]



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
    layoutWith { options = options } rootAttrs element


rootAttrs : List (Attribute msg)
rootAttrs =
    [ Background.color Colors.primary.bright
    , Font.color Colors.dark.darker
    , Font.size <| Constants.fontSize 1
    ]


toTitle : Model -> String
toTitle { route, articles } =
    case route of
        HomeRoute ->
            "miyamog"

        NotFoundRoute _ ->
            "notfound - miyamog"

        ArticleRoute id ->
            (Article.get id articles
                |> Maybe.map (.meta >> .title)
                |> Maybe.withDefault id
            )
                ++ " - miyamog"
