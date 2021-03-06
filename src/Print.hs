{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE Trustworthy       #-}

-- | Generalization of 'Prelude.putStr' and 'Prelude.putStrLn' functions.

module Print
       ( Print (..)
       , putText
       , putLText
       ) where

import qualified Base
import           Data.Function              ((.))
import qualified Prelude                    as Prelude

import           Control.Monad.IO.Class     (MonadIO, liftIO)
import qualified Data.ByteString.Char8      as BS
import qualified Data.ByteString.Lazy.Char8 as BL

import qualified Data.Text                  as T
import qualified Data.Text.IO               as T

import qualified Data.Text.Lazy             as TL
import qualified Data.Text.Lazy.IO          as TL


-- | Polymorfic over string and lifted to 'MonadIO' printing functions.
class Print a where
  putStr :: MonadIO m => a -> m ()
  putStrLn :: MonadIO m => a -> m ()

instance Print T.Text where
  putStr = liftIO . T.putStr
  putStrLn = liftIO . T.putStrLn

instance Print TL.Text where
  putStr = liftIO . TL.putStr
  putStrLn = liftIO . TL.putStrLn

instance Print BS.ByteString where
  putStr = liftIO . BS.putStr
  putStrLn = liftIO . BS.putStrLn

instance Print BL.ByteString where
  putStr = liftIO . BL.putStr
  putStrLn = liftIO . BL.putStrLn

instance Print [Base.Char] where
  putStr = liftIO . Prelude.putStr
  putStrLn = liftIO . Prelude.putStrLn

-- | Specialized to 'T.Text' version of 'putStrLn' or forcing type inference.
putText :: MonadIO m => T.Text -> m ()
putText = putStrLn
{-# SPECIALIZE putText :: T.Text -> Base.IO () #-}

-- | Specialized to 'TL.Text' version of 'putStrLn' or forcing type inference.
putLText :: MonadIO m => TL.Text -> m ()
putLText = putStrLn
{-# SPECIALIZE putLText :: TL.Text -> Base.IO () #-}
