module Services.Article exposing
    ( init, get, update, setLoading
    , fetch
    )

{-|


# CRUD

@docs init, get, update, setLoading


# API

@docs fetch

-}

import Http
import List.Extra
import Types exposing (Article, Content(..))



-- CRUD


init : List String -> List Article
init titles =
    List.map (\title -> { title = title, content = NotAsked }) titles


get : String -> List Article -> Maybe Article
get title articles =
    List.Extra.find (equals title) articles


update : Article -> List Article -> List Article
update article articles =
    List.Extra.setIf (equals article.title) article articles


setLoading : String -> List Article -> List Article
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
