module Services.Route exposing
    ( parse
    , homeUrl, articleUrl
    , getId
    )

{-|

@docs parse
@docs homeUrl, articleUrl

@docs getId

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


getId : Route -> Maybe String
getId r =
    case r of
        ArticleRoute id ->
            Just id

        _ ->
            Nothing



-- urls


homeUrl : String
homeUrl =
    absolute [] []


articleUrl : String -> String
articleUrl id =
    absolute [ "article", id ] []
