{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-missing-fields #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
{-# OPTIONS_GHC -fno-warn-name-shadowing #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-----------------------------------------------------------------
-- Autogenerated by Thrift Compiler (0.9.3)                      --
--                                                             --
-- DO NOT EDIT UNLESS YOU ARE SURE YOU KNOW WHAT YOU ARE DOING --
-----------------------------------------------------------------

module MafiaPlayer_Client(ping,start_game,kill,time_forward,server_message,set_role) where
import qualified Data.IORef as R
import Prelude (($), (.), (>>=), (==), (++))
import qualified Prelude as P
import qualified Control.Exception as X
import qualified Control.Monad as M ( liftM, ap, when )
import Data.Functor ( (<$>) )
import qualified Data.ByteString.Lazy as LBS
import qualified Data.Hashable as H
import qualified Data.Int as I
import qualified Data.Maybe as M (catMaybes)
import qualified Data.Text.Lazy.Encoding as E ( decodeUtf8, encodeUtf8 )
import qualified Data.Text.Lazy as LT
import qualified GHC.Generics as G (Generic)
import qualified Data.Typeable as TY ( Typeable )
import qualified Data.HashMap.Strict as Map
import qualified Data.HashSet as Set
import qualified Data.Vector as Vector
import qualified Test.QuickCheck.Arbitrary as QC ( Arbitrary(..) )
import qualified Test.QuickCheck as QC ( elements )

import qualified Thrift as T
import qualified Thrift.Types as T
import qualified Thrift.Arbitraries as T


import Mafia_Types
import MafiaPlayer
seqid = R.newIORef 0
ping (ip,op) = do
  send_ping op
  recv_ping ip
send_ping op = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessageBegin op ("ping", T.M_CALL, seqn)
  write_Ping_args op (Ping_args{})
  T.writeMessageEnd op
  T.tFlush (T.getTransport op)
recv_ping ip = do
  (fname, mtype, rseqid) <- T.readMessageBegin ip
  M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; T.readMessageEnd ip ; X.throw exn }
  res <- read_Ping_result ip
  T.readMessageEnd ip
  P.return ()
start_game (ip,op) arg_player_names = do
  send_start_game op arg_player_names
  recv_start_game ip
send_start_game op arg_player_names = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessageBegin op ("start_game", T.M_CALL, seqn)
  write_Start_game_args op (Start_game_args{start_game_args_player_names=arg_player_names})
  T.writeMessageEnd op
  T.tFlush (T.getTransport op)
recv_start_game ip = do
  (fname, mtype, rseqid) <- T.readMessageBegin ip
  M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; T.readMessageEnd ip ; X.throw exn }
  res <- read_Start_game_result ip
  T.readMessageEnd ip
  P.return ()
kill (ip,op) arg_message = do
  send_kill op arg_message
  recv_kill ip
send_kill op arg_message = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessageBegin op ("kill", T.M_CALL, seqn)
  write_Kill_args op (Kill_args{kill_args_message=arg_message})
  T.writeMessageEnd op
  T.tFlush (T.getTransport op)
recv_kill ip = do
  (fname, mtype, rseqid) <- T.readMessageBegin ip
  M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; T.readMessageEnd ip ; X.throw exn }
  res <- read_Kill_result ip
  T.readMessageEnd ip
  P.return ()
time_forward (ip,op) = do
  send_time_forward op
  recv_time_forward ip
send_time_forward op = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessageBegin op ("time_forward", T.M_CALL, seqn)
  write_Time_forward_args op (Time_forward_args{})
  T.writeMessageEnd op
  T.tFlush (T.getTransport op)
recv_time_forward ip = do
  (fname, mtype, rseqid) <- T.readMessageBegin ip
  M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; T.readMessageEnd ip ; X.throw exn }
  res <- read_Time_forward_result ip
  T.readMessageEnd ip
  P.return ()
server_message (ip,op) arg_message = do
  send_server_message op arg_message
  recv_server_message ip
send_server_message op arg_message = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessageBegin op ("server_message", T.M_CALL, seqn)
  write_Server_message_args op (Server_message_args{server_message_args_message=arg_message})
  T.writeMessageEnd op
  T.tFlush (T.getTransport op)
recv_server_message ip = do
  (fname, mtype, rseqid) <- T.readMessageBegin ip
  M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; T.readMessageEnd ip ; X.throw exn }
  res <- read_Server_message_result ip
  T.readMessageEnd ip
  P.return ()
set_role (ip,op) arg_role = do
  send_set_role op arg_role
  recv_set_role ip
send_set_role op arg_role = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessageBegin op ("set_role", T.M_CALL, seqn)
  write_Set_role_args op (Set_role_args{set_role_args_role=arg_role})
  T.writeMessageEnd op
  T.tFlush (T.getTransport op)
recv_set_role ip = do
  (fname, mtype, rseqid) <- T.readMessageBegin ip
  M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; T.readMessageEnd ip ; X.throw exn }
  res <- read_Set_role_result ip
  T.readMessageEnd ip
  P.return ()
