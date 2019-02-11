module Views.Pages.Article exposing (view)

import Element exposing (..)
import Element.Font as Font
import Services.Article as Article
import Services.Markup as Markup
import Types exposing (Article, Articles, Content(..))
import Views.Basics.Spinner
import Views.Constants as Constants


view : String -> Articles -> Element msg
view id articles =
    column [ width fill ]
        [ case Article.get id articles of
            Just article ->
                contentView article

            Nothing ->
                text <| "NotFound : " ++ id
        ]


contentView : Article -> Element msg
contentView { meta, content } =
    case content of
        Success raw ->
            case Markup.parse raw of
                Ok { title, lines } ->
                    column []
                        [ el [ Font.size <| Constants.fontSize 2 ] <| text title
                        , textColumn [] <|
                            List.map (\line -> paragraph [] [ text line ]) lines
                        ]

                Err err ->
                    paragraph [] <|
                        List.map (Debug.toString >> text) err

        NotAsked ->
            paragraph []
                [ text <| "NotAsked : " ++ meta.title
                , text "Here is Bug."
                ]

        Loading ->
            el [ centerX ] <| Views.Basics.Spinner.view

        Failure error ->
            text <| "Error : " ++ Debug.toString error
