module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (src)
import Markdown
import Http exposing (..)
import Json.Decode exposing (field, string)


---- MODEL ----


type alias Model =
    { content : String
    }

type alias Filename =
    String


init : ( Model, Cmd Msg )
init =
    ( Model ""
    , loadFile "/article2.json" 
    )



---- UPDATE ----


type Msg
    = Init
    | FileLoaded (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Init ->
            ( model
            , loadFile "/article2.json" 
            )
        
        FileLoaded result ->
            case result of
                Ok newContent ->
                    ( { model | content = newContent }
                    , Cmd.none
                    )

                Err _ ->
                    ( model
                    , Cmd.none
                    )




---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div []
          [ img [ src "/logo.svg" ] []
          , h1 [] [ text "Header" ]
          ]
        , div []
          [ section []
            [ toArticle model.content
            , toArticle "file2"
            , toArticle "file3"
            ]
          ]
        ]


toArticle: String -> Html Msg
toArticle content =
    article [] [ Markdown.toHtml [] content ]

loadFile: Filename -> Cmd Msg
loadFile filename =
    Http.send FileLoaded (Http.get filename (field "content" string))

---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
