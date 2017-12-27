import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import StarRatingComponent from 'react-star-rating-component';
import axios from 'axios';
import ReactOnRails from "react-on-rails"

class UserRatingForm extends React.Component {
  constructor() {
    super();
    this.state = {
      score: 0,
      review: '',
      id: null
    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleReviewChange = this.handleReviewChange.bind(this);
  }

  componentDidMount() {
    if(this.props.userRating) {
      const { score, review, id } = this.props.userRating;
      this.setState({ score, review, id });
    }
  }

  onStarClick(nextValue, prevValue, name) {
    this.setState({score: nextValue});
  }

  handleReviewChange(event) {
    this.setState({review: event.target.value});
  }

  editRating() {
      axios.patch(`/api/v1/shows/${this.props.showId}/ratings/${this.state.id}`, {
      review: this.state.review,
      score: this.state.score,
      authenticity_token: ReactOnRails.authenticityToken()
    }).then(function(response) {
      window.location = response.request.responseURL;
    });
  }

  createRating() {
    axios.post(`/api/v1/shows/${this.props.showId}/ratings`, {
      review: this.state.review,
      score: this.state.score,
      authenticity_token: ReactOnRails.authenticityToken()
    }).then(function(response) {
      window.location = response.request.responseURL;
    });
  }

  handleSubmit(event) {
    event.preventDefault();
    this.state.id ? this.editRating() : this.createRating()
  }

  render() {
    return(
      <div id="user-rating-form" >
      <form onSubmit={this.handleSubmit}>
      <div>
      <textarea id="user-review" value={this.state.review} onChange={this.handleReviewChange}/>
      </div>
      <div>
      <StarRatingComponent
        name="user-rating"
        value={this.state.score}
        onStarClick={this.onStarClick.bind(this)} />
      </div>
      <button type="submit" id="user-submit">Submit</button>
      </form>
      </div>
    )
  }
}

UserRatingForm.defaultProps = {
  userRating: {}
}

UserRatingForm.propTypes = {
  showId: PropTypes.number,
  userRating: PropTypes.object
}

export default UserRatingForm;
