import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import RatingsList from './ratings_list'
import UserRatingForm from './user_rating_form'
import UserRatingDetails from './user_rating_details'
import StarRating from './star_rating'

const ShowDetails = props => {
    let userRatingComponent;
    if(props.showUserRatingForm) {
      userRatingComponent = <UserRatingDetails showId={props.showId} userRating={props.userRating} editFunc={props.toggleShowUserForm}/>
    } else {
      userRatingComponent = <UserRatingForm showId={props.showId} userRating={props.userRating}/>
    }

  return (<div className="ui container">
    <div className="ui raised text container segment">
    <h1 className="ui header">
      <img src={props.imageUrl} />
      <div className="content">
        {props.title}
        <div className="sub header">
          <div className="ui label">
              <StarRating name="avgRating" editing={false} value={props.avgRating} />
              <div className="detail">{props.avgRating}</div>
          </div>
        </div>
      </div>
    </h1>
      <div className="ui content">
    <p>{props.description}</p>
    {userRatingComponent}
    </div>
    </div>
  <div>
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
