import           Control.Concurrent.MVar
import qualified Control.Exception         as X
import qualified Control.Monad             as M (ap, liftM, when)
import qualified Data.ByteString.Lazy      as LBS
import           Data.Functor              ((<$>))
import qualified Data.Hashable             as H
import qualified Data.HashMap.Strict       as Map
import qualified Data.HashSet              as Set
import qualified Data.Int                  as I
import qualified Data.Maybe                as M (catMaybes)
import qualified Data.Text.Lazy            as LT
import qualified Data.Text.Lazy.Encoding   as E (decodeUtf8, encodeUtf8)
import qualified Data.Typeable             as TY (Typeable)
import qualified Data.Vector               as Vector
import qualified GHC.Generics              as G (Generic)
import           GHC.IO.Handle
import           Network
import           Prelude                   (return, ($), (++), (.), (==), (>>=))
import qualified Prelude                   as P
import qualified Test.QuickCheck           as QC (elements)
import qualified Test.QuickCheck.Arbitrary as QC (Arbitrary (..))

import           Thrift
import           Thrift.Protocol
import           Thrift.Protocol.Binary
import           Thrift.Server
import           Thrift.Transport.Handle

import           Mafia_Consts
import qualified MafiaPlayer               as MP
import           MafiaPlayer_Client
import           MafiaPlayer_Iface
import qualified MafiaServer               as MS
import           MafiaServer_Client
import           MafiaServer_Iface

import           Data.Int
import           System.Random

data Player = Player {
number :: I.Int32,
name   :: P.String,
handle :: (BinaryProtocol Handle, BinaryProtocol Handle),
alive  :: P.Bool,
role   :: P.String
}

instance P.Show Player where
  show x = " ID: " ++ P.show (number x) ++ " Name: " ++ P.show (name x)

type MutablePlayerMap = MVar (Map.HashMap Int Player)

data ServerHandler = ServerHandler {
players :: MutablePlayerMap
}

getPlayers ServerHandler {players = p} = p :: MutablePlayerMap

addToMap :: MutablePlayerMap -> Int -> Player -> P.IO(Map.HashMap Int Player)
addToMap mvarMap number player = do
  m <- takeMVar mvarMap
  let newMap = Map.insert number player m
  putMVar mvarMap newMap
  return newMap

newSH = do
  m <- newMVar Map.empty
  return $ ServerHandler m

newPlayer :: I.Int32 -> P.String -> (BinaryProtocol Handle, BinaryProtocol Handle) -> Player
newPlayer num n p = Player {number = num, name = n, handle = p, alive = P.True, role = "unassigned"}



instance MafiaServer_Iface ServerHandler where
  ping _ = P.print "Ping"

  join_game s n h= do
    let host = LT.unpack h
    let port = PortNumber 9090
    transport <- hOpen (host, port)
    let binProto = BinaryProtocol transport
    let handle = (binProto, binProto)
    let name = LT.unpack n

    number <- getStdRandom (randomR (0, 2 P.^16))
    let num32 = P.fromIntegral number :: I.Int32
    let player = newPlayer num32 name handle
    let players = getPlayers s
    current_map <- addToMap players number player


    P.putStr name
    P.putStrLn " joined the game"

    return num32

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

start_game =

main = do
  handler <- newSH
  P.print "Starting Server"
  runBasicServer handler MS.process 9090
