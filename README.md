# minesweeper-API
The idea of generating a Minesweeper API is an uncommon request since it presents a couple of architectural challenges. It is suggested that it should be implemented as if it was meant to be played by a mobile App. Then the question is, How do we handle or manage abuse.

If the backend is doing the validations play-by-play, it should be understood that every event should be validated by the backend, which generates a more substantial amount of traffic between the client-server. But now, since the advent of Javascript a lot of business logic has been jumping to the frontend, mostly because it provides a "faster experience," but also it is prone to modification by the user. 

Since having a great experience and thwarting abusers, means to have the logic be repeated in the backend and the frontend, a decision should be taken as to where to place the logic. 

Since this exercise asked for Minesweeper API, we could push all the state to the backend and just have the client be a representation and validate all the events in the backend returning only the state to be drawn by the frontend. 



## The Game
Develop the classic game of [Minesweeper](https://en.wikipedia.org/wiki/Minesweeper_(video_game))

## Show your work

1.  Create a Public repository
2.  Commit each step of your process so we can follow your thought process.

## What to build
The following is a list of items (prioritized from most important to least important) we wish to see:

* Design and implement  a documented RESTful API for the game (think of a mobile app for your API)
* Implement an API client library for the API designed above. Ideally, in a different language, of your preference, to the one used for the API
* When a cell with no adjacent mines is revealed, all adjacent squares will be revealed (and repeat)
* Ability to 'flag' a cell with a question mark or red flag
* Detect when game is over
* Persistence
* Time tracking
* Ability to start a new game and preserve/resume the old ones
* Ability to select the game parameters: number of rows, columns, and mines
* Ability to support multiple users/accounts
 
## Deliverables we expect:
* URL where the game can be accessed and played (use any platform of your preference: heroku.com, aws.amazon.com, etc)
* Code in a public Github repo
* README file with the decisions taken and important notes

## Time Spent
You do not need to fully complete the challenge. We suggest not to spend more than 5 hours total, which can be done over the course of 2 days.  Please make commits as often as possible so we can see the time you spent and please do not make one commit.  We will evaluate the code and time spent.
 
What we want to see is how well you handle yourself given the time you spend on the problem, how you think, and how you prioritize when time is insufficient to solve everything.

Please email your solution as soon as you have completed the challenge or the time is up.
