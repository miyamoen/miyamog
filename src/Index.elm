module Index exposing (Meta, metas)


type alias Meta =
    { id : String, title : String }


metas : List Meta
metas =
    [ { id = "hello", title = "Hello, miyamog!" }
    , { id = "miyamog_structure", title = "miyamogのモジュール構成" }
    ]
