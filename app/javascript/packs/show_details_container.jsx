import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import ShowDetails from './show_details';
import axios from 'axios';


class ShowDetailsContainer extends React.Component {
  constructor() {
    super();
    this.state = {
      title: '',
      description: '',
      imageUrl: '',
      avgRating: null,
      userRating: {},
      ratings: [],
      showUserRatingForm: false
    }
    this.toggleShowUserForm = this.toggleShowUserForm.bind(this)
  }

  toggleShowUserForm() {
    this.setState({showUserRatingForm: !this.state.showUserRatingForm});
  }

  componentDidMount() {
    axios.get(`/api/v1/shows/${this.props.match.params.id}}`).then(function(response) {
     return response.data;
    }).then((show) => {
      this.setState({
        title: show.title,
        description: show.description,
        imageUrl: show.image_url,
        avgRating: show.avg_rating,
        ratings: show.ratings,
        userRating: show.user_rating
      });
      if (show.user_rating) {
        this.setState({showUserRatingForm: true})
      };
    })
  }

  render() {
    return <ShowDetails
    title={this.state.title}
    description={this.state.description}
    imageUrl={this.state.imageUrl}
    avgRating={this.state.avgRating}
    ratings={this.state.ratings}
    showId={this.props.match.params.id}
    userRating={this.state.userRating}
    showUserRatingForm={this.state.showUserRatingForm}
    toggleShowUserForm={this.toggleShowUserForm}
      />
  }
}

export default ShowDetailsContainer;
