import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import StarRatingComponent from 'react-star-rating-component'

const StarRating = props => (
  <StarRatingComponent
    name={props.name}
    editing={props.editing}
    value={parseFloat(props.value)}
    onStarClick={props.onStarClick}
  />
)

export default StarRating;
