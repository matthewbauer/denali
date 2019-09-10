{-# LANGUAGE CPP                 #-}
{-# LANGUAGE LambdaCase          #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE RecursiveDo         #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TupleSections       #-}
import Data.Maybe
import Data.Text
import Language.Javascript.JSaddle.WebKitGTK (run)
import Prelude
import Reflex.Dom.Core
import System.Environment
import Control.Monad.IO.Class

main :: IO ()
main = run $ mainWidget $ do
  el "p" $ text "Denali installer"
  nixosManual <- liftIO $ fmap (fromMaybe "https://nixos.org/nixos/manual/") $
    lookupEnv "NIXOS_MANUAL"
  elAttr "iframe" ("src" =: pack nixosManual <> "width" =: "100%" <> "height" =: "80%") $ pure ()
