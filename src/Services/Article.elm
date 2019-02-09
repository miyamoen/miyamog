module Services.Article exposing
    ( init, get, update, setLoading
    , fetch
    , toUrl
    )

{-|


# CRUD

@docs init, get, update, setLoading


# API

@docs fetch


# View Helper

@docs toUrl

-}

import Http
import List.Extra
import Services.Route exposing (articleUrl)
import Types exposing (Article, Articles, Content(..))



-- CRUD


init : List String -> Articles
init titles =
    List.map (\title -> { title = title, content = NotAsked }) titles


get : String -> Articles -> Maybe Article
get title articles =
    List.Extra.find (equals title) articles


update : Article -> Articles -> Articles
update article articles =
    List.Extra.setIf (equals article.title) article articles


setLoading : String -> Articles -> Articles
setLoading title articles =
    List.Extra.setIf (equals title) { title = title, content = Loading } articles


equals : String -> Article -> Bool
equals title article =
    article.title == title



-- API


fetch : String -> (Article -> msg) -> Cmd msg
fetch title toMsg =
    Http.get
        { url = "/markup/" ++ title ++ ".markup"
        , expect = Http.expectString (fromResult >> Article title >> toMsg)
        }


fromResult : Result Http.Error String -> Content
fromResult res =
    case res of
        Ok content ->
            Success content

        Err err ->
            Failure err



-- view helper


toUrl : Article -> String
toUrl { title } =
    articleUrl title
