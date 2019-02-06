module Types exposing (Article, Content(..), Model, Msg(..), Route(..))

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Http
import Url exposing (Url)


type alias Model =
    { articles : List Article
    , key : Key
    , route : Route
    }


type alias Article =
    { title : String, content : Content }


type Content
    = NotAsked
    | Loading
    | Failure Http.Error
    | Success String


type Msg
    = NoOp
    | OnUrlRequest UrlRequest
    | OnUrlChange Url
    | GotArticle Article


type Route
    = HomeRoute
    | NotFoundRoute Url
    | ArticleRoute String
