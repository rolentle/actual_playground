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
      <div id="user-rating" >
      Your Rating: {this.props.userRating.score}
      Your Review: {this.props.userRating.review}
      <a onClick={this.handleEdit} href=''>(edit)</a>
      <a onClick={this.handleDelete} href=''>(delete)</a>
      </div>)
  }
}

export default UserRatingDetails;
