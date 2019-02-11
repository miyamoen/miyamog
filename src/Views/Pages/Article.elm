module Views.Pages.Article exposing (view)

import Element exposing (..)
import Element.Font as Font
import Services.Article as Article
import Types exposing (Article, Articles, Content(..))
import Views.Basics.Spinner


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
        Success body ->
            paragraph [] [ text body ]

        NotAsked ->
            paragraph []
                [ text <| "NotAsked : " ++ meta.title
                , text "Here is Bug."
                ]

        Loading ->
            el [ centerX ] <| Views.Basics.Spinner.view

        Failure error ->
            text <| "Error : " ++ Debug.toString error
