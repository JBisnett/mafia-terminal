import           Control.Concurrent.MVar
import qualified Control.Exception            as X
import qualified Control.Monad                as M (ap, liftM, when)
import qualified Data.ByteString.Lazy         as LBS
import           Data.Functor                 ((<$>))
import qualified Data.Hashable                as H
import qualified Data.HashMap.Strict          as Map
import qualified Data.HashSet                 as Set
import qualified Data.Int                     as I
import qualified Data.Maybe                   as M (catMaybes)
import qualified Data.Text.Lazy               as LT
import qualified Data.Text.Lazy.Encoding      as E (decodeUtf8, encodeUtf8)
import qualified Data.Typeable                as TY (Typeable)
import qualified Data.Vector                  as Vector
import qualified GHC.Generics                 as G (Generic)
import           GHC.IO.Handle
import           Network
import           Prelude                      (return, ($), (++), (.), (==),
                                               (>>=))
import qualified Prelude                      as P
import qualified Test.QuickCheck              as QC (elements)
import qualified Test.QuickCheck.Arbitrary    as QC (Arbitrary (..))

import           Thrift
import           Thrift.Protocol
import           Thrift.Protocol.Binary
import           Thrift.Server
import           Thrift.Transport.Handle

import qualified Generated.MafiaPlayer        as MP
import           Generated.MafiaPlayer_Client
import           Generated.MafiaPlayer_Iface
import qualified Generated.MafiaServer        as MS
import           Generated.MafiaServer_Client
import           Generated.MafiaServer_Iface

data Player = Player {
name   :: P.String,
handle :: (BinaryProtocol Handle, BinaryProtocol Handle),
alive  :: P.Bool,
role   :: P.String
}

data ServerHandler = ServerHandler {
players :: MVar [Player]
}

getPlayers ServerHandler {players = p} = p

newCH = do
  testing <- newMVar []
  return $ ServerHandler testing

newPlayer :: P.String -> (BinaryProtocol Handle, BinaryProtocol Handle) -> Player
newPlayer n p = Player {name = n, handle = p, alive = P.True, role = "unassigned"}

instance MafiaServer_Iface ServerHandler where
  ping _ = P.print "Ping"
  join_game s n h p = do
    let host = LT.unpack h
    transport <- hOpen (host, PortNumber 9090)
    let binProto = BinaryProtocol transport
    let h = (binProto, binProto)
    let name = LT.unpack n
    let player = newPlayer name h
    let players = getPlayers s
    state <- takeMVar  players
    let newState = player : state
    putMVar players newState
    P.putStr name
    P.putStrLn " joined the game"
    return P.True
  take_action _ _ _ = do
    P.print "Take Action"
    return P.True
  public_message _ message = do
    P.print message
    return P.True
  group_message _ _ message =  do
    P.print message
    return P.True
  private_message _ _ message = do
    P.print message
    return P.True


main = do
  handler <- newCH
  P.print "Starting Server"
  runBasicServer handler MS.process 9090
