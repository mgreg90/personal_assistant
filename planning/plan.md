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

## Models Implied
1. Preposition

## Classes Implied
1. MessageBody
2. EveryPhrase
3. AtPhrase
4. OnPhrase
5. InPhrase
6. TimePhrase (to be inherited by the others)

## Modules Implied
1. PrepositionalPhraseUtils (for 'phrase class' class methods for stripping)

I'm thinking they can just be service classes since they will really only be used once - during parsing a message into a reminder hash.