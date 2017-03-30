## NEXT:

I need a sound way of getting the last_in, last_at, last_every, and last_on without
causing an infinite loop. Essentially they can't rely on eachother.

This means I should be thinking about parsing out all the prepositional phrases
beginning with those four keywords.

But since that sounds pretty difficult :point_up:, what if I maintained the same
logic I have now, but cut off the phrase after the next instance of one of the
four prepositions.

This way, I don't have to worry about infinite loops and I don't have to worry about handling messages with a whole bunch of prepositional phrases.
