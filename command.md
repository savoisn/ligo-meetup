# dry run the contract with a default store
`ligo dry-run meetup-event.ligo main 'Showed(("tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx":address))' "record booked = ((set end):set(address)); showed = ((set end):set(address));  end"`

# build to get the Michelson shit 
`ligo compile-contract meetup-event.ligo main`

# build the storage
`ligo compile-storage  meetup-event.ligo main "record booked = ((set end):set(address)); showed = ((set end):set(address));  end"`
gives : 
`(Pair {} {})`

# orginate with tezos client
`tezos-client originate contract meetup-event transferring 0 from bootstrap1 running /home/nomadic/Projects/Meetup/meetup-event2.tz --init '(Pair {} {})' --burn-cap 0.725`

# call the SC 

## build the parameter from ligo
`ligo compile-parameter meetup-event.ligo main 'Showed(("tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx":address))'`
gives :
`(Right "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx")`

## Really call it :
`tezos-client transfer 0 from bootstrap1 to meetup-event --arg '(Right "tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx")'`
alternative using entrypoint: 
`tezos-client transfer 0 from bootstrap1 to meetup-event --arg '"tz1KqTpEZ7Yob7QbPE4Hy4Wo8fHG8LhKxZSx"' --entrypoint showed`

## command to bake
`tezos-client bake for bootstrap1`

## command to get the storage 
`tezos-client get script storage for meetup-event`

