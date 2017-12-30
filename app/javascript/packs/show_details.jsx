import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import StarRatingComponent from 'react-star-rating-component';
import RatingsList from './ratings_list';
import UserRatingForm from './user_rating_form';
import UserRatingDetails from './user_rating_details';

const ShowDetails = props => {
    let userRatingComponent;
    if(props.showUserRatingForm) {
      userRatingComponent = <UserRatingDetails showId={props.showId} userRating={props.userRating} editFunc={props.toggleShowUserForm}/>
    } else {
      userRatingComponent = <UserRatingForm showId={props.showId} userRating={props.userRating}/>
    }
  return (<div>
  <div>{props.title}</div>
  <div>{props.description}</div>
  <img src={props.imageUrl} />
  <div>
    Average Rating:
    <span>{props.avgRating}</span>
    <span>
    <StarRatingComponent name={'avgRating'} editing={false} value={props.avgRating} />
    </span>
  </div>
  <div>
    {userRatingComponent}
  </div>
  <RatingsList ratings={props.ratings} />
  </div>)
}

ShowDetails.defaultProps = {
  ratings: [],
  userRating: {},
  avgRating: null
}

ShowDetails.propTypes = {
  showId: PropTypes.string,
  title: PropTypes.string,
  description: PropTypes.string,
  imageUrl: PropTypes.string,
  avgRating: PropTypes.string,
  ratings: PropTypes.array,
  userRating: PropTypes.object,
  showUserRatingForm: PropTypes.bool,
  toggleShowUserForm: PropTypes.func
}

export default ShowDetails;
