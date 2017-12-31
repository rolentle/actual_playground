import React from 'react'
import ReactDOM from 'react-dom'
import {
    BrowserRouter as Router,
    Route,
    Link
} from 'react-router-dom'

import ShowListContainer from './shows_list'
import ShowDetailsContainer from './show_details_container'

const App = () => (
    <Router>
      <div>
        <Route exact path="/" component={ShowListContainer}/>
        <Route exact path="/shows" component={ShowListContainer}/>
        <Route exact path="/shows/:id" component={ShowDetailsContainer}/>
      </div>
    </Router>
)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.body.appendChild(document.createElement('div')),
 )
})
