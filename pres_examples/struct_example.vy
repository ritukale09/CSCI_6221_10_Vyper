# Information about voters
struct Voter:
    name: String[32]
    voted: bool

vitalik: Voter = Voter(name="Vitalik", voted=False)
vitalik.voted = True


