module Views.Pages.Home exposing (view)

import Element exposing (..)
import Element.Font as Font
import Services.Article as Article
import Types exposing (Article, Articles)
import Views.Constants as Constants


view : Articles -> Element msg
view articles =
    column [ width fill, spacing <| Constants.spacing 3 ]
        [ column [ width fill, spacing <| Constants.spacing 1 ]
            [ el [ Font.size <| Constants.fontSize 2 ] <| text "miyamogって？"
            , textColumn [ width fill ]
                [ paragraph [] [ text "miyamoが実験的に作っているブログ。markdownが好きじゃないのでelm-markupを使ってパースとレンダリングも自前でやろうとしている。" ]
                , paragraph [] [ text "正直めんどい気もする" ]
                ]
            , textColumn [ width fill ]
                [ paragraph [] [ text "まだ全然できてないのでそもそも記事部分読みにくいです。やっていく所存です" ]
                ]
            ]
        , column [ width fill, spacing <| Constants.spacing 1 ]
            [ el [ Font.size <| Constants.fontSize 2 ] <| text "一覧"
            , column [ spacing <| Constants.spacing 1 ] <|
                List.map articleLink articles
            ]
        ]


articleLink : Article -> Element msg
articleLink article =
    link []
        { url = Article.toUrl article
        , label = text article.meta.title
        }
