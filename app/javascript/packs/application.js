/* eslint no-console:0 */

import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const apiURI = '/games'

class Cell extends Component {
  constructor(props) {
    super(props)
    this.cell = this.props.cell
    this.click = this.props.click
  }

  render() {
    const cell = this.cell
    return (
      <div onClick={(e) => this.click(e, cell)} >
        {this.cell.char}
      </div>
    )

  }

}

class Board extends Component {
  constructor(props) {
    super(props)
    this.state = this.props.state
  }

  render() {
    const { error, isPlaying, game } = this.state
    const grid = game.board.grid
    const click = this.props.click

    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isPlaying) {
      return (
        <div>
          Loading...
        </div>
      )
    } else {
      return (
        <table>
          <tbody>
            {grid.map((row, index) => (
              <tr key={`${row.id}${index}`}>
                {row.map(cell => (
                  <td>
                    <Cell key={`${cell.x}${cell.y}`} cell={cell} click={click}/>
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      )
    }
  }
}

const NewGameButton = ({createNewGame}) => {
  return (
    <button onClick={(e) => {
      e.preventDefault();
      createNewGame();
    }}>
    New Game
  </button>
  );
};

class Minesweeper extends Component {
  constructor(props) {
    super(props)
    this.handleClick = this.handleClick.bind(this)
    this.state = {
      isPlaying: false,
      gameId: "",
      game: {}
    }
  }

  createGame() {
    fetch(apiURI, { method: "POST" })
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isPlaying: false,
            gameId: result.id
          })
          this.updateGame()
        }
      )
  }

  updateGame() {
    fetch(`${apiURI}/${this.state.gameId}`)
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            game: result,
            isPlaying: true
          })
        }
      )
  }

  handleClick(e, cell) {
    let payload = {
      'row': cell.x,
      'col': cell.y
    }

    let data = JSON.stringify( payload )

    if (e.shiftKey) {
      this.flag(data)
    } else {
      this.reveal(data)
    }
  }

  flag(payload) {
    fetch(`${apiURI}/${this.state.gameId}/flags`, {
      method: "POST",
      headers: {
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json'
      },
      body: payload })
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isPlaying: false,
            game: result
          })
          this.updateGame()
        }
      )

  }

  reveal(payload) {
    fetch(`${apiURI}/${this.state.gameId}/reveals`, {
      method: "POST",
      headers: {
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json'
      },
      body: payload })
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isPlaying: false,
            game: result
          })
          this.updateGame()
        }
      )

  }

  render() {
    const { error, isPlaying, game } = this.state;

    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isPlaying) {
      return (
        <div>
          <NewGameButton createNewGame={this.createGame.bind(this)} />
          <p>Start a new game by clicking the 'New Game' button</p>
        </div>
      )
    } else {
      return (
        <div>
          <NewGameButton createNewGame={this.createGame.bind(this)} />
          <Board state={this.state} click={this.handleClick} />
          <div>
            <h3>Uncover the tiles and avoid the mines</h3>
            <ul>
              <li>Click to reveal tile</li>
              <li>Shift+Click to flag tile</li>
              <li>Repeat until all the tiles are revealed or you find a mine</li>
            </ul>
          </div>
        </div>
      )
    }
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Minesweeper name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
