{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_joko_test (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/oscarroche/dev/joko_test/.cabal-sandbox/bin"
libdir     = "/Users/oscarroche/dev/joko_test/.cabal-sandbox/lib/x86_64-osx-ghc-8.4.3/joko-test-0.1.0.0-LT1fbatrBqnAP0XbXm1zZP-joko-test"
dynlibdir  = "/Users/oscarroche/dev/joko_test/.cabal-sandbox/lib/x86_64-osx-ghc-8.4.3"
datadir    = "/Users/oscarroche/dev/joko_test/.cabal-sandbox/share/x86_64-osx-ghc-8.4.3/joko-test-0.1.0.0"
libexecdir = "/Users/oscarroche/dev/joko_test/.cabal-sandbox/libexec/x86_64-osx-ghc-8.4.3/joko-test-0.1.0.0"
sysconfdir = "/Users/oscarroche/dev/joko_test/.cabal-sandbox/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "joko_test_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "joko_test_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "joko_test_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "joko_test_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "joko_test_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "joko_test_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
