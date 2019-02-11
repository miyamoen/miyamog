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
import View


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = View.document
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

        ( articles, cmd ) =
            onRouteChange route (Article.init Index.metas)
    in
    ( { articles = articles
      , key = key
      , route = route
      }
    , cmd
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnUrlRequest (Internal url) ->
            let
                ( articles, cmd ) =
                    onRouteChange (Route.parse url) model.articles
            in
            ( { model | articles = articles }
            , Cmd.batch
                [ cmd
                , Nav.pushUrl model.key (Url.toString url)
                ]
            )

        OnUrlRequest (External url) ->
            ( model
            , Nav.load url
            )

        OnUrlChange url ->
            ( { model | route = Route.parse url }, Cmd.none )

        GotContent id content ->
            ( { model | articles = Article.setContent id content model.articles }
            , Cmd.none
            )


onRouteChange : Route -> Articles -> ( Articles, Cmd Msg )
onRouteChange route articles =
    case route of
        ArticleRoute id ->
            if Article.haveContent id articles then
                ( articles, Cmd.none )

            else
                ( Article.setLoading id articles, Article.fetch id (GotContent id) )

        _ ->
            ( articles, Cmd.none )
