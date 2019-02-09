module Views.Pages.Article exposing (view)

import Element exposing (..)
import Element.Font as Font
import Services.Article as Article
import Types exposing (Article, Articles, Content(..))
import Views.Basics.Spinner


view : String -> Articles -> Element msg
view title articles =
    column [ padding 32, width fill ]
        [ el [ Font.size 32 ] <| text title
        , case Article.get title articles of
            Just article ->
                contentView article

            Nothing ->
                text <| "NotFound : " ++ title
        ]


contentView : Article -> Element msg
contentView { title, content } =
    case content of
        Success body ->
            paragraph [] [ text body ]

        NotAsked ->
            paragraph []
                [ text <| "NotAsked : " ++ title
                , text "Here is Bug."
                ]

        Loading ->
            el [ centerX ] <| Views.Basics.Spinner.view

        Failure error ->
            text <| "Error : " ++ Debug.toString error
