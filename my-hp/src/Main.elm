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


init : ( Model, Cmd Msg )
init =
    ( "", Cmd.none )



---- UPDATE ----


type Msg
    = Init


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Init ->
            ( model
            , Cmd.none 
            )



---- VIEW ----

view : Model -> Html Msg
view model =
    div []
        [ div [ class "header" ]
            [ br [] []
            , br [] []
            , br [] []
            , br [] []
            , br [] []
            , br [] []
            , br [] []
            , br [] []
            , br [] []
            , br [] []
            , br [] []
            , h1 [] [ text "Leonie & Lionel" ]
            ]
        , div []
            [ section []
                [ toArticle "Hier entsteht die Hochzeitshomepage von Leonie und Lionel, wir bitten um ein wenig Geduld..."
                , toHtmlArticle [ img [ src "/World_Plane.gif" ] [] ]
                ]
            ]
        , div [ class "footer" ] [ text "Vielen Dank." ]
        ]


options : Options
options =
    { defaultOptions | sanitize = False }

toHtmlArticle: List (Html Msg) -> Html Msg
toHtmlArticle html =
    article [] 
      [ div [ class "article_top"]
        [ div [ class "article_content"] html
        ]
      , div [ class "article_bottom" ] []
      ]

toArticle: String -> Html Msg
toArticle content =
    article [] 
      [ div [ class "article_top"]
        [ div [ class "article_content"] [ Markdown.toHtmlWith options [class "md"] content ]
        ]
      , div [ class "article_bottom" ] []
      ]

---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
