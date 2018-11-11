module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (src, class)
import Markdown exposing (Options, defaultOptions)
import Http
import Json.Decode exposing (field, string)


---- MODEL ----


type alias Model =
    String

type alias Filename =
    String


init : ( Model, Cmd Msg )
init =
    ( ""
    , loadFile "/article1.md" 
    --, loadFile "/article2.json" 
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
            , Cmd.none 
            )
        
        FileLoaded result ->
            case result of
                Ok newContent ->
                    ( newContent
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
        [ div [ class "header" ]
            [ img [ src "/logo.svg" ] []
            , h1 [] [ text "Header" ]
            ]
        , div []
            [ section []
            [ toArticle "Article 1"
            , toArticle model
            , toArticle model
            , toArticle "Article 3"
            ]
            ]
        , div [ class "footer" ] [ text "Vielen Dank." ]
        ]


options : Options
options =
    { defaultOptions | sanitize = False }

toArticle: String -> Html Msg
toArticle content =
    article [] 
      [ div [ class "article_top"]
        [ div [ class "article_content"] [ Markdown.toHtmlWith options [class "md"] content ]
        ]
      , div [ class "article_bottom" ] []
      ]

loadFile: Filename -> Cmd Msg
loadFile filename =
    Http.send FileLoaded (Http.getString filename)

---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
