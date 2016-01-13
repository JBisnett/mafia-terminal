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
import           Prelude                   (return, ($), (++), (.), (==), (>>=))
import qualified Prelude                   as P
import qualified Test.QuickCheck           as QC (elements)
import qualified Test.QuickCheck.Arbitrary as QC (Arbitrary (..))

import           Network

import           Control.Concurrent.MVar

import           Thrift
import           Thrift.Protocol
import           Thrift.Protocol.Binary
import           Thrift.Server
import           Thrift.Transport
import           Thrift.Transport.Handle

import qualified MafiaPlayer               as MP
import           MafiaPlayer_Client        as MPC
import           MafiaPlayer_Iface
import qualified MafiaServer               as MS
import           MafiaServer_Client        as MSC
import           MafiaServer_Iface



main = do
  transport  <- hOpen ("localhost", PortNumber 9090)
  let binProto = BinaryProtocol transport
  let client = (binProto, binProto)

  MPC.ping client
