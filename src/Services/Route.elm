module Services.Route exposing
    ( parse
    , homeUrl, articleUrl
    , getTitle
    )

{-|

@docs parse
@docs homeUrl, articleUrl

@docs getTitle

-}

import Types exposing (Route(..))
import Url exposing (Url)
import Url.Builder exposing (absolute)
import Url.Parser exposing (..)


parse : Url -> Route
parse url =
    Url.Parser.parse route url
        |> Maybe.withDefault (NotFoundRoute url)


route : Parser (Route -> a) a
route =
    oneOf
        [ map HomeRoute top
        , map ArticleRoute (s "article" </> string)
        ]


getTitle : Route -> Maybe String
getTitle r =
    case r of
        ArticleRoute title ->
            Just title

        _ ->
            Nothing



-- urls


homeUrl : String
homeUrl =
    absolute [] []


articleUrl : String -> String
articleUrl title =
    absolute [ "article", title ] []
