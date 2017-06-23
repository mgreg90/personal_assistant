I need to...

Handle Reminder jobs effectively on create/update

I'm thinking...

* ::update_jobs method that gets called on any save/update of a reminder.
* that method will create a reminder job with last_reminder method.
* reminder job will finish by preparing the next reminder job.
* ensure that we don't have two jobs run for the same reminder


## Thought Vomit

I'm doing a terrible job keeping track of what my app is doing and how it works.
It's complex so that means 4 things:
1. I need to be testing this app heavily
2. I need to be logging and responding with errors and responsible error
   messages
3. I need to use git gratuitously. I've been outrageously picky with my commits
   because I like them to be perfect, but I need to use git realistically and
   take advantage of its utility. Lots of branches. Lots of commits.
4. I need to use trello effectively. Make small things cards. It's okay.
   The more I use it, the more effective a tool it is for me. Since my
   greatest weakness has been organization, this is essential.

### Actionable Steps

1. Make sense of current tests. Make them pass if they're valid. Remove them if
   they are not.
2. Build validations and error handling for user input immediately upon receipt.
2. Unit Test everything. Don't forget about OOP. Classes should do one thing.
3. Going forward, TDD everything.

### General Thoughts

* Always validate user input!!!
* TDD