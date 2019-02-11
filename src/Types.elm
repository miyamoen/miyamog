module Types exposing
    ( Article
    , Articles
    , Content(..)
    , Model
    , Msg(..)
    , Route(..)
    )

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Http
import Index exposing (Meta)
import Url exposing (Url)


type alias Model =
    { articles : Articles
    , key : Key
    , route : Route
    }


type alias Articles =
    List Article


type alias Article =
    { meta : Meta, content : Content }


type Content
    = NotAsked
    | Loading
    | Failure Http.Error
    | Success String


type Msg
    = NoOp
    | OnUrlRequest UrlRequest
    | OnUrlChange Url
    | GotContent String Content


type Route
    = HomeRoute
    | NotFoundRoute Url
    | ArticleRoute String
