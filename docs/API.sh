## Create a Game
curl -X "POST" "http://minesweeper-api.dev/games"

## Get Game
curl "http://minesweeper-api.dev/games/109"

## Toggle Flag on Cell
curl -X "POST" "http://minesweeper-api.dev/games/105/flags" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "row": "0",
  "col": "0"
}'

## Reveal Cell
curl -X "POST" "http://minesweeper-api.dev/games/118/reveals" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "row": "0",
  "col": "0"
}'
