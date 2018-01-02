import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import axios from 'axios'
import ReactOnRails from 'react-on-rails'

class UserRatingDetails extends React.Component {
  constructor() {
    super();
    this.handleEdit = this.handleEdit.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  }

  handleEdit(event) {
    event.preventDefault();
    this.props.editFunc();
  }

  handleDelete(event) {
    event.preventDefault();
    axios.delete(`/api/v1/shows/${this.props.showId}/ratings/${this.props.userRating.id}`, {
    authenticity_token: ReactOnRails.authenticityToken()
    }).then(({request}) => window.location = request.responseURL);
  }

  render() {
    return(
      <div className="ui container" id="user-rating" >
        <div className="menu">
          <h3>My Rating: {this.props.userRating.score}</h3>
        </div>
      <h3>My Review:</h3>
      <p>{this.props.userRating.review}</p>
      <div className="ui buttons">
      <button className="ui red mini button"  onClick={this.handleDelete}>Delete</button>
        <div className="or"></div>
      <button className="ui blue mini button" onClick={this.handleEdit}>Edit</button>
      </div>
      </div>)
  }
}

export default UserRatingDetails;
