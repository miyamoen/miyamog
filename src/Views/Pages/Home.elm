module Views.Pages.Home exposing (view)

import Element exposing (..)
import Services.Article as Article
import Types exposing (Article, Articles)


view : Articles -> Element msg
view articles =
    column [ spacing 8, padding 32 ] <|
        List.map articleLink articles


articleLink : Article -> Element msg
articleLink article =
    link []
        { url = Article.toUrl article
        , label = text article.title
        }
