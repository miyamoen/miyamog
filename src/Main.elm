module Main exposing (main)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation as Nav exposing (Key)
import Html exposing (..)
import Http
import Index
import Services.Article as Article
import Services.Route as Route
import Types exposing (..)
import Url exposing (Url)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    let
        route =
            Route.parse url
    in
    ( { articles = Article.init Index.titles
      , key = key
      , route = route
      }
    , routeCmd route
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnUrlRequest (Internal url) ->
            ( model
            , Cmd.batch
                [ routeCmd <| Route.parse url
                , Nav.pushUrl model.key (Url.toString url)
                ]
            )

        OnUrlRequest (External url) ->
            ( model
            , Nav.load url
            )

        OnUrlChange url ->
            ( { model | route = Route.parse url }, Cmd.none )

        GotArticle article ->
            ( { model | articles = Article.update article model.articles }
            , Cmd.none
            )


routeCmd : Route -> Cmd Msg
routeCmd route =
    case route of
        ArticleRoute title ->
            Article.fetch title GotArticle

        _ ->
            Cmd.none


view : Model -> Document Msg
view model =
    { title = "miyamog"
    , body = [ text "hello" ]
    }
