# Plan

We need to find all the time phrases. We can sum these into four categories:
1. every
2. at
3. on
4. in

We can find them by regex matching for them and grabbing all the text from there until the next preposition.

Each of these phrases should be their own class, inheriting from a shared class.

We then parse each prepositional phrase for valid time data. We store valid time strings into a variable in the message class.

We then create a hash of the data necessary to create a reminder.

The reminder is saved unless validations in the reminder class (custom validator? probably) tell us it is an invalid combination of time data.

## Classes Implied
1. Message::Body
2. Message::EveryPhrase
3. Message::AtPhrase
4. Message::OnPhrase
5. Message::InPhrase
6. Message::PrepositionalPhrase (to be inherited by the others)

## Modules Implied
1. TimePhraseUtils (stripping time info)

I'm thinking they can just be service classes since they will really only be used once - during parsing a message into a reminder hash.
