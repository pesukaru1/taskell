{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
module UI.Modal (
    showModal
) where

import Events.State (State, Mode(..), ModalType(..), mode, getCurrentTask)
import Events.State.Modal.SubTasks (getCurrentSubTask)
import Brick
import Brick.Widgets.Center
import Brick.Widgets.Border
import Data.Taskell.Task (SubTask, description, subTasks, name, complete)
import Data.Text as T (Text, lines, replace, breakOn, strip, drop, append, length)
import Data.Text.Encoding (decodeUtf8)
import Data.FileEmbed (embedFile)
import Data.Foldable (toList)
import Data.Sequence (mapWithIndex)
import IO.Markdown (trimListItem)

import UI.Types (ResourceName(..))
import UI.Theme (titleAttr, taskCurrentAttr, disabledAttr)

place :: Widget ResourceName -> Widget ResourceName
place = padTopBottom 1 . centerLayer . border . padTopBottom 1 . padLeftRight 4 . hLimit 50

modal :: Text -> Widget ResourceName -> Widget ResourceName
modal title w = place $ t <=> w'
    where t = padLeftRight 2 . padBottom (Pad 1) . withAttr titleAttr $ txtWrap title
          w'= viewport RNModal Vertical w

help :: Widget ResourceName
help = modal "Controls" w
    where ls = T.lines $ decodeUtf8 $(embedFile "templates/controls.md")
          (l, r) = unzip $ breakOn ":" . T.replace "`" "" . trimListItem <$> ls
          left = padRight (Pad 2) . vBox $ withAttr taskCurrentAttr . txt <$> l
          right = vBox $ txt . T.strip . T.drop 1 <$> r
          w = left <+> right

addCursor :: Int -> Text -> Widget ResourceName -> Widget ResourceName
addCursor li d = showCursor (RNModalItem li) (Location (T.length d + 2, 0))

renderSubTask :: Int -> Int -> SubTask -> Widget ResourceName
renderSubTask current i subtask | i == current = visible $ withAttr taskCurrentAttr widget
                                | complete subtask = withAttr disabledAttr widget
                                | otherwise = widget
    where postfix = if complete subtask then " ✓" else ""
          text = name subtask `append` postfix
          widget = addCursor i text (txt "• " <+> txtWrap text)

st :: State -> Maybe (Widget ResourceName)
st state = do
    task <- getCurrentTask state
    index <- getCurrentSubTask state
    let sts = subTasks task
        w | null sts = withAttr disabledAttr $ txt "  No sub-tasks"
          | otherwise = vBox . toList $ renderSubTask index `mapWithIndex` sts
    return $ modal (description task) w

getModal :: State -> ModalType -> [Widget ResourceName]
getModal s t = case t of
    Help -> [help]
    SubTasks _ _ -> case st s of
        Just w -> [w]
        Nothing -> []

showModal :: State -> [Widget ResourceName] -> [Widget ResourceName]
showModal s view = case mode s of
    Modal t -> getModal s t ++ view
    _ -> view