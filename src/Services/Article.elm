module Services.Article exposing
    ( init, get, update, setLoading, setContent, hasContent, haveContent
    , fetch
    , toUrl
    )

{-|


# CRUD

@docs init, get, update, setLoading, setContent, hasContent, haveContent


# API

@docs fetch


# View Helper

@docs toUrl

-}

import Http
import Index exposing (Meta)
import List.Extra
import Services.Route exposing (articleUrl)
import Types exposing (Article, Articles, Content(..))



-- CRUD


init : List Meta -> Articles
init metas =
    List.map (\meta -> { meta = meta, content = NotAsked }) metas


get : String -> Articles -> Maybe Article
get id articles =
    List.Extra.find (equals id) articles


update : Article -> Articles -> Articles
update article articles =
    List.Extra.setIf (equals article.meta.id) article articles


setContent : String -> Content -> Articles -> Articles
setContent id content articles =
    List.Extra.updateIf (equals id)
        (\article -> { article | content = content })
        articles


setLoading : String -> Articles -> Articles
setLoading id articles =
    setContent id Loading articles


haveContent : String -> Articles -> Bool
haveContent id articles =
    List.Extra.find (equals id) articles
        |> Maybe.map hasContent
        |> Maybe.withDefault False


hasContent : Article -> Bool
hasContent { content } =
    case content of
        Success _ ->
            True

        _ ->
            False


equals : String -> Article -> Bool
equals id article =
    article.meta.id == id



-- API


fetch : String -> (Content -> msg) -> Cmd msg
fetch id toMsg =
    Http.get
        { url = "/markup/" ++ id ++ ".markup"
        , expect = Http.expectString (fromResult >> toMsg)
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
toUrl { meta } =
    articleUrl meta.id
