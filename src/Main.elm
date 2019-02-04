module Main exposing (main)

import Browser exposing (Document, UrlRequest(..), application)
import Browser.Navigation as Nav exposing (Key)
import Html exposing (..)
import Http
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


type alias Model =
    { content : String
    , key : Key
    }


type Msg
    = NoOp
    | OnUrlRequest UrlRequest
    | OnUrlChange Url
    | GotContent (Result Http.Error String)


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    ( { content = "te", key = key }, fetchHello )


fetchHello : Cmd Msg
fetchHello =
    Http.get
        { url = "/markup/hello.markup"
        , expect = Http.expectString GotContent
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnUrlRequest (Internal url) ->
            ( model
            , Nav.pushUrl model.key (Url.toString url)
            )

        OnUrlRequest (External url) ->
            ( model
            , Nav.load url
            )

        OnUrlChange _ ->
            ( model, Cmd.none )

        GotContent (Ok content) ->
            ( { model | content = content }, Cmd.none )

        GotContent (Err error) ->
            let
                _ =
                    Debug.log "err" error
            in
            ( model, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "miyamog"
    , body = [ text model.content ]
    }
