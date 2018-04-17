
-- | Core types used across Disciplina codebase.

module Disciplina.Core.Types
       ( Address (..)
       , mkAddr
       , SubjectId
       , Grade (..)
       , StudentId
       , EducatorId
       , CourseId (..)
       , AssignmentId
       , ATGDelta (..)
       ) where

import Data.Map (Map)
import Universum

import Disciplina.Crypto (Hash, PublicKey, hash)

-- | 'Address' datatype. Not 'newtype', because later it will
-- inevitably become more complex.
-- TODO: maybe we should use a shorter hash for address, like in Cardano?
data Address = Address
    { addrHash :: !(Hash PublicKey)
    } deriving (Eq, Ord, Show, Generic)

mkAddr :: PublicKey -> Address
mkAddr = Address . hash

-- | ID of particular subject. IDs of the same subject must be
-- equal across Educators.
-- TODO: 'Int' is a stub, change to something more real.
type SubjectId = Int

-- | Assignment/course grade.
-- TODO: decide on final format of the grade.
data Grade = F | D | C | B | A
    deriving (Eq, Ord, Enum, Bounded, Show)

-- | Student is identified by their public address.
type StudentId = Address

-- | Educator is identified by their public adddress.
type EducatorId = Address

data CourseId = CourseId
    { ciSubject :: !SubjectId
    -- ^ We include subject ID into course ID to simplify
    -- indexing of transactions by subject.
    -- TODO: think about it, maybe it's better to reduce size of
    -- transactions and use really fast map from subject IDs to course IDs?
    , ciId      :: !Int
    -- ^ An identificator of particular Educator's course
    -- among all courses on that subject.
    } deriving (Show, Eq, Ord, Generic)

-- | 'AssignmentId' is a hash of assignment contents,
-- which are stored off-chain.
data Assignment

type AssignmentId = Hash Assignment

-- | ATGDelta is a diff for set of subjects which are taught by Educator.
-- Implemented as 'Map SubjectId Bool' to avoid representing invalid diffs
-- (like, subject is present simultaneously in added and removed sets).
-- TODO: maybe we should separately make up a library for such stuff,
-- like 'MapModifier'?
newtype ATGDelta = ATGDelta
    { getATGDelta :: Map SubjectId Bool
    } deriving (Show, Eq, Ord, Generic)
