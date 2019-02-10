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
init ids =
    List.map (\id -> { id = id, content = NotAsked }) ids


get : String -> Articles -> Maybe Article
get id articles =
    List.Extra.find (equals id) articles


update : Article -> Articles -> Articles
update article articles =
    List.Extra.setIf (equals article.id) article articles


setLoading : String -> Articles -> Articles
setLoading id articles =
    List.Extra.setIf (equals id) { id = id, content = Loading } articles


equals : String -> Article -> Bool
equals id article =
    article.id == id



-- API


fetch : String -> (Article -> msg) -> Cmd msg
fetch id toMsg =
    Http.get
        { url = "/markup/" ++ id ++ ".markup"
        , expect = Http.expectString (fromResult >> Article id >> toMsg)
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
toUrl { id } =
    articleUrl id
